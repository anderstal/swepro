USE [master]
GO
/****** Object:  Database [sweproteindb]    Script Date: 2014-04-03 10:49:36 ******/
CREATE DATABASE [SweProteinDB]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'SweProteinDB', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL11.SQLEXPRESS\MSSQL\DATA\SweProteinDB.mdf' , SIZE = 5120KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'SweProteinDB_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL11.SQLEXPRESS\MSSQL\DATA\SweProteinDB_log.ldf' , SIZE = 2048KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [sweproteindb] SET COMPATIBILITY_LEVEL = 110
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [sweproteindb].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [sweproteindb] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [sweproteindb] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [sweproteindb] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [sweproteindb] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [sweproteindb] SET ARITHABORT OFF 
GO
ALTER DATABASE [sweproteindb] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [sweproteindb] SET AUTO_CREATE_STATISTICS ON 
GO
ALTER DATABASE [sweproteindb] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [sweproteindb] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [sweproteindb] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [sweproteindb] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [sweproteindb] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [sweproteindb] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [sweproteindb] SET QUOTED_IDENTIFIER OFF 
USE [sweproteindb]
GO
/****** Object:  Table [dbo].[tbCampaign]    Script Date: 2014-04-03 10:49:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbCampaign](
	[iID] [int] IDENTITY(1,1) NOT NULL,
	[sName] [nvarchar](50) NOT NULL,
	[sImgURL] [nvarchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[iID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

/****** Object:  Table [dbo].[tbGuestOrder] Script Date: 2014-03-26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbGuestProductOrder] (
    [iID]              INT           IDENTITY (1, 1) NOT NULL,
    [iGuestOrderID] INT           NOT NULL,
    [iProductID]       INT	     NOT NULL,
    [iQuantity]        INT           NOT NULL,
    PRIMARY KEY CLUSTERED 
	(
	[iID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tbGuestShipping] Script Date: 2014-03-26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbGuestOrder] (
    [iID]           INT            IDENTITY (1, 1) NOT NULL,
    [iStatus]       INT 	   NOT NULL,
    [sAddress]      NVARCHAR (100) NOT NULL,
    [sPostalNumber] NVARCHAR (50)  NOT NULL,
    [sCity]         NVARCHAR (50)  NOT NULL,
    [sEmail]        NVARCHAR (100) NULL,
    [sTelephone]    NVARCHAR (50)  NULL,
    [iSum]          INT            NOT NULL,
    [dtOrderDate]   DATETIME       NOT NULL,
    PRIMARY KEY CLUSTERED 
	(
	[iID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tbOrder]    Script Date: 2014-04-03 10:49:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbOrder](
	[iID] [int] IDENTITY(1,1) NOT NULL,
	[iUserID] [int] NOT NULL,
	[iStatus] [int] NOT NULL,
	[iSum] [int] NULL,
	[dtOrderDate] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[iID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tbProduct]    Script Date: 2014-04-03 10:49:36 ******/
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
	[iProductCategory] [int] NULL,
	[iPoints] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[iID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tbProductCategory]    Script Date: 2014-04-03 10:49:36 ******/
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
/****** Object:  Table [dbo].[tbProductOrder]    Script Date: 2014-04-03 10:49:36 ******/
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
/****** Object:  Table [dbo].[tbProductType]    Script Date: 2014-04-03 10:49:36 ******/
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
/****** Object:  Table [dbo].[tbStatus]    Script Date: 2014-04-03 10:49:36 ******/
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
/****** Object:  Table [dbo].[tbTaste]    Script Date: 2014-04-03 10:49:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tbTaste](
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
/****** Object:  Table [dbo].[tbUserInfo]    Script Date: 2014-04-03 10:49:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbUserInfo](
	[iID] [int] IDENTITY(1,1) NOT NULL,
	[iUserID] [int] NOT NULL,
	[sFirstName] [nvarchar](70) NULL,
	[sLastName] [nvarchar](70) NULL,
	[sAdress] [nvarchar](70) NULL,
	[sPostalNumber] [nvarchar](10) NULL,
	[sCity] [nvarchar](50) NULL,
	[sEmail] [nvarchar](50) NULL,
	[sTelephone] [nvarchar](50) NULL,
	[iTotalPurchase] [int] NULL,
	[iNewsOffers] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[iID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[UserProfile]    Script Date: 2014-04-03 10:49:36 ******/
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
/****** Object:  Table [dbo].[webpages_Membership]    Script Date: 2014-04-03 10:49:36 ******/
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
/****** Object:  Table [dbo].[webpages_OAuthMembership]    Script Date: 2014-04-03 10:49:36 ******/
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
/****** Object:  Table [dbo].[webpages_Roles]    Script Date: 2014-04-03 10:49:36 ******/
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
/****** Object:  Table [dbo].[webpages_UsersInRoles]    Script Date: 2014-04-03 10:49:36 ******/
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
SET IDENTITY_INSERT [dbo].[tbCampaign] ON 

INSERT [dbo].[tbCampaign] ([iID], [sName], [sImgURL]) VALUES (5, N'2 för 1', N'/Images/Campaign/180PVL_Kreabolic_q214_gsde.jpg')
INSERT [dbo].[tbCampaign] ([iID], [sName], [sImgURL]) VALUES (6, N'Halva priset', N'/Images/Campaign/180x200pxStimutantQ2.jpg')
INSERT [dbo].[tbCampaign] ([iID], [sName], [sImgURL]) VALUES (8, N'utförsäljning', N'/Images/Campaign/gymhusetrea.jpg')
INSERT [dbo].[tbCampaign] ([iID], [sName], [sImgURL]) VALUES (9, N'reaish', N'/Images/Campaign/gymhusetrea2.jpg')
SET IDENTITY_INSERT [dbo].[tbCampaign] OFF
SET IDENTITY_INSERT [dbo].[tbOrder] ON 

INSERT [dbo].[tbOrder] ([iID], [iUserID], [iStatus], [iSum], [dtOrderDate]) VALUES (10, 3, 1, 1565, CAST(0x0000A30101590F6A AS DateTime))
INSERT [dbo].[tbOrder] ([iID], [iUserID], [iStatus], [iSum], [dtOrderDate]) VALUES (11, 3, 1, 1606, CAST(0x0000A30101599585 AS DateTime))
INSERT [dbo].[tbOrder] ([iID], [iUserID], [iStatus], [iSum], [dtOrderDate]) VALUES (12, 3, 1, 2653, CAST(0x0000A3010159A2DF AS DateTime))
INSERT [dbo].[tbOrder] ([iID], [iUserID], [iStatus], [iSum], [dtOrderDate]) VALUES (13, 3, 1, 1002, CAST(0x0000A3010159BF02 AS DateTime))
INSERT [dbo].[tbOrder] ([iID], [iUserID], [iStatus], [iSum], [dtOrderDate]) VALUES (14, 4, 1, 1730, CAST(0x0000A301015A09EF AS DateTime))
INSERT [dbo].[tbOrder] ([iID], [iUserID], [iStatus], [iSum], [dtOrderDate]) VALUES (15, 4, 1, 768, CAST(0x0000A301015ACCF4 AS DateTime))
INSERT [dbo].[tbOrder] ([iID], [iUserID], [iStatus], [iSum], [dtOrderDate]) VALUES (16, 4, 1, 887, CAST(0x0000A301015AEB6F AS DateTime))
INSERT [dbo].[tbOrder] ([iID], [iUserID], [iStatus], [iSum], [dtOrderDate]) VALUES (17, 4, 1, 1185, CAST(0x0000A301015B0D62 AS DateTime))
INSERT [dbo].[tbOrder] ([iID], [iUserID], [iStatus], [iSum], [dtOrderDate]) VALUES (18, 4, 1, 1034, CAST(0x0000A301015B26AD AS DateTime))
SET IDENTITY_INSERT [dbo].[tbOrder] OFF
SET IDENTITY_INSERT [dbo].[tbProduct] ON 

