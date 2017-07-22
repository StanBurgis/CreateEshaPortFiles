select description, bfn.primarykey, modifydate, ubfgi.Name, bfg.GroupKey
from dbo.BaseFoodGroup bfg
inner join dbo.UBaseFoodGroupInfo ubfgi on ubfgi.GroupKey = bfg.GroupKey
inner join dbo.BaseFoodName bfn on bfn.PrimaryKey = bfg.PrimaryKey
where ispublished=1
--and (ubfgi.Name like 'PDS%' or ubfgi.Name like 'LDS%')
--and description Like '[a-f]%'
--and ubfgi.Name in ('Freestyle Published','PDS Published','Puerto Rico Published')
and ubfgi.Name in ('LDS Published')
order by description

--this re-publishes any recipes from the backup table.  BEFORE DELETING YOU SHOULD BACKUP
/*
insert into BaseFoodGroup (PrimaryKey, GroupKey)  
(select bak.PrimaryKey, bak.GroupKey from BaseFoodGroup_Backup20170221 bak 
where not exists 
	(select null from BaseFoodGroup bfg where bfg.PrimaryKey = bak.PrimaryKey and bfg.GroupKey=bak.GroupKey)
)
*/

--this is the delete.  this unpublishes the recipes with the matching primarykey
/*
delete
from dbo.BaseFoodGroup
from BaseFoodGroup bfg
inner join BaseFoodName bfn on bfn.PrimaryKey = bfg.PrimaryKey
inner join dbo.UBaseFoodGroupInfo ubfgi on ubfgi.GroupKey = bfg.GroupKey
where
	ubfgi.Name='LDS Published'
	and IsPublished='1'	
	--and description not Like '[a-f]%'

*/