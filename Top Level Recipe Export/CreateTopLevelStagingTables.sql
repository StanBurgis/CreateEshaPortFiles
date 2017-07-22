USE [DaVinci_TEST]
GO

/****** Object:  StoredProcedure [dbo].[CreateTopLevelStagingTables]    Script Date: 07/21/2017 19:52:27 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE  PROCEDURE  [dbo].[CreateTopLevelStagingTables]
 

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
Truncate table t_ko_genesis_TopRecipeStagingTable
begin

insert into t_ko_genesis_TopRecipeStagingTable
([UserCode],
	[Name],
	 [item_usercode],
	 [input_form_num],
	
	[Item_Qty],
	[phase]
	)


select      
SpecNumber,	
Spec_Name,	
input_mat_num,
Input_Formula_Num,

Input_Mat_Qty,
0
from t_ko_genesis_formula_bom_Staging 
   where specnumber not in
   (select usercode from gendata_20170717.dbo.basefoodusercode code
       join gendata_20170717.dbo.basefoodname name
       on code.primarykey = name.primarykey
       where name.type = 2)
  order by specnumber, Input_Formula_Num, input_mat_num


---update from extra attributes table 	
update t_ko_genesis_TopRecipeStagingTable
	set 
	[Volume_Qty] = ex.TOTAL_VOLUME_THEORETICAL_L,
	[Unit_Qty] = ex.TOTAL_WEIGHT_THEORETICAL_KG,
	[DENSITY] = ex.DENSITY_KG_L_CALC
	from t_ko_genesis_TopRecipeStagingTable trst
 join t_ko_genesis_formula_extattr_staging ex
on trst.usercode = ex.specnumber
--and trst.insert_dt = ex.insert_dt


update t_ko_genesis_TopRecipeStagingTable 
set input_form_num = item_usercode
where input_form_num is null

  update t_ko_genesis_TopRecipeStagingTable
  set phase = 1
  where usercode not in
  (select distinct input_form_num from t_ko_genesis_TopRecipeStagingTable)

  update t_ko_genesis_TopRecipeStagingTable
  set phase = 2
  where phase = 0 and usercode not in (select distinct input_form_num from t_ko_genesis_TopRecipeStagingTable where phase =0)

  update t_ko_genesis_TopRecipeStagingTable
  set phase = 3
  where phase =0 and usercode not in (select distinct input_form_num from t_ko_genesis_TopRecipeStagingTable where phase = 0)



--	delete  from t_ko_genesis_TopRecipeStagingTable
--where usercode in 
--(select trst2.usercode from t_ko_genesis_TopRecipeStagingTable trst1
--join t_ko_genesis_TopRecipeStagingTable trst2
--on trst1.UserCode = trst2.UserCode and 
--trst1.Name = trst2.Name and
--trst1.Item_Name = trst2.Item_Name and 
--trst1.Item_Qty = trst2.Item_Qty and 
--trst1.Item_Measure = trst2.Item_Measure and 
--trst1.Volume_Qty = trst2.Volume_Qty and 
--trst2.Volume_Measure = trst1.Volume_Measure and 
--trst1.Unit_Qty = trst2.Unit_Qty and 
--trst1.Unit_Measure = trst2.Unit_Measure and 
--trst1.Supplier = trst2.Supplier and 
--trst1.Phase = trst2.Phase
--where trst1.DENSITY is not null
--and trst2.DENSITY is null)--1721)
--and item_name in 
--(select trst2.item_name from t_ko_genesis_TopRecipeStagingTable trst1
--join t_ko_genesis_TopRecipeStagingTable trst2
--on trst1.UserCode = trst2.UserCode and 
--trst1.Name = trst2.Name and
--trst1.Item_Name = trst2.Item_Name and 
--trst1.Item_Qty = trst2.Item_Qty and 
--trst1.Item_Measure = trst2.Item_Measure and 
--trst1.Volume_Qty = trst2.Volume_Qty and 
--trst2.Volume_Measure = trst1.Volume_Measure and 
--trst1.Unit_Qty = trst2.Unit_Qty and 
--trst1.Unit_Measure = trst2.Unit_Measure and 
--trst1.Supplier = trst2.Supplier and 
--trst1.Phase = trst2.Phase
--where trst1.DENSITY is not null
--and trst2.DENSITY is null)
--and DENSITY is not null

--update t_ko_genesis_toprecipestagingtable set unit_gram_weight = unit_qty*1000
update t_ko_genesis_toprecipestagingtable set Volume_gram_weight = unit_qty*1000

--update t_ko_genesis_TopRecipeStagingTable set Item_Name = 'BEV_WATER:Treated Water'
--where Item_Name = 'Treated Water'

update t_ko_genesis_TopRecipeStagingTable
set item_primary_key = uc.primarykey
from t_ko_genesis_TopRecipeStagingTable trst
join gendata_20170717.dbo.BaseFoodUserCode uc
on uc.UserCode = trst.item_usercode

update t_ko_genesis_TopRecipeStagingTable
set item_doc_type = 2
end

end

 

GO

