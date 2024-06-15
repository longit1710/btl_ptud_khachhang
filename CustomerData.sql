USE [ptud]
GO
/****** Object:  Table [dbo].[cart]    Script Date: 6/15/2024 5:16:14 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[cart](
	[cart_id] [int] IDENTITY(1,1) NOT NULL,
	[customer_id] [int] NOT NULL,
	[product_id] [int] NOT NULL,
	[quantity] [int] NOT NULL,
	[price] [decimal](10, 2) NOT NULL,
	[created_date] [datetime] NULL,
	[status] [varchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[cart_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[category]    Script Date: 6/15/2024 5:16:14 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[category](
	[category_id] [int] NOT NULL,
	[name] [varchar](100) NULL,
PRIMARY KEY CLUSTERED 
(
	[category_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[customer]    Script Date: 6/15/2024 5:16:14 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[customer](
	[customer_id] [int] IDENTITY(1,1) NOT NULL,
	[first_name] [varchar](100) NULL,
	[last_name] [varchar](100) NULL,
	[email] [varchar](100) NULL,
	[password] [varchar](100) NULL,
	[address] [varchar](100) NULL,
	[phone_number] [varchar](100) NULL,
PRIMARY KEY CLUSTERED 
(
	[customer_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[order]    Script Date: 6/15/2024 5:16:14 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[order](
	[order_id] [int] IDENTITY(1,1) NOT NULL,
	[customer_id] [int] NULL,
	[order_date] [datetime] NULL,
	[status] [nvarchar](50) NULL,
	[payment_method] [nvarchar](50) NULL,
	[payment_amount] [decimal](18, 2) NULL,
	[payment_date] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[order_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[order_item]    Script Date: 6/15/2024 5:16:14 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[order_item](
	[order_item_id] [int] IDENTITY(1,1) NOT NULL,
	[order_id] [int] NULL,
	[product_id] [int] NULL,
	[quantity] [int] NULL,
	[price] [decimal](18, 2) NULL,
PRIMARY KEY CLUSTERED 
(
	[order_item_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[product]    Script Date: 6/15/2024 5:16:14 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[product](
	[product_id] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](100) NULL,
	[description] [nvarchar](100) NULL,
	[price] [decimal](10, 2) NULL,
	[salecount] [int] NULL,
	[category_id] [int] NULL,
	[image] [varchar](100) NULL,
	[date_added] [date] NULL,
PRIMARY KEY CLUSTERED 
(
	[product_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[cart] ON 

INSERT [dbo].[cart] ([cart_id], [customer_id], [product_id], [quantity], [price], [created_date], [status]) VALUES (1, 1, 1, 2, CAST(350000.00 AS Decimal(10, 2)), CAST(N'2024-06-13T06:07:25.830' AS DateTime), N'Active')
INSERT [dbo].[cart] ([cart_id], [customer_id], [product_id], [quantity], [price], [created_date], [status]) VALUES (2, 1, 2, 1, CAST(320000.00 AS Decimal(10, 2)), CAST(N'2024-06-13T06:07:25.830' AS DateTime), N'Active')
INSERT [dbo].[cart] ([cart_id], [customer_id], [product_id], [quantity], [price], [created_date], [status]) VALUES (3, 2, 3, 3, CAST(300000.00 AS Decimal(10, 2)), CAST(N'2024-06-13T06:07:25.830' AS DateTime), N'Ordered')
INSERT [dbo].[cart] ([cart_id], [customer_id], [product_id], [quantity], [price], [created_date], [status]) VALUES (4, 2, 4, 1, CAST(280000.00 AS Decimal(10, 2)), CAST(N'2024-06-13T06:07:25.830' AS DateTime), N'Cancelled')
INSERT [dbo].[cart] ([cart_id], [customer_id], [product_id], [quantity], [price], [created_date], [status]) VALUES (5, 1, 1, 5, CAST(1750000.00 AS Decimal(10, 2)), CAST(N'2024-06-15T01:05:28.063' AS DateTime), N'Paid')
INSERT [dbo].[cart] ([cart_id], [customer_id], [product_id], [quantity], [price], [created_date], [status]) VALUES (6, 1, 6, 3, CAST(810000.00 AS Decimal(10, 2)), CAST(N'2024-06-15T01:10:48.770' AS DateTime), N'Paid')
INSERT [dbo].[cart] ([cart_id], [customer_id], [product_id], [quantity], [price], [created_date], [status]) VALUES (7, 1, 2, 3, CAST(320000.00 AS Decimal(10, 2)), CAST(N'2024-06-15T01:21:20.790' AS DateTime), N'Paid')
INSERT [dbo].[cart] ([cart_id], [customer_id], [product_id], [quantity], [price], [created_date], [status]) VALUES (12, 1, 1, 2, CAST(350000.00 AS Decimal(10, 2)), CAST(N'2024-06-15T02:52:50.660' AS DateTime), N'Paid')
INSERT [dbo].[cart] ([cart_id], [customer_id], [product_id], [quantity], [price], [created_date], [status]) VALUES (14, 1, 7, 9, CAST(230000.00 AS Decimal(10, 2)), CAST(N'2024-06-15T03:03:01.093' AS DateTime), N'Pending')
INSERT [dbo].[cart] ([cart_id], [customer_id], [product_id], [quantity], [price], [created_date], [status]) VALUES (23, 1, 1, 4, CAST(350000.00 AS Decimal(10, 2)), CAST(N'2024-06-15T05:50:00.173' AS DateTime), N'Pending')
INSERT [dbo].[cart] ([cart_id], [customer_id], [product_id], [quantity], [price], [created_date], [status]) VALUES (24, 1, 15, 1, CAST(240000.00 AS Decimal(10, 2)), CAST(N'2024-06-15T05:50:16.907' AS DateTime), N'Pending')
INSERT [dbo].[cart] ([cart_id], [customer_id], [product_id], [quantity], [price], [created_date], [status]) VALUES (25, 1, 16, 4, CAST(225000.00 AS Decimal(10, 2)), CAST(N'2024-06-15T05:50:28.730' AS DateTime), N'Pending')
INSERT [dbo].[cart] ([cart_id], [customer_id], [product_id], [quantity], [price], [created_date], [status]) VALUES (27, 1, 3, 1, CAST(300000.00 AS Decimal(10, 2)), CAST(N'2024-06-15T16:42:11.390' AS DateTime), N'Pending')
INSERT [dbo].[cart] ([cart_id], [customer_id], [product_id], [quantity], [price], [created_date], [status]) VALUES (28, 1, 8, 1, CAST(220000.00 AS Decimal(10, 2)), CAST(N'2024-06-15T16:42:25.387' AS DateTime), N'Pending')
SET IDENTITY_INSERT [dbo].[cart] OFF
GO
INSERT [dbo].[category] ([category_id], [name]) VALUES (1, N'Áo so mi')
INSERT [dbo].[category] ([category_id], [name]) VALUES (2, N'Áo phông')
GO
SET IDENTITY_INSERT [dbo].[customer] ON 

INSERT [dbo].[customer] ([customer_id], [first_name], [last_name], [email], [password], [address], [phone_number]) VALUES (1, N'John', N'Doe', N'john.doe@example.com', N'password123', N'123 Elm St', N'123-456-7890')
INSERT [dbo].[customer] ([customer_id], [first_name], [last_name], [email], [password], [address], [phone_number]) VALUES (2, N'Jane', N'Smith', N'jane.smith@example.com', N'password456', N'456 Oak St', N'987-654-3210')
INSERT [dbo].[customer] ([customer_id], [first_name], [last_name], [email], [password], [address], [phone_number]) VALUES (3, N'long', N'pham', N'longdz17102003@gmail.com', N'1234567', N'hn', N'0329475890')
SET IDENTITY_INSERT [dbo].[customer] OFF
GO
SET IDENTITY_INSERT [dbo].[product] ON 

INSERT [dbo].[product] ([product_id], [name], [description], [price], [salecount], [category_id], [image], [date_added]) VALUES (1, N'Áo so mi nam tr?ng', N'Áo so mi nam màu tr?ng, ki?u dáng d?p', CAST(350000.00 AS Decimal(10, 2)), 100, 1, N'image1.png', CAST(N'2023-01-01' AS Date))
INSERT [dbo].[product] ([product_id], [name], [description], [price], [salecount], [category_id], [image], [date_added]) VALUES (2, N'Áo so mi nam xanh', N'Áo so mi nam màu xanh duong, th?i trang', CAST(320000.00 AS Decimal(10, 2)), 90, 1, N'image2.png', CAST(N'2023-01-05' AS Date))
INSERT [dbo].[product] ([product_id], [name], [description], [price], [salecount], [category_id], [image], [date_added]) VALUES (3, N'Áo so mi n? d?', N'Áo so mi n? màu d?, sang tr?ng', CAST(300000.00 AS Decimal(10, 2)), 80, 1, N'image3.png', CAST(N'2023-01-10' AS Date))
INSERT [dbo].[product] ([product_id], [name], [description], [price], [salecount], [category_id], [image], [date_added]) VALUES (4, N'Áo so mi n? h?a ti?t', N'Áo so mi n? h?a ti?t, phong cách', CAST(280000.00 AS Decimal(10, 2)), 85, 1, N'image4.png', CAST(N'2023-01-15' AS Date))
INSERT [dbo].[product] ([product_id], [name], [description], [price], [salecount], [category_id], [image], [date_added]) VALUES (5, N'Áo phông nam den', N'Áo phông nam màu den, don gi?n', CAST(250000.00 AS Decimal(10, 2)), 120, 2, N'image5.png', CAST(N'2023-01-20' AS Date))
INSERT [dbo].[product] ([product_id], [name], [description], [price], [salecount], [category_id], [image], [date_added]) VALUES (6, N'Áo phông nam xám', N'Áo phông nam màu xám, th?i trang', CAST(270000.00 AS Decimal(10, 2)), 110, 2, N'image6.png', CAST(N'2023-01-25' AS Date))
INSERT [dbo].[product] ([product_id], [name], [description], [price], [salecount], [category_id], [image], [date_added]) VALUES (7, N'Áo phông n? tr?ng', N'Áo phông n? màu tr?ng, thanh l?ch', CAST(230000.00 AS Decimal(10, 2)), 130, 2, N'image7.png', CAST(N'2023-01-30' AS Date))
INSERT [dbo].[product] ([product_id], [name], [description], [price], [salecount], [category_id], [image], [date_added]) VALUES (8, N'Áo phông n? h?ng', N'Áo phông n? màu h?ng, d? thuong', CAST(220000.00 AS Decimal(10, 2)), 125, 2, N'image8.png', CAST(N'2023-02-01' AS Date))
INSERT [dbo].[product] ([product_id], [name], [description], [price], [salecount], [category_id], [image], [date_added]) VALUES (9, N'Áo so mi nam c? tr?', N'Áo so mi nam c? tr?, phong cách hi?n d?i', CAST(380000.00 AS Decimal(10, 2)), 95, 1, N'image9.png', CAST(N'2023-02-05' AS Date))
INSERT [dbo].[product] ([product_id], [name], [description], [price], [salecount], [category_id], [image], [date_added]) VALUES (10, N'Áo so mi nam caro', N'Áo so mi nam h?a ti?t caro, cá tính', CAST(360000.00 AS Decimal(10, 2)), 105, 1, N'image10.png', CAST(N'2023-02-10' AS Date))
INSERT [dbo].[product] ([product_id], [name], [description], [price], [salecount], [category_id], [image], [date_added]) VALUES (11, N'Áo so mi n? den', N'Áo so mi n? màu den, thanh l?ch', CAST(290000.00 AS Decimal(10, 2)), 75, 1, N'image11.png', CAST(N'2023-02-15' AS Date))
INSERT [dbo].[product] ([product_id], [name], [description], [price], [salecount], [category_id], [image], [date_added]) VALUES (12, N'Áo so mi n? xanh duong', N'Áo so mi n? màu xanh duong, tr? trung', CAST(310000.00 AS Decimal(10, 2)), 85, 1, N'image12.png', CAST(N'2023-02-20' AS Date))
INSERT [dbo].[product] ([product_id], [name], [description], [price], [salecount], [category_id], [image], [date_added]) VALUES (13, N'Áo phông nam tr?ng s?c', N'Áo phông nam màu tr?ng s?c, thanh l?ch', CAST(260000.00 AS Decimal(10, 2)), 115, 2, N'image13.png', CAST(N'2023-02-25' AS Date))
INSERT [dbo].[product] ([product_id], [name], [description], [price], [salecount], [category_id], [image], [date_added]) VALUES (14, N'Áo phông nam xanh lá', N'Áo phông nam màu xanh lá cây, tuoi m?i', CAST(275000.00 AS Decimal(10, 2)), 110, 2, N'image14.png', CAST(N'2023-03-01' AS Date))
INSERT [dbo].[product] ([product_id], [name], [description], [price], [salecount], [category_id], [image], [date_added]) VALUES (15, N'Áo phông n? h?a ti?t hoa', N'Áo phông n? h?a ti?t hoa, d? thuong', CAST(240000.00 AS Decimal(10, 2)), 135, 2, N'image15.png', CAST(N'2023-03-05' AS Date))
INSERT [dbo].[product] ([product_id], [name], [description], [price], [salecount], [category_id], [image], [date_added]) VALUES (16, N'Áo phông n? d? dô', N'Áo phông n? màu d? d?m, n?i b?t', CAST(225000.00 AS Decimal(10, 2)), 130, 2, N'image16.png', CAST(N'2023-03-10' AS Date))
INSERT [dbo].[product] ([product_id], [name], [description], [price], [salecount], [category_id], [image], [date_added]) VALUES (17, N'Áo so mi nam k? s?c', N'Áo so mi nam k? s?c, l?ch lãm', CAST(395000.00 AS Decimal(10, 2)), 88, 1, N'image17.png', CAST(N'2023-03-15' AS Date))
INSERT [dbo].[product] ([product_id], [name], [description], [price], [salecount], [category_id], [image], [date_added]) VALUES (18, N'Áo so mi nam tr?ng h?a ti?t', N'Áo so mi nam màu tr?ng h?a ti?t, sang tr?ng', CAST(365000.00 AS Decimal(10, 2)), 92, 1, N'image18.png', CAST(N'2023-03-20' AS Date))
INSERT [dbo].[product] ([product_id], [name], [description], [price], [salecount], [category_id], [image], [date_added]) VALUES (19, N'Áo so mi n? xanh ng?c', N'Áo so mi n? màu xanh ng?c, thanh l?ch', CAST(295000.00 AS Decimal(10, 2)), 78, 1, N'image19.png', CAST(N'2023-03-25' AS Date))
INSERT [dbo].[product] ([product_id], [name], [description], [price], [salecount], [category_id], [image], [date_added]) VALUES (20, N'Áo so mi n? tr?ng b?n l?n', N'Áo so mi n? màu tr?ng, phong cách m?i', CAST(315000.00 AS Decimal(10, 2)), 82, 1, N'image20.png', CAST(N'2023-03-30' AS Date))
SET IDENTITY_INSERT [dbo].[product] OFF
GO
ALTER TABLE [dbo].[cart] ADD  DEFAULT (getdate()) FOR [created_date]
GO
ALTER TABLE [dbo].[cart] ADD  DEFAULT ('Active') FOR [status]
GO
ALTER TABLE [dbo].[product] ADD  DEFAULT (getdate()) FOR [date_added]
GO
ALTER TABLE [dbo].[cart]  WITH CHECK ADD FOREIGN KEY([customer_id])
REFERENCES [dbo].[customer] ([customer_id])
GO
ALTER TABLE [dbo].[cart]  WITH CHECK ADD FOREIGN KEY([product_id])
REFERENCES [dbo].[product] ([product_id])
GO
ALTER TABLE [dbo].[order_item]  WITH CHECK ADD  CONSTRAINT [FK_order_item_order] FOREIGN KEY([order_id])
REFERENCES [dbo].[order] ([order_id])
GO
ALTER TABLE [dbo].[order_item] CHECK CONSTRAINT [FK_order_item_order]
GO
ALTER TABLE [dbo].[order_item]  WITH CHECK ADD  CONSTRAINT [FK_order_item_product] FOREIGN KEY([product_id])
REFERENCES [dbo].[product] ([product_id])
GO
ALTER TABLE [dbo].[order_item] CHECK CONSTRAINT [FK_order_item_product]
GO
ALTER TABLE [dbo].[product]  WITH CHECK ADD FOREIGN KEY([category_id])
REFERENCES [dbo].[category] ([category_id])
GO
