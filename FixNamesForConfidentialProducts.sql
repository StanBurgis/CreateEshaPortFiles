--begin tran
--update cosd 
--set cosd.productname = ri.itemname
--from t_ko_genesis_EshaPortalStaging eps
--left join gendata.dbo.recipeitem ri
--on eps.itemkey = ri.itemKey
--left join t_ko_genesis_formula_COSD_Data cosd
--on cosd.SpecNumber = eps.UserCode
--where eps.PrimaryKey is not null

select distinct cosd.ProductName COSD_Name, ri.ItemName  RecipeItem_name, eps.PrimaryKey eps_itemkey, ri.ItemKey RecipeItem_ItemKey,cosd.SpecNumber COSD_SpecNumber
,uc.usercode bfuc_UserCode
from t_ko_genesis_formula_COSD_Data cosd
join gendata.dbo.BaseFoodUserCode uc
on cosd.SpecNumber = uc.UserCode
join gendata.dbo.RecipeItem ri
on uc.PrimaryKey = ri.ItemKey
join t_ko_genesis_EshaPortalStaging eps
on eps.primarykey = ri.ItemKey 

select * from t_ko_genesis_EshaPortalStaging