USE [DaVinci_TEST]
GO

/****** Object:  StoredProcedure [dbo].[Create1BStagingtables]    Script Date: 07/21/2017 19:50:41 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Create1BStagingtables]
	-- Add the parameters for the stored procedure here

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	truncate table t_ko_genesis_formula_BomDate

insert  
into t_ko_genesis_formula_BomDate
select specnumber, input_formula_num, input_mat_num, max(insert_dt) 
from t_ko_genesis_formula_bom
where ProcessedDate = '1900-01-01 00:00:00.000'
group by specnumber, input_formula_num, input_mat_num 
order by 1, 2, 3

truncate table t_ko_genesis_formula_bom_Staging
insert into t_ko_genesis_formula_bom_Staging
select bom.* from  t_ko_genesis_formula_bom bom
join t_ko_genesis_formula_BomDate dt
on bom.specnumber=dt.specnumber
where (bom.input_mat_num = dt.input_mat_num or
bom.input_formula_num = dt.input_formula_num) and
bom.insert_dt = dt.maxdate 
and  ProcessedDate = '1900-01-01 00:00:00.000'

update t_ko_genesis_formula_bom_Staging set input_formula_num = input_mat_num
where input_formula_num is null

Truncate table [t_ko_genesis_formula_extattr_Date]

insert into [t_ko_genesis_formula_extattr_Date]
SELECt [SpecNumber]
      ,max ([Insert_dt]) MaxDate
      
  FROM [t_ko_genesis_formula_extattr]
  where ProcessedDate = '1900-01-01 00:00:00.000'
  group by SpecNumber

  truncate table [t_ko_genesis_formula_extattr_staging]
 insert into [t_ko_genesis_formula_extattr_staging]
Select distinct ext.SpecNumber,
TOTAL_VOLUME_THEORETICAL_L, TOTAL_VOLUME_THEORETICAL_L_UOM, TOTAL_WEIGHT_THEORETICAL_KG,
TOTAL_WEIGHT_THEORETICAL_KG_UOM, DENSITY_KG_L_CALC

  from t_ko_genesis_formula_extattr ext
join [t_ko_genesis_formula_extattr_Date] maxdt
on ext.specnumber = maxdt.specnumber and ext.insert_dt = maxdt.maxdate
order by ext.specnumber

-- Delete duplicate records where DENSITY_KG_L_CALC is null
Delete from [t_ko_genesis_formula_extattr_staging] where specnumber in
(select distinct specnumber from t_ko_genesis_formula_extattr_staging
group by specnumber
having count(specnumber) > 1)
and DENSITY_KG_L_CALC is null


truncate table [t_ko_genesis_Ingredient_Composition_Date]
insert into  [t_ko_genesis_Ingredient_Composition_Date]
 select [SpecNumber]
     
      ,[Component]
      ,[Description]
      ,[Countryname]
      
	  , max(insert_dt)  
  FROM [DaVinci_TEST].[dbo].[t_ko_genesis_Ingredient_Composition]
  where ProcessedDate = '1900-01-01 00:00:00.000'
  group by 
      [SpecNumber]
	  ,[Component]
      ,[Description]
      ,[Countryname]
      

	 truncate table [t_ko_genesis_Ingredient_Composition_Staging]
	 insert into [t_ko_genesis_Ingredient_Composition_Staging]
	  select comp.* 
	  from [t_ko_genesis_Ingredient_Composition] comp
	  join [t_ko_genesis_Ingredient_Composition_Date] dt
	  on comp.specnumber = dt.specnumber
	  and comp.Component = dt.Component
	  where dt.maxdate = comp.insert_dt
	  and  ProcessedDate = '1900-01-01 00:00:00.000'


Truncate table [t_ko_genesis_ingredient_nutrition_Date]

insert into [t_ko_genesis_ingredient_nutrition_Date]
SELECT [SpecNumber]
      ,[Equivalent]
      ,[Nutrient]
      ,[Per_100g]
      ,[Per_100gUOM]
	  ,max(insert_dt) max_date

  FROM [t_ko_genesis_ingredient_nutrition]
  where ProcessedDate = '1900-01-01 00:00:00.000'
  group by 
  [SpecNumber]
      ,[Equivalent]
      ,[Nutrient]
      ,[Per_100g]
      ,[Per_100gUOM]

	  truncate table [t_ko_genesis_ingredient_nutrition_Staging]
	  insert into [t_ko_genesis_ingredient_nutrition_Staging]	 
	  select ing.*
	  from [t_ko_genesis_ingredient_nutrition_Date] dt
	  join [t_ko_genesis_ingredient_nutrition] ing
	  on dt.SpecNumber = ing.SpecNumber
	  and ing.insert_dt = dt.max_date
	  and ing.nutrient = dt.nutrient
	  where ProcessedDate = '1900-01-01 00:00:00.000'
	 


drop table 	t_ko_genesis_ingredient_allergens_sensitivities_date
	select  specnumber, MAX(Insert_dt) MaxDate
	into  t_ko_genesis_ingredient_allergens_sensitivities_date
	from 
	t_ko_genesis_ingredient_allergens_sensitivities
	 where ProcessedDate = '1900-01-01 00:00:00.000'
	 group by SPECNUMBER
	 
drop table t_ko_genesis_ingredient_allergens_sensitivities_staging	 
	 select alsen.* into t_ko_genesis_ingredient_allergens_sensitivities_staging
	 from t_ko_genesis_ingredient_allergens_sensitivities alsen
	 join t_ko_genesis_ingredient_allergens_sensitivities_date date
	 on alsen.SPECNUMBER = date.SPECNUMBER
	 and alsen.Insert_dt = date.MaxDate
 
END

GO

