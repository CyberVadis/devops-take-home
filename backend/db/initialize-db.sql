USE [master]
GO
/****** Object:  Database [devops-db]    Script Date: 2/16/2018 10:54:40 AM ******/
CREATE DATABASE [devops-db]
 CONTAINMENT = NONE
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [devops-db].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [devops-db] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [devops-db] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [devops-db] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [devops-db] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [devops-db] SET ARITHABORT OFF 
GO
ALTER DATABASE [devops-db] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [devops-db] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [devops-db] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [devops-db] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [devops-db] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [devops-db] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [devops-db] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [devops-db] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [devops-db] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [devops-db] SET  DISABLE_BROKER 
GO
ALTER DATABASE [devops-db] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [devops-db] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [devops-db] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [devops-db] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [devops-db] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [devops-db] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [devops-db] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [devops-db] SET RECOVERY FULL 
GO
ALTER DATABASE [devops-db] SET  MULTI_USER 
GO
ALTER DATABASE [devops-db] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [devops-db] SET DB_CHAINING OFF 
GO
ALTER DATABASE [devops-db] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [devops-db] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [devops-db] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'devops-db', N'ON'
GO
ALTER DATABASE [devops-db] SET QUERY_STORE = OFF
GO
USE [devops-db]
GO
/****** Object:  Table [dbo].[Incidents]    Script Date: 2/16/2018 10:54:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Incidents](
	[Id] [nvarchar](50) NOT NULL,
	[Title] [nvarchar](50) NULL,
	[Description] [nvarchar](max) NULL,
	[AffectedCompany] [nvarchar](50) NULL,
	[Registered] [datetime] NULL,
 CONSTRAINT [PK_Incidents] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
INSERT [dbo].[Incidents] ([Id], [Title], [Description], [AffectedCompany], [Registered]) VALUES (N'aaaaaaaa-1111-bbbb-2222-cccccccccccc', N'Title from db', N'Description from db', N'Db based company', CAST(N'2018-01-01T00:00:00.000' AS DateTime))
USE [master]
GO
ALTER DATABASE [devops-db] SET  READ_WRITE 
GO
