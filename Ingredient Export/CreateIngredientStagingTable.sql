USE [DaVinci_TEST]
GO

/****** Object:  StoredProcedure [dbo].[CreateIngredientStagingTable]    Script Date: 07/21/2017 19:51:47 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/*
Created 02/08/2017 by Stan Burgis
The purpose of this sproc is to populate the Ingredient Staging table
*/
 
CREATE procedure [dbo].[CreateIngredientStagingTable]
as


truncate table t_ko_genesis_IngredientStagingTable --Clear out from last run


--_Step one:Select all new entries from the ingredient composition table
insert into [t_ko_genesis_IngredientStagingTable]
	(
	[Name] ,
	[GramWeight]
	 )
(select  distinct Component,100 from t_ko_genesis_Ingredient_Composition_staging

where processeddate = '1900-01-01 00:00:00.000'
and  component not in
(
select comp.component from  t_ko_genesis_Ingredient_composition_staging comp
where component  in
(
select description from 
gendata.dbo.basefoodname 
where primarykey >= 2000000
and type = 1
)))
--Step 2 update usercode 
declare @maxUsercode int
set @maxusercode = 
(
select ((substring(max(uc.usercode),3,( len(max (uc.usercode)))))) from gendata.dbo.basefoodusercode uc
join 
(
select usercode, isnumeric((substring(max(usercode),3,( len(max (usercode)))))) as IsNumeric from gendata.dbo.basefoodusercode
where left(usercode,2) = 'd_'
group by usercode
)  as t 
on uc.usercode = t.usercode
where t.isnumeric = 1
)
update t_ko_genesis_ingredientstagingtable
set usercode = 'd_'+cast((@maxusercode+tablekey) as varchar(max))






--update [t_ko_genesis_IngredientStagingTable]
--set CommonName = 'Unmatched Picasso Component'
--where UserCode is null


GO