INSERT [dbo].[tbProduct] ([iID], [iProductType], [sProductBrand], [sName], [iPrice], [sPicture], [sDescription], [iStockBalance], [iItemsSold], [iCount], [iTaste], [sMoreInfo], [iCampaign], [iProductCategory], [iPoints]) VALUES (155, 1, N'BMR', N'Powerbar STORKÖP', 199, N'/Images/Products/bar3.jpg', N'En fett mycket längre beskrivning av produkten här', 24, 1, 1, 4, N'Storköp med ba', 8, 2, NULL)
INSERT [dbo].[tbProduct] ([iID], [iProductType], [sProductBrand], [sName], [iPrice], [sPicture], [sDescription], [iStockBalance], [iItemsSold], [iCount], [iTaste], [sMoreInfo], [iCampaign], [iProductCategory], [iPoints]) VALUES (156, 2, N'BrandMan', N'GASP Byxor', 249, N'/Images/Products/byxor1.jpg', N'En fett mycket längre beskrivning av produkten här', 39, 2, 1, 4, N'GASP brallor Kartellen Style', 8, 1, NULL)
INSERT [dbo].[tbProduct] ([iID], [iProductType], [sProductBrand], [sName], [iPrice], [sPicture], [sDescription], [iStockBalance], [iItemsSold], [iCount], [iTaste], [sMoreInfo], [iCampaign], [iProductCategory], [iPoints]) VALUES (157, 2, N'Märket', N'GASP Byxor', 350, N'/Images/Products/byxor2.jpg', N'En fett mycket längre beskrivning av produkten här', 19, 1, 1, 4, N'Riktiga gangsterbrallor förortstylen', 8, 2, NULL)
INSERT [dbo].[tbProduct] ([iID], [iProductType], [sProductBrand], [sName], [iPrice], [sPicture], [sDescription], [iStockBalance], [iItemsSold], [iCount], [iTaste], [sMoreInfo], [iCampaign], [iProductCategory], [iPoints]) VALUES (158, 3, N'Märket', N'Carbs Flex', 99, N'/Images/Products/carbs1.jpg', N'En fett mycket längre beskrivning av produkten här', 18, 2, 1, 4, N'Om du vill gå upp i vikt', 8, 2, NULL)
INSERT [dbo].[tbProduct] ([iID], [iProductType], [sProductBrand], [sName], [iPrice], [sPicture], [sDescription], [iStockBalance], [iItemsSold], [iCount], [iTaste], [sMoreInfo], [iCampaign], [iProductCategory], [iPoints]) VALUES (159, 3, N'Märket', N'Carbs Ultimate', 129, N'/Images/Products/carbs2.jpg', N'En fett mycket längre beskrivning av produkten här', 20, 0, 1, 4, N'För den smala', 6, 2, NULL)
INSERT [dbo].[tbProduct] ([iID], [iProductType], [sProductBrand], [sName], [iPrice], [sPicture], [sDescription], [iStockBalance], [iItemsSold], [iCount], [iTaste], [sMoreInfo], [iCampaign], [iProductCategory], [iPoints]) VALUES (160, 4, N'Märket', N'Celsius Original', 19, N'/Images/Products/celsius.jpg', N'En fett mycket längre beskrivning av produkten här', 18, 2, 1, 4, N'Fitnessdryck', 5, 2, NULL)
INSERT [dbo].[tbProduct] ([iID], [iProductType], [sProductBrand], [sName], [iPrice], [sPicture], [sDescription], [iStockBalance], [iItemsSold], [iCount], [iTaste], [sMoreInfo], [iCampaign], [iProductCategory], [iPoints]) VALUES (161, 4, N'GymHuset', N'Celsius Lemon', 19, N'/Images/Products/celsius2.jpg', N'En fett mycket längre beskrivning av produkten här', 20, 0, 1, 4, N'Fitnessdryck', 5, 2, NULL)
INSERT [dbo].[tbProduct] ([iID], [iProductType], [sProductBrand], [sName], [iPrice], [sPicture], [sDescription], [iStockBalance], [iItemsSold], [iCount], [iTaste], [sMoreInfo], [iCampaign], [iProductCategory], [iPoints]) VALUES (162, 5, N'GymHuset', N'Fatburner X2', 199, N'/Images/Products/fatburner1.jpg', N'En fett mycket längre beskrivning av produkten här', 18, 2, 1, 4, N'Fettförbrännare, den bästa sorten', 9, 2, NULL)
INSERT [dbo].[tbProduct] ([iID], [iProductType], [sProductBrand], [sName], [iPrice], [sPicture], [sDescription], [iStockBalance], [iItemsSold], [iCount], [iTaste], [sMoreInfo], [iCampaign], [iProductCategory], [iPoints]) VALUES (163, 5, N'GymHuset', N'Get Slim', 149, N'/Images/Products/fatburner2.jpg', N'En fett mycket längre beskrivning av produkten här', 18, 2, 1, 4, N'Fettförbrännare, den bästa sorten', 9, 2, NULL)
INSERT [dbo].[tbProduct] ([iID], [iProductType], [sProductBrand], [sName], [iPrice], [sPicture], [sDescription], [iStockBalance], [iItemsSold], [iCount], [iTaste], [sMoreInfo], [iCampaign], [iProductCategory], [iPoints]) VALUES (164, 5, N'ProteinBolaget', N'Fatburner X2', 249, N'/Images/Products/fatburner3.jpg', N'En fett mycket längre beskrivning av produkten här', 18, 2, 1, 4, N'Fett dyr fettförbrännare men också den bästa', 9, 2, NULL)
INSERT [dbo].[tbProduct] ([iID], [iProductType], [sProductBrand], [sName], [iPrice], [sPicture], [sDescription], [iStockBalance], [iItemsSold], [iCount], [iTaste], [sMoreInfo], [iCampaign], [iProductCategory], [iPoints]) VALUES (165, 6, N'ProteinBolaget', N'xTreme Gainer', 399, N'/Images/Products/gainer.jpg', N'En fett mycket längre beskrivning av produkten här', 19, 1, 1, 4, N'Öka 20kg i veckan', 8, 2, NULL)
INSERT [dbo].[tbProduct] ([iID], [iProductType], [sProductBrand], [sName], [iPrice], [sPicture], [sDescription], [iStockBalance], [iItemsSold], [iCount], [iTaste], [sMoreInfo], [iCampaign], [iProductCategory], [iPoints]) VALUES (166, 6, N'ProteinBolaget', N'SupR Gaino', 200, N'/Images/Products/gainer2.jpg', N'En fett mycket längre beskrivning av produkten här', 17, 3, 1, 4, N'Bli som Coleman på 2 veckor', 6, 2, NULL)
INSERT [dbo].[tbProduct] ([iID], [iProductType], [sProductBrand], [sName], [iPrice], [sPicture], [sDescription], [iStockBalance], [iItemsSold], [iCount], [iTaste], [sMoreInfo], [iCampaign], [iProductCategory], [iPoints]) VALUES (167, 6, N'ProteinBolaget', N'RX GainoMAX', 129, N'/Images/Products/gainer3.jpg', N'En fett mycket längre beskrivning av produkten här', 20, 0, 1, 4, N'RX är den nyaste gainern på marknaden', 8, 2, NULL)
INSERT [dbo].[tbProduct] ([iID], [iProductType], [sProductBrand], [sName], [iPrice], [sPicture], [sDescription], [iStockBalance], [iItemsSold], [iCount], [iTaste], [sMoreInfo], [iCampaign], [iProductCategory], [iPoints]) VALUES (168, 6, N'ProteinBolaget', N'GainMaximalt', 150, N'/Images/Products/gainer4.jpg', N'En fett mycket längre beskrivning av produkten här', 17, 3, 1, 4, N'Sämsta gainern på marknaden, du blir smal som fan', 8, 2, NULL)
INSERT [dbo].[tbProduct] ([iID], [iProductType], [sProductBrand], [sName], [iPrice], [sPicture], [sDescription], [iStockBalance], [iItemsSold], [iCount], [iTaste], [sMoreInfo], [iCampaign], [iProductCategory], [iPoints]) VALUES (169, 7, N'BMR', N'Kreatin Mono', 99, N'/Images/Products/kreatin.jpg', N'En fett mycket längre beskrivning av produkten här', 20, 0, 1, 4, N'Kreatin gör att du lägger på dig lite vätska', 9, 2, NULL)
INSERT [dbo].[tbProduct] ([iID], [iProductType], [sProductBrand], [sName], [iPrice], [sPicture], [sDescription], [iStockBalance], [iItemsSold], [iCount], [iTaste], [sMoreInfo], [iCampaign], [iProductCategory], [iPoints]) VALUES (170, 6, N'BMR', N'Rapid Creatin', 119, N'/Images/Products/kreatin2.jpg', N'En fett mycket längre beskrivning av produkten här', 19, 1, 1, 4, N'Du tar 200 i marklyft efter en skopa', 6, 2, NULL)
INSERT [dbo].[tbProduct] ([iID], [iProductType], [sProductBrand], [sName], [iPrice], [sPicture], [sDescription], [iStockBalance], [iItemsSold], [iCount], [iTaste], [sMoreInfo], [iCampaign], [iProductCategory], [iPoints]) VALUES (171, 6, N'BMR', N'Ultra Kreatin', 149, N'/Images/Products/kreatin3.jpg', N'En fett mycket längre beskrivning av produkten här', 20, 0, 1, 4, N'Ultras, bästa kreatinet för huliganer', 5, 2, NULL)
INSERT [dbo].[tbProduct] ([iID], [iProductType], [sProductBrand], [sName], [iPrice], [sPicture], [sDescription], [iStockBalance], [iItemsSold], [iCount], [iTaste], [sMoreInfo], [iCampaign], [iProductCategory], [iPoints]) VALUES (172, 8, N'BMR', N'Anabola Steroider', 119, N'/Images/Products/muscle1.jpg', N'En fett mycket längre beskrivning av produkten här', 20, 0, 1, 4, N'Ät och du blir Arnold om 1 timma', 5, 2, NULL)
INSERT [dbo].[tbProduct] ([iID], [iProductType], [sProductBrand], [sName], [iPrice], [sPicture], [sDescription], [iStockBalance], [iItemsSold], [iCount], [iTaste], [sMoreInfo], [iCampaign], [iProductCategory], [iPoints]) VALUES (173, 9, N'BMR', N'Omega-3', 49, N'/Images/Products/omega3.jpg', N'En fett mycket längre beskrivning av produkten här', 20, 0, 1, 4, N'Fiskbajs i tablettform', 5, 2, NULL)
INSERT [dbo].[tbProduct] ([iID], [iProductType], [sProductBrand], [sName], [iPrice], [sPicture], [sDescription], [iStockBalance], [iItemsSold], [iCount], [iTaste], [sMoreInfo], [iCampaign], [iProductCategory], [iPoints]) VALUES (174, 9, N'BMR', N'Super Omega', 49, N'/Images/Products/omega34.jpg', N'En fett mycket längre beskrivning av produkten här', 20, 0, 1, 4, N'Kvarlevor från fisk på burk', 6, 2, NULL)
INSERT [dbo].[tbProduct] ([iID], [iProductType], [sProductBrand], [sName], [iPrice], [sPicture], [sDescription], [iStockBalance], [iItemsSold], [iCount], [iTaste], [sMoreInfo], [iCampaign], [iProductCategory], [iPoints]) VALUES (175, 13, N'BMR', N'ProttePulver', 249, N'/Images/Products/protein.jpg', N'En fett mycket längre beskrivning av produkten här', 17, 3, 1, 4, N'Protein för att bli musklig', 6, 2, NULL)
INSERT [dbo].[tbProduct] ([iID], [iProductType], [sProductBrand], [sName], [iPrice], [sPicture], [sDescription], [iStockBalance], [iItemsSold], [iCount], [iTaste], [sMoreInfo], [iCampaign], [iProductCategory], [iPoints]) VALUES (176, 13, N'PulverFabrico', N'Proteinpulver', 150, N'/Images/Products/protein2.jpg', N'En fett mycket längre beskrivning av produkten här', 17, 3, 1, 4, N'Det bästa ultimata proteinet från StarKorv', NULL, 2, NULL)
INSERT [dbo].[tbProduct] ([iID], [iProductType], [sProductBrand], [sName], [iPrice], [sPicture], [sDescription], [iStockBalance], [iItemsSold], [iCount], [iTaste], [sMoreInfo], [iCampaign], [iProductCategory], [iPoints]) VALUES (177, 13, N'PulverFabrico', N'Super Protein', 350, N'/Images/Products/protein3.jpg', N'En fett mycket längre beskrivning av produkten här', 15, 5, 1, 4, N'Dyrast är alltid bäst', NULL, 2, NULL)
INSERT [dbo].[tbProduct] ([iID], [iProductType], [sProductBrand], [sName], [iPrice], [sPicture], [sDescription], [iStockBalance], [iItemsSold], [iCount], [iTaste], [sMoreInfo], [iCampaign], [iProductCategory], [iPoints]) VALUES (178, 13, N'PulverFabrico', N'Protein MegaX', 249, N'/Images/Products/protein5.jpg', N'En fett mycket längre beskrivning av produkten här', 20, 0, 1, 4, N'Mega X har nu lanserat sitt sämsta protein', NULL, 2, NULL)
INSERT [dbo].[tbProduct] ([iID], [iProductType], [sProductBrand], [sName], [iPrice], [sPicture], [sDescription], [iStockBalance], [iItemsSold], [iCount], [iTaste], [sMoreInfo], [iCampaign], [iProductCategory], [iPoints]) VALUES (179, 10, N'PulverFabrico', N'PWO xSuper', 199, N'/Images/Products/pwo.jpg', N'En fett mycket längre beskrivning av produkten här', 16, 4, 1, 4, N'För att örka mer på gymmet', NULL, 2, NULL)
INSERT [dbo].[tbProduct] ([iID], [iProductType], [sProductBrand], [sName], [iPrice], [sPicture], [sDescription], [iStockBalance], [iItemsSold], [iCount], [iTaste], [sMoreInfo], [iCampaign], [iProductCategory], [iPoints]) VALUES (180, 10, N'PulverFabrico', N'NeuroCore', 199, N'/Images/Products/pwo2.jpg', N'En fett mycket längre beskrivning av produkten här', 15, 9, 1, 4, N'NeuroCores PWO smakar pizza', NULL, 2, NULL)
INSERT [dbo].[tbProduct] ([iID], [iProductType], [sProductBrand], [sName], [iPrice], [sPicture], [sDescription], [iStockBalance], [iItemsSold], [iCount], [iTaste], [sMoreInfo], [iCampaign], [iProductCategory], [iPoints]) VALUES (182, 10, N'PulverFabrico', N'BMR Animus', 160, N'/Images/Products/pwo4.jpg', N'En fett mycket längre beskrivning av produkten här', 14, 6, 1, 4, N'BMR Animus blabla massa text', NULL, 2, NULL)
INSERT [dbo].[tbProduct] ([iID], [iProductType], [sProductBrand], [sName], [iPrice], [sPicture], [sDescription], [iStockBalance], [iItemsSold], [iCount], [iTaste], [sMoreInfo], [iCampaign], [iProductCategory], [iPoints]) VALUES (183, 11, N'PulverFabrico', N'Plastshaker', 49, N'/Images/Products/shaker1.jpg', N'En fett mycket längre beskrivning av produkten här', 17, 3, 1, 4, N'En shaker som du kan blanda knarket i', NULL, 3, NULL)
INSERT [dbo].[tbProduct] ([iID], [iProductType], [sProductBrand], [sName], [iPrice], [sPicture], [sDescription], [iStockBalance], [iItemsSold], [iCount], [iTaste], [sMoreInfo], [iCampaign], [iProductCategory], [iPoints]) VALUES (184, 11, N'Sweetaffe', N'Shaker', 32, N'/Images/Products/shaker2.jpg', N'En fett mycket längre beskrivning av produkten här', 18, 2, 1, 4, N'Billigaste shakern ever', NULL, 3, NULL)
INSERT [dbo].[tbProduct] ([iID], [iProductType], [sProductBrand], [sName], [iPrice], [sPicture], [sDescription], [iStockBalance], [iItemsSold], [iCount], [iTaste], [sMoreInfo], [iCampaign], [iProductCategory], [iPoints]) VALUES (185, 11, N'Sweetaffe', N'Ful shaker', 119, N'/Images/Products/shaker3.jpg', N'En fett mycket längre beskrivning av produkten här', 14, 6, 1, 4, N'mmspörts fula shejker', NULL, 3, NULL)
INSERT [dbo].[tbProduct] ([iID], [iProductType], [sProductBrand], [sName], [iPrice], [sPicture], [sDescription], [iStockBalance], [iItemsSold], [iCount], [iTaste], [sMoreInfo], [iCampaign], [iProductCategory], [iPoints]) VALUES (186, 12, N'Sweetaffe', N'Go Hard', 345, N'/Images/Products/t-shirt1.jpg', N'En fett mycket längre beskrivning av produkten här', 18, 2, 1, 4, N'Cool t-shirt för stora killar', NULL, 1, NULL)
INSERT [dbo].[tbProduct] ([iID], [iProductType], [sProductBrand], [sName], [iPrice], [sPicture], [sDescription], [iStockBalance], [iItemsSold], [iCount], [iTaste], [sMoreInfo], [iCampaign], [iProductCategory], [iPoints]) VALUES (187, 12, N'Sweetaffe', N'Go more Hard', 320, N'/Images/Products/t-shirt2.jpg', N'En fett mycket längre beskrivning av produkten här', 17, 3, 1, 4, N'Ännu ballare gangsta-t-shirt', NULL, 1, NULL)
INSERT [dbo].[tbProduct] ([iID], [iProductType], [sProductBrand], [sName], [iPrice], [sPicture], [sDescription], [iStockBalance], [iItemsSold], [iCount], [iTaste], [sMoreInfo], [iCampaign], [iProductCategory], [iPoints]) VALUES (188, 9, N'Sweetaffe', N'Vitamin D', 99, N'/Images/Products/vitamin1.jpg', N'En fett mycket längre beskrivning av produkten här', 16, 4, 1, 4, N'Vitamin D, för dig som är tönt och inte äter fisk', NULL, 2, NULL)
INSERT [dbo].[tbProduct] ([iID], [iProductType], [sProductBrand], [sName], [iPrice], [sPicture], [sDescription], [iStockBalance], [iItemsSold], [iCount], [iTaste], [sMoreInfo], [iCampaign], [iProductCategory], [iPoints]) VALUES (189, 9, N'Sweetaffe', N'Vitamin D3', 109, N'/Images/Products/vitamin3.jpg', N'En fett mycket längre beskrivning av produkten här', 17, 3, 1, 4, N'Fiskvitaminen bäst på hela jorden aboooo', NULL, 2, NULL)
INSERT [dbo].[tbProduct] ([iID], [iProductType], [sProductBrand], [sName], [iPrice], [sPicture], [sDescription], [iStockBalance], [iItemsSold], [iCount], [iTaste], [sMoreInfo], [iCampaign], [iProductCategory], [iPoints]) VALUES (190, 9, N'Sweetaffe', N'Vitamin B', 99, N'/Images/Products/vitamin4.jpg', N'En fett mycket längre beskrivning av produkten här', 18, 2, 1, 4, N'Meningslös att köpa men köp ändå din pillertorsk', NULL, 2, NULL)
INSERT [dbo].[tbProduct] ([iID], [iProductType], [sProductBrand], [sName], [iPrice], [sPicture], [sDescription], [iStockBalance], [iItemsSold], [iCount], [iTaste], [sMoreInfo], [iCampaign], [iProductCategory], [iPoints]) VALUES (194, 1, N'BMR', N'Bars', 199, N'/Images/Products/bar3.jpg', N'En fett mycket längre beskrivning av produkten här', 24, 1, 1, 4, N'Storköp med ba', 8, 2, NULL)
INSERT [dbo].[tbProduct] ([iID], [iProductType], [sProductBrand], [sName], [iPrice], [sPicture], [sDescription], [iStockBalance], [iItemsSold], [iCount], [iTaste], [sMoreInfo], [iCampaign], [iProductCategory], [iPoints]) VALUES (195, 2, N'BrandMan', N'Coola Byxor', 249, N'/Images/Products/byxor1.jpg', N'En fett mycket längre beskrivning av produkten här', 39, 2, 1, 4, N'GASP brallor Kartellen Style', 8, 1, NULL)
INSERT [dbo].[tbProduct] ([iID], [iProductType], [sProductBrand], [sName], [iPrice], [sPicture], [sDescription], [iStockBalance], [iItemsSold], [iCount], [iTaste], [sMoreInfo], [iCampaign], [iProductCategory], [iPoints]) VALUES (196, 2, N'Märket', N'Training Pants', 350, N'/Images/Products/byxor2.jpg', N'En fett mycket längre beskrivning av produkten här', 19, 1, 1, 4, N'Riktiga gangsterbrallor förortstylen', 8, 2, NULL)
INSERT [dbo].[tbProduct] ([iID], [iProductType], [sProductBrand], [sName], [iPrice], [sPicture], [sDescription], [iStockBalance], [iItemsSold], [iCount], [iTaste], [sMoreInfo], [iCampaign], [iProductCategory], [iPoints]) VALUES (197, 3, N'Märket', N'Kolhydrater', 99, N'/Images/Products/carbs1.jpg', N'En fett mycket längre beskrivning av produkten här', 18, 2, 1, 4, N'Om du vill gå upp i vikt', 8, 2, NULL)
INSERT [dbo].[tbProduct] ([iID], [iProductType], [sProductBrand], [sName], [iPrice], [sPicture], [sDescription], [iStockBalance], [iItemsSold], [iCount], [iTaste], [sMoreInfo], [iCampaign], [iProductCategory], [iPoints]) VALUES (198, 3, N'Märket', N'Carbotolum', 129, N'/Images/Products/carbs2.jpg', N'En fett mycket längre beskrivning av produkten här', 20, 0, 1, 4, N'För den smala', 6, 2, NULL)
INSERT [dbo].[tbProduct] ([iID], [iProductType], [sProductBrand], [sName], [iPrice], [sPicture], [sDescription], [iStockBalance], [iItemsSold], [iCount], [iTaste], [sMoreInfo], [iCampaign], [iProductCategory], [iPoints]) VALUES (199, 4, N'Märket', N'Celsius Päron', 19, N'/Images/Products/celsius.jpg', N'En fett mycket längre beskrivning av produkten här', 18, 2, 1, 4, N'Fitnessdryck', 5, 2, NULL)
INSERT [dbo].[tbProduct] ([iID], [iProductType], [sProductBrand], [sName], [iPrice], [sPicture], [sDescription], [iStockBalance], [iItemsSold], [iCount], [iTaste], [sMoreInfo], [iCampaign], [iProductCategory], [iPoints]) VALUES (200, 4, N'GymHuset', N'Celsius Kaffe', 19, N'/Images/Products/celsius2.jpg', N'En fett mycket längre beskrivning av produkten här', 20, 0, 1, 4, N'Fitnessdryck', 5, 2, NULL)
INSERT [dbo].[tbProduct] ([iID], [iProductType], [sProductBrand], [sName], [iPrice], [sPicture], [sDescription], [iStockBalance], [iItemsSold], [iCount], [iTaste], [sMoreInfo], [iCampaign], [iProductCategory], [iPoints]) VALUES (201, 5, N'GymHuset', N'Tjockispiller', 199, N'/Images/Products/fatburner1.jpg', N'En fett mycket längre beskrivning av produkten här', 18, 2, 1, 4, N'Fettförbrännare, den bästa sorten', 9, 2, NULL)
INSERT [dbo].[tbProduct] ([iID], [iProductType], [sProductBrand], [sName], [iPrice], [sPicture], [sDescription], [iStockBalance], [iItemsSold], [iCount], [iTaste], [sMoreInfo], [iCampaign], [iProductCategory], [iPoints]) VALUES (202, 5, N'GymHuset', N'Fitpills', 149, N'/Images/Products/fatburner2.jpg', N'En fett mycket längre beskrivning av produkten här', 18, 2, 1, 4, N'Fettförbrännare, den bästa sorten', 9, 2, NULL)
INSERT [dbo].[tbProduct] ([iID], [iProductType], [sProductBrand], [sName], [iPrice], [sPicture], [sDescription], [iStockBalance], [iItemsSold], [iCount], [iTaste], [sMoreInfo], [iCampaign], [iProductCategory], [iPoints]) VALUES (203, 5, N'ProteinBolaget', N'Fettbrännare', 249, N'/Images/Products/fatburner3.jpg', N'En fett mycket längre beskrivning av produkten här', 18, 2, 1, 4, N'Fett dyr fettförbrännare men också den bästa', 9, 2, NULL)
INSERT [dbo].[tbProduct] ([iID], [iProductType], [sProductBrand], [sName], [iPrice], [sPicture], [sDescription], [iStockBalance], [iItemsSold], [iCount], [iTaste], [sMoreInfo], [iCampaign], [iProductCategory], [iPoints]) VALUES (204, 6, N'ProteinBolaget', N'Carbohydrate', 399, N'/Images/Products/gainer.jpg', N'En fett mycket längre beskrivning av produkten här', 19, 1, 1, 4, N'Öka 20kg i veckan', 8, 2, NULL)
INSERT [dbo].[tbProduct] ([iID], [iProductType], [sProductBrand], [sName], [iPrice], [sPicture], [sDescription], [iStockBalance], [iItemsSold], [iCount], [iTaste], [sMoreInfo], [iCampaign], [iProductCategory], [iPoints]) VALUES (205, 6, N'ProteinBolaget', N'Maximal Gainer', 200, N'/Images/Products/gainer2.jpg', N'En fett mycket längre beskrivning av produkten här', 17, 3, 1, 4, N'Bli som Coleman på 2 veckor', 6, 2, NULL)
INSERT [dbo].[tbProduct] ([iID], [iProductType], [sProductBrand], [sName], [iPrice], [sPicture], [sDescription], [iStockBalance], [iItemsSold], [iCount], [iTaste], [sMoreInfo], [iCampaign], [iProductCategory], [iPoints]) VALUES (206, 6, N'ProteinBolaget', N'Gainer MAX4000', 129, N'/Images/Products/gainer3.jpg', N'En fett mycket längre beskrivning av produkten här', 20, 0, 1, 4, N'RX är den nyaste gainern på marknaden', 8, 2, NULL)
INSERT [dbo].[tbProduct] ([iID], [iProductType], [sProductBrand], [sName], [iPrice], [sPicture], [sDescription], [iStockBalance], [iItemsSold], [iCount], [iTaste], [sMoreInfo], [iCampaign], [iProductCategory], [iPoints]) VALUES (207, 6, N'ProteinBolaget', N'SuperFormula Gain', 150, N'/Images/Products/gainer4.jpg', N'En fett mycket längre beskrivning av produkten här', 17, 3, 1, 4, N'Sämsta gainern på marknaden, du blir smal som fan', 8, 2, NULL)
INSERT [dbo].[tbProduct] ([iID], [iProductType], [sProductBrand], [sName], [iPrice], [sPicture], [sDescription], [iStockBalance], [iItemsSold], [iCount], [iTaste], [sMoreInfo], [iCampaign], [iProductCategory], [iPoints]) VALUES (208, 7, N'BMR', N'Creatin Blue', 99, N'/Images/Products/kreatin.jpg', N'En fett mycket längre beskrivning av produkten här', 20, 0, 1, 4, N'Kreatin gör att du lägger på dig lite vätska', 9, 2, NULL)
INSERT [dbo].[tbProduct] ([iID], [iProductType], [sProductBrand], [sName], [iPrice], [sPicture], [sDescription], [iStockBalance], [iItemsSold], [iCount], [iTaste], [sMoreInfo], [iCampaign], [iProductCategory], [iPoints]) VALUES (209, 6, N'BMR', N'Only Crea', 119, N'/Images/Products/kreatin2.jpg', N'En fett mycket längre beskrivning av produkten här', 19, 1, 1, 4, N'Du tar 200 i marklyft efter en skopa', 6, 2, NULL)
INSERT [dbo].[tbProduct] ([iID], [iProductType], [sProductBrand], [sName], [iPrice], [sPicture], [sDescription], [iStockBalance], [iItemsSold], [iCount], [iTaste], [sMoreInfo], [iCampaign], [iProductCategory], [iPoints]) VALUES (210, 6, N'BMR', N'Krea-Bolic', 149, N'/Images/Products/kreatin3.jpg', N'En fett mycket längre beskrivning av produkten här', 20, 0, 1, 4, N'Ultras, bästa kreatinet för huliganer', 5, 2, NULL)
INSERT [dbo].[tbProduct] ([iID], [iProductType], [sProductBrand], [sName], [iPrice], [sPicture], [sDescription], [iStockBalance], [iItemsSold], [iCount], [iTaste], [sMoreInfo], [iCampaign], [iProductCategory], [iPoints]) VALUES (211, 8, N'BMR', N'MuscleGain PRO', 119, N'/Images/Products/muscle1.jpg', N'En fett mycket längre beskrivning av produkten här', 20, 0, 1, 4, N'Ät och du blir Arnold om 1 timma', 5, 2, NULL)
INSERT [dbo].[tbProduct] ([iID], [iProductType], [sProductBrand], [sName], [iPrice], [sPicture], [sDescription], [iStockBalance], [iItemsSold], [iCount], [iTaste], [sMoreInfo], [iCampaign], [iProductCategory], [iPoints]) VALUES (212, 9, N'BMR', N'Fiskpills', 49, N'/Images/Products/omega3.jpg', N'En fett mycket längre beskrivning av produkten här', 20, 0, 1, 4, N'Fiskbajs i tablettform', 5, 2, NULL)
INSERT [dbo].[tbProduct] ([iID], [iProductType], [sProductBrand], [sName], [iPrice], [sPicture], [sDescription], [iStockBalance], [iItemsSold], [iCount], [iTaste], [sMoreInfo], [iCampaign], [iProductCategory], [iPoints]) VALUES (213, 9, N'BMR', N'Omega 100', 49, N'/Images/Products/omega34.jpg', N'En fett mycket längre beskrivning av produkten här', 20, 0, 1, 4, N'Kvarlevor från fisk på burk', 6, 2, NULL)
INSERT [dbo].[tbProduct] ([iID], [iProductType], [sProductBrand], [sName], [iPrice], [sPicture], [sDescription], [iStockBalance], [iItemsSold], [iCount], [iTaste], [sMoreInfo], [iCampaign], [iProductCategory], [iPoints]) VALUES (214, 13, N'BMR', N'Whey-100 GOLD', 249, N'/Images/Products/protein.jpg', N'En fett mycket längre beskrivning av produkten här', 17, 3, 1, 4, N'Protein för att bli musklig', 6, 2, NULL)
INSERT [dbo].[tbProduct] ([iID], [iProductType], [sProductBrand], [sName], [iPrice], [sPicture], [sDescription], [iStockBalance], [iItemsSold], [iCount], [iTaste], [sMoreInfo], [iCampaign], [iProductCategory], [iPoints]) VALUES (215, 13, N'PulverFabrico', N'Arnold Protein', 150, N'/Images/Products/protein2.jpg', N'En fett mycket längre beskrivning av produkten här', 17, 3, 1, 4, N'Det bästa ultimata proteinet från StarKorv', NULL, 2, NULL)
INSERT [dbo].[tbProduct] ([iID], [iProductType], [sProductBrand], [sName], [iPrice], [sPicture], [sDescription], [iStockBalance], [iItemsSold], [iCount], [iTaste], [sMoreInfo], [iCampaign], [iProductCategory], [iPoints]) VALUES (216, 13, N'PulverFabrico', N'Amino Protein', 350, N'/Images/Products/protein3.jpg', N'En fett mycket längre beskrivning av produkten här', 15, 5, 1, 4, N'Dyrast är alltid bäst', NULL, 2, NULL)
INSERT [dbo].[tbProduct] ([iID], [iProductType], [sProductBrand], [sName], [iPrice], [sPicture], [sDescription], [iStockBalance], [iItemsSold], [iCount], [iTaste], [sMoreInfo], [iCampaign], [iProductCategory], [iPoints]) VALUES (217, 13, N'PulverFabrico', N'Pro Whey-80', 249, N'/Images/Products/protein5.jpg', N'En fett mycket längre beskrivning av produkten här', 20, 0, 1, 4, N'Mega X har nu lanserat sitt sämsta protein', NULL, 2, NULL)
INSERT [dbo].[tbProduct] ([iID], [iProductType], [sProductBrand], [sName], [iPrice], [sPicture], [sDescription], [iStockBalance], [iItemsSold], [iCount], [iTaste], [sMoreInfo], [iCampaign], [iProductCategory], [iPoints]) VALUES (218, 10, N'PulverFabrico', N'Ultra Fast', 199, N'/Images/Products/pwo.jpg', N'En fett mycket längre beskrivning av produkten här', 16, 4, 1, 4, N'För att örka mer på gymmet', NULL, 2, NULL)
INSERT [dbo].[tbProduct] ([iID], [iProductType], [sProductBrand], [sName], [iPrice], [sPicture], [sDescription], [iStockBalance], [iItemsSold], [iCount], [iTaste], [sMoreInfo], [iCampaign], [iProductCategory], [iPoints]) VALUES (219, 10, N'PulverFabrico', N'CoreNeuro', 199, N'/Images/Products/pwo2.jpg', N'En fett mycket längre beskrivning av produkten här', 15, 9, 1, 4, N'NeuroCores PWO smakar pizza', NULL, 2, NULL)
INSERT [dbo].[tbProduct] ([iID], [iProductType], [sProductBrand], [sName], [iPrice], [sPicture], [sDescription], [iStockBalance], [iItemsSold], [iCount], [iTaste], [sMoreInfo], [iCampaign], [iProductCategory], [iPoints]) VALUES (221, 10, N'PulverFabrico', N'Animal Pak', 160, N'/Images/Products/pwo4.jpg', N'En fett mycket längre beskrivning av produkten här', 14, 6, 1, 4, N'BMR Animus blabla massa text', NULL, 2, NULL)
INSERT [dbo].[tbProduct] ([iID], [iProductType], [sProductBrand], [sName], [iPrice], [sPicture], [sDescription], [iStockBalance], [iItemsSold], [iCount], [iTaste], [sMoreInfo], [iCampaign], [iProductCategory], [iPoints]) VALUES (222, 11, N'PulverFabrico', N'Shaker X', 49, N'/Images/Products/shaker1.jpg', N'En fett mycket längre beskrivning av produkten här', 17, 3, 1, 4, N'En shaker som du kan blanda knarket i', NULL, 3, NULL)
INSERT [dbo].[tbProduct] ([iID], [iProductType], [sProductBrand], [sName], [iPrice], [sPicture], [sDescription], [iStockBalance], [iItemsSold], [iCount], [iTaste], [sMoreInfo], [iCampaign], [iProductCategory], [iPoints]) VALUES (223, 11, N'Sweetaffe', N'Shaker Grå', 32, N'/Images/Products/shaker2.jpg', N'En fett mycket längre beskrivning av produkten här', 18, 2, 1, 4, N'Billigaste shakern ever', NULL, 3, NULL)
INSERT [dbo].[tbProduct] ([iID], [iProductType], [sProductBrand], [sName], [iPrice], [sPicture], [sDescription], [iStockBalance], [iItemsSold], [iCount], [iTaste], [sMoreInfo], [iCampaign], [iProductCategory], [iPoints]) VALUES (224, 11, N'Sweetaffe', N'Billig Shaker', 119, N'/Images/Products/shaker3.jpg', N'En fett mycket längre beskrivning av produkten här', 14, 6, 1, 4, N'mmspörts fula shejker', NULL, 3, NULL)
INSERT [dbo].[tbProduct] ([iID], [iProductType], [sProductBrand], [sName], [iPrice], [sPicture], [sDescription], [iStockBalance], [iItemsSold], [iCount], [iTaste], [sMoreInfo], [iCampaign], [iProductCategory], [iPoints]) VALUES (225, 12, N'Sweetaffe', N'T-shirt svart', 345, N'/Images/Products/t-shirt1.jpg', N'En fett mycket längre beskrivning av produkten här', 18, 2, 1, 4, N'Cool t-shirt för stora killar', NULL, 1, NULL)
INSERT [dbo].[tbProduct] ([iID], [iProductType], [sProductBrand], [sName], [iPrice], [sPicture], [sDescription], [iStockBalance], [iItemsSold], [iCount], [iTaste], [sMoreInfo], [iCampaign], [iProductCategory], [iPoints]) VALUES (226, 12, N'Sweetaffe', N'T-shirt vit', 320, N'/Images/Products/t-shirt2.jpg', N'En fett mycket längre beskrivning av produkten här', 17, 3, 1, 4, N'Ännu ballare gangsta-t-shirt', NULL, 1, NULL)
INSERT [dbo].[tbProduct] ([iID], [iProductType], [sProductBrand], [sName], [iPrice], [sPicture], [sDescription], [iStockBalance], [iItemsSold], [iCount], [iTaste], [sMoreInfo], [iCampaign], [iProductCategory], [iPoints]) VALUES (227, 9, N'Sweetaffe', N'D Vitamins', 99, N'/Images/Products/vitamin1.jpg', N'En fett mycket längre beskrivning av produkten här', 16, 4, 1, 4, N'Vitamin D, för dig som är tönt och inte äter fisk', NULL, 2, NULL)
INSERT [dbo].[tbProduct] ([iID], [iProductType], [sProductBrand], [sName], [iPrice], [sPicture], [sDescription], [iStockBalance], [iItemsSold], [iCount], [iTaste], [sMoreInfo], [iCampaign], [iProductCategory], [iPoints]) VALUES (228, 9, N'Sweetaffe', N'D3 Vitamins', 109, N'/Images/Products/vitamin3.jpg', N'En fett mycket längre beskrivning av produkten här', 17, 3, 1, 4, N'Fiskvitaminen bäst på hela jorden aboooo', NULL, 2, NULL)
INSERT [dbo].[tbProduct] ([iID], [iProductType], [sProductBrand], [sName], [iPrice], [sPicture], [sDescription], [iStockBalance], [iItemsSold], [iCount], [iTaste], [sMoreInfo], [iCampaign], [iProductCategory], [iPoints]) VALUES (229, 9, N'Sweetaffe', N'B Vitamins', 99, N'/Images/Products/vitamin4.jpg', N'En fett mycket längre beskrivning av produkten här', 18, 2, 1, 4, N'Meningslös att köpa men köp ändå din pillertorsk', NULL, 2, NULL)
SET IDENTITY_INSERT [dbo].[tbProduct] OFF
SET IDENTITY_INSERT [dbo].[tbProductCategory] ON 

