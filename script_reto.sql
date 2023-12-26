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
	[dmeDateReservationEnd] [datetime] NULL,
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


CREATE TABLE WaitReservations(
	idWaitReservation INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
	idBook INT NOT NULL REFERENCES [dbo].[books](idBook),
	idUser INT NOT NULL REFERENCES [dbo].[users](idUser),
	varPriority VARCHAR(2) NOT NULL,
	[dmeDateReservation] [datetime] NULL,
	[dmeDateReservationEnd] [datetime] NULL,
	[intStatus] [int] NULL,
	[dmeDateCreate] [datetime] NOT NULL,
	[dmeDateUpdate] [datetime] NULL,
	[bolIsActive] [bit] NULL
);


CREATE TABLE UserNotifications(
	idNotification INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
	idUser INT NOT NULL REFERENCES [dbo].[users](idUser),
	varDescription VARCHAR(200) NOT NULL,
	[intStatus] [int] NULL,
	[dmeDateCreate] [datetime] NOT NULL,
	[dmeDateUpdate] [datetime] NULL,
	[bolIsActive] [bit] NULL
)
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
	LEFT JOIN (SELECT * FROM dbo.reservations as re where re.bolIsActive = 1) AS r
	ON (b.idBook = r.idBook)
	WHERE (@CODE IS NULL OR @CODE = '' OR b.varCode  LIKE '%' + @CODE + '%') AND (r.bolIsActive = 1 or r.bolIsActive IS NULL);
