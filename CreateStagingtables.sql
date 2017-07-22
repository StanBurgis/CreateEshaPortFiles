USE [DaVinci_TEST]
GO

/****** Object:  StoredProcedure [dbo].[CreateStagingtables]    Script Date: 06/30/2017 23:46:24 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[CreateStagingtables]
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
--where specnumber = '5183538-001'
group by specnumber, input_formula_num, input_mat_num 
order by 1, 2, 3

truncate table t_ko_genesis_formula_bom_BOMStaging
insert into t_ko_genesis_formula_bom_BOMStaging
select bom.* from  t_ko_genesis_formula_bom bom
join t_ko_genesis_formula_BomDate dt
on bom.specnumber=dt.specnumber
where (bom.input_mat_num = dt.input_mat_num or
bom.input_formula_num = dt.input_formula_num) and
bom.insert_dt = dt.maxdate 

/****** Script for SelectTopNRows command from SSMS  ******/
Truncate table [t_ko_genesis_formula_extattr_Date]

insert into [t_ko_genesis_formula_extattr_Date]
SELECt [SpecNumber]
      ,max ([Insert_dt]) MaxDate
      ,[DENSITY_TYPE]
  FROM [t_ko_genesis_formula_extattr]
  group by SpecNumber, Density_type

  truncate table [t_ko_genesis_formula_extattr_staging]
 insert into [t_ko_genesis_formula_extattr_staging]
 select ext.*
from [t_ko_genesis_formula_extattr] ext
join [t_ko_genesis_formula_extattr_Date] dt
on ext.specnumber=dt.specnumber
where dt.MaxDate = ext.Insert_dt 

truncate table [t_ko_genesis_Ingredient_Composition_Date]
insert into  [t_ko_genesis_Ingredient_Composition_Date]
 select [SpecNumber]
      ,[Equivalent]
      ,[Component]
      ,[Description]
      ,[Countryname]
      ,[Formulation]
	  , max(insert_dt)  
  FROM [DaVinci_TEST].[dbo].[t_ko_genesis_Ingredient_Composition]
  group by [SpecNumber]
      ,[Equivalent]
      ,[Component]
      ,[Description]
      ,[Countryname]
      ,[Formulation]

	 truncate table [t_ko_genesis_Ingredient_Composition_Staging]
	 insert into [t_ko_genesis_Ingredient_Composition_Staging]
	  select comp.* 
	  from [t_ko_genesis_Ingredient_Composition] comp
	  join [t_ko_genesis_Ingredient_Composition_Date] dt
	  on comp.specnumber = dt.specnumber
	  where dt.maxdate = comp.insert_dt


Truncate table [t_ko_genesis_ingredient_nutrition_Date]

insert into [t_ko_genesis_ingredient_nutrition_Date]
SELECT [SpecNumber]
      ,[Business_Unit]
      ,[Equivalent]
      ,[Nutrient]
      ,[Per_100g]
      ,[Per_100gUOM]
	  ,max(insert_dt) max_date

  FROM [t_ko_genesis_ingredient_nutrition]
  group by 
  [SpecNumber]
      ,[Business_Unit]
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
	  where ing.insert_dt = dt.max_date
	  and ing.nutrient = dt.nutrient
	  and ing.business_unit = dt.business_unit


	
	

 
END

GO

