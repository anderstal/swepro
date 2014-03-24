

USE [sweproteindb]
GO
/****** Object:  Table [dbo].[Campaign]    Script Date: 2014-03-21 12:20:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Campaign](
	[iID] [int] IDENTITY(1,1) NOT NULL,
	[sName] [nvarchar](50) NOT NULL,
	[imgURL] [nvarchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[iID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Taste]    Script Date: 2014-03-21 12:20:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Taste](
	[iID] [int] IDENTITY(1,1) NOT NULL,
	[sTaste] [varchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[iID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tbOrder]    Script Date: 2014-03-21 12:20:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbOrder](
	[iID] [int] IDENTITY(1,1) NOT NULL,
	[UserID] [int] NOT NULL,
	[iStatus] [int] NOT NULL,
	[iSum] [int] NULL,
	[dtOrderDate] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[iID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO



/****** Object:  Table [dbo].[tbProduct]    Script Date: 2014-03-21 12:20:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbProduct](
	[iID] [int] IDENTITY(1,1) NOT NULL,
	[iProductType] [int] NULL,
	[sProductBrand] [nvarchar](50) NULL,
	[sName] [nvarchar](50) NULL,
	[iPrice] [int] NULL,
	[sPicture] [nvarchar](200) NULL,
	[sDescription] [nvarchar](500) NULL,
	[iStockBalance] [int] NULL,
	[iItemsSold] [int] NULL,
	[iCount] [int] NULL,
	[iTaste] [int] NULL,
	[sMoreInfo] [nvarchar](2000) NULL,
	[iCampaign] [int] NULL,
	[iProductCategory] [INT] NULL,
PRIMARY KEY CLUSTERED 
(
	[iID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tbProductCategory]    Script Date: 2014-03-21 12:20:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbProductCategory](
	[iID] [int] IDENTITY(1,1) NOT NULL,
	[sName] [nvarchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[iID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tbProductOrder]    Script Date: 2014-03-21 12:20:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbProductOrder](
	[iID] [int] IDENTITY(1,1) NOT NULL,
	[iOrderID] [int] NOT NULL,
	[iProductID] [int] NOT NULL,
	[iQuantity] [int] NOT NULL,
	[iPrice] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[iID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tbProductType]    Script Date: 2014-03-21 12:20:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbProductType](
	[iID] [int] IDENTITY(1,1) NOT NULL,
	[sName] [nvarchar](100) NOT NULL,
	[iProductCategory] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[iID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tbStatus]    Script Date: 2014-03-21 12:20:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbStatus](
	[iID] [int] IDENTITY(1,1) NOT NULL,
	[sStatus] [nvarchar](40) NULL,
PRIMARY KEY CLUSTERED 
(
	[iID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[UserInfo]    Script Date: 2014-03-21 12:20:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserInfo](
	[iID] [int] IDENTITY(1,1) NOT NULL,
	[UserID] [int] NOT NULL,
	[Adress] [nvarchar](70) NULL,
	[PostalNumber] [nvarchar](10) NULL,
	[sCity] [nvarchar](50) NULL,
	[sEmail] [nvarchar](50) NULL,
	[sTelephone] [nvarchar](50) NULL,
	[iTotalPurchase] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[iID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[UserProfile]    Script Date: 2014-03-21 12:20:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserProfile](
	[UserId] [int] IDENTITY(1,1) NOT NULL,
	[UserName] [nvarchar](56) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[webpages_Membership]    Script Date: 2014-03-21 12:20:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[webpages_Membership](
	[UserId] [int] NOT NULL,
	[CreateDate] [datetime] NULL,
	[ConfirmationToken] [nvarchar](128) NULL,
	[IsConfirmed] [bit] NULL,
	[LastPasswordFailureDate] [datetime] NULL,
	[PasswordFailuresSinceLastSuccess] [int] NOT NULL,
	[Password] [nvarchar](128) NOT NULL,
	[PasswordChangedDate] [datetime] NULL,
	[PasswordSalt] [nvarchar](128) NOT NULL,
	[PasswordVerificationToken] [nvarchar](128) NULL,
	[PasswordVerificationTokenExpirationDate] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[webpages_OAuthMembership]    Script Date: 2014-03-21 12:20:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[webpages_OAuthMembership](
	[Provider] [nvarchar](30) NOT NULL,
	[ProviderUserId] [nvarchar](100) NOT NULL,
	[UserId] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Provider] ASC,
	[ProviderUserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[webpages_Roles]    Script Date: 2014-03-21 12:20:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[webpages_Roles](
	[RoleId] [int] IDENTITY(1,1) NOT NULL,
	[RoleName] [nvarchar](256) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[RoleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[webpages_UsersInRoles]    Script Date: 2014-03-21 12:20:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[webpages_UsersInRoles](
	[UserId] [int] NOT NULL,
	[RoleId] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[UserId] ASC,
	[RoleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET IDENTITY_INSERT [dbo].[Taste] ON 

INSERT [dbo].[Taste] ([iID], [sTaste]) VALUES (1, N'Jordgubb')
INSERT [dbo].[Taste] ([iID], [sTaste]) VALUES (2, N'Hallon')
INSERT [dbo].[Taste] ([iID], [sTaste]) VALUES (3, N'Choklad')
INSERT [dbo].[Taste] ([iID], [sTaste]) VALUES (4, N'')
SET IDENTITY_INSERT [dbo].[Taste] OFF
SET IDENTITY_INSERT [dbo].[tbOrder] ON 

INSERT [dbo].[tbOrder] ([iID], [UserID], [iStatus], [iSum], [dtOrderDate]) VALUES (4, 1, 2, 124, CAST(0x000007DA00000000 AS DateTime))
INSERT [dbo].[tbOrder] ([iID], [UserID], [iStatus], [iSum], [dtOrderDate]) VALUES (5, 1, 2, 124, CAST(0x000007DA00000000 AS DateTime))
INSERT [dbo].[tbOrder] ([iID], [UserID], [iStatus], [iSum], [dtOrderDate]) VALUES (6, 1, 2, 124, CAST(0x000007DA00000000 AS DateTime))
INSERT [dbo].[tbOrder] ([iID], [UserID], [iStatus], [iSum], [dtOrderDate]) VALUES (8, 1, 1, 1714, CAST(0x0000A2F500C96FD5 AS DateTime))
SET IDENTITY_INSERT [dbo].[tbOrder] OFF
SET IDENTITY_INSERT [dbo].[tbProduct] ON 

INSERT [dbo].[tbProduct] ([iID], [iProductType], [sProductBrand], [sName], [iPrice], [sPicture], [sDescription], [iStockBalance], [iItemsSold], [iCount], [iTaste], [sMoreInfo], [iCampaign]) VALUES (155, 1, N'BMR', N'Powerbar STORKÖP', 199, N'/Images/Products/bar3.jpg', N'En fett mycket längre beskrivning av produkten här', 20, 0, 1, 4, N'Storköp med ba', NULL)
INSERT [dbo].[tbProduct] ([iID], [iProductType], [sProductBrand], [sName], [iPrice], [sPicture], [sDescription], [iStockBalance], [iItemsSold], [iCount], [iTaste], [sMoreInfo], [iCampaign]) VALUES (156, 2, N'BrandMan', N'GASP Byxor', 249, N'/Images/Products/byxor1.jpg', N'En fett mycket längre beskrivning av produkten här', 20, 0, 1, 4, N'GASP brallor Kartellen Style', NULL)
INSERT [dbo].[tbProduct] ([iID], [iProductType], [sProductBrand], [sName], [iPrice], [sPicture], [sDescription], [iStockBalance], [iItemsSold], [iCount], [iTaste], [sMoreInfo], [iCampaign]) VALUES (157, 2, N'Märket', N'GASP Byxor', 350, N'/Images/Products/byxor2.jpg', N'En fett mycket längre beskrivning av produkten här', 20, 0, 1, 4, N'Riktiga gangsterbrallor förortstylen', NULL)
INSERT [dbo].[tbProduct] ([iID], [iProductType], [sProductBrand], [sName], [iPrice], [sPicture], [sDescription], [iStockBalance], [iItemsSold], [iCount], [iTaste], [sMoreInfo], [iCampaign]) VALUES (158, 3, N'Märket', N'Carbs Flex', 99, N'/Images/Products/carbs1.jpg', N'En fett mycket längre beskrivning av produkten här', 20, 0, 1, 4, N'Om du vill gå upp i vikt', NULL)
INSERT [dbo].[tbProduct] ([iID], [iProductType], [sProductBrand], [sName], [iPrice], [sPicture], [sDescription], [iStockBalance], [iItemsSold], [iCount], [iTaste], [sMoreInfo], [iCampaign]) VALUES (159, 3, N'Märket', N'Carbs Ultimate', 129, N'/Images/Products/carbs2.jpg', N'En fett mycket längre beskrivning av produkten här', 20, 0, 1, 4, N'För den smala', NULL)
INSERT [dbo].[tbProduct] ([iID], [iProductType], [sProductBrand], [sName], [iPrice], [sPicture], [sDescription], [iStockBalance], [iItemsSold], [iCount], [iTaste], [sMoreInfo], [iCampaign]) VALUES (160, 4, N'Märket', N'Celsius Original', 19, N'/Images/Products/celsius.jpg', N'En fett mycket längre beskrivning av produkten här', 20, 0, 1, 4, N'Fitnessdryck', NULL)
INSERT [dbo].[tbProduct] ([iID], [iProductType], [sProductBrand], [sName], [iPrice], [sPicture], [sDescription], [iStockBalance], [iItemsSold], [iCount], [iTaste], [sMoreInfo], [iCampaign]) VALUES (161, 4, N'GymHuset', N'Celsius Lemon', 19, N'/Images/Products/celsius2.jpg', N'En fett mycket längre beskrivning av produkten här', 20, 0, 1, 4, N'Fitnessdryck', NULL)
INSERT [dbo].[tbProduct] ([iID], [iProductType], [sProductBrand], [sName], [iPrice], [sPicture], [sDescription], [iStockBalance], [iItemsSold], [iCount], [iTaste], [sMoreInfo], [iCampaign]) VALUES (162, 5, N'GymHuset', N'Fatburner X2', 199, N'/Images/Products/fatburner1.jpg', N'En fett mycket längre beskrivning av produkten här', 20, 0, 1, 4, N'Fettförbrännare, den bästa sorten', NULL)
INSERT [dbo].[tbProduct] ([iID], [iProductType], [sProductBrand], [sName], [iPrice], [sPicture], [sDescription], [iStockBalance], [iItemsSold], [iCount], [iTaste], [sMoreInfo], [iCampaign]) VALUES (163, 5, N'GymHuset', N'Get Slim', 149, N'/Images/Products/fatburner2.jpg', N'En fett mycket längre beskrivning av produkten här', 20, 0, 1, 4, N'Fettförbrännare, den bästa sorten', NULL)
INSERT [dbo].[tbProduct] ([iID], [iProductType], [sProductBrand], [sName], [iPrice], [sPicture], [sDescription], [iStockBalance], [iItemsSold], [iCount], [iTaste], [sMoreInfo], [iCampaign]) VALUES (164, 5, N'ProteinBolaget', N'Fatburner X2', 249, N'/Images/Products/fatburner3.jpg', N'En fett mycket längre beskrivning av produkten här', 20, 0, 1, 4, N'Fett dyr fettförbrännare men också den bästa', NULL)
INSERT [dbo].[tbProduct] ([iID], [iProductType], [sProductBrand], [sName], [iPrice], [sPicture], [sDescription], [iStockBalance], [iItemsSold], [iCount], [iTaste], [sMoreInfo], [iCampaign]) VALUES (165, 6, N'ProteinBolaget', N'xTreme Gainer', 399, N'/Images/Products/gainer.jpg', N'En fett mycket längre beskrivning av produkten här', 20, 0, 1, 4, N'Öka 20kg i veckan', NULL)
INSERT [dbo].[tbProduct] ([iID], [iProductType], [sProductBrand], [sName], [iPrice], [sPicture], [sDescription], [iStockBalance], [iItemsSold], [iCount], [iTaste], [sMoreInfo], [iCampaign]) VALUES (166, 6, N'ProteinBolaget', N'SupR Gaino', 200, N'/Images/Products/gainer2.jpg', N'En fett mycket längre beskrivning av produkten här', 20, 0, 1, 4, N'Bli som Coleman på 2 veckor', NULL)
INSERT [dbo].[tbProduct] ([iID], [iProductType], [sProductBrand], [sName], [iPrice], [sPicture], [sDescription], [iStockBalance], [iItemsSold], [iCount], [iTaste], [sMoreInfo], [iCampaign]) VALUES (167, 6, N'ProteinBolaget', N'RX GainoMAX', 129, N'/Images/Products/gainer3.jpg', N'En fett mycket längre beskrivning av produkten här', 20, 0, 1, 4, N'RX är den nyaste gainern på marknaden', NULL)
INSERT [dbo].[tbProduct] ([iID], [iProductType], [sProductBrand], [sName], [iPrice], [sPicture], [sDescription], [iStockBalance], [iItemsSold], [iCount], [iTaste], [sMoreInfo], [iCampaign]) VALUES (168, 6, N'ProteinBolaget', N'GainMaximalt', 150, N'/Images/Products/gainer4.jpg', N'En fett mycket längre beskrivning av produkten här', 20, 0, 1, 4, N'Sämsta gainern på marknaden, du blir smal som fan', NULL)
INSERT [dbo].[tbProduct] ([iID], [iProductType], [sProductBrand], [sName], [iPrice], [sPicture], [sDescription], [iStockBalance], [iItemsSold], [iCount], [iTaste], [sMoreInfo], [iCampaign]) VALUES (169, 7, N'BMR', N'Kreatin Mono', 99, N'/Images/Products/kreatin.jpg', N'En fett mycket längre beskrivning av produkten här', 20, 0, 1, 4, N'Kreatin gör att du lägger på dig lite vätska', NULL)
INSERT [dbo].[tbProduct] ([iID], [iProductType], [sProductBrand], [sName], [iPrice], [sPicture], [sDescription], [iStockBalance], [iItemsSold], [iCount], [iTaste], [sMoreInfo], [iCampaign]) VALUES (170, 7, N'BMR', N'Rapid Creatin', 119, N'/Images/Products/kreatin2.jpg', N'En fett mycket längre beskrivning av produkten här', 20, 0, 1, 4, N'Du tar 200 i marklyft efter en skopa', NULL)
INSERT [dbo].[tbProduct] ([iID], [iProductType], [sProductBrand], [sName], [iPrice], [sPicture], [sDescription], [iStockBalance], [iItemsSold], [iCount], [iTaste], [sMoreInfo], [iCampaign]) VALUES (171, 7, N'BMR', N'Ultra Kreatin', 149, N'/Images/Products/kreatin3.jpg', N'En fett mycket längre beskrivning av produkten här', 20, 0, 1, 4, N'Ultras, bästa kreatinet för huliganer', NULL)
INSERT [dbo].[tbProduct] ([iID], [iProductType], [sProductBrand], [sName], [iPrice], [sPicture], [sDescription], [iStockBalance], [iItemsSold], [iCount], [iTaste], [sMoreInfo], [iCampaign]) VALUES (172, 8, N'BMR', N'Anabola Steroider', 119, N'/Images/Products/muscle1.jpg', N'En fett mycket längre beskrivning av produkten här', 20, 0, 1, 4, N'Ät och du blir Arnold om 1 timma', NULL)
INSERT [dbo].[tbProduct] ([iID], [iProductType], [sProductBrand], [sName], [iPrice], [sPicture], [sDescription], [iStockBalance], [iItemsSold], [iCount], [iTaste], [sMoreInfo], [iCampaign]) VALUES (173, 9, N'BMR', N'Omega-3', 49, N'/Images/Products/omega3.jpg', N'En fett mycket längre beskrivning av produkten här', 20, 0, 1, 4, N'Fiskbajs i tablettform', NULL)
INSERT [dbo].[tbProduct] ([iID], [iProductType], [sProductBrand], [sName], [iPrice], [sPicture], [sDescription], [iStockBalance], [iItemsSold], [iCount], [iTaste], [sMoreInfo], [iCampaign]) VALUES (174, 9, N'BMR', N'Super Omega', 49, N'/Images/Products/omega34.jpg', N'En fett mycket längre beskrivning av produkten här', 20, 0, 1, 4, N'Kvarlevor från fisk på burk', NULL)
INSERT [dbo].[tbProduct] ([iID], [iProductType], [sProductBrand], [sName], [iPrice], [sPicture], [sDescription], [iStockBalance], [iItemsSold], [iCount], [iTaste], [sMoreInfo], [iCampaign]) VALUES (175, 13, N'BMR', N'ProttePulver', 249, N'/Images/Products/protein.jpg', N'En fett mycket längre beskrivning av produkten här', 20, 0, 1, 4, N'Protein för att bli musklig', NULL)
INSERT [dbo].[tbProduct] ([iID], [iProductType], [sProductBrand], [sName], [iPrice], [sPicture], [sDescription], [iStockBalance], [iItemsSold], [iCount], [iTaste], [sMoreInfo], [iCampaign]) VALUES (176, 13, N'PulverFabrico', N'Proteinpulver', 150, N'/Images/Products/protein2.jpg', N'En fett mycket längre beskrivning av produkten här', 20, 0, 1, 4, N'Det bästa ultimata proteinet från StarKorv', NULL)
INSERT [dbo].[tbProduct] ([iID], [iProductType], [sProductBrand], [sName], [iPrice], [sPicture], [sDescription], [iStockBalance], [iItemsSold], [iCount], [iTaste], [sMoreInfo], [iCampaign]) VALUES (177, 13, N'PulverFabrico', N'Super Protein', 350, N'/Images/Products/protein3.jpg', N'En fett mycket längre beskrivning av produkten här', 20, 0, 1, 4, N'Dyrast är alltid bäst', NULL)
INSERT [dbo].[tbProduct] ([iID], [iProductType], [sProductBrand], [sName], [iPrice], [sPicture], [sDescription], [iStockBalance], [iItemsSold], [iCount], [iTaste], [sMoreInfo], [iCampaign]) VALUES (178, 13, N'PulverFabrico', N'Protein MegaX', 249, N'/Images/Products/protein5.jpg', N'En fett mycket längre beskrivning av produkten här', 20, 0, 1, 4, N'Mega X har nu lanserat sitt sämsta protein', NULL)
INSERT [dbo].[tbProduct] ([iID], [iProductType], [sProductBrand], [sName], [iPrice], [sPicture], [sDescription], [iStockBalance], [iItemsSold], [iCount], [iTaste], [sMoreInfo], [iCampaign]) VALUES (179, 10, N'PulverFabrico', N'PWO xSuper', 199, N'/Images/Products/pwo.jpg', N'En fett mycket längre beskrivning av produkten här', 20, 0, 1, 4, N'För att örka mer på gymmet', NULL)
INSERT [dbo].[tbProduct] ([iID], [iProductType], [sProductBrand], [sName], [iPrice], [sPicture], [sDescription], [iStockBalance], [iItemsSold], [iCount], [iTaste], [sMoreInfo], [iCampaign]) VALUES (180, 10, N'PulverFabrico', N'NeuroCore', 199, N'/Images/Products/pwo2.jpg', N'En fett mycket längre beskrivning av produkten här', 20, 0, 1, 4, N'NeuroCores PWO smakar pizza', NULL)
INSERT [dbo].[tbProduct] ([iID], [iProductType], [sProductBrand], [sName], [iPrice], [sPicture], [sDescription], [iStockBalance], [iItemsSold], [iCount], [iTaste], [sMoreInfo], [iCampaign]) VALUES (181, 10, N'PulverFabrico', N'Best PWO Ever', 1337, N'/Images/Products/pwo3.jpg', N'En fett mycket längre beskrivning av produkten här', 20, 100, 1, 4, N'Bästa motivationen', NULL)
INSERT [dbo].[tbProduct] ([iID], [iProductType], [sProductBrand], [sName], [iPrice], [sPicture], [sDescription], [iStockBalance], [iItemsSold], [iCount], [iTaste], [sMoreInfo], [iCampaign]) VALUES (182, 10, N'PulverFabrico', N'BMR Animus', 160, N'/Images/Products/pwo4.jpg', N'En fett mycket längre beskrivning av produkten här', 20, 0, 1, 4, N'BMR Animus blabla massa text', NULL)
INSERT [dbo].[tbProduct] ([iID], [iProductType], [sProductBrand], [sName], [iPrice], [sPicture], [sDescription], [iStockBalance], [iItemsSold], [iCount], [iTaste], [sMoreInfo], [iCampaign]) VALUES (183, 11, N'PulverFabrico', N'Plastshaker', 49, N'/Images/Products/shaker1.jpg', N'En fett mycket längre beskrivning av produkten här', 20, 0, 1, 4, N'En shaker som du kan blanda knarket i', NULL)
INSERT [dbo].[tbProduct] ([iID], [iProductType], [sProductBrand], [sName], [iPrice], [sPicture], [sDescription], [iStockBalance], [iItemsSold], [iCount], [iTaste], [sMoreInfo], [iCampaign]) VALUES (184, 11, N'Sweetaffe', N'Shaker', 32, N'/Images/Products/shaker2.jpg', N'En fett mycket längre beskrivning av produkten här', 20, 0, 1, 4, N'Billigaste shakern ever', NULL)
INSERT [dbo].[tbProduct] ([iID], [iProductType], [sProductBrand], [sName], [iPrice], [sPicture], [sDescription], [iStockBalance], [iItemsSold], [iCount], [iTaste], [sMoreInfo], [iCampaign]) VALUES (185, 11, N'Sweetaffe', N'Ful shaker', 119, N'/Images/Products/shaker3.jpg', N'En fett mycket längre beskrivning av produkten här', 20, 0, 1, 4, N'mmspörts fula shejker', NULL)
INSERT [dbo].[tbProduct] ([iID], [iProductType], [sProductBrand], [sName], [iPrice], [sPicture], [sDescription], [iStockBalance], [iItemsSold], [iCount], [iTaste], [sMoreInfo], [iCampaign]) VALUES (186, 12, N'Sweetaffe', N'Go Hard', 345, N'/Images/Products/t-shirt1.jpg', N'En fett mycket längre beskrivning av produkten här', 20, 0, 1, 4, N'Cool t-shirt för stora killar', NULL)
INSERT [dbo].[tbProduct] ([iID], [iProductType], [sProductBrand], [sName], [iPrice], [sPicture], [sDescription], [iStockBalance], [iItemsSold], [iCount], [iTaste], [sMoreInfo], [iCampaign]) VALUES (187, 12, N'Sweetaffe', N'Go more Hard', 320, N'/Images/Products/t-shirt2.jpg', N'En fett mycket längre beskrivning av produkten här', 20, 0, 1, 4, N'Ännu ballare gangsta-t-shirt', NULL)
INSERT [dbo].[tbProduct] ([iID], [iProductType], [sProductBrand], [sName], [iPrice], [sPicture], [sDescription], [iStockBalance], [iItemsSold], [iCount], [iTaste], [sMoreInfo], [iCampaign]) VALUES (188, 9, N'Sweetaffe', N'Vitamin D', 99, N'/Images/Products/vitamin1.jpg', N'En fett mycket längre beskrivning av produkten här', 20, 0, 1, 4, N'Vitamin D, för dig som är tönt och inte äter fisk', NULL)
INSERT [dbo].[tbProduct] ([iID], [iProductType], [sProductBrand], [sName], [iPrice], [sPicture], [sDescription], [iStockBalance], [iItemsSold], [iCount], [iTaste], [sMoreInfo], [iCampaign]) VALUES (189, 9, N'Sweetaffe', N'Vitamin D3', 109, N'/Images/Products/vitamin3.jpg', N'En fett mycket längre beskrivning av produkten här', 20, 0, 1, 4, N'Fiskvitaminen bäst på hela jorden aboooo', NULL)
INSERT [dbo].[tbProduct] ([iID], [iProductType], [sProductBrand], [sName], [iPrice], [sPicture], [sDescription], [iStockBalance], [iItemsSold], [iCount], [iTaste], [sMoreInfo], [iCampaign]) VALUES (190, 9, N'Sweetaffe', N'Vitamin B', 99, N'/Images/Products/vitamin4.jpg', N'En fett mycket längre beskrivning av produkten här', 20, 0, 1, 4, N'Meningslös att köpa men köp ändå din pillertorsk', NULL)
SET IDENTITY_INSERT [dbo].[tbProduct] OFF
SET IDENTITY_INSERT [dbo].[tbProductCategory] ON 

INSERT [dbo].[tbProductCategory] ([iID], [sName]) VALUES (1, N'Kläder')
INSERT [dbo].[tbProductCategory] ([iID], [sName]) VALUES (2, N'Kosttillskott')
INSERT [dbo].[tbProductCategory] ([iID], [sName]) VALUES (3, N'Tillbehör')
SET IDENTITY_INSERT [dbo].[tbProductCategory] OFF
SET IDENTITY_INSERT [dbo].[tbProductOrder] ON 

INSERT [dbo].[tbProductOrder] ([iID], [iOrderID], [iProductID], [iQuantity], [iPrice]) VALUES (1, 8, 157, 1, 350)
INSERT [dbo].[tbProductOrder] ([iID], [iOrderID], [iProductID], [iQuantity], [iPrice]) VALUES (2, 8, 156, 2, 249)
INSERT [dbo].[tbProductOrder] ([iID], [iOrderID], [iProductID], [iQuantity], [iPrice]) VALUES (3, 8, 162, 1, 199)
INSERT [dbo].[tbProductOrder] ([iID], [iOrderID], [iProductID], [iQuantity], [iPrice]) VALUES (4, 8, 170, 1, 119)
INSERT [dbo].[tbProductOrder] ([iID], [iOrderID], [iProductID], [iQuantity], [iPrice]) VALUES (5, 8, 176, 1, 150)
INSERT [dbo].[tbProductOrder] ([iID], [iOrderID], [iProductID], [iQuantity], [iPrice]) VALUES (6, 8, 179, 1, 199)
INSERT [dbo].[tbProductOrder] ([iID], [iOrderID], [iProductID], [iQuantity], [iPrice]) VALUES (7, 8, 155, 1, 199)
SET IDENTITY_INSERT [dbo].[tbProductOrder] OFF
SET IDENTITY_INSERT [dbo].[tbProductType] ON 

INSERT [dbo].[tbProductType] ([iID], [sName], [iProductCategory]) VALUES (1, N'Bars', 2)
INSERT [dbo].[tbProductType] ([iID], [sName], [iProductCategory]) VALUES (2, N'Byxor', 1)
INSERT [dbo].[tbProductType] ([iID], [sName], [iProductCategory]) VALUES (3, N'Kolhydrater', 2)
INSERT [dbo].[tbProductType] ([iID], [sName], [iProductCategory]) VALUES (4, N'Drycker', 2)
INSERT [dbo].[tbProductType] ([iID], [sName], [iProductCategory]) VALUES (5, N'Fettförbrännare', 2)
INSERT [dbo].[tbProductType] ([iID], [sName], [iProductCategory]) VALUES (6, N'Gainer', 2)
INSERT [dbo].[tbProductType] ([iID], [sName], [iProductCategory]) VALUES (7, N'Kreatin', 2)
INSERT [dbo].[tbProductType] ([iID], [sName], [iProductCategory]) VALUES (8, N'Muskelökande', 2)
INSERT [dbo].[tbProductType] ([iID], [sName], [iProductCategory]) VALUES (9, N'Vitaminer', 2)
INSERT [dbo].[tbProductType] ([iID], [sName], [iProductCategory]) VALUES (10, N'PWO', 2)
INSERT [dbo].[tbProductType] ([iID], [sName], [iProductCategory]) VALUES (11, N'Shakers', 3)
INSERT [dbo].[tbProductType] ([iID], [sName], [iProductCategory]) VALUES (12, N'Tröjor', 1)
INSERT [dbo].[tbProductType] ([iID], [sName], [iProductCategory]) VALUES (13, N'Protein', 2)
SET IDENTITY_INSERT [dbo].[tbProductType] OFF
SET IDENTITY_INSERT [dbo].[tbStatus] ON 

INSERT [dbo].[tbStatus] ([iID], [sStatus]) VALUES (1, N'Betald')
INSERT [dbo].[tbStatus] ([iID], [sStatus]) VALUES (2, N'Skickad')
SET IDENTITY_INSERT [dbo].[tbStatus] OFF
SET IDENTITY_INSERT [dbo].[UserProfile] ON 

INSERT [dbo].[UserProfile] ([UserId], [UserName]) VALUES (1, N'admin')
SET IDENTITY_INSERT [dbo].[UserProfile] OFF
INSERT [dbo].[webpages_Membership] ([UserId], [CreateDate], [ConfirmationToken], [IsConfirmed], [LastPasswordFailureDate], [PasswordFailuresSinceLastSuccess], [Password], [PasswordChangedDate], [PasswordSalt], [PasswordVerificationToken], [PasswordVerificationTokenExpirationDate]) VALUES (1, CAST(0x0000A2F50080D2D8 AS DateTime), NULL, 1, NULL, 0, N'APV+XhbN4GWaEpmZ0g7hHgGJyy8c7iKFfDHw13MQmNEKG5FyhbDdPUte8J72eFHnnQ==', CAST(0x0000A2F50080D2D8 AS DateTime), N'', NULL, NULL)
SET ANSI_PADDING ON

GO
/****** Object:  Index [UQ__UserProf__C9F28456040EB0B1]    Script Date: 2014-03-21 12:20:11 ******/
ALTER TABLE [dbo].[UserProfile] ADD UNIQUE NONCLUSTERED 
(
	[UserName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [UQ__webpages__8A2B61601D0F9613]    Script Date: 2014-03-21 12:20:11 ******/
ALTER TABLE [dbo].[webpages_Roles] ADD UNIQUE NONCLUSTERED 
(
	[RoleName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[webpages_Membership] ADD  DEFAULT ((0)) FOR [IsConfirmed]
GO
ALTER TABLE [dbo].[webpages_Membership] ADD  DEFAULT ((0)) FOR [PasswordFailuresSinceLastSuccess]
GO
ALTER TABLE [dbo].[tbOrder]  WITH CHECK ADD FOREIGN KEY([iStatus])
REFERENCES [dbo].[tbStatus] ([iID])
GO
ALTER TABLE [dbo].[tbOrder]  WITH CHECK ADD FOREIGN KEY([UserID])
REFERENCES [dbo].[UserProfile] ([UserId])
GO
ALTER TABLE [dbo].[tbProduct]  WITH CHECK ADD FOREIGN KEY([iProductType])
REFERENCES [dbo].[tbProductType] ([iID])
GO
ALTER TABLE [dbo].[tbProduct]  WITH CHECK ADD FOREIGN KEY([iTaste])
REFERENCES [dbo].[Taste] ([iID])
GO
ALTER TABLE [dbo].[tbProductOrder]  WITH CHECK ADD FOREIGN KEY([iOrderID])
REFERENCES [dbo].[tbOrder] ([iID])
GO
ALTER TABLE [dbo].[tbProductOrder]  WITH CHECK ADD FOREIGN KEY([iProductID])
REFERENCES [dbo].[tbProduct] ([iID])
GO
ALTER TABLE [dbo].[tbProductType]  WITH CHECK ADD FOREIGN KEY([iProductCategory])
REFERENCES [dbo].[tbProductCategory] ([iID])
GO
ALTER TABLE [dbo].[UserProfile]  WITH CHECK ADD FOREIGN KEY([UserId])
REFERENCES [dbo].[UserProfile] ([UserId])
GO
ALTER TABLE [dbo].[webpages_UsersInRoles]  WITH CHECK ADD  CONSTRAINT [fk_RoleId] FOREIGN KEY([RoleId])
REFERENCES [dbo].[webpages_Roles] ([RoleId])
GO
ALTER TABLE [dbo].[webpages_UsersInRoles] CHECK CONSTRAINT [fk_RoleId]
GO
ALTER TABLE [dbo].[webpages_UsersInRoles]  WITH CHECK ADD  CONSTRAINT [fk_UserId] FOREIGN KEY([UserId])
REFERENCES [dbo].[UserProfile] ([UserId])
GO
ALTER TABLE [dbo].[webpages_UsersInRoles] CHECK CONSTRAINT [fk_UserId]
GO

ALTER TABLE [tbProductType]
ADD FOREIGN KEY ([iProductCategory]) REFERENCES [tbProductCategory](iID)
USE [master]
GO
ALTER DATABASE [sweproteindb] SET  READ_WRITE 
GO