END
GO
/****** Object:  StoredProcedure [dbo].[SP_RESERVARLIBRO]    Script Date: 14/12/2023 17:35:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create  proc [dbo].[SP_RESERVARLIBRO](@ID_USER INT, @ID_BOOK INT)
AS
	begin
		INSERT INTO dbo.reservations (idUser, idBook, dmeDateReservation, dmeDateReservationEnd,intStatus, dmeDateCreate, bolIsActive) VALUES (@ID_USER, @ID_BOOK, CAST(GETDATE() AS DATE), DATEADD(DAY, 1, CAST(GETDATE() AS DATE)), 1, GETDATE(), 1);
		UPDATE dbo.books SET bolIsReservated = 1 WHERE idBook = @ID_BOOK;

		--INSERCION DE NOTIFICACION
		INSERT INTO dbo.UserNotifications(idUser, varDescription, intStatus, dmeDateCreate, bolIsActive)
		SELECT 
		r.idUser, 
		CONCAT('Hola ', u.varFirstName , ', ya cuenta con la reserva del libro ', b.varTitle, ' desde el ', CONVERT(varchar, r.dmeDateReservation, 103), ' - ', convert(varchar(5), r.dmeDateReservation, 8), ' hasta ', CONVERT(varchar, r.dmeDateReservationEnd, 103), ' - ', convert(varchar(5), r.dmeDateReservationEnd, 8)), 
		1,
		GETDATE(),
		1
		FROM dbo.reservations AS r
		INNER JOIN dbo.users AS u
		ON r.idUser = u.idUser
		INNER JOIN dbo.books AS b
		ON r.idBook = b.idBook
		WHERE r.idUser = @ID_USER AND r.idBook = @ID_BOOK AND r.bolIsActive = 1;
	end
GO
/****** Object:  StoredProcedure [dbo].[SP_RESERVARCOLA]    Script Date: 14/12/2023 17:35:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create  proc [dbo].[SP_RESERVARCOLA](@ID_USER INT, @ID_BOOK INT)
AS
	begin
		DECLARE @V_INT_PRIORITY INT;
		
		SELECT @V_INT_PRIORITY = COUNT(*) FROM dbo.WaitReservations WHERE idBook = @ID_BOOK AND bolIsActive = 1;

		set @V_INT_PRIORITY = @V_INT_PRIORITY + 1;

		INSERT INTO dbo.WaitReservations(
		idBook, 
		idUser,
		varPriority ,
		dmeDateReservation, 
		dmeDateReservationEnd,
		intStatus, 
		dmeDateCreate, 
		bolIsActive) 
		VALUES  (
		@ID_BOOK, 
		@ID_USER, 
		CONCAT('P', cast(@V_INT_PRIORITY as VARCHAR(1))),
		DATEADD(DAY, @V_INT_PRIORITY, CAST(GETDATE() AS DATE)), 
		DATEADD(DAY, @V_INT_PRIORITY + 1, CAST(GETDATE() AS DATE)), 
		1,
		GETDATE(), 
		1);

		--INSERCION DE NOTIFICACION
		INSERT INTO dbo.UserNotifications(idUser, varDescription, intStatus, dmeDateCreate, bolIsActive)
		SELECT 
		@ID_USER, 
		CONCAT('Hola ', u.varFirstName, ', su fecha de reserva era el dia ', CONVERT(varchar, w.dmeDateReservation, 103), ' - ', convert(varchar(5), w.dmeDateReservation, 8), ' del Libro: ', b.varTitle, '(', b.varCode, ')'),
		1,
		GETDATE(),
		1
		FROM dbo.WaitReservations as w 
		INNER JOIN dbo.users AS u
		ON w.idUser = u.idUser
		INNER JOIN dbo.books AS b
		ON w.idBook = b.idBook
		WHERE w.idUser = @ID_USER AND w.idBook = @ID_BOOK AND w.varPriority = CONCAT('P', cast(@V_INT_PRIORITY as VARCHAR(1))) AND w.bolIsActive = 1;
		
	end
GO
/****** Object:  StoredProcedure [dbo].[SP_OBTENERUSUARIOXEMAIL]    Script Date: 14/12/2023 17:35:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROC [dbo].[SP_OBTENERUSUARIOXEMAIL](@EMAIL VARCHAR(100))AS
BEGIN
	SELECT * FROM dbo.users WHERE varEmail = @EMAIL AND bolIsActive = 1;
END
GO
/****** Object:  StoredProcedure [dbo].[SP_VALIDARRESERVAXLIBRO]    Script Date: 14/12/2023 17:35:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create   proc [dbo].[SP_VALIDARRESERVAXLIBRO](@CODE_BOOK varchar(50)) AS
BEGIN
	SELECT COUNT(1) FROM dbo.reservations AS r INNER JOIN dbo.books AS b ON r.idBook = b.idBook WHERE b.varCode = @CODE_BOOK;
END
GO
/****** Object:  StoredProcedure [dbo].[SP_VALIDARRESERVAXUSUARIOXLIBRO]    Script Date: 14/12/2023 17:35:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create   proc [dbo].[SP_VALIDARRESERVAXUSUARIOXLIBRO](@ID_USER INT, @CODE_BOOK varchar(50)) AS
BEGIN
	SELECT COUNT(1) FROM dbo.reservations r INNER JOIN dbo.books AS b ON r.idBook = b.idBook WHERE b.varCode = @CODE_BOOK AND r.idUser = @ID_USER AND r.bolIsActive = 1;
END
GO
/****** Object:  StoredProcedure [dbo].[SP_BUSCARLIBROXCODE]    Script Date: 14/12/2023 17:35:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create   proc [dbo].[SP_BUSCARLIBROXCODE](@CODE_BOOK varchar(50)) AS
BEGIN
	SELECT * FROM dbo.books WHERE varCode = @CODE_BOOK;
END
GO
/****** Object:  StoredProcedure [dbo].[SP_VALIDARCOLA]    Script Date: 14/12/2023 17:35:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create  proc [dbo].[SP_VALIDARCOLA](@ID_USER INT,@ID_BOOK INT) AS
BEGIN
	DECLARE @V_INT_COLA int = 0;
	--VALIDAR SI EL USUARIO NO ES EL MISMO
	-- 1 ES TIENE Y 0 ES NO TIENE ACTIVOS
	SELECT @V_INT_COLA = COUNT(1) FROM dbo.WaitReservations WHERE idBook = @ID_BOOK AND idUser = @ID_USER AND bolIsActive = 1;

	IF @V_INT_COLA > 0
	BEGIN
		SELECT @V_INT_COLA;
	END
	ELSE
	BEGIN
		--VALIDAMOS QUE EL LIBRO NO SUPERE LOS 3 PERSONAS
		SELECT @V_INT_COLA = COUNT(*) FROM dbo.WaitReservations WHERE idBook = @ID_BOOK AND bolIsActive = 1;

		IF @V_INT_COLA >= 3
		BEGIN
			--CASO QUE HAYA 3 YA RESERVADOS
			SELECT @V_INT_COLA;
		END
		ELSE
		BEGIN 
			SELECT 0;
		END	
	END
END
GO
/****** Object:  StoredProcedure [dbo].[SP_LISTARNOTIFICACIONESXUSUARIO]    Script Date: 14/12/2023 17:35:06 *****
*/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create or alter proc [dbo].[SP_LISTARNOTIFICACIONESXUSUARIO](@ID_USER INT) AS
BEGIN
	SELECT varDescription FROM dbo.UserNotifications WHERE idUser = @ID_USER AND bolIsActive = 1;