INSERT [dbo].[tbProductCategory] ([iID], [sName]) VALUES (1, N'Kläder')
INSERT [dbo].[tbProductCategory] ([iID], [sName]) VALUES (2, N'Kosttillskott')
INSERT [dbo].[tbProductCategory] ([iID], [sName]) VALUES (3, N'Tillbehör')
SET IDENTITY_INSERT [dbo].[tbProductCategory] OFF
SET IDENTITY_INSERT [dbo].[tbProductOrder] ON 

INSERT [dbo].[tbProductOrder] ([iID], [iOrderID], [iProductID], [iQuantity], [iPrice]) VALUES (15, 10, 164, 1, 249)
INSERT [dbo].[tbProductOrder] ([iID], [iOrderID], [iProductID], [iQuantity], [iPrice]) VALUES (16, 10, 175, 1, 249)
INSERT [dbo].[tbProductOrder] ([iID], [iOrderID], [iProductID], [iQuantity], [iPrice]) VALUES (17, 10, 166, 2, 200)
INSERT [dbo].[tbProductOrder] ([iID], [iOrderID], [iProductID], [iQuantity], [iPrice]) VALUES (18, 10, 182, 1, 160)
INSERT [dbo].[tbProductOrder] ([iID], [iOrderID], [iProductID], [iQuantity], [iPrice]) VALUES (19, 10, 183, 1, 49)
INSERT [dbo].[tbProductOrder] ([iID], [iOrderID], [iProductID], [iQuantity], [iPrice]) VALUES (20, 10, 189, 1, 109)
INSERT [dbo].[tbProductOrder] ([iID], [iOrderID], [iProductID], [iQuantity], [iPrice]) VALUES (21, 10, 176, 1, 150)
INSERT [dbo].[tbProductOrder] ([iID], [iOrderID], [iProductID], [iQuantity], [iPrice]) VALUES (22, 10, 179, 1, 199)
INSERT [dbo].[tbProductOrder] ([iID], [iOrderID], [iProductID], [iQuantity], [iPrice]) VALUES (23, 11, 168, 1, 150)
INSERT [dbo].[tbProductOrder] ([iID], [iOrderID], [iProductID], [iQuantity], [iPrice]) VALUES (24, 11, 180, 2, 199)
INSERT [dbo].[tbProductOrder] ([iID], [iOrderID], [iProductID], [iQuantity], [iPrice]) VALUES (25, 11, 182, 1, 160)
INSERT [dbo].[tbProductOrder] ([iID], [iOrderID], [iProductID], [iQuantity], [iPrice]) VALUES (26, 11, 177, 2, 350)
INSERT [dbo].[tbProductOrder] ([iID], [iOrderID], [iProductID], [iQuantity], [iPrice]) VALUES (27, 11, 183, 1, 49)
INSERT [dbo].[tbProductOrder] ([iID], [iOrderID], [iProductID], [iQuantity], [iPrice]) VALUES (28, 11, 163, 1, 149)
INSERT [dbo].[tbProductOrder] ([iID], [iOrderID], [iProductID], [iQuantity], [iPrice]) VALUES (29, 12, 168, 1, 150)
INSERT [dbo].[tbProductOrder] ([iID], [iOrderID], [iProductID], [iQuantity], [iPrice]) VALUES (30, 12, 180, 2, 199)
INSERT [dbo].[tbProductOrder] ([iID], [iOrderID], [iProductID], [iQuantity], [iPrice]) VALUES (31, 12, 182, 1, 160)
INSERT [dbo].[tbProductOrder] ([iID], [iOrderID], [iProductID], [iQuantity], [iPrice]) VALUES (32, 12, 177, 2, 350)
INSERT [dbo].[tbProductOrder] ([iID], [iOrderID], [iProductID], [iQuantity], [iPrice]) VALUES (33, 12, 183, 1, 49)
INSERT [dbo].[tbProductOrder] ([iID], [iOrderID], [iProductID], [iQuantity], [iPrice]) VALUES (34, 12, 163, 1, 149)
INSERT [dbo].[tbProductOrder] ([iID], [iOrderID], [iProductID], [iQuantity], [iPrice]) VALUES (35, 12, 165, 1, 399)
INSERT [dbo].[tbProductOrder] ([iID], [iOrderID], [iProductID], [iQuantity], [iPrice]) VALUES (36, 12, 157, 1, 350)
INSERT [dbo].[tbProductOrder] ([iID], [iOrderID], [iProductID], [iQuantity], [iPrice]) VALUES (37, 12, 158, 1, 99)
INSERT [dbo].[tbProductOrder] ([iID], [iOrderID], [iProductID], [iQuantity], [iPrice]) VALUES (38, 12, 162, 1, 199)
INSERT [dbo].[tbProductOrder] ([iID], [iOrderID], [iProductID], [iQuantity], [iPrice]) VALUES (39, 13, 180, 1, 199)
INSERT [dbo].[tbProductOrder] ([iID], [iOrderID], [iProductID], [iQuantity], [iPrice]) VALUES (40, 13, 184, 1, 32)
INSERT [dbo].[tbProductOrder] ([iID], [iOrderID], [iProductID], [iQuantity], [iPrice]) VALUES (41, 13, 185, 1, 119)
INSERT [dbo].[tbProductOrder] ([iID], [iOrderID], [iProductID], [iQuantity], [iPrice]) VALUES (42, 13, 186, 1, 345)
INSERT [dbo].[tbProductOrder] ([iID], [iOrderID], [iProductID], [iQuantity], [iPrice]) VALUES (43, 13, 189, 1, 109)
INSERT [dbo].[tbProductOrder] ([iID], [iOrderID], [iProductID], [iQuantity], [iPrice]) VALUES (44, 13, 188, 2, 99)
INSERT [dbo].[tbProductOrder] ([iID], [iOrderID], [iProductID], [iQuantity], [iPrice]) VALUES (45, 14, 180, 2, 199)
INSERT [dbo].[tbProductOrder] ([iID], [iOrderID], [iProductID], [iQuantity], [iPrice]) VALUES (46, 14, 184, 1, 32)
INSERT [dbo].[tbProductOrder] ([iID], [iOrderID], [iProductID], [iQuantity], [iPrice]) VALUES (47, 14, 185, 1, 119)
INSERT [dbo].[tbProductOrder] ([iID], [iOrderID], [iProductID], [iQuantity], [iPrice]) VALUES (48, 14, 186, 1, 345)
INSERT [dbo].[tbProductOrder] ([iID], [iOrderID], [iProductID], [iQuantity], [iPrice]) VALUES (49, 14, 189, 1, 109)
INSERT [dbo].[tbProductOrder] ([iID], [iOrderID], [iProductID], [iQuantity], [iPrice]) VALUES (50, 14, 188, 2, 99)
INSERT [dbo].[tbProductOrder] ([iID], [iOrderID], [iProductID], [iQuantity], [iPrice]) VALUES (51, 14, 160, 1, 19)
INSERT [dbo].[tbProductOrder] ([iID], [iOrderID], [iProductID], [iQuantity], [iPrice]) VALUES (52, 14, 177, 1, 350)
INSERT [dbo].[tbProductOrder] ([iID], [iOrderID], [iProductID], [iQuantity], [iPrice]) VALUES (53, 14, 182, 1, 160)
INSERT [dbo].[tbProductOrder] ([iID], [iOrderID], [iProductID], [iQuantity], [iPrice]) VALUES (54, 15, 175, 1, 249)
INSERT [dbo].[tbProductOrder] ([iID], [iOrderID], [iProductID], [iQuantity], [iPrice]) VALUES (55, 15, 187, 1, 320)
INSERT [dbo].[tbProductOrder] ([iID], [iOrderID], [iProductID], [iQuantity], [iPrice]) VALUES (56, 15, 179, 1, 199)
INSERT [dbo].[tbProductOrder] ([iID], [iOrderID], [iProductID], [iQuantity], [iPrice]) VALUES (57, 16, 176, 1, 150)
INSERT [dbo].[tbProductOrder] ([iID], [iOrderID], [iProductID], [iQuantity], [iPrice]) VALUES (58, 16, 190, 1, 99)
INSERT [dbo].[tbProductOrder] ([iID], [iOrderID], [iProductID], [iQuantity], [iPrice]) VALUES (59, 16, 185, 1, 119)
INSERT [dbo].[tbProductOrder] ([iID], [iOrderID], [iProductID], [iQuantity], [iPrice]) VALUES (60, 16, 180, 1, 199)
INSERT [dbo].[tbProductOrder] ([iID], [iOrderID], [iProductID], [iQuantity], [iPrice]) VALUES (61, 16, 187, 1, 320)
INSERT [dbo].[tbProductOrder] ([iID], [iOrderID], [iProductID], [iQuantity], [iPrice]) VALUES (62, 17, 176, 1, 150)
INSERT [dbo].[tbProductOrder] ([iID], [iOrderID], [iProductID], [iQuantity], [iPrice]) VALUES (63, 17, 190, 1, 99)
INSERT [dbo].[tbProductOrder] ([iID], [iOrderID], [iProductID], [iQuantity], [iPrice]) VALUES (64, 17, 185, 1, 119)
INSERT [dbo].[tbProductOrder] ([iID], [iOrderID], [iProductID], [iQuantity], [iPrice]) VALUES (65, 17, 180, 1, 199)
INSERT [dbo].[tbProductOrder] ([iID], [iOrderID], [iProductID], [iQuantity], [iPrice]) VALUES (66, 17, 187, 1, 320)
INSERT [dbo].[tbProductOrder] ([iID], [iOrderID], [iProductID], [iQuantity], [iPrice]) VALUES (67, 17, 162, 1, 199)
INSERT [dbo].[tbProductOrder] ([iID], [iOrderID], [iProductID], [iQuantity], [iPrice]) VALUES (68, 17, 158, 1, 99)
INSERT [dbo].[tbProductOrder] ([iID], [iOrderID], [iProductID], [iQuantity], [iPrice]) VALUES (69, 18, 156, 2, 249)
INSERT [dbo].[tbProductOrder] ([iID], [iOrderID], [iProductID], [iQuantity], [iPrice]) VALUES (70, 18, 155, 1, 199)
INSERT [dbo].[tbProductOrder] ([iID], [iOrderID], [iProductID], [iQuantity], [iPrice]) VALUES (71, 18, 170, 1, 119)
INSERT [dbo].[tbProductOrder] ([iID], [iOrderID], [iProductID], [iQuantity], [iPrice]) VALUES (72, 18, 179, 1, 199)
INSERT [dbo].[tbProductOrder] ([iID], [iOrderID], [iProductID], [iQuantity], [iPrice]) VALUES (73, 18, 160, 1, 19)
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
INSERT [dbo].[tbProductType] ([iID], [sName], [iProductCategory]) VALUES (15, N'Teknik', 3)
SET IDENTITY_INSERT [dbo].[tbProductType] OFF
SET IDENTITY_INSERT [dbo].[tbStatus] ON 

