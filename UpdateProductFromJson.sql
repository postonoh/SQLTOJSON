USE [Shelby]
GO
/****** Object:  StoredProcedure [dbo].[UpdateProductFromJson]    Script Date: 1/2/2020 11:32:25 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[UpdateProductFromJson](@ProductID int, @ProductJson NVARCHAR(MAX))
AS BEGIN

	UPDATE dbo.Product SET
		Name = json.Name,
		Color = json.Color,
		Size = json.Size,
		Price = json.Price,
		Quantity = json.Quantity,
		Data = ISNULL(json.Data, dbo.Product.Data),
		Tags = ISNULL(json.Tags,dbo.Product.Tags)
	FROM OPENJSON(@ProductJson)
		WITH (	Name nvarchar(100) N'strict $."Name"',
				Color nvarchar(30),
				Size nvarchar(10),
				Price money N'strict $."Price"',
				Quantity int,
				Data nvarchar(max) AS JSON,
				Tags nvarchar(max) AS JSON) as json
	WHERE dbo.Product.ProductID = @ProductID

END
