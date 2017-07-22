--Select * From gendata.dbo.basefoodmemo
--Where CharIndex(nchar(65533) COLLATE Latin1_General_BIN2, memo) > 0

select * from gendata.dbo.basefoodmemo
where memo  like '%'+nchar(65533) COLLATE Latin1_General_BIN2+'%'


update gendata.dbo.basefoodmemo
set memo = replace(memo,nchar(65533) COLLATE Latin1_General_BIN2,'')
update gendata.dbo.basefoodmemo
set memo = replace(memo,'BARQS','BARQ''S')
update gendata.dbo.basefoodmemo
set memo = replace(memo,'SEAGRAMS','SEAGRAMS''S')
update gendata.dbo.basefoodmemo
set memo = replace(memo,'FS Juice  Frozen','FS Juice – Frozen')
update gendata.dbo.basefoodmemo
set memo = replace(memo,'FS Juice  Syrup','FS Juice – Syrup')
update gendata.dbo.basefoodmemo
set memo = replace(memo,'CRME','CR''ME')
update gendata.dbo.basefoodmemo
set memo = replace(memo,'POPPIN','POPPIN''')
update gendata.dbo.basefoodmemo
set memo = replace(memo,'ORCHARDS','ORCHARD''S')
update gendata.dbo.basefoodmemo
set memo = replace(memo,'FLASHIN','FLASHIN''')
update gendata.dbo.basefoodmemo
set memo = replace(memo,'ANNNES','ANNE''S')
update gendata.dbo.basefoodmemo
set memo = replace(memo,'FS JUICE  MCDONALDS','FS JUICE – MCDONALDS')
update gendata.dbo.basefoodmemo
set memo = replace(memo,'FS JUICE  ASEPTIC','FS JUICE – ACEPTIC')
