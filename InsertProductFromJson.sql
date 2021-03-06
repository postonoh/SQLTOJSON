USE [Shelby]
GO
/****** Object:  StoredProcedure [dbo].[InsertProductFromJson]    Script Date: 1/2/2020 11:33:51 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[InsertProductFromJson](@ProductJson NVARCHAR(MAX))
AS BEGIN

	INSERT INTO dbo.Product(Name,Color,Size,Price,Quantity,Data,Tags)
	OUTPUT  INSERTED.ProductID
	SELECT Name,Color,Size,Price,Quantity,Data,Tags
	FROM OPENJSON(@ProductJson)
		WITH (	Name nvarchar(100) N'strict $."Name"',
				Color nvarchar(30),
				Size nvarchar(10),
				Price money N'strict $."Price"',
				Quantity int,
				Data nvarchar(max) AS JSON,
				Tags nvarchar(max) AS JSON) as json
END
