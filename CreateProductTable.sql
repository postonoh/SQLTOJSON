USE [Shelby]
GO
/****** Object:  Table [dbo].[Product]    Script Date: 1/2/2020 11:25:25 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Product](
	[ProductID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[Color] [nvarchar](15) NULL,
	[Size] [nvarchar](5) NULL,
	[Price] [money] NOT NULL,
	[Quantity] [int] NULL,
	[Data] [nvarchar](4000) NULL,
	[Tags] [nvarchar](4000) NULL,
PRIMARY KEY CLUSTERED 
(
	[ProductID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET IDENTITY_INSERT [dbo].[Product] ON 

GO
INSERT [dbo].[Product] ([ProductID], [Name], [Color], [Size], [Price], [Quantity], [Data], [Tags]) VALUES (15, N'Adjustable Race', N'Magenta', N'62', 100.0000, 75, N'{"Type":"Part","MadeIn":"China"}', NULL)
GO
INSERT [dbo].[Product] ([ProductID], [Name], [Color], [Size], [Price], [Quantity], [Data], [Tags]) VALUES (16, N'Bearing Ball', N'Magenta', N'62', 15.9900, 90, N'{"ManufacturingCost":11.672700,"Type":"Part","MadeIn":"China"}', N'["promo"]')
GO
INSERT [dbo].[Product] ([ProductID], [Name], [Color], [Size], [Price], [Quantity], [Data], [Tags]) VALUES (17, N'BB Ball Bearing', N'Magenta', N'62', 28.9900, 80, N'{"ManufacturingCost":21.162700,"Type":"Part","MadeIn":"China"}', NULL)
GO
INSERT [dbo].[Product] ([ProductID], [Name], [Color], [Size], [Price], [Quantity], [Data], [Tags]) VALUES (18, N'Blade', N'Magenta', N'62', 18.0000, 45, N'{}', N'["new"]')
GO
INSERT [dbo].[Product] ([ProductID], [Name], [Color], [Size], [Price], [Quantity], [Data], [Tags]) VALUES (19, N'Sport-100 Helmet, Red', N'Red', N'72', 41.9900, 38, N'{"ManufacturingCost":30.652700,"Type":"Еquipment","MadeIn":"China"}', N'["promo"]')
GO
INSERT [dbo].[Product] ([ProductID], [Name], [Color], [Size], [Price], [Quantity], [Data], [Tags]) VALUES (20, N'Sport-100 Helmet, Black', N'Black', N'72', 31.4900, 60, N'{"ManufacturingCost":22.987700,"Type":"Еquipment","MadeIn":"China"}', N'["new","promo"]')
GO
INSERT [dbo].[Product] ([ProductID], [Name], [Color], [Size], [Price], [Quantity], [Data], [Tags]) VALUES (21, N'Mountain Bike Socks, M', N'White', N'M', 560.9900, 30, N'{"Type":"Clothes"}', N'["sales","promo"]')
GO
INSERT [dbo].[Product] ([ProductID], [Name], [Color], [Size], [Price], [Quantity], [Data], [Tags]) VALUES (22, N'Mountain Bike Socks, L', N'White', N'L', 120.9900, 20, N'{"ManufacturingCost":88.322700,"Type":"Clothes"}', N'["sales","promo"]')
GO
INSERT [dbo].[Product] ([ProductID], [Name], [Color], [Size], [Price], [Quantity], [Data], [Tags]) VALUES (23, N'Long-Sleeve Logo Jersey, XL', N'Multi', N'XL', 44.9900, 60, N'{"ManufacturingCost":32.842700,"Type":"Clothes"}', N'["sales","promo"]')
GO
INSERT [dbo].[Product] ([ProductID], [Name], [Color], [Size], [Price], [Quantity], [Data], [Tags]) VALUES (24, N'Road-650 Black, 52', N'Black', N'52', 704.6900, 70, N'{"Type":"Bike","MadeIn":"UK"}', NULL)
GO
INSERT [dbo].[Product] ([ProductID], [Name], [Color], [Size], [Price], [Quantity], [Data], [Tags]) VALUES (25, N'Mountain-100 Silver, 38', N'Silver', N'38', 359.9900, 45, N'{"ManufacturingCost":262.792700,"Type":"Bike","MadeIn":"UK"}', N'["promo"]')
GO
INSERT [dbo].[Product] ([ProductID], [Name], [Color], [Size], [Price], [Quantity], [Data], [Tags]) VALUES (26, N'Road-250 Black, 48', N'Black', N'48', 299.0200, 25, N'{"ManufacturingCost":218.284600,"Type":"Bike","MadeIn":"UK"}', N'["new","promo"]')
GO
INSERT [dbo].[Product] ([ProductID], [Name], [Color], [Size], [Price], [Quantity], [Data], [Tags]) VALUES (27, N'ML Bottom Bracket', NULL, NULL, 101.2400, 50, N'{"Type":"Part","MadeIn":"China"}', NULL)
GO
INSERT [dbo].[Product] ([ProductID], [Name], [Color], [Size], [Price], [Quantity], [Data], [Tags]) VALUES (28, N'HL Bottom Bracket', NULL, NULL, 121.4900, 65, N'{"ManufacturingCost":88.687700,"Type":"Part","MadeIn":"China"}', NULL)
GO
SET IDENTITY_INSERT [dbo].[Product] OFF
GO
