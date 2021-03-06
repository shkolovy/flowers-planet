use FlowersPlanet
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Flower]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Flower](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](200) NOT NULL,
	[Price] [float] NOT NULL,
	[Discount] [int] NOT NULL CONSTRAINT [DF_Flower_Discount]  DEFAULT ((0)),
	[Description] [nvarchar](max) NULL,
	[Article] [nvarchar](max) NULL,
	[Url] [nvarchar](200) NOT NULL,
	[MetaDesc] [nvarchar](max) NULL,
	[MetaTitle] [nvarchar](200) NULL,
	[Photo] [image] NULL,
	[MetaKeys] [nvarchar](max) NULL,
 CONSTRAINT [PK_Flower] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Menu]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Menu](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](max) NOT NULL,
	[Url] [nvarchar](400) NOT NULL,
	[MetaDesc] [nvarchar](max) NULL,
	[MetaTitle] [nvarchar](200) NULL,
	[MetaKeys] [nvarchar](max) NULL,
	[Article] [nvarchar](max) NULL,
 CONSTRAINT [PK_Menu] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FlowerInTag]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[FlowerInTag](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[IdTag] [int] NOT NULL,
	[IdFlower] [int] NOT NULL,
 CONSTRAINT [PK_FlowerInTag] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Tag]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Tag](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](200) NOT NULL,
	[Url] [nvarchar](200) NOT NULL,
	[IdMenu] [int] NOT NULL,
	[MetaDesc] [nvarchar](max) NULL,
	[MetaTitle] [nvarchar](200) NULL,
	[MetaKeys] [nvarchar](max) NULL,
	[Article] [nvarchar](max) NULL,
 CONSTRAINT [PK_Tag] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_FlowerInTag_Flower]') AND parent_object_id = OBJECT_ID(N'[dbo].[FlowerInTag]'))
ALTER TABLE [dbo].[FlowerInTag]  WITH CHECK ADD  CONSTRAINT [FK_FlowerInTag_Flower] FOREIGN KEY([IdFlower])
REFERENCES [dbo].[Flower] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[FlowerInTag] CHECK CONSTRAINT [FK_FlowerInTag_Flower]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_FlowerInTag_Tag]') AND parent_object_id = OBJECT_ID(N'[dbo].[FlowerInTag]'))
ALTER TABLE [dbo].[FlowerInTag]  WITH CHECK ADD  CONSTRAINT [FK_FlowerInTag_Tag] FOREIGN KEY([IdTag])
REFERENCES [dbo].[Tag] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[FlowerInTag] CHECK CONSTRAINT [FK_FlowerInTag_Tag]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Tag_Menu]') AND parent_object_id = OBJECT_ID(N'[dbo].[Tag]'))
ALTER TABLE [dbo].[Tag]  WITH CHECK ADD  CONSTRAINT [FK_Tag_Menu] FOREIGN KEY([IdMenu])
REFERENCES [dbo].[Menu] ([Id])
GO
ALTER TABLE [dbo].[Tag] CHECK CONSTRAINT [FK_Tag_Menu]
