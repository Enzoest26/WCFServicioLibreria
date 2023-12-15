USE [master]
GO
IF EXISTS (SELECT * FROM sys.databases WHERE name = 'dbReto1')
BEGIN
	DROP DATABASE [dbReto1]
END
GO
/****** Object:  Database [dbReto1]    Script Date: 14/12/2023 17:35:06 ******/
CREATE DATABASE [dbReto1]
GO
ALTER DATABASE [dbReto1] SET COMPATIBILITY_LEVEL = 140
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [dbReto1].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [dbReto1] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [dbReto1] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [dbReto1] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [dbReto1] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [dbReto1] SET ARITHABORT OFF 
GO
ALTER DATABASE [dbReto1] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [dbReto1] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [dbReto1] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [dbReto1] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [dbReto1] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [dbReto1] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [dbReto1] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [dbReto1] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [dbReto1] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [dbReto1] SET  ENABLE_BROKER 
GO
ALTER DATABASE [dbReto1] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [dbReto1] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [dbReto1] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [dbReto1] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [dbReto1] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [dbReto1] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [dbReto1] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [dbReto1] SET RECOVERY FULL 
GO
ALTER DATABASE [dbReto1] SET  MULTI_USER 
GO
ALTER DATABASE [dbReto1] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [dbReto1] SET DB_CHAINING OFF 
GO
ALTER DATABASE [dbReto1] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [dbReto1] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [dbReto1] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'dbReto1', N'ON'
GO
ALTER DATABASE [dbReto1] SET QUERY_STORE = OFF
GO
USE [dbReto1]
GO
/****** Object:  Table [dbo].[books]    Script Date: 14/12/2023 17:35:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[books](
	[idBook] [int] IDENTITY(1,1) NOT NULL,
	[varTitle] [varchar](100) NOT NULL,
	[varCode] [varchar](50) NOT NULL UNIQUE,
	[intStatus] [int] NULL,
	[dmeDateCreate] [datetime] NOT NULL,
	[dmeDateUpdate] [datetime] NULL,
	[bolIsReservated] [bit] NULL,
	[bolIsActive] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[idBook] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[reservations]    Script Date: 14/12/2023 17:35:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[reservations](
	[idReservation] [int] IDENTITY(1,1) NOT NULL,
	[idUser] [int] NOT NULL,
	[idBook] [int] NOT NULL,
	[dmeDateReservation] [datetime] NULL,
	[intStatus] [int] NULL,
	[dmeDateCreate] [datetime] NOT NULL,
	[dmeDateUpdate] [datetime] NULL,
	[bolIsActive] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[idReservation] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[users]    Script Date: 14/12/2023 17:35:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[users](
	[idUser] [int] IDENTITY(1,1) NOT NULL,
	[varFirstName] [varchar](100) NOT NULL,
	[varLastName] [varchar](100) NOT NULL,
	[varEmail] [varchar](100) NOT NULL,
	[varPassword] [varchar](200) NOT NULL,
	[intStatus] [int] NULL,
	[dmeDateCreate] [datetime] NOT NULL,
	[dmeDateUpdate] [datetime] NULL,
	[bolIsActive] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[idUser] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[books] ADD  DEFAULT ((1)) FOR [intStatus]
GO
ALTER TABLE [dbo].[books] ADD  DEFAULT (NULL) FOR [dmeDateUpdate]
GO
ALTER TABLE [dbo].[books] ADD  DEFAULT ((1)) FOR [bolIsActive]
GO
ALTER TABLE [dbo].[reservations] ADD  DEFAULT (NULL) FOR [dmeDateReservation]
GO
ALTER TABLE [dbo].[reservations] ADD  DEFAULT ((1)) FOR [intStatus]
GO
ALTER TABLE [dbo].[reservations] ADD  DEFAULT (NULL) FOR [dmeDateUpdate]
GO
ALTER TABLE [dbo].[reservations] ADD  DEFAULT ((1)) FOR [bolIsActive]
GO
ALTER TABLE [dbo].[users] ADD  DEFAULT ((1)) FOR [intStatus]
GO
ALTER TABLE [dbo].[users] ADD  DEFAULT (NULL) FOR [dmeDateUpdate]
GO
ALTER TABLE [dbo].[users] ADD  DEFAULT ((1)) FOR [bolIsActive]
GO
ALTER TABLE [dbo].[reservations]  WITH CHECK ADD FOREIGN KEY([idBook])
REFERENCES [dbo].[books] ([idBook])
GO
ALTER TABLE [dbo].[reservations]  WITH CHECK ADD FOREIGN KEY([idBook])
REFERENCES [dbo].[books] ([idBook])
GO
ALTER TABLE [dbo].[reservations]  WITH CHECK ADD FOREIGN KEY([idUser])
REFERENCES [dbo].[users] ([idUser])
GO
ALTER TABLE [dbo].[reservations]  WITH CHECK ADD FOREIGN KEY([idUser])
REFERENCES [dbo].[users] ([idUser])
GO
/****** Object:  StoredProcedure [dbo].[SP_LISTARVISTALIBROS]    Script Date: 14/12/2023 17:35:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[SP_LISTARVISTALIBROS](@CODE VARCHAR(50))
AS
BEGIN
	SELECT
		b.varCode, b.varTitle, 
		CASE
			WHEN r.idBook IS NULL 
			THEN 'NO RESERVADO'
			ELSE 'RESERVADO'
		END AS varStatus,
		r.dmeDateReservation
	FROM dbo.books AS b 
	LEFT JOIN dbo.reservations AS r
	ON (b.idBook = r.idBook)
	WHERE (@CODE IS NULL OR @CODE = '' OR b.varCode  LIKE '%' + @CODE + '%');
END
GO
/****** Object:  StoredProcedure [dbo].[SP_RESERVARLIBRO]    Script Date: 14/12/2023 17:35:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create   proc [dbo].[SP_RESERVARLIBRO](@ID_USER INT, @ID_BOOK INT, @DATE_RESERVATION DATETIME, @STATUS INT, @DATE_CREATED DATETIME, @ACTIVE BIT)
AS
	begin
		INSERT INTO dbo.reservations (idUser, idBook, dmeDateReservation, intStatus, dmeDateCreate, bolIsActive) VALUES (@ID_USER, @ID_BOOK,@DATE_RESERVATION, @STATUS, @DATE_CREATED, @ACTIVE);
		UPDATE dbo.books SET bolIsReservated = 1 WHERE idBook = @ID_BOOK;
	end
GO
/****** Object:  StoredProcedure [dbo].[SP_VALIDARACCESO]    Script Date: 14/12/2023 17:35:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROC [dbo].[SP_VALIDARACCESO](@EMAIL VARCHAR(100), @PASSWORD VARCHAR(200))AS
BEGIN
	SELECT * FROM dbo.users WHERE varEmail = @EMAIL AND varPassword = @PASSWORD AND bolIsActive = 1;
END
GO
/****** Object:  StoredProcedure [dbo].[SP_VALIDARRESERVA]    Script Date: 14/12/2023 17:35:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create   proc [dbo].[SP_VALIDARRESERVA](@CODE_BOOK varchar(50)) AS
BEGIN
	SELECT COUNT(1) FROM dbo.reservations AS r INNER JOIN dbo.books AS b ON r.idBook = b.idBook WHERE b.varCode = @CODE_BOOK;
END
GO
/****** Object:  StoredProcedure [dbo].[SP_VALIDARRESERVA]    Script Date: 14/12/2023 17:35:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create   proc [dbo].[SP_BUSCARLIBROXCODE](@CODE_BOOK varchar(50)) AS
BEGIN
	SELECT * FROM dbo.books WHERE varCode = @CODE_BOOK;
END
GO

USE [master]
GO

ALTER DATABASE [dbReto1] SET  READ_WRITE 
GO

SET DATEFORMAT ymd
SET ARITHABORT, ANSI_PADDING, ANSI_WARNINGS, CONCAT_NULL_YIELDS_NULL, QUOTED_IDENTIFIER, ANSI_NULLS, NOCOUNT ON
SET NUMERIC_ROUNDABORT, IMPLICIT_TRANSACTIONS, XACT_ABORT OFF
GO


INSERT dbReto1.dbo.books(varTitle, varCode, intStatus, dmeDateCreate, dmeDateUpdate, bolIsReservated, bolIsActive) VALUES ( 'Principito', 'LB0001', 1, '2023-12-13 19:42:05.850', NULL, CONVERT(bit, 'True'), CONVERT(bit, 'True'))
INSERT dbReto1.dbo.books(varTitle, varCode, intStatus, dmeDateCreate, dmeDateUpdate, bolIsReservated, bolIsActive) VALUES ('Harry Potter', 'LB0022', 1, '2023-12-13 19:42:23.620', NULL, CONVERT(bit, 'True'), CONVERT(bit, 'True'))
INSERT dbReto1.dbo.books(varTitle, varCode, intStatus, dmeDateCreate, dmeDateUpdate, bolIsReservated, bolIsActive) VALUES ('Javita desde la casa', 'LB0012', 1, '2023-12-13 19:42:34.740', NULL, CONVERT(bit, 'True'), CONVERT(bit, 'True'))
INSERT dbReto1.dbo.books(varTitle, varCode, intStatus, dmeDateCreate, dmeDateUpdate, bolIsReservated, bolIsActive) VALUES ('Libro de Dios', 'LB0082', 1, '2023-12-14 15:38:27.970', NULL, CONVERT(bit, 'False'), CONVERT(bit, 'True'))
INSERT dbReto1.dbo.books( varTitle, varCode, intStatus, dmeDateCreate, dmeDateUpdate, bolIsReservated, bolIsActive) VALUES ( 'Historia del Perú', 'LB0030', 1, '2023-12-14 15:40:52.963', NULL, CONVERT(bit, 'False'), CONVERT(bit, 'True'))
INSERT dbReto1.dbo.books(varTitle, varCode, intStatus, dmeDateCreate, dmeDateUpdate, bolIsReservated, bolIsActive) VALUES ( 'Historia del Amaeríca Latina', 'LB0015', 1, '2023-12-14 15:50:13.573', NULL, CONVERT(bit, 'False'), CONVERT(bit, 'True'))
INSERT dbReto1.dbo.books(varTitle, varCode, intStatus, dmeDateCreate, dmeDateUpdate, bolIsReservated, bolIsActive) VALUES ('Historia del Espacio', 'LB0077', 1, '2023-12-14 15:50:26.910', NULL, CONVERT(bit, 'False'), CONVERT(bit, 'True'))
INSERT dbReto1.dbo.books(varTitle, varCode, intStatus, dmeDateCreate, dmeDateUpdate, bolIsReservated, bolIsActive) VALUES ('Historia del Espacio 2', 'LB0007', 1, '2023-12-14 15:50:26.910', NULL, CONVERT(bit, 'False'), CONVERT(bit, 'True'))
INSERT dbReto1.dbo.books(varTitle, varCode, intStatus, dmeDateCreate, dmeDateUpdate, bolIsReservated, bolIsActive) VALUES ('Historia del Espacio 3', 'LB0008', 1, '2023-12-14 15:50:26.910', NULL, CONVERT(bit, 'False'), CONVERT(bit, 'True'))

GO

INSERT dbReto1.dbo.users( varFirstName, varLastName, varEmail, varPassword, intStatus, dmeDateCreate, dmeDateUpdate, bolIsActive) VALUES ( 'Enzo', 'Esteban', 'enzoest26@gmail.com', 'enzitoTuRey', 1, '2023-12-13 11:07:47.240', NULL, CONVERT(bit, 'True'))
INSERT dbReto1.dbo.users( varFirstName, varLastName, varEmail, varPassword, intStatus, dmeDateCreate, dmeDateUpdate, bolIsActive) VALUES ( 'Juan', 'Pedro', 'pedrito15@gmail.com', 'predrito12', 1, '2023-12-13 11:08:08.407', NULL, CONVERT(bit, 'False'))
GO

INSERT dbReto1.dbo.reservations( idUser, idBook, dmeDateReservation, intStatus, dmeDateCreate, dmeDateUpdate, bolIsActive) VALUES ( 1, 3, '2023-12-13 19:42:50.343', 1, '2023-12-13 19:42:50.343', NULL, CONVERT(bit, 'True'))
INSERT dbReto1.dbo.reservations( idUser, idBook, dmeDateReservation, intStatus, dmeDateCreate, dmeDateUpdate, bolIsActive) VALUES ( 1, 1, '2023-12-13 20:04:33.237', 1, '2023-12-13 20:04:33.240', NULL, CONVERT(bit, 'True'))
INSERT dbReto1.dbo.reservations( idUser, idBook, dmeDateReservation, intStatus, dmeDateCreate, dmeDateUpdate, bolIsActive) VALUES ( 1, 5, '2023-12-14 15:48:44.903', 1, '2023-12-14 15:48:44.903', NULL, CONVERT(bit, 'True'))
INSERT dbReto1.dbo.reservations( idUser, idBook, dmeDateReservation, intStatus, dmeDateCreate, dmeDateUpdate, bolIsActive) VALUES ( 1, 4, '2023-12-14 15:49:10.180', 1, '2023-12-14 15:49:10.180', NULL, CONVERT(bit, 'True'))
INSERT dbReto1.dbo.reservations( idUser, idBook, dmeDateReservation, intStatus, dmeDateCreate, dmeDateUpdate, bolIsActive) VALUES ( 1, 7, '2023-12-14 15:50:52.173', 1, '2023-12-14 15:50:52.173', NULL, CONVERT(bit, 'True'))
INSERT dbReto1.dbo.reservations( idUser, idBook, dmeDateReservation, intStatus, dmeDateCreate, dmeDateUpdate, bolIsActive) VALUES ( 1, 2, '2023-12-14 15:52:11.003', 1, '2023-12-14 15:52:11.003', NULL, CONVERT(bit, 'True'))
GO


