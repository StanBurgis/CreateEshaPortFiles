USE [DaVinci_TEST]
GO

/****** Object:  UserDefinedFunction [dbo].[UniqueList]    Script Date: 4/17/2017 9:00:31 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE FUNCTION [dbo].[UniqueList]
(
@List VARCHAR(MAX),
@Delim CHAR
)
RETURNS
VARCHAR(MAX)
AS
BEGIN
DECLARE @ParseList TABLE
(
Item VARCHAR(MAX)
)
DECLARE @list1 VARCHAR(MAX), @Pos INT, @rList VARCHAR(MAX)
SET @list = LTRIM(RTRIM(@list)) + @Delim
SET @pos = CHARINDEX(@delim, @list, 1)
WHILE @pos > 0
BEGIN
SET @list1 = LTRIM(RTRIM(LEFT(@list, @pos -1 )))
IF @list1 <> ''
INSERT INTO @ParseList VALUES (CAST(@list1 AS VARCHAR(MAX)))
SET @list = SUBSTRING(@list, @pos+1, LEN(@list))
SET @pos = CHARINDEX(@delim, @list, 1)
END
SELECT @rlist = COALESCE(@rlist+';',' ') + item
FROM (SELECT DISTINCT Item FROM @ParseList) t
RETURN @rlist
END


GO

