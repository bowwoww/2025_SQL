if exists (select * from sys.databases where name = 'GoodStore')
    drop database GoodStore;
GO

CREATE DATABASE [GoodStore]
GO

USE [GoodStore]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Category](
	[CateID] [nchar](2) NOT NULL,
	[CateName] [nvarchar](20) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[CateID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Member](
	[MemberID] [nchar](6) NOT NULL,
	[Name] [nvarchar](27) NOT NULL,
	[Gender] [bit] NOT NULL,
	[Point] [int] NOT NULL,
	[Account] [nvarchar](12) NOT NULL,
	[Password] [nvarchar](64) NOT NULL,
 CONSTRAINT [PK__Member__0CF04B38A211F86A] PRIMARY KEY CLUSTERED 
(
	[MemberID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Order](
	[OrderID] [nchar](12) NOT NULL,
	[OrderDate] [datetime] NOT NULL,
	[MemberID] [nchar](6) NOT NULL,
	[ContactName] [nvarchar](27) NOT NULL,
	[ContactAddress] [nvarchar](60) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[OrderID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OrderDetail](
	[OrderID] [nchar](12) NOT NULL,
	[ProductID] [nchar](5) NOT NULL,
	[Qty] [int] NOT NULL,
	[Price] [money] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[OrderID] ASC,
	[ProductID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Product](
	[ProductID] [nchar](5) NOT NULL,
	[ProductName] [nvarchar](40) NOT NULL,
	[Price] [money] NOT NULL,
	[Description] [nvarchar](200) NULL,
	[Picture] [nvarchar](12) NOT NULL,
	[CateID] [nchar](2) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ProductID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
INSERT [dbo].[Category] ([CateID], [CateName]) VALUES (N'A1', N'一般飲料')
INSERT [dbo].[Category] ([CateID], [CateName]) VALUES (N'A2', N'咖啡')
INSERT [dbo].[Category] ([CateID], [CateName]) VALUES (N'A3', N'啤酒')
INSERT [dbo].[Category] ([CateID], [CateName]) VALUES (N'A4', N'提神飲料')
INSERT [dbo].[Category] ([CateID], [CateName]) VALUES (N'B1', N'甜酸醬')
INSERT [dbo].[Category] ([CateID], [CateName]) VALUES (N'B2', N'配料')
INSERT [dbo].[Category] ([CateID], [CateName]) VALUES (N'B3', N'塗抹醬')
INSERT [dbo].[Category] ([CateID], [CateName]) VALUES (N'B4', N'香料')
INSERT [dbo].[Category] ([CateID], [CateName]) VALUES (N'C1', N'甜點心')
INSERT [dbo].[Category] ([CateID], [CateName]) VALUES (N'C2', N'糖果')
INSERT [dbo].[Category] ([CateID], [CateName]) VALUES (N'C3', N'麵包')
INSERT [dbo].[Category] ([CateID], [CateName]) VALUES (N'D1', N'餅乾')
INSERT [dbo].[Category] ([CateID], [CateName]) VALUES (N'E1', N'麵粉')
INSERT [dbo].[Category] ([CateID], [CateName]) VALUES (N'E2', N'麥片')
INSERT [dbo].[Category] ([CateID], [CateName]) VALUES (N'F1', N'豬肉')
INSERT [dbo].[Category] ([CateID], [CateName]) VALUES (N'G1', N'水果乾')
INSERT [dbo].[Category] ([CateID], [CateName]) VALUES (N'G2', N'豆腐')
GO
INSERT [dbo].[Member] ([MemberID], [Name], [Gender], [Point], [Account], [Password]) VALUES (N'M00001', N'王小明', 1, 0, N'abc', N'D04C2178E49C9673F73919B659A6EE83E06F3B95FE49E6FD225AED2E56C69990')
INSERT [dbo].[Member] ([MemberID], [Name], [Gender], [Point], [Account], [Password]) VALUES (N'M00002', N'陳小美', 0, 0, N'abc123', N'E3B0C44298FC1C149AFBF4C8996FB92427AE41E4649B934CA495991B7852B855')
GO
INSERT [dbo].[Product] ([ProductID], [ProductName], [Price], [Description], [Picture], [CateID]) VALUES (N'A2001', N'濃縮咖啡', 99.0000, N'高品質濃縮咖啡，適合用來製作各種咖啡飲品。', N'A2001.jpg', N'A2')
INSERT [dbo].[Product] ([ProductID], [ProductName], [Price], [Description], [Picture], [CateID]) VALUES (N'A2002', N'即食咖啡', 89.0000, N'快速沖泡即飲咖啡，隨時享受濃郁的咖啡香氣。', N'A2002.jpg', N'A2')
INSERT [dbo].[Product] ([ProductID], [ProductName], [Price], [Description], [Picture], [CateID]) VALUES (N'A3001', N'精釀啤酒', 129.0000, N'經典手工釀造啤酒，口感醇厚，適合與朋友聚會時享用。', N'A3001.jpg', N'A3')
INSERT [dbo].[Product] ([ProductID], [ProductName], [Price], [Description], [Picture], [CateID]) VALUES (N'A3002', N'精選啤酒禮盒', 399.0000, N'包含多種啤酒口味的禮盒，適合作為送禮佳品。', N'A3002.jpg', N'A3')
INSERT [dbo].[Product] ([ProductID], [ProductName], [Price], [Description], [Picture], [CateID]) VALUES (N'A4001', N'馬力夯', 35.0000, N'富含咖啡因的提神飲料，幫助你保持清醒和活力。', N'A4001.jpg', N'A4')
INSERT [dbo].[Product] ([ProductID], [ProductName], [Price], [Description], [Picture], [CateID]) VALUES (N'B1001', N'蕃茄', 45.0000, N'經典甜酸醬，適合搭配炸物、春捲等食物。', N'B1001.jpg', N'B1')
INSERT [dbo].[Product] ([ProductID], [ProductName], [Price], [Description], [Picture], [CateID]) VALUES (N'B2001', N'五香配料', 22.0000, N'多功能烹飪配料，讓您的料理更加美味。', N'B2001.jpg', N'B2')
INSERT [dbo].[Product] ([ProductID], [ProductName], [Price], [Description], [Picture], [CateID]) VALUES (N'B2002', N'烤雞香料', 16.0000, N'專為烤雞設計的香料調味包，讓雞肉更加美味。', N'B2002.jpg', N'B2')
INSERT [dbo].[Product] ([ProductID], [ProductName], [Price], [Description], [Picture], [CateID]) VALUES (N'B3001', N'花生塗抹醬', 59.0000, N'香濃花生醬，完美塗抹在吐司或搭配餅乾。', N'B3001.jpg', N'B3')
INSERT [dbo].[Product] ([ProductID], [ProductName], [Price], [Description], [Picture], [CateID]) VALUES (N'B3002', N'肉桂香料', 14.0000, N'新鮮肉桂香料，適合用於甜點或飲品中。', N'B3002.jpg', N'B3')
INSERT [dbo].[Product] ([ProductID], [ProductName], [Price], [Description], [Picture], [CateID]) VALUES (N'B3003', N'巧克力慕斯', 69.0000, N'濃郁巧克力慕斯，口感絲滑，完美享受。', N'B3003.jpg', N'B3')
INSERT [dbo].[Product] ([ProductID], [ProductName], [Price], [Description], [Picture], [CateID]) VALUES (N'B3004', N'藍莓果醬', 49.0000, N'新鮮藍莓製作的果醬，搭配麵包或餅乾非常美味。', N'B3004.jpg', N'B3')
INSERT [dbo].[Product] ([ProductID], [ProductName], [Price], [Description], [Picture], [CateID]) VALUES (N'B3005', N'手工草莓果醬', 39.0000, N'新鮮草莓製作的手工果醬，口感濃郁，甜美可口。', N'B3005.jpg', N'B3')
INSERT [dbo].[Product] ([ProductID], [ProductName], [Price], [Description], [Picture], [CateID]) VALUES (N'B4001', N'迷迭香', 12.0000, N'新鮮迷迭香香料，提升料理的香氣和風味。', N'B4001.jpg', N'B4')
INSERT [dbo].[Product] ([ProductID], [ProductName], [Price], [Description], [Picture], [CateID]) VALUES (N'C1001', N'巧克力甜點', 49.0000, N'濃郁巧克力味的甜點，香甜可口，令人回味無窮。', N'C1001.jpg', N'C1')
INSERT [dbo].[Product] ([ProductID], [ProductName], [Price], [Description], [Picture], [CateID]) VALUES (N'C1002', N'紅豆餅', 59.0000, N'甜美的紅豆餡餅，外皮酥脆，內餡香甜。', N'C1002.jpg', N'C1')
INSERT [dbo].[Product] ([ProductID], [ProductName], [Price], [Description], [Picture], [CateID]) VALUES (N'C1003', N'香濃巧克力棒', 59.0000, N'香濃的巧克力棒，帶來滿滿的幸福感。', N'C1003.jpg', N'C1')
INSERT [dbo].[Product] ([ProductID], [ProductName], [Price], [Description], [Picture], [CateID]) VALUES (N'C2001', N'水果糖', 19.0000, N'多種口味的水果糖，口感清新，適合隨時享用。', N'C2001.jpg', N'C2')
INSERT [dbo].[Product] ([ProductID], [ProductName], [Price], [Description], [Picture], [CateID]) VALUES (N'C2002', N'蜂蜜糖果', 24.0000, N'天然蜂蜜糖果，口感香甜，保健又美味。', N'C2002.jpg', N'C2')
INSERT [dbo].[Product] ([ProductID], [ProductName], [Price], [Description], [Picture], [CateID]) VALUES (N'C2003', N'無糖堅果', 69.0000, N'高蛋白無糖堅果，健康零食的最佳選擇。', N'C2003.jpg', N'C2')
INSERT [dbo].[Product] ([ProductID], [ProductName], [Price], [Description], [Picture], [CateID]) VALUES (N'C3001', N'全麥麵包', 39.0000, N'新鮮出爐的全麥麵包，健康又美味。', N'C3001.jpg', N'C3')
INSERT [dbo].[Product] ([ProductID], [ProductName], [Price], [Description], [Picture], [CateID]) VALUES (N'C3002', N'多穀麵包', 49.0000, N'富含多種穀物的麵包，健康又營養，適合早餐享用。', N'C3002.jpg', N'C3')
INSERT [dbo].[Product] ([ProductID], [ProductName], [Price], [Description], [Picture], [CateID]) VALUES (N'D1001', N'巧克力餅乾', 29.0000, N'濃郁巧克力餅乾，外脆內軟，口感豐富。', N'D1001.jpg', N'D1')
INSERT [dbo].[Product] ([ProductID], [ProductName], [Price], [Description], [Picture], [CateID]) VALUES (N'D1002', N'椰子餅乾', 29.0000, N'帶有椰香的酥脆餅乾，口感輕盈又香甜。', N'D1002.jpg', N'D1')
INSERT [dbo].[Product] ([ProductID], [ProductName], [Price], [Description], [Picture], [CateID]) VALUES (N'E1001', N'高筋麵粉', 59.0000, N'高筋麵粉，製作麵包和餅乾的理想選擇。', N'E1001.jpg', N'E1')
INSERT [dbo].[Product] ([ProductID], [ProductName], [Price], [Description], [Picture], [CateID]) VALUES (N'E2001', N'即食麥片', 99.0000, N'即食麥片，含有豐富的纖維和營養，適合快速早餐。', N'E2001.jpg', N'E2')
INSERT [dbo].[Product] ([ProductID], [ProductName], [Price], [Description], [Picture], [CateID]) VALUES (N'F1001', N'豬肉脯', 79.0000, N'美味豬肉脯，嚼勁十足，帶有濃郁的肉香。', N'F1001.jpg', N'F1')
INSERT [dbo].[Product] ([ProductID], [ProductName], [Price], [Description], [Picture], [CateID]) VALUES (N'G1001', N'無糖水果乾', 55.0000, N'自然乾燥的水果乾，無添加糖，健康又美味。', N'G1001.jpg', N'G1')
INSERT [dbo].[Product] ([ProductID], [ProductName], [Price], [Description], [Picture], [CateID]) VALUES (N'G1002', N'芒果乾', 39.0000, N'天然乾燥芒果，甜美無比，適合作為小吃。', N'G1002.jpg', N'G1')
INSERT [dbo].[Product] ([ProductID], [ProductName], [Price], [Description], [Picture], [CateID]) VALUES (N'G2001', N'老豆腐', 19.0000, N'傳統風味的老豆腐，適合各種料理。', N'G2001.jpg', N'G2')
GO
SET ANSI_PADDING ON
GO

ALTER TABLE [dbo].[Member] ADD  CONSTRAINT [UQ__Member__B0C3AC4646969FD1] UNIQUE NONCLUSTERED 
(
	[Account] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Member] ADD  CONSTRAINT [DF__Member__Point__403A8C7D]  DEFAULT ((0)) FOR [Point]
GO
ALTER TABLE [dbo].[Order] ADD  DEFAULT (getdate()) FOR [OrderDate]
GO
ALTER TABLE [dbo].[OrderDetail] ADD  DEFAULT ((1)) FOR [Qty]
GO
ALTER TABLE [dbo].[Order]  WITH CHECK ADD  CONSTRAINT [FK__Order__MemberID__4316F928] FOREIGN KEY([MemberID])
REFERENCES [dbo].[Member] ([MemberID])
GO
ALTER TABLE [dbo].[Order] CHECK CONSTRAINT [FK__Order__MemberID__4316F928]
GO
ALTER TABLE [dbo].[OrderDetail]  WITH CHECK ADD FOREIGN KEY([OrderID])
REFERENCES [dbo].[Order] ([OrderID])
GO
ALTER TABLE [dbo].[OrderDetail]  WITH CHECK ADD FOREIGN KEY([ProductID])
REFERENCES [dbo].[Product] ([ProductID])
GO
ALTER TABLE [dbo].[Product]  WITH CHECK ADD FOREIGN KEY([CateID])
REFERENCES [dbo].[Category] ([CateID])
GO

use GoodStore
go

SELECT * FROM Product

