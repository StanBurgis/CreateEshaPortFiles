USE [DaVinci_TEST]
GO

/****** Object:  StoredProcedure [dbo].[CreateEshaStagingTable]    Script Date: 07/21/2017 19:51:26 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


/*
Created 12/16/2016 by Stan Burgis
The purpose of this sproc is to create and populate the staging table for the Esha Portal
*/
 
CREATE procedure [dbo].[CreateEshaStagingTable]
as
--IF OBJECT_ID (N't_ko_genesis_EshaPortalStaging', N'U') IS NOT NULL 

-----------XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
--delete from t_ko_genesis_squish2
--where SpecNumber not in
--(

--SELECT left(specnumber, charindex('|', specnumber) -1)
--from t_ko_genesis_squish2
--where SpecNumber like '%|%'
--union
--select specnumber 
-- from t_ko_genesis_squish2
--where SpecNumber like '%|%'
--)


drop table t_ko_genesis_EshaPortalStaging
--else
create table t_ko_genesis_EshaPortalStaging
(ItemKey nvarchar(25),
PrimaryKey nvarchar(15),
UserCode nvarchar(max),
name nvarchar (max),
itemUsercode nvarchar(max),
Note2 nvarchar(max),
Note3 nvarchar(max),
insertedon datetime,
updatedon datetime,
OldNotes2 nvarchar (max)
) ;
---insert Primary Keys into Staging table from Recipe Item Table
INSERT INTO t_ko_genesis_EshaPortalStaging 
(itemkey, itemusercode)
SELECT DISTINCT bfuc.PrimaryKey, bfuc.usercode
from [t_ko_genesis_squish2] sq2
 join gendata.dbo.basefoodusercode bfuc 
on sq2.SpecNumber = bfuc.UserCode --2404

insert into t_ko_genesis_EshaPortalStaging
(PrimaryKey, itemUsercode)
select distinct ri.recipekey,bfuc.UserCode
from [t_ko_genesis_squish2] sq2
 join gendata.dbo.basefoodusercode bfuc 
on sq2.SpecNumber = bfuc.UserCode
 join gendata.dbo.RecipeItem ri
on bfuc.PrimaryKey = ri.itemkey --1807

update t_ko_genesis_EshaPortalStaging 
set itemkey = ri.itemkey
from t_ko_genesis_EshaPortalStaging eps
join gendata.dbo.RecipeItem ri
on ri.recipekey = eps.primarykey

update t_ko_genesis_EshaPortalStaging 
set primarykey =itemkey where primarykey is null 

 update t_ko_genesis_EshaPortalStaging 
 set usercode = bfuc.usercode
 from gendata.dbo.basefoodusercode bfuc
 join t_ko_genesis_EshaPortalStaging eps
 on bfuc.primarykey = eps.primarykey

update t_ko_genesis_EshaPortalStaging 
set updatedon = GETDATE()
 
 
--update staging table with Note3 when there is data in the bfm.memo field
update t_ko_genesis_EshaPortalStaging
set note3 = (bfm.memo + ', Updated Recipe ' + convert(char(19), updatedon)+ '[crlf]')
from t_ko_genesis_EshaPortalStaging eps
join [gendata].[dbo].Basefoodmemo bfm
on eps.itemkey = bfm.Primarykey
where memotype = 2
 
--update staging table with Note3 when there is NO data in the bfm.memo field
update t_ko_genesis_EshaPortalStaging
set note3 = ('Updated Recipe ' + convert(char(19), updatedon)+'[crlf]')
where note3 is null
 


update t_ko_genesis_EshaPortalStaging
set Note2 = sq.Notes2

 from  t_ko_genesis_EshaPortalStaging eps 
join t_ko_genesis_squish2 sq 
on sq.SpecNumber = eps.itemusercode




update t_ko_genesis_EshaPortalStaging 
set note2 = sq.notes2
from t_ko_genesis_EshaPortalStaging eps
join t_ko_genesis_squish2 sq
on eps.usercode = sq.SpecNumber
 

update t_ko_genesis_EshaPortalStaging
set OldNotes2 = (SELECT left(bfm.memo, charindex('EndUse |', bfm.memo) -1))
from t_ko_genesis_EshaPortalStaging eps
join [gendata].[dbo].Basefoodmemo bfm
on eps.primaryKey = bfm.Primarykey
where memotype = 1 and bfm.memo like '%EndUse |%'

update t_ko_genesis_EshaPortalStaging
set OldNotes2 = bfm.memo
from t_ko_genesis_EshaPortalStaging eps
join [gendata].[dbo].Basefoodmemo bfm
on eps.primaryKey = bfm.Primarykey
where memotype = 1 and bfm.memo NOT like '%EndUse |%'
 
  UPDATE dbo.t_ko_genesis_EshaPortalStaging
 SET note2 = ('@start@' + note2)
 WHERE note2 NOT LIKE '%@start@%'
 AND (OldNotes2 IS NULL
 OR oldnotes2 = '')
 
 
 update t_ko_genesis_EshaPortalStaging
set Note2 = (
Note2 + '@end@')
 WHERE note2 NOT LIKE '%@end@%'
 AND (OldNotes2 IS NULL
 OR  oldnotes2 = '')
 
 
  update t_ko_genesis_EshaPortalStaging
set Note2 = (OldNotes2 +
Note2 + '@end@')
 WHERE note2 NOT LIKE '%@end@%'
 AND oldnotes2 IS NOT null
 
-- Update [dbo].[t_ko_genesis_EshaPortalStaging] set note2 = REPLACE(note2,'@end@@start@',' ')
  
 Update [dbo].[t_ko_genesis_EshaPortalStaging] set note2 = REPLACE(note2,'EndUse','@start@EndUse')
 WHERE note2 NOT LIKE '@start@%'
 
  Update [dbo].[t_ko_genesis_EshaPortalStaging] set note2 = REPLACE(note2,'@end@EndUse','EndUse')

 update t_ko_genesis_EshaPortalStaging
set note2 = REPLACE(note2,'enduse', '[crlf]enduse')
where note2 not like '%@start@enduse%'


 update t_ko_genesis_EshaPortalStaging
set note2 = REPLACE(note2,'@start@[crlf][crlf]', '@start@')

update t_ko_genesis_EshaPortalStaging
set Note2 = REPLACE(note2, '[crlf]', char(13)+ char(10))

update t_ko_genesis_EshaPortalStaging
set Note2  = replace (note2, CHAR(13)+CHAR(10)+ CHAR(13)+CHAR(10), CHAR(13)+char(10))
update t_ko_genesis_EshaPortalStaging
set Note2 = REPLACE(note2,  char(13)+ char(10),'[crlf]')

update t_ko_genesis_EshaPortalStaging
set note2 = replace (note2, char(09),'')


update t_ko_genesis_EshaPortalStaging
set name = bfn.description
from t_ko_genesis_EshaPortalStaging eps
join gendata.dbo.BaseFoodName bfn 
on bfn.PrimaryKey = eps.PrimaryKey








GO