INSERT [dbo].[tbStatus] ([iID], [sStatus]) VALUES (1, N'Betald')
INSERT [dbo].[tbStatus] ([iID], [sStatus]) VALUES (2, N'Skickad')
SET IDENTITY_INSERT [dbo].[tbStatus] OFF
SET IDENTITY_INSERT [dbo].[tbTaste] ON 

INSERT [dbo].[tbTaste] ([iID], [sTaste]) VALUES (1, N'Jordgubb')
INSERT [dbo].[tbTaste] ([iID], [sTaste]) VALUES (2, N'Hallon')
INSERT [dbo].[tbTaste] ([iID], [sTaste]) VALUES (3, N'Choklad')
INSERT [dbo].[tbTaste] ([iID], [sTaste]) VALUES (4, N'Neutral')
SET IDENTITY_INSERT [dbo].[tbTaste] OFF
SET IDENTITY_INSERT [dbo].[tbUserInfo] ON 

INSERT [dbo].[tbUserInfo] ([iID], [iUserID], [sFirstName], [sLastName], [sAdress], [sPostalNumber], [sCity], [sEmail], [sTelephone], [iTotalPurchase], [iNewsOffers]) VALUES (1, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL)
INSERT [dbo].[tbUserInfo] ([iID], [iUserID], [sFirstName], [sLastName], [sAdress], [sPostalNumber], [sCity], [sEmail], [sTelephone], [iTotalPurchase], [iNewsOffers]) VALUES (2, 3, NULL, NULL, N'Bredbyplan 22', NULL, N'Rinkeby', N'oskaranderstal@gmail.com', N'0700703635', 0, NULL)
INSERT [dbo].[tbUserInfo] ([iID], [iUserID], [sFirstName], [sLastName], [sAdress], [sPostalNumber], [sCity], [sEmail], [sTelephone], [iTotalPurchase], [iNewsOffers]) VALUES (3, 4, N'Oskar', N'Åhman', N'Bredbyplan 22', N'16371', N'Rinkeby', N'oskaranderstal@gmail.com', N'0700703635', 0, NULL)
INSERT [dbo].[tbUserInfo] ([iID], [iUserID], [sFirstName], [sLastName], [sAdress], [sPostalNumber], [sCity], [sEmail], [sTelephone], [iTotalPurchase], [iNewsOffers]) VALUES (4, 5, N'Erik', N'Karlsson', N'Molnvägen 47', N'11414', N'Himlen', N'gymuser1@gmail.com', N'112', 0, NULL)
SET IDENTITY_INSERT [dbo].[tbUserInfo] OFF
SET IDENTITY_INSERT [dbo].[UserProfile] ON 