END
GO
/****** Object:  StoredProcedure [dbo].[SP_LIBERACIONLIBROS]    Script Date: 14/12/2023 17:35:06 *****
*/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[SP_LIBERACIONLIBROS](@FECHA_PRUEBA DATE) AS
BEGIN
		--FECHA ACTUAL
	DECLARE @V_DATE_FECHAACTUAL DATE = GETDATE();
	DECLARE @V_INT_CONTADOR_COLA INT;
	DECLARE @V_INT_VALIDAR_COLA INT;
	--SOLO DE PRUEBA PAR PROBAR POR DIAS
	SET @V_DATE_FECHAACTUAL = @FECHA_PRUEBA; --24

	SELECT @V_INT_VALIDAR_COLA = COUNT(1) FROM dbo.reservations WHERE CAST(dmeDateReservation AS DATE) = @V_DATE_FECHAACTUAL and bolIsActive = 1;

	IF @V_INT_VALIDAR_COLA = 0
	BEGIN
		--DESACTIVANDO TODAS LAS NOTIFICACIONES
		UPDATE dbo.UserNotifications SET bolIsActive = 0 WHERE bolIsActive = 1;

		-- ESTO PARA VALIDAR LA TABLA SI HAY PARA HACER COLA
		SELECT @V_INT_CONTADOR_COLA =COUNT(*) FROM dbo.WaitReservations WHERE varPriority = 'P1' AND dmeDateReservation = @V_DATE_FECHAACTUAL AND bolIsActive = 1;

		IF @V_INT_CONTADOR_COLA > 0
		BEGIN
			-- SI EXISTE PARA LA FECHA DE HOY, NO HACER NADA
			-- SI NO EXISTE PARA LA FECHA DE HOY, REALIZAR EL PROCEDIMIENTO
			--INSERCION A TABLA RESERVAS
			INSERT INTO dbo.reservations(idBook, idUser, intStatus, dmeDateReservation, dmeDateReservationEnd, dmeDateCreate, bolIsActive)
			SELECT w.idBook, w.idUser, 1, w.dmeDateReservation, w.dmeDateReservationEnd, GETDATE(), 1
			FROM dbo.WaitReservations AS w WHERE varPriority = 'P1' AND dmeDateReservation = @V_DATE_FECHAACTUAL AND bolIsActive = 1;

			--ACTUALIZACION A TABLA COLA DE P2 A P1 DATEADD(DAY, 1, @V_DATE_FECHAACTUAL),
			UPDATE dbo.WaitReservations SET varPriority = 'P1' WHERE varPriority = 'P2'  AND CAST(dmeDateReservation AS DATE) = DATEADD(DAY, 1, @V_DATE_FECHAACTUAL) and bolIsActive = 1; 

			--ACTUALIZACION A TABLA COLA DE P3 A P2
			UPDATE dbo.WaitReservations SET varPriority = 'P2' WHERE varPriority = 'P3'  AND CAST(dmeDateReservation AS DATE) = DATEADD(DAY, 2, @V_DATE_FECHAACTUAL) and bolIsActive = 1; 

			--ACTUALIZACION A TABLA COLA DE DESACTIVACION
			UPDATE dbo.WaitReservations SET bolIsActive = 0 WHERE CAST(dmeDateReservation AS DATE) = @V_DATE_FECHAACTUAL and bolIsActive = 1; 

			--ACTUALIZACION A TABLA RESERVATION DE DESACTIVACION
			UPDATE dbo.reservations SET bolIsActive = 0 WHERE CAST(dmeDateReservationEnd AS DATE) = @V_DATE_FECHAACTUAL and bolIsActive = 1; 

			--INSERCION DE NOTIFICACIONES DEL COLA
			INSERT INTO dbo.UserNotifications(idUser, varDescription, intStatus, dmeDateCreate, bolIsActive)
			SELECT
			w.idUser, 
			CONCAT('Hola ', u.varFirstName, ', su fecha de reserva era el dia ', CONVERT(varchar, w.dmeDateReservation, 103), ' - ', convert(varchar(5), w.dmeDateReservation, 8), ' del Libro: ', b.varTitle, '(', b.varCode, ')'), 
			1, 
			GETDATE(),
			1 
			FROM dbo.WaitReservations  as w
			INNER JOIN dbo.users u
			ON w.idUser = u.idUser
			INNER JOIN dbo.books AS b
			ON w.idBook = b.idBook
			WHERE w.varPriority IN ('P1', 'P2', 'P3') AND w.bolIsActive = 1;

			INSERT INTO dbo.UserNotifications(idUser, varDescription, intStatus, dmeDateCreate, bolIsActive)
			SELECT 
			r.idUser, 
			CONCAT('Hola ', u.varFirstName , ', ya cuenta con la reserva del libro ', b.varTitle, ' desde el ', CONVERT(varchar, r.dmeDateReservation, 103), ' - ', convert(varchar(5), r.dmeDateReservation, 8), ' hasta ', CONVERT(varchar, r.dmeDateReservationEnd, 103), ' - ', convert(varchar(5), r.dmeDateReservationEnd, 8)), 
			1, 
			GETDATE(), 
			1 
			FROM dbo.reservations as r
			INNER JOIN dbo.users u
			ON r.idUser = u.idUser
			INNER JOIN dbo.books as b
			ON r.idBook = b.idBook
			WHERE r.bolIsActive = 1;

		END
	END
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
INSERT dbReto1.dbo.users( varFirstName, varLastName, varEmail, varPassword, intStatus, dmeDateCreate, dmeDateUpdate, bolIsActive) VALUES ( 'Juan', 'Pedro', 'pedrito15@gmail.com', 'predrito12', 1, '2023-12-13 11:08:08.407', NULL, CONVERT(bit, 'True'))
GO



