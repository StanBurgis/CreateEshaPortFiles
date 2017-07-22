USE [DaVinci_TEST]
GO

/****** Object:  StoredProcedure [dbo].[CreateNotes2SquishTable]    Script Date: 07/21/2017 19:52:10 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE procedure [dbo].[CreateNotes2SquishTable]
AS
DELETE [t_ko_genesis_squish2] 
INSERT INTO [t_ko_genesis_squish2] 
SELECT specNumber,
Notes2='EndUse | ' + ISNULL(EndUse, ' ') +  '[crlf]' + 
'ISSCOMProductCode | ' + ISNULL(ISSCOMProductCode, ' ') +  '[crlf]' + 
'LocationOfSale |  '+ ISNULL(LocationOfSale, ' ') +  '[crlf]' +  
'ISSCOMPhysicalState | ' + ISNULL(ISSCOMPhysicalState, ' ') +  '[crlf]' +  
'PARType | ' + ISNULL(PARType, ' ') +  '[crlf]' +  
'ProductName | ' + ISNULL(ProductName, ' ') +  '[crlf]' +    
'ReplaceBBN  | ' + ISNULL(ReplaceBBN, ' ')  
 FROM(
SELECT specNumber,

       ProductName= dbo.UniqueList(STUFF((SELECT ';' + ProductName 
                    FROM   t_ko_genesis_formula_COSD_Data T1
                    WHERE  T1.specNumber = T.specNumber
                    ORDER  BY specNumber
                    FOR XML
             PATH(''), type).value('.', 'varchar(max)'), 1, 1, ''),';'),
             
              
       ISSCOMProductCode= dbo.UniqueList(STUFF((SELECT ';' + ISSCOMProductCode
                    FROM   t_ko_genesis_formula_COSD_Data T1
                    WHERE  T1.specNumber = T.specNumber
                    ORDER  BY specNumber
                    FOR XML
             PATH(''), type).value('.', 'varchar(max)'), 1, 1, ''),';'),
             
        LocationOfSale= dbo.UniqueList(STUFF((SELECT';' + LocationOfSale
                    FROM   t_ko_genesis_formula_COSD_Data T1
                    WHERE  T1.specNumber = T.specNumber
                    ORDER  BY specNumber
                    FOR XML
             PATH(''), type).value('.', 'varchar(max)'), 1, 1, ''),';'),
                                        
       EndUse= dbo.UniqueList(STUFF((SELECT';' + EndUse  
                    FROM   t_ko_genesis_formula_COSD_Data T1
                    WHERE  T1.specNumber = T.specNumber
                    ORDER  BY specNumber
                    FOR XML
             PATH(''), type).value('.', 'varchar(max)'), 1, 1, ''),';'),
                                              
       ISSCOMPhysicalState= dbo.UniqueList(STUFF((SELECT';' + ISSCOMPhysicalState 
                    FROM   t_ko_genesis_formula_COSD_Data T1
                    WHERE  T1.specNumber = T.specNumber
                    ORDER  BY specNumber
                    FOR XML
             PATH(''), type).value('.', 'varchar(max)'), 1, 1, ''),';'),
            
                                              
       PARType= dbo.UniqueList(STUFF((SELECT';' + PARType 
                    FROM   t_ko_genesis_formula_COSD_Data T1
                    WHERE  T1.specNumber = T.specNumber
                    ORDER  BY specNumber
                    FOR XML
             PATH(''), type).value('.', 'varchar(max)'), 1, 1, ''),';'),
                                              
       ReplaceBBN= dbo.UniqueList(STUFF((SELECT';' + ReplaceBBN
                    FROM   t_ko_genesis_formula_COSD_Data T1
                    WHERE  T1.specNumber = T.specNumber
                    ORDER  BY specNumber
                    FOR XML
             PATH(''), type).value('.', 'varchar(max)'), 1, 1, '') ,';')
             
                                            
                                             
FROM   t_ko_genesis_formula_COSD_Data T where CAST(InsertDate AS DATE) > CAST(ProcessedDate  AS DATE) 


) T 

  insert into t_ko_genesis_squish2
  select   uc.usercode,sq.notes2 
  from gendata.dbo.BaseFoodUserCode uc
  join t_ko_genesis_squish2 sq
  on uc.usercode like convert (nvarchar(max),sq.SpecNumber)+'%'
  and sq.SpecNumber <> uc.usercode
 order by 1



GO