INSERT [dbo].[UserProfile] ([UserId], [UserName]) VALUES (1, N'admin')
INSERT [dbo].[UserProfile] ([UserId], [UserName]) VALUES (2, N'guest')
INSERT [dbo].[UserProfile] ([UserId], [UserName]) VALUES (5, N'erik')
INSERT [dbo].[UserProfile] ([UserId], [UserName]) VALUES (4, N'orre')
INSERT [dbo].[UserProfile] ([UserId], [UserName]) VALUES (3, N'oskar')
SET IDENTITY_INSERT [dbo].[UserProfile] OFF
INSERT [dbo].[webpages_Membership] ([UserId], [CreateDate], [ConfirmationToken], [IsConfirmed], [LastPasswordFailureDate], [PasswordFailuresSinceLastSuccess], [Password], [PasswordChangedDate], [PasswordSalt], [PasswordVerificationToken], [PasswordVerificationTokenExpirationDate]) VALUES (1, CAST(0x0000A2F50080D2D8 AS DateTime), NULL, 1, NULL, 0, N'APV+XhbN4GWaEpmZ0g7hHgGJyy8c7iKFfDHw13MQmNEKG5FyhbDdPUte8J72eFHnnQ==', CAST(0x0000A2F50080D2D8 AS DateTime), N'', NULL, NULL)
INSERT [dbo].[webpages_Membership] ([UserId], [CreateDate], [ConfirmationToken], [IsConfirmed], [LastPasswordFailureDate], [PasswordFailuresSinceLastSuccess], [Password], [PasswordChangedDate], [PasswordSalt], [PasswordVerificationToken], [PasswordVerificationTokenExpirationDate]) VALUES (2, CAST(0x0000A30101365C7A AS DateTime), NULL, 1, NULL, 0, N'ABrBxz617n+nsZknin6JLvNjav8edMteRsodgY4+0nYbdh0lfe3+h9lsWj1wJ8O4TA==', CAST(0x0000A30101365C7A AS DateTime), N'', NULL, NULL)
INSERT [dbo].[webpages_Membership] ([UserId], [CreateDate], [ConfirmationToken], [IsConfirmed], [LastPasswordFailureDate], [PasswordFailuresSinceLastSuccess], [Password], [PasswordChangedDate], [PasswordSalt], [PasswordVerificationToken], [PasswordVerificationTokenExpirationDate]) VALUES (3, CAST(0x0000A3010137EC75 AS DateTime), NULL, 1, NULL, 0, N'ANtvuMlC17qZ/I2yStWicc2lEWFaHwjQuZXiWKlx0S30NHrTClUBCbxIgIgyWUdMmg==', CAST(0x0000A3010137EC75 AS DateTime), N'', NULL, NULL)
INSERT [dbo].[webpages_Membership] ([UserId], [CreateDate], [ConfirmationToken], [IsConfirmed], [LastPasswordFailureDate], [PasswordFailuresSinceLastSuccess], [Password], [PasswordChangedDate], [PasswordSalt], [PasswordVerificationToken], [PasswordVerificationTokenExpirationDate]) VALUES (4, CAST(0x0000A30101390925 AS DateTime), NULL, 1, NULL, 0, N'AEY0pK+6yxtsFrKd8djZILAL7koZZrS78vlQs92XMxnQg8yC67SN6Vu+km4PEl/dug==', CAST(0x0000A30101390925 AS DateTime), N'', NULL, NULL)
SET ANSI_PADDING ON

