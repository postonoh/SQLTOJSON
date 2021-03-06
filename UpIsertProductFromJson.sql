USE [Shelby]
GO
/****** Object:  StoredProcedure [dbo].[UpsertProductFromJson]    Script Date: 1/2/2020 11:33:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[UpIsertProductFromJson](@ProductID int, @ProductJson NVARCHAR(MAX))
AS BEGIN

	MERGE INTO dbo.Product
	USING ( SELECT Name,Color,Size,Price,Quantity,Data,Tags
			FROM OPENJSON(@ProductJson)
				WITH (
					Name nvarchar(100) N'strict $."Name"',
					Color nvarchar(30),
					Size nvarchar(10),
					Price money N'strict $."Price"',
					Quantity int,
					Data nvarchar(max) AS JSON,
					Tags nvarchar(max) AS JSON)) as json
	ON (dbo.Product.ProductID = @ProductID)
	WHEN MATCHED THEN 
		UPDATE SET
			Name = json.Name,
			Color = json.Color,
			Size = json.Size,
			Price = json.Price,
			Quantity = json.Quantity,
			Data = json.Data,
			Tags = json.Tags
	WHEN NOT MATCHED THEN 
		INSERT (Name,Color,Size,Price,Quantity,Data,Tags)
		VALUES (json.Name,json.Color,json.Size,json.Price,json.Quantity,json.Data,json.Tags);
END
