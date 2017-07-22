USE [DaVinci_TEST]
GO

/****** Object:  StoredProcedure [dbo].[SCodeRecipeStaging]    Script Date: 07/21/2017 19:53:24 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO




---------------------------------------------------------------------------------------------------------------------------------------------------

--fifth step

CREATE procedure [dbo].[SCodeRecipeStaging]
as
declare @thisSpec varchar(max)	

--set nocount on
truncate table t_ko_genesis_ScodeStagingTable
 truncate table t_ko_genesis_nutrient_exception_report
 			
insert into t_ko_genesis_ScodeStagingTable
(usercode,name,ItemName,itemquantity)
 

select distinct 
icomp.SpecNumber, 
 icomp.Equivalent,
 icomp.component, 
 icomp.formulation
 from t_ko_genesis_ingredient_composition_staging icomp
where SpecNumber in
(

select distinct input_mat_num from t_ko_genesis_formula_bom_staging 
--join t_ko_genesis_ingredient_composition_staging comp
where
  Input_Formula_Num =  Input_Mat_Num and  
  
  input_mat_num in
(
select specnumber from t_ko_genesis_ingredient_composition_staging
)

 and input_mat_num  not in
(select distinct usercode from gendata.dbo.basefoodusercode uc--9
join gendata.dbo.basefoodname bfn
on uc.primarykey = bfn.primarykey 
where bfn.type = 2


)
) order by SpecNumber
 update t_ko_genesis_scodestagingtable   set [Added Sugar (g)]= nut.per_100g   from t_ko_genesis_scodestagingtable scode   join t_ko_genesis_ingredient_nutrition_Staging nut   on scode.usercode = nut.specnumber    where nut.nutrient = 'Added Sugars'
update t_ko_genesis_scodestagingtable   set [Alcohol (g)]= nut.per_100g   from t_ko_genesis_scodestagingtable scode   join t_ko_genesis_ingredient_nutrition_Staging nut   on scode.usercode = nut.specnumber    where nut.nutrient = 'Alcohol'
update t_ko_genesis_scodestagingtable   set [Ash (g)]= nut.per_100g   from t_ko_genesis_scodestagingtable scode   join t_ko_genesis_ingredient_nutrition_Staging nut   on scode.usercode = nut.specnumber    where nut.nutrient = 'Ash'
update t_ko_genesis_scodestagingtable   set [Water (g)]= nut.per_100g   from t_ko_genesis_scodestagingtable scode   join t_ko_genesis_ingredient_nutrition_Staging nut   on scode.usercode = nut.specnumber    where nut.nutrient = 'Moisture'
update t_ko_genesis_scodestagingtable   set [Mono Fat (g)]= nut.per_100g   from t_ko_genesis_scodestagingtable scode   join t_ko_genesis_ingredient_nutrition_Staging nut   on scode.usercode = nut.specnumber    where nut.nutrient = 'Monounsaturated Fat'
update t_ko_genesis_scodestagingtable   set [Organic Acids (g)]= nut.per_100g   from t_ko_genesis_scodestagingtable scode   join t_ko_genesis_ingredient_nutrition_Staging nut   on scode.usercode = nut.specnumber    where nut.nutrient = 'Organic Acids'
update t_ko_genesis_scodestagingtable   set [Poly Fat (g)]= nut.per_100g   from t_ko_genesis_scodestagingtable scode   join t_ko_genesis_ingredient_nutrition_Staging nut   on scode.usercode = nut.specnumber    where nut.nutrient = 'Polyunsaturated Fat'
update t_ko_genesis_scodestagingtable   set [Protein (g)]= nut.per_100g   from t_ko_genesis_scodestagingtable scode   join t_ko_genesis_ingredient_nutrition_Staging nut   on scode.usercode = nut.specnumber    where nut.nutrient = 'Protein'
update t_ko_genesis_scodestagingtable   set [Saturated Fat (g)]= nut.per_100g   from t_ko_genesis_scodestagingtable scode   join t_ko_genesis_ingredient_nutrition_Staging nut   on scode.usercode = nut.specnumber    where nut.nutrient = 'Saturated Fat'
update t_ko_genesis_scodestagingtable   set [Sugar Alcohol (g)]= nut.per_100g   from t_ko_genesis_scodestagingtable scode   join t_ko_genesis_ingredient_nutrition_Staging nut   on scode.usercode = nut.specnumber    where nut.nutrient = 'Sugar Alcohol'
update t_ko_genesis_scodestagingtable   set [Fat (g)]= nut.per_100g   from t_ko_genesis_scodestagingtable scode   join t_ko_genesis_ingredient_nutrition_Staging nut   on scode.usercode = nut.specnumber    where nut.nutrient = 'Total Fat'
update t_ko_genesis_scodestagingtable   set [Trans Fatty Acid (g)]= nut.per_100g   from t_ko_genesis_scodestagingtable scode   join t_ko_genesis_ingredient_nutrition_Staging nut   on scode.usercode = nut.specnumber    where nut.nutrient = 'Trans Fatty Acid'
update t_ko_genesis_scodestagingtable   set [Calories (kcal)]= nut.per_100g   from t_ko_genesis_scodestagingtable scode   join t_ko_genesis_ingredient_nutrition_Staging nut   on scode.usercode = nut.specnumber    where nut.nutrient = 'Calories US'
update t_ko_genesis_scodestagingtable   set [Chromium (mcg)]= nut.per_100g   from t_ko_genesis_scodestagingtable scode   join t_ko_genesis_ingredient_nutrition_Staging nut   on scode.usercode = nut.specnumber    where nut.nutrient = 'Chromium'
update t_ko_genesis_scodestagingtable   set [Folic Acid (mcg)]= nut.per_100g   from t_ko_genesis_scodestagingtable scode   join t_ko_genesis_ingredient_nutrition_Staging nut   on scode.usercode = nut.specnumber    where nut.nutrient = 'Folic Acid'
update t_ko_genesis_scodestagingtable   set [Beta-Carotene (mcg)]= nut.per_100g   from t_ko_genesis_scodestagingtable scode   join t_ko_genesis_ingredient_nutrition_Staging nut   on scode.usercode = nut.specnumber    where nut.nutrient = 'Vitamin A - b-Carotene'
update t_ko_genesis_scodestagingtable   set [Vitamin K (mcg)]= nut.per_100g   from t_ko_genesis_scodestagingtable scode   join t_ko_genesis_ingredient_nutrition_Staging nut   on scode.usercode = nut.specnumber    where nut.nutrient = 'Vitamin K'
update t_ko_genesis_scodestagingtable   set [Caffeine (mg)]= nut.per_100g   from t_ko_genesis_scodestagingtable scode   join t_ko_genesis_ingredient_nutrition_Staging nut   on scode.usercode = nut.specnumber    where nut.nutrient = 'Caffeine'
update t_ko_genesis_scodestagingtable   set [Calcium (mg)]= nut.per_100g   from t_ko_genesis_scodestagingtable scode   join t_ko_genesis_ingredient_nutrition_Staging nut   on scode.usercode = nut.specnumber    where nut.nutrient = 'Calcium'
update t_ko_genesis_scodestagingtable   set [Chloride (mg)]= nut.per_100g   from t_ko_genesis_scodestagingtable scode   join t_ko_genesis_ingredient_nutrition_Staging nut   on scode.usercode = nut.specnumber    where nut.nutrient = 'Chloride'
update t_ko_genesis_scodestagingtable   set [Cholesterol (mg)]= nut.per_100g   from t_ko_genesis_scodestagingtable scode   join t_ko_genesis_ingredient_nutrition_Staging nut   on scode.usercode = nut.specnumber    where nut.nutrient = 'Cholesterol'
update t_ko_genesis_scodestagingtable   set [Choline (mg)]= nut.per_100g   from t_ko_genesis_scodestagingtable scode   join t_ko_genesis_ingredient_nutrition_Staging nut   on scode.usercode = nut.specnumber    where nut.nutrient = 'Choline'
update t_ko_genesis_scodestagingtable   set [Copper (mg)]= nut.per_100g   from t_ko_genesis_scodestagingtable scode   join t_ko_genesis_ingredient_nutrition_Staging nut   on scode.usercode = nut.specnumber    where nut.nutrient = 'Copper'
update t_ko_genesis_scodestagingtable   set [Fluoride (mg)]= nut.per_100g   from t_ko_genesis_scodestagingtable scode   join t_ko_genesis_ingredient_nutrition_Staging nut   on scode.usercode = nut.specnumber    where nut.nutrient = 'Fluoride'
update t_ko_genesis_scodestagingtable   set [Iron (mg)]= nut.per_100g   from t_ko_genesis_scodestagingtable scode   join t_ko_genesis_ingredient_nutrition_Staging nut   on scode.usercode = nut.specnumber    where nut.nutrient = 'Iron'
update t_ko_genesis_scodestagingtable   set [Magnesium (mg)]= nut.per_100g   from t_ko_genesis_scodestagingtable scode   join t_ko_genesis_ingredient_nutrition_Staging nut   on scode.usercode = nut.specnumber    where nut.nutrient = 'Magnesium'
update t_ko_genesis_scodestagingtable   set [Manganese (mg)]= nut.per_100g   from t_ko_genesis_scodestagingtable scode   join t_ko_genesis_ingredient_nutrition_Staging nut   on scode.usercode = nut.specnumber    where nut.nutrient = 'Manganese'
update t_ko_genesis_scodestagingtable   set [Phosphorus (mg)]= nut.per_100g   from t_ko_genesis_scodestagingtable scode   join t_ko_genesis_ingredient_nutrition_Staging nut   on scode.usercode = nut.specnumber    where nut.nutrient = 'Phosphorus'
update t_ko_genesis_scodestagingtable   set [Potassium (mg)]= nut.per_100g   from t_ko_genesis_scodestagingtable scode   join t_ko_genesis_ingredient_nutrition_Staging nut   on scode.usercode = nut.specnumber    where nut.nutrient = 'Potassium'
update t_ko_genesis_scodestagingtable   set [Pyridoxine - B6 (mg)]= nut.per_100g   from t_ko_genesis_scodestagingtable scode   join t_ko_genesis_ingredient_nutrition_Staging nut   on scode.usercode = nut.specnumber    where nut.nutrient = 'Pyridoxine - B6'
update t_ko_genesis_scodestagingtable   set [Vitamin B2 (mg)]= nut.per_100g   from t_ko_genesis_scodestagingtable scode   join t_ko_genesis_ingredient_nutrition_Staging nut   on scode.usercode = nut.specnumber    where nut.nutrient = 'Riboflavin - B2'
update t_ko_genesis_scodestagingtable   set [Sodium (mg)]= nut.per_100g   from t_ko_genesis_scodestagingtable scode   join t_ko_genesis_ingredient_nutrition_Staging nut   on scode.usercode = nut.specnumber    where nut.nutrient = 'Sodium'
update t_ko_genesis_scodestagingtable   set [Vitamin B1 (mg)]= nut.per_100g   from t_ko_genesis_scodestagingtable scode   join t_ko_genesis_ingredient_nutrition_Staging nut   on scode.usercode = nut.specnumber    where nut.nutrient = 'Thiamin - B1'
update t_ko_genesis_scodestagingtable   set [Vitamin B6 (mg)]= nut.per_100g   from t_ko_genesis_scodestagingtable scode   join t_ko_genesis_ingredient_nutrition_Staging nut   on scode.usercode = nut.specnumber    where nut.nutrient = 'Vitamin B6'
update t_ko_genesis_scodestagingtable   set [Vitamin C (mg)]= nut.per_100g   from t_ko_genesis_scodestagingtable scode   join t_ko_genesis_ingredient_nutrition_Staging nut   on scode.usercode = nut.specnumber    where nut.nutrient = 'Vitamin C'
update t_ko_genesis_scodestagingtable   set [Vitamin E - mg (mg)]= nut.per_100g   from t_ko_genesis_scodestagingtable scode   join t_ko_genesis_ingredient_nutrition_Staging nut   on scode.usercode = nut.specnumber    where nut.nutrient = 'Vitamin E'
update t_ko_genesis_scodestagingtable   set [Zinc (mg)]= nut.per_100g   from t_ko_genesis_scodestagingtable scode   join t_ko_genesis_ingredient_nutrition_Staging nut   on scode.usercode = nut.specnumber    where nut.nutrient = 'Zinc'
update t_ko_genesis_scodestagingtable   set [Total Insoluble Fiber (g)]= nut.per_100g   from t_ko_genesis_scodestagingtable scode   join t_ko_genesis_ingredient_nutrition_Staging nut   on scode.usercode = nut.specnumber    where nut.nutrient = 'Insoluble Fiber'
update t_ko_genesis_scodestagingtable   set [Insoluble Fiber (2016) (g)]= nut.per_100g   from t_ko_genesis_scodestagingtable scode   join t_ko_genesis_ingredient_nutrition_Staging nut   on scode.usercode = nut.specnumber    where nut.nutrient = 'Insoluble Fiber'
update t_ko_genesis_scodestagingtable   set [Total Soluble Fiber (g)]= nut.per_100g   from t_ko_genesis_scodestagingtable scode   join t_ko_genesis_ingredient_nutrition_Staging nut   on scode.usercode = nut.specnumber    where nut.nutrient = 'Soluble Fiber'
update t_ko_genesis_scodestagingtable   set [Soluble Fiber (2016) (g)]= nut.per_100g   from t_ko_genesis_scodestagingtable scode   join t_ko_genesis_ingredient_nutrition_Staging nut   on scode.usercode = nut.specnumber    where nut.nutrient = 'Soluble Fiber'
update t_ko_genesis_scodestagingtable   set [Folate (mcg)]= nut.per_100g   from t_ko_genesis_scodestagingtable scode   join t_ko_genesis_ingredient_nutrition_Staging nut   on scode.usercode = nut.specnumber    where nut.nutrient = 'Folate'
update t_ko_genesis_scodestagingtable   set [Folate, DFE (mcg DFE)]= nut.per_100g   from t_ko_genesis_scodestagingtable scode   join t_ko_genesis_ingredient_nutrition_Staging nut   on scode.usercode = nut.specnumber    where nut.nutrient = 'Folate'
update t_ko_genesis_scodestagingtable   set [Vitamin B3 (mg)]= nut.per_100g   from t_ko_genesis_scodestagingtable scode   join t_ko_genesis_ingredient_nutrition_Staging nut   on scode.usercode = nut.specnumber    where nut.nutrient = 'Niacin - B3'
update t_ko_genesis_scodestagingtable   set [Vitamin B3 - Niacin Equiv (mg)]= nut.per_100g   from t_ko_genesis_scodestagingtable scode   join t_ko_genesis_ingredient_nutrition_Staging nut   on scode.usercode = nut.specnumber    where nut.nutrient = 'Niacin - B3'
update t_ko_genesis_scodestagingtable   set [Vitamin A - IU (IU)]= nut.per_100g   from t_ko_genesis_scodestagingtable scode   join t_ko_genesis_ingredient_nutrition_Staging nut   on scode.usercode = nut.specnumber    where nut.nutrient = 'Vitamin A - IU'
update t_ko_genesis_scodestagingtable   set [Vitamin A - Total]= nut.per_100g   from t_ko_genesis_scodestagingtable scode   join t_ko_genesis_ingredient_nutrition_Staging nut   on scode.usercode = nut.specnumber    where nut.nutrient = 'Vitamin A - Total'
update t_ko_genesis_scodestagingtable   set [Carbohydrates (g)]= nut.per_100g   from t_ko_genesis_scodestagingtable scode   join t_ko_genesis_ingredient_nutrition_Staging nut   on scode.usercode = nut.specnumber    where nut.nutrient = 'Carbohydrates'
update t_ko_genesis_scodestagingtable   set [total Carbohydrate (g)]= nut.per_100g   from t_ko_genesis_scodestagingtable scode   join t_ko_genesis_ingredient_nutrition_Staging nut   on scode.usercode = nut.specnumber    where nut.nutrient = 'total Carbohydrate'
update t_ko_genesis_scodestagingtable   set [Total Sugars (g)]= nut.per_100g   from t_ko_genesis_scodestagingtable scode   join t_ko_genesis_ingredient_nutrition_Staging nut   on scode.usercode = nut.specnumber    where nut.nutrient = 'Total Sugars'
update t_ko_genesis_scodestagingtable   set [Sugars (g)]= nut.per_100g   from t_ko_genesis_scodestagingtable scode   join t_ko_genesis_ingredient_nutrition_Staging nut   on scode.usercode = nut.specnumber    where nut.nutrient = 'Sugars'
update t_ko_genesis_scodestagingtable   set [Pantothenic Acid (mg)]= nut.per_100g   from t_ko_genesis_scodestagingtable scode   join t_ko_genesis_ingredient_nutrition_Staging nut   on scode.usercode = nut.specnumber    where nut.nutrient = 'Pantothenic Acid'
update t_ko_genesis_scodestagingtable   set [Pantothenic (mg)]= nut.per_100g   from t_ko_genesis_scodestagingtable scode   join t_ko_genesis_ingredient_nutrition_Staging nut   on scode.usercode = nut.specnumber    where nut.nutrient = 'Pantothenic'
update t_ko_genesis_scodestagingtable   set [Dietary Fiber (g)]= nut.per_100g   from t_ko_genesis_scodestagingtable scode   join t_ko_genesis_ingredient_nutrition_Staging nut   on scode.usercode = nut.specnumber    where nut.nutrient = 'Dietary Fiber'
update t_ko_genesis_scodestagingtable   set [Total Dietary Fiber (g)]= nut.per_100g   from t_ko_genesis_scodestagingtable scode   join t_ko_genesis_ingredient_nutrition_Staging nut   on scode.usercode = nut.specnumber    where nut.nutrient = 'Total Dietary Fiber'
update t_ko_genesis_scodestagingtable   set [Iodine (mcg)]= nut.per_100g   from t_ko_genesis_scodestagingtable scode   join t_ko_genesis_ingredient_nutrition_Staging nut   on scode.usercode = nut.specnumber    where nut.nutrient = 'Iodine' and nut.Per_100gUOM = 'Micrograms'
update t_ko_genesis_scodestagingtable   set [Iodine (mcg)]= nut.per_100g*1000   from t_ko_genesis_scodestagingtable scode   join t_ko_genesis_ingredient_nutrition_Staging nut   on scode.usercode = nut.specnumber    where nut.nutrient = 'Iodine' and nut.Per_100gUOM = 'milligrams'
update t_ko_genesis_scodestagingtable   set [Selenium (mcg)]= nut.per_100g   from t_ko_genesis_scodestagingtable scode   join t_ko_genesis_ingredient_nutrition_Staging nut   on scode.usercode = nut.specnumber    where nut.nutrient = 'Selenium' and nut.Per_100gUOM = 'Micrograms'
update t_ko_genesis_scodestagingtable   set [Selenium (mcg)]= nut.per_100g*1000   from t_ko_genesis_scodestagingtable scode   join t_ko_genesis_ingredient_nutrition_Staging nut   on scode.usercode = nut.specnumber    where nut.nutrient = 'Selenium' and nut.Per_100gUOM = 'milligrams'
update t_ko_genesis_scodestagingtable   set [Biotin (mcg)]= nut.per_100g*1000   from t_ko_genesis_scodestagingtable scode   join t_ko_genesis_ingredient_nutrition_Staging nut   on scode.usercode = nut.specnumber    where nut.nutrient = 'Biotin'
update t_ko_genesis_scodestagingtable   set [Vitamin B12 (mcg)]= nut.per_100g*1000   from t_ko_genesis_scodestagingtable scode   join t_ko_genesis_ingredient_nutrition_Staging nut   on scode.usercode = nut.specnumber    where nut.nutrient = 'Vitamin B12'
update t_ko_genesis_scodestagingtable   set [Vitamin D - mcg (mcg)]= nut.per_100g/40   from t_ko_genesis_scodestagingtable scode   join t_ko_genesis_ingredient_nutrition_Staging nut   on scode.usercode = nut.specnumber    where nut.nutrient = 'Vitamin D'
update t_ko_genesis_scodestagingtable   set [Vitamin D - IU (IU)]= nut.per_100g   from t_ko_genesis_scodestagingtable scode   join t_ko_genesis_ingredient_nutrition_Staging nut   on scode.usercode = nut.specnumber    where nut.nutrient = 'Vitamin D'
 
 --Insert Values into Nutrient Exception report table
 insert into  t_ko_genesis_nutrient_exception_report
select distinct
 Name, 
'|[Carbohydrates (g)]'+ CONVERT(varchar(max), [Carbohydrates (g)]) , 
'|[Total Carbohydrate (g)]' +CONVERT(varchar(max), [total Carbohydrate (g)]) ,
GETDATE()   
from t_ko_genesis_scodestagingtable
where ([Carbohydrates (g)] <> 0
and [total Carbohydrate (g)] <> 0)
and [Carbohydrates (g)]<>[total Carbohydrate (g)]

insert into t_ko_genesis_nutrient_exception_report 
select distinct name,
'|[Pyridoxine - B6 (mg)]'+ CONVERT(varchar(max), [Pyridoxine - B6 (mg)]), 
'|[Vitamin B6 (mg)]' +CONVERT(varchar(max), [Vitamin B6 (mg)]),
GETDATE()
from t_ko_genesis_scodestagingtable
where ([Pyridoxine - B6 (mg)] <> 0
and [Vitamin B6 (mg)] <> 0)
and [Pyridoxine - B6 (mg)]<>[Vitamin B6 (mg)]

insert into t_ko_genesis_nutrient_exception_report 
select distinct name,
'|[Vitamin A - IU (IU)]'+ CONVERT(varchar(max), [Vitamin A - IU (IU)]), 
'|[Vitamin A - Total]' +CONVERT(varchar(max), [Vitamin A - Total]),
GETDATE()
from t_ko_genesis_scodestagingtable
where ([Vitamin A - IU (IU)] <> 0
and [Vitamin A - Total] <> 0)
and [Vitamin A - IU (IU)]<>[Vitamin A - Total]


insert into t_ko_genesis_nutrient_exception_report (name, [value 1],Date)
select distinct name,
'|[Vitamin A - Total]'+ CONVERT(varchar(max), [Vitamin A - Total]), GETDATE()
from t_ko_genesis_scodestagingtable
where [Vitamin A - Total] > 0

insert into t_ko_genesis_nutrient_exception_report (name, [value 1],Date)
select  distinct name,
'|[Vitamin A - IU (IU)]'+ CONVERT(varchar(max), [Vitamin A - IU (IU)]), GETDATE()
from t_ko_genesis_scodestagingtable
where [Vitamin A - IU (IU)] > 0

insert into t_ko_genesis_nutrient_exception_report 
select distinct name,
'|[Sugars (g)]'+ CONVERT(varchar(max), [Sugars (g)]), 
'|[Total Sugars (g)]' +CONVERT(varchar(max), [Total Sugars (g)]),
GETDATE()
from t_ko_genesis_scodestagingtable
where ([Sugars (g)] <> 0
and [Total Sugars (g)] <> 0)
and [Sugars (g)]<>[Total Sugars (g)]

insert into t_ko_genesis_nutrient_exception_report
select distinct name,
'|[Pantothenic Acid (mg)]'+ CONVERT(varchar(max), [Pantothenic Acid (mg)]), 
'|[Pantothenic (mg)]' +CONVERT(varchar(max), [Pantothenic (mg)]),
GETDATE()
from t_ko_genesis_scodestagingtable
where ([Pantothenic Acid (mg)] <> 0
and [Pantothenic (mg)] <> 0)
and [Pantothenic Acid (mg)]<>[Pantothenic (mg)]

insert into t_ko_genesis_nutrient_exception_report
select distinct name,
'|[Dietary Fiber (g)]'+ CONVERT(varchar(max), [Dietary Fiber (g)]), 
'|[Total Dietary Fiber (g)]' +CONVERT(varchar(max), [Total Dietary Fiber (g)]),
getdate() 
from t_ko_genesis_scodestagingtable
where ([Dietary Fiber (g)] <> 0
and [Total Dietary Fiber (g)] <> 0)
and [Dietary Fiber (g)] <> [Total Dietary Fiber (g)]

--Update Insert Either Fields
update t_ko_genesis_scodestagingtable   set [Carbohydrates (g)]= [Total Carbohydrate (g)]
where [Carbohydrates (g)]< [Total Carbohydrate (g)]
update t_ko_genesis_scodestagingtable   set [Total Carbohydrate (g)] =[Carbohydrates (g)]
where [Carbohydrates (g)]>[Total Carbohydrate (g)]
update t_ko_genesis_scodestagingtable   set [Carbohydrates (g)]= [Total Carbohydrate (g)]
where [Carbohydrates (g)] is null
update t_ko_genesis_scodestagingtable   set [Total Carbohydrate (g)] =[Carbohydrates (g)]
where [Total Carbohydrate (g)] is null

update t_ko_genesis_scodestagingtable   set [Vitamin B6 (mg)]= [Pyridoxine - B6 (mg)]
where [Vitamin B6 (mg)]< [Pyridoxine - B6 (mg)]
update t_ko_genesis_scodestagingtable   set [Pyridoxine - B6 (mg)] =[Vitamin B6 (mg)]
where [Vitamin B6 (mg)]>[Pyridoxine - B6 (mg)]
update t_ko_genesis_scodestagingtable   set [Pyridoxine - B6 (mg)]= [Vitamin B6 (mg)]
where [Pyridoxine - B6 (mg)] is null or [Pyridoxine - B6 (mg)] = 0
update t_ko_genesis_scodestagingtable   set [Vitamin B6 (mg)] =[Pyridoxine - B6 (mg)]
where [Vitamin B6 (mg)] is null or [Vitamin B6 (mg)] = 0

update t_ko_genesis_scodestagingtable   set [Vitamin A - IU (IU)]= [Vitamin A - Total]
where [Vitamin A - IU (IU)]< [Vitamin A - Total]
update t_ko_genesis_scodestagingtable   set [Vitamin A - Total] =[Vitamin A - IU (IU)]
where [Vitamin A - IU (IU)]>[Vitamin A - Total]
update t_ko_genesis_scodestagingtable   set [Vitamin A - IU (IU)]= [Vitamin A - Total]
where [Vitamin A - IU (IU)] is null
update t_ko_genesis_scodestagingtable   set [Vitamin A - Total] =[Vitamin A - IU (IU)]
where [Vitamin A - Total] is null

update t_ko_genesis_scodestagingtable   set [Sugars (g)]= [Total Sugars (g)]
where [Sugars (g)]< [Total Sugars (g)]
update t_ko_genesis_scodestagingtable   set [Total Sugars (g)] =[Sugars (g)]
where [Sugars (g)]>[Total Sugars (g)]
update t_ko_genesis_scodestagingtable   set [Sugars (g)]= [Total Sugars (g)]
where [Sugars (g)] is null
update t_ko_genesis_scodestagingtable   set [Total Sugars (g)] =[Sugars (g)]
where [Total Sugars (g)] is null

update t_ko_genesis_scodestagingtable   set [Pantothenic (mg)]= [Pantothenic Acid (mg)]
where [Pantothenic (mg)]< [Pantothenic Acid (mg)]
update t_ko_genesis_scodestagingtable   set [Pantothenic Acid (mg)] =[Pantothenic (mg)]
where [Pantothenic (mg)]>[Pantothenic Acid (mg)]
update t_ko_genesis_scodestagingtable   set [Pantothenic (mg)]= [Pantothenic Acid (mg)]
where [Pantothenic (mg)] is null
update t_ko_genesis_scodestagingtable   set [Pantothenic Acid (mg)] =[Pantothenic (mg)]
where [Pantothenic Acid (mg)] is null

update t_ko_genesis_scodestagingtable   set [Dietary Fiber (g)]= [Total Dietary Fiber (g)]
where [Dietary Fiber (g)]< [Total Dietary Fiber (g)]
update t_ko_genesis_scodestagingtable   set [Total Dietary Fiber (g)] =[Dietary Fiber (g)]
where [Dietary Fiber (g)]>[Total Dietary Fiber (g)]
update t_ko_genesis_scodestagingtable   set [Dietary Fiber (g)]= [Total Dietary Fiber (g)]
where [Dietary Fiber (g)] is null
update t_ko_genesis_scodestagingtable   set [Total Dietary Fiber (g)] =[Dietary Fiber (g)]
where [Total Dietary Fiber (g)] is null
Update t_ko_genesis_scodestagingtable set [Dietary Fiber (2016) (g)] = [Total Dietary Fiber (g)]

 --Update Allergens
 update t_ko_genesis_ScodeStagingTable
set [Allergen Milk] = 'T' 
from t_ko_genesis_ScodeStagingTable scode
join t_ko_genesis_ingredient_allergens_sensitivities_staging alsen
on scode.usercode = alsen.specnumber 
and 
alsen.[name] like '06.%'
and alsen.Contains_Flag = 'Known to Contain'

update t_ko_genesis_ScodeStagingTable
set [Allergen Celery] = 'T' 
from t_ko_genesis_ScodeStagingTable scode
join t_ko_genesis_ingredient_allergens_sensitivities_staging alsen
on scode.usercode = alsen.specnumber 
and 
alsen.[name] like '01.%'
and alsen.Contains_Flag = 'Known to Contain'

update t_ko_genesis_ScodeStagingTable
set [Allergen shellfish] = 'T' 
from t_ko_genesis_ScodeStagingTable scode
join t_ko_genesis_ingredient_allergens_sensitivities_staging alsen
on scode.usercode = alsen.specnumber 
and 
(alsen.[name] like '02.%' or alsen.[name] like '13.%')
and alsen.Contains_Flag = 'Known to Contain'

update t_ko_genesis_ScodeStagingTable
set [Allergen eggs] = 'T' 
from t_ko_genesis_ScodeStagingTable scode
join t_ko_genesis_ingredient_allergens_sensitivities_staging alsen
on scode.usercode = alsen.specnumber 
and 
alsen.[name] like '03.%'
and alsen.Contains_Flag = 'Known to Contain'

update t_ko_genesis_ScodeStagingTable
set [Allergen fish] = 'T' 
from t_ko_genesis_ScodeStagingTable scode
join t_ko_genesis_ingredient_allergens_sensitivities_staging alsen
on scode.usercode = alsen.specnumber 
and 
alsen.[name] like '04.%'
and alsen.Contains_Flag = 'Known to Contain'

update t_ko_genesis_ScodeStagingTable
set [Allergen mustard] = 'T' 
from t_ko_genesis_ScodeStagingTable scode
join t_ko_genesis_ingredient_allergens_sensitivities_staging alsen
on scode.usercode = alsen.specnumber 
and 
alsen.[name] like '07.%'
and alsen.Contains_Flag = 'Known to Contain'

update t_ko_genesis_ScodeStagingTable
set [Allergen Tree Nuts] = 'T' 
from t_ko_genesis_ScodeStagingTable scode
join t_ko_genesis_ingredient_allergens_sensitivities_staging alsen
on scode.usercode = alsen.specnumber 
and 
(alsen.[name] like '08.%'or alsen.[name] like '08a.%')
and alsen.Contains_Flag = 'Known to Contain'

update t_ko_genesis_ScodeStagingTable
set [Allergen Peanut] = 'T' 
from t_ko_genesis_ScodeStagingTable scode
join t_ko_genesis_ingredient_allergens_sensitivities_staging alsen
on scode.usercode = alsen.specnumber 
and 
alsen.[name] like '09.%'
and alsen.Contains_Flag = 'Known to Contain'

update t_ko_genesis_ScodeStagingTable
set [Allergen Sesame Seeds] = 'T' 
from t_ko_genesis_ScodeStagingTable scode
join t_ko_genesis_ingredient_allergens_sensitivities_staging alsen
on scode.usercode = alsen.specnumber 
and 
alsen.[name] like '10.%'
and alsen.Contains_Flag = 'Known to Contain'

update t_ko_genesis_ScodeStagingTable
set [Allergen Soy] = 'T' 
from t_ko_genesis_ScodeStagingTable scode
join t_ko_genesis_ingredient_allergens_sensitivities_staging alsen
on scode.usercode = alsen.specnumber 
and 
alsen.[name] like '11.%'
and alsen.Contains_Flag = 'Known to Contain'

update t_ko_genesis_ScodeStagingTable
set [Allergen Lupin] = 'T' 
from t_ko_genesis_ScodeStagingTable scode
join t_ko_genesis_ingredient_allergens_sensitivities_staging alsen
on scode.usercode = alsen.specnumber 
and 
alsen.[name] like '14.%'
and alsen.Contains_Flag = 'Known to Contain'

update t_ko_genesis_ScodeStagingTable 
set [Allergens Crustaceans] = 'T'  
from t_ko_genesis_ScodeStagingTable scode 
join t_ko_genesis_ingredient_allergens_sensitivities_staging alsen 
on scode.usercode = alsen.specnumber  
and  
alsen.[name] like '02.%' 
and alsen.Contains_Flag = 'Known to Contain'

update t_ko_genesis_ScodeStagingTable 
set [Allergen Gluten] = 'T'  
from t_ko_genesis_ScodeStagingTable scode 
join t_ko_genesis_ingredient_allergens_sensitivities_staging alsen 
on scode.usercode = alsen.specnumber  
and  alsen.[name] like '05.%' 
and alsen.Contains_Flag = 'Known to Contain'

update t_ko_genesis_ScodeStagingTable 
set [Allergen Molluscs] = 'T'  
from t_ko_genesis_ScodeStagingTable scode 
join t_ko_genesis_ingredient_allergens_sensitivities_staging alsen 
on scode.usercode = alsen.specnumber  
and  alsen.[name] like '13.%' 
and alsen.Contains_Flag = 'Known to Contain'

update t_ko_genesis_ScodeStagingTable 
set [Allergen Sulphites] = 'T'  
from t_ko_genesis_ScodeStagingTable scode 
join t_ko_genesis_ingredient_allergens_sensitivities_staging alsen 
on scode.usercode = alsen.specnumber  
and  alsen.[name] like '12.%'
 and alsen.Contains_Flag = 'Known to Contain'
 
update t_ko_genesis_ScodeStagingTable 
set [Allergen Wheat] = 'T'  
from t_ko_genesis_ScodeStagingTable scode 
join t_ko_genesis_ingredient_allergens_sensitivities_staging alsen 
on scode.usercode = alsen.specnumber  
and  alsen.[name] like '05.%' 
and alsen.Contains_Flag = 'Known to Contain'

--update t_ko_genesis_scodestagingtable
--set [Iodine (mcg)] = [Iodine (mcg)] * 1000 where usercode in 
--(select specnumber from t_ko_genesis_ingredient_nutrition_Staging
--where nutrient = 'iodine' and per_100gUOM = 'milligrams'
--)

--update t_ko_genesis_scodestagingtable
--set [Selenium (mcg)] = [Selenium (mcg)] * 1000 where usercode in 
--(select specnumber from t_ko_genesis_ingredient_nutrition_Staging
--where nutrient = 'selenium' and per_100gUOM = 'milligrams'
--)

--update t_ko_genesis_scodestagingtable
--set [Vitamin B12 (mcg)] = [Vitamin B12 (mcg)] * 1000 where usercode in 
--(select specnumber from t_ko_genesis_ingredient_nutrition_Staging
--where nutrient = 'vitamin b12' and per_100gUOM = 'milligrams'
--)

--Need milligram to IU conversion for viatimin A,D,and E.

/*
select distinct  usercode, (SUM(itemquantity)/100) TotalItemQuantity 
into #temp
from t_ko_genesis_ScodeStagingTable  
group by usercode
update t_ko_genesis_ScodeStagingTable set	[Added Sugar] =[Added Sugar] * t.totalitemquantity from t_ko_genesis_ScodeStagingTable scode join #temp t on t.usercode = scode.usercode
update t_ko_genesis_ScodeStagingTable set	[Alcohol] =	[Alcohol] * t.totalitemquantity from t_ko_genesis_ScodeStagingTable scode join #temp t on t.usercode = scode.usercode
update t_ko_genesis_ScodeStagingTable set	[Ash] =	[Ash] * t.totalitemquantity from t_ko_genesis_ScodeStagingTable scode join #temp t on t.usercode = scode.usercode
update t_ko_genesis_ScodeStagingTable set	[beta Carotene] =	[beta Carotene] * t.totalitemquantity from t_ko_genesis_ScodeStagingTable scode join #temp t on t.usercode = scode.usercode
update t_ko_genesis_ScodeStagingTable set	[Caffeine] =	[Caffeine] * t.totalitemquantity from t_ko_genesis_ScodeStagingTable scode join #temp t on t.usercode = scode.usercode
update t_ko_genesis_ScodeStagingTable set	[Calcium] =	[Calcium] * t.totalitemquantity from t_ko_genesis_ScodeStagingTable scode join #temp t on t.usercode = scode.usercode
update t_ko_genesis_ScodeStagingTable set	[Calories US] =	[Calories US] * t.totalitemquantity from t_ko_genesis_ScodeStagingTable scode join #temp t on t.usercode = scode.usercode
update t_ko_genesis_ScodeStagingTable set	[Total Carbohydrate] =	[Total Carbohydrate] * t.totalitemquantity from t_ko_genesis_ScodeStagingTable scode join #temp t on t.usercode = scode.usercode
update t_ko_genesis_ScodeStagingTable set	[Chloride] =	[Chloride] * t.totalitemquantity from t_ko_genesis_ScodeStagingTable scode join #temp t on t.usercode = scode.usercode
update t_ko_genesis_ScodeStagingTable set	[Cholesterol] =	[Cholesterol] * t.totalitemquantity from t_ko_genesis_ScodeStagingTable scode join #temp t on t.usercode = scode.usercode
update t_ko_genesis_ScodeStagingTable set	[Copper] =	[Copper] * t.totalitemquantity from t_ko_genesis_ScodeStagingTable scode join #temp t on t.usercode = scode.usercode
update t_ko_genesis_ScodeStagingTable set	[Total Dietary Fiber] =	[Total Dietary Fiber] * t.totalitemquantity from t_ko_genesis_ScodeStagingTable scode join #temp t on t.usercode = scode.usercode
update t_ko_genesis_ScodeStagingTable set	[DietaryFiber2016] =	[DietaryFiber2016] * t.totalitemquantity from t_ko_genesis_ScodeStagingTable scode join #temp t on t.usercode = scode.usercode
update t_ko_genesis_ScodeStagingTable set	[total Fat] =	[total Fat] * t.totalitemquantity from t_ko_genesis_ScodeStagingTable scode join #temp t on t.usercode = scode.usercode
update t_ko_genesis_ScodeStagingTable set	[Folate] =	[Folate] * t.totalitemquantity from t_ko_genesis_ScodeStagingTable scode join #temp t on t.usercode = scode.usercode
update t_ko_genesis_ScodeStagingTable set	[Iodine] =	[Iodine] * t.totalitemquantity from t_ko_genesis_ScodeStagingTable scode join #temp t on t.usercode = scode.usercode
update t_ko_genesis_ScodeStagingTable set	[Iron] =	[Iron] * t.totalitemquantity from t_ko_genesis_ScodeStagingTable scode join #temp t on t.usercode = scode.usercode
update t_ko_genesis_ScodeStagingTable set	[Magnesium] =	[Magnesium] * t.totalitemquantity from t_ko_genesis_ScodeStagingTable scode join #temp t on t.usercode = scode.usercode
update t_ko_genesis_ScodeStagingTable set	[Manganese] =	[Manganese] * t.totalitemquantity from t_ko_genesis_ScodeStagingTable scode join #temp t on t.usercode = scode.usercode
update t_ko_genesis_ScodeStagingTable set	[MonoFat] =	[MonoFat] * t.totalitemquantity from t_ko_genesis_ScodeStagingTable scode join #temp t on t.usercode = scode.usercode
update t_ko_genesis_ScodeStagingTable set	[Pantothenic Acid] =	[Pantothenic Acid] * t.totalitemquantity from t_ko_genesis_ScodeStagingTable scode join #temp t on t.usercode = scode.usercode
update t_ko_genesis_ScodeStagingTable set	[Phosphorus] =	[Phosphorus] * t.totalitemquantity from t_ko_genesis_ScodeStagingTable scode join #temp t on t.usercode = scode.usercode
update t_ko_genesis_ScodeStagingTable set	[Polyunsaturated Fat] =	[Polyunsaturated Fat] * t.totalitemquantity from t_ko_genesis_ScodeStagingTable scode join #temp t on t.usercode = scode.usercode
update t_ko_genesis_ScodeStagingTable set	[Potassium] =	[Potassium] * t.totalitemquantity from t_ko_genesis_ScodeStagingTable scode join #temp t on t.usercode = scode.usercode
update t_ko_genesis_ScodeStagingTable set	[Protein] =	[Protein] * t.totalitemquantity from t_ko_genesis_ScodeStagingTable scode join #temp t on t.usercode = scode.usercode
update t_ko_genesis_ScodeStagingTable set	[Saturated Fat] =	[Saturated Fat] * t.totalitemquantity from t_ko_genesis_ScodeStagingTable scode join #temp t on t.usercode = scode.usercode
update t_ko_genesis_ScodeStagingTable set	[Selenium] =	[Selenium] * t.totalitemquantity from t_ko_genesis_ScodeStagingTable scode join #temp t on t.usercode = scode.usercode
update t_ko_genesis_ScodeStagingTable set	[Sodium] =	[Sodium] * t.totalitemquantity from t_ko_genesis_ScodeStagingTable scode join #temp t on t.usercode = scode.usercode
update t_ko_genesis_ScodeStagingTable set	[Total Sugars] =	[Total Sugars] * t.totalitemquantity from t_ko_genesis_ScodeStagingTable scode join #temp t on t.usercode = scode.usercode
update t_ko_genesis_ScodeStagingTable set	[Trans Fatty Acid] =	[Trans Fatty Acid] * t.totalitemquantity from t_ko_genesis_ScodeStagingTable scode join #temp t on t.usercode = scode.usercode
update t_ko_genesis_ScodeStagingTable set	[Vitamin A - Total] =	[Vitamin A - Total] * t.totalitemquantity from t_ko_genesis_ScodeStagingTable scode join #temp t on t.usercode = scode.usercode
update t_ko_genesis_ScodeStagingTable set	[Vitamin B1] =	[Vitamin B1] * t.totalitemquantity from t_ko_genesis_ScodeStagingTable scode join #temp t on t.usercode = scode.usercode
update t_ko_genesis_ScodeStagingTable set	[Vitamin B2] =	[Vitamin B2] * t.totalitemquantity from t_ko_genesis_ScodeStagingTable scode join #temp t on t.usercode = scode.usercode
update t_ko_genesis_ScodeStagingTable set	[Vitamin B3] =	[Vitamin B3] * t.totalitemquantity from t_ko_genesis_ScodeStagingTable scode join #temp t on t.usercode = scode.usercode
update t_ko_genesis_ScodeStagingTable set	[Vitamin B6] =	[Vitamin B6] * t.totalitemquantity from t_ko_genesis_ScodeStagingTable scode join #temp t on t.usercode = scode.usercode
update t_ko_genesis_ScodeStagingTable set	[Vitamin B12] =	[Vitamin B12] * t.totalitemquantity from t_ko_genesis_ScodeStagingTable scode join #temp t on t.usercode = scode.usercode
update t_ko_genesis_ScodeStagingTable set	[Vitamin C] =	[Vitamin C] * t.totalitemquantity from t_ko_genesis_ScodeStagingTable scode join #temp t on t.usercode = scode.usercode
update t_ko_genesis_ScodeStagingTable set	[Vitamin D] =	[Vitamin D] * t.totalitemquantity from t_ko_genesis_ScodeStagingTable scode join #temp t on t.usercode = scode.usercode
update t_ko_genesis_ScodeStagingTable set	[Vitamin E] =	[Vitamin E] * t.totalitemquantity from t_ko_genesis_ScodeStagingTable scode join #temp t on t.usercode = scode.usercode
update t_ko_genesis_ScodeStagingTable set	[VitaminK] =	[VitaminK] * t.totalitemquantity from t_ko_genesis_ScodeStagingTable scode join #temp t on t.usercode = scode.usercode
update t_ko_genesis_ScodeStagingTable set	[Moisture] =	[Moisture] * t.totalitemquantity from t_ko_genesis_ScodeStagingTable scode join #temp t on t.usercode = scode.usercode
update t_ko_genesis_ScodeStagingTable set	[Zinc] =	[Zinc] * t.totalitemquantity from t_ko_genesis_ScodeStagingTable scode join #temp t on t.usercode = scode.usercode
drop table #temp
*/
update t_ko_genesis_ScodeStagingTable
set itemprimarykey = uc.primarykey 
from gendata.dbo.basefoodusercode uc
join gendata.dbo.basefoodname bfn
on uc.primarykey = bfn.primarykey
join t_ko_genesis_ScodeStagingTable scode
on scode.itemname = bfn.description
and bfn.type = 1
and uc.primarykey >= 2000000

update t_ko_genesis_ScodeStagingTable
set itemusercode = uc.usercode 
from gendata.dbo.basefoodusercode uc
join gendata.dbo.basefoodname bfn
on uc.primarykey = bfn.primarykey
join t_ko_genesis_ScodeStagingTable scode
on scode.itemprimarykey = uc.primarykey
and bfn.type = 1
and uc.primarykey >= 2000000


update t_ko_genesis_ScodeStagingTable
set item_doctype = 1






 
GO