GO
/****** Object:  Index [UQ__UserProf__C9F284562120CA9C]    Script Date: 2014-04-03 10:49:36 ******/
ALTER TABLE [dbo].[UserProfile] ADD UNIQUE NONCLUSTERED 
(
	[UserName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [UQ__webpages__8A2B6160CBBF133B]    Script Date: 2014-04-03 10:49:36 ******/
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
ALTER TABLE [dbo].[tbOrder]  WITH CHECK ADD FOREIGN KEY([iUserID])
REFERENCES [dbo].[UserProfile] ([UserId])
GO
ALTER TABLE [dbo].[tbProductOrder]  WITH CHECK ADD FOREIGN KEY([iOrderID])
REFERENCES [dbo].[tbOrder] ([iID])
GO
ALTER TABLE [dbo].[tbProductOrder]  WITH CHECK ADD FOREIGN KEY([iProductID])
REFERENCES [dbo].[tbProduct] ([iID])
GO
ALTER TABLE [dbo].[tbGuestOrder] WITH CHECK ADD FOREIGN KEY ([iStatus])
REFERENCES [dbo].[tbStatus] ([iID])
GO
ALTER TABLE [dbo].[tbGuestProductOrder] WITH CHECK ADD FOREIGN KEY ([iGuestOrderID]) 
REFERENCES [dbo].[tbGuestOrder] ([iID]) ON DELETE CASCADE
GO
ALTER TABLE [dbo].[tbGuestProductOrder] WITH CHECK ADD FOREIGN KEY ([iProductID])
REFERENCES [dbo].[tbProduct] ([iID])
GO 
ALTER TABLE [dbo].[tbProduct]  WITH CHECK ADD FOREIGN KEY([iProductType])
REFERENCES [dbo].[tbProductType] ([iID])
GO
ALTER TABLE [dbo].[tbProduct]  WITH CHECK ADD FOREIGN KEY([iTaste])
REFERENCES [dbo].[tbTaste] ([iID])
GO
ALTER TABLE [dbo].[tbProductType]  WITH CHECK ADD FOREIGN KEY([iProductCategory])
REFERENCES [dbo].[tbProductCategory] ([iID])
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
USE [master]
GO
ALTER DATABASE [sweproteindb] SET  READ_WRITE 
GO
