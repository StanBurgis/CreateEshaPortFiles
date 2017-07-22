
--Updated Recipe Feb 16 2017  4:19PM  , Updated Recipe Feb 24 2017  , Updated Recipe Feb 24 2017  3:41PM  
select * from gendata.dbo.basefoodmemo
where MemoType = 2
and memo like '%Updated Recipe Mar 21%'--4483
order by TableKey desc --147
--Get total count of records updated
select distinct  eps.primarykey from t_ko_genesis_EshaPortalStaging eps
join gendata.dbo.BaseFoodMemo bfm
on eps.PrimaryKey = bfm.PrimaryKey 
and bfm.Memo like '%Updated Recipe Mar 21%'--147


--1) @start@ complete on all records
select * from gendata.dbo.BaseFoodMemo where PrimaryKey in 
(select bfm.primarykey from t_ko_genesis_EshaPortalStaging eps
join gendata.dbo.BaseFoodMemo bfm
on eps.PrimaryKey = bfm.PrimaryKey 
and bfm.Memo like '%Updated Recipe Mar 21%')
and Memo  like '@start@%'--147
and memotype = 1
order by primarykey 

--2) @end@ complete on all records
select * from gendata.dbo.BaseFoodMemo where PrimaryKey in 
(select bfm.primarykey from t_ko_genesis_EshaPortalStaging eps
join gendata.dbo.BaseFoodMemo bfm
on eps.PrimaryKey = bfm.PrimaryKey 
and bfm.Memo like '%Updated Recipe Mar 21%')
and Memo like '@%end@'--147
----3) Distinct usercodes in COSD match the sum of BFUC matches and exception report kick-outs
--select bfm.* from t_ko_genesis_EshaPortalStaging eps
--join gendata.dbo.BaseFoodMemo bfm
--on eps.PrimaryKey = bfm.PrimaryKey 
--and bfm.Memo like '%Updated Recipe Mar 11 2017  2:38AM%'

--select distinct specnumber from t_ko_genesis_formula_COSD_Data

--4) Usercodes in EPS match number of records updated in BFM
select  distinct * from t_ko_genesis_EshaPortalStaging--147
select * from t_ko_genesis_EshaPortalStaging eps
 left
 join gendata.dbo.BaseFoodMemo bfm
on eps.PrimaryKey = bfm.PrimaryKey 
and bfm.Memo like '%Updated Recipe Mar 11 2017  2:38AM%'--147
where bfm.PrimaryKey is null

--5) char 10 +13 between every attribute| value pair
select * from gendata.dbo.BaseFoodMemo where PrimaryKey in 
(select bfm.primarykey from t_ko_genesis_EshaPortalStaging eps
join gendata.dbo.BaseFoodMemo bfm
on eps.PrimaryKey = bfm.PrimaryKey 
and bfm.Memo like '%Updated Recipe Mar 21%')
and Memo like '%'+char(13)+CHAR(10)+'%' --4480
--and Memo like '%crlf%'--0
and MemoType = 1 --147
--and MemoType = 2 --147
and Memo like '%Updated Recipe Mar 21%'--4482

--6) Join of old Notes1 to our EndUse has a char10+13
select * from gendata.dbo.BaseFoodMemo where PrimaryKey in 
(select bfm.primarykey from t_ko_genesis_EshaPortalStaging eps
join gendata.dbo.BaseFoodMemo bfm
on eps.PrimaryKey = bfm.PrimaryKey 
and bfm.Memo like '%Updated Recipe Mar 21%')
and Memo like '%'+char(13)+CHAR(10)+'enduse%'
and Memo not like '@start@enduse%'
and MemoType = 1--12

--7) No truncation
--Verified through data inspection using notepad++

--8) No [CRLF] in BFM
--Verified in earlier query
--9) No char 09s
select * from gendata.dbo.BaseFoodMemo where PrimaryKey in 
(select bfm.primarykey from t_ko_genesis_EshaPortalStaging eps
join gendata.dbo.BaseFoodMemo bfm
on eps.PrimaryKey = bfm.PrimaryKey 
and bfm.Memo like '%Updated Recipe Mar 21%')
and Memo like '%'+char(09)+'%'--0

--10) No char 10+13 directly after @start@ and directly before @end@
select * from gendata.dbo.BaseFoodMemo where PrimaryKey in 
(select bfm.primarykey from t_ko_genesis_EshaPortalStaging eps
join gendata.dbo.BaseFoodMemo bfm
on eps.PrimaryKey = bfm.PrimaryKey 
and bfm.Memo like '%Updated Recipe Mar 11 2017  2:38AM%')
--and Memo like '@start@'+char(13)+CHAR(10)+'%'--0
and Memo like '%'+char(13)+CHAR(10)+'@end@'--0


