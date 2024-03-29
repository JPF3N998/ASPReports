
/****** Object:  Table [dbo].[ASP]    Script Date: 9/27/2019 11:42:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ASP](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[nombre] [nvarchar](64) NOT NULL,
	[ubicacion] [nvarchar](256) NOT NULL,
	[fechaCreacion] [nvarchar](10) NOT NULL,
	[activo] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Oportunidades]    Script Date: 9/27/2019 11:42:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Oportunidades](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[idSitio] [int] NOT NULL,
	[descripcion] [nvarchar](512) NOT NULL,
	[observaciones] [nvarchar](1024) NOT NULL,
	[fechaModificacion] [nvarchar](10) NOT NULL,
	[activo] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RatingRecurso]    Script Date: 9/27/2019 11:42:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RatingRecurso](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[idRecurso] [int] NOT NULL,
	[relacionPropositoASP] [int] NOT NULL,
	[relacionTemaInterpretativoASP] [int] NOT NULL,
	[variedadRecurso] [int] NOT NULL,
	[atractivo] [int] NOT NULL,
	[accesibilidad] [int] NOT NULL,
	[fechaModificacion] [nvarchar](10) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Recursos]    Script Date: 9/27/2019 11:42:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Recursos](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[idTipoRecurso] [int] NOT NULL,
	[idSitio] [int] NOT NULL,
	[nombre] [nvarchar](128) NOT NULL,
	[ubicacion] [nvarchar](128) NOT NULL,
	[traslape] [nvarchar](128) NOT NULL,
	[condicion] [nvarchar](128) NOT NULL,
	[atractivos] [nvarchar](128) NOT NULL,
	[soporte] [bit] NOT NULL,
	[capacidad] [int] NOT NULL,
	[hectareas] [float] NOT NULL,
	[oportunidades] [nvarchar](256) NOT NULL,
	[fechaModificacion] [nvarchar](10) NOT NULL,
	[activo] [bit] NOT NULL
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Sitios]    Script Date: 9/27/2019 11:42:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Sitios](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[idASP] [int] NOT NULL,
	[idTipoFigura] [int] NOT NULL,
	[nombre] [nvarchar](64) NOT NULL,
	[ubicacion] [nvarchar](256) NOT NULL,
	[zonificacion] [bit] NOT NULL,
	[tamano] [nvarchar](512) NOT NULL,
	[valoracionRelacionPropositoASP] [float] NOT NULL,
	[valoracionRelacionTemasInterpretativos] [float] NOT NULL,
	[valoracionVariedadRecurso] [float] NOT NULL,
	[valoracionAtractivo] [float] NOT NULL,
	[valoracionAccesibilidad] [float] NOT NULL,
	[fechaCreacion] [nvarchar](10) NOT NULL,
	[activo] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[sysdiagrams]    Script Date: 9/27/2019 11:42:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[sysdiagrams](
	[name] [sysname] NOT NULL,
	[principal_id] [int] NOT NULL,
	[diagram_id] [int] IDENTITY(1,1) NOT NULL,
	[version] [int] NULL,
	[definition] [varbinary](max) NULL,
PRIMARY KEY CLUSTERED 
(
	[diagram_id] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UK_principal_name] UNIQUE NONCLUSTERED 
(
	[principal_id] ASC,
	[name] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TipoFigura]    Script Date: 9/27/2019 11:42:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TipoFigura](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[nombre] [nvarchar](32) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TipoRecurso]    Script Date: 9/27/2019 11:42:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TipoRecurso](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[nombre] [nvarchar](128) NOT NULL,
	[fechaCreacion] [nvarchar](10) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Usuario]    Script Date: 9/27/2019 11:42:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Usuario](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[nombre] [nvarchar](50) NOT NULL,
	[cedula] [nvarchar](15) NOT NULL,
	[correo] [nvarchar](50) NOT NULL,
	[usuario] [nvarchar](50) NOT NULL,
	[contrasena] [nvarchar](50) NOT NULL,
	[admin] [bit] NOT NULL,
	[activo] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Oportunidades]  WITH CHECK ADD FOREIGN KEY([idSitio])
REFERENCES [dbo].[Sitios] ([id])
GO
ALTER TABLE [dbo].[RatingRecurso]  WITH CHECK ADD FOREIGN KEY([idRecurso])
REFERENCES [dbo].[Recursos] ([id])
GO
ALTER TABLE [dbo].[Recursos]  WITH CHECK ADD FOREIGN KEY([idSitio])
REFERENCES [dbo].[Sitios] ([id])
GO
ALTER TABLE [dbo].[Recursos]  WITH CHECK ADD FOREIGN KEY([idTipoRecurso])
REFERENCES [dbo].[TipoRecurso] ([id])
GO
ALTER TABLE [dbo].[Sitios]  WITH CHECK ADD FOREIGN KEY([idASP])
REFERENCES [dbo].[ASP] ([id])
GO
ALTER TABLE [dbo].[Sitios]  WITH CHECK ADD FOREIGN KEY([idTipoFigura])
REFERENCES [dbo].[TipoFigura] ([id])
GO
/****** Object:  StoredProcedure [dbo].[spActualizarRatingRecurso]    Script Date: 9/27/2019 11:42:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[spActualizarRatingRecurso]
	@nombreASPInput NVARCHAR(64),
	@nombreSitioInput NVARCHAR(64),
	@nombreRecursoInput NVARCHAR(128),
	@rRelacionPropositoASP INT,
	@rRelacionTemaInterpretativoASP INT,
	@rVariedadRecurso INT,
	@rAtractivo INT,
	@rAccesibildad INT AS
BEGIN
	DECLARE @idASP INT;
	EXEC spGetIDAsp @nombreASPInput,@idASP OUTPUT;
	IF @idASP IS NOT NULL
		BEGIN
			DECLARE @idSitio INT;
			EXEC spGetIDSitio @idASP,@nombreSitioInput,@idSitio OUTPUT;
			IF @idSitio IS NOT NULL
				BEGIN
					DECLARE @idRecurso INT;
					EXEC spGetIDRecurso @idSitio, @nombreRecursoInput,@idRecurso OUTPUT;
					IF @idRecurso IS NOT NULL
						BEGIN
							BEGIN TRY
								BEGIN TRANSACTION
									UPDATE RatingRecurso
										SET RatingRecurso.relacionPropositoASP = @rRelacionPropositoASP,
											RatingRecurso.relacionTemaInterpretativoASP = @rRelacionTemaInterpretativoASP,
											RatingRecurso.variedadRecurso = @rVariedadRecurso,
											RatingRecurso.atractivo = @rAtractivo,
											RatingRecurso.accesibilidad = @rAccesibildad,
											RatingRecurso.fechaModificacion = CONVERT(NVARCHAR(15),GETDATE(),103)
										WHERE @idRecurso = RatingRecurso.idRecurso
										EXEC spActualizarValoracion @nombreASPInput,@nombreSitioInput
								COMMIT
							END TRY
							BEGIN CATCH
								IF @@TRANCOUNT > 0
									ROLLBACK
									RETURN -1*@@ERROR
							END CATCH
						END
					ELSE
						BEGIN
							PRINT 'Recurso no existe'
							RETURN -1
						END
				END
			ELSE
				BEGIN
					PRINT 'No existe ese sitio'
					RETURN -1
				END
		END
	ELSE
		BEGIN
			PRINT 'No existe ese ASP'
			RETURN -1
		END
END
GO
/****** Object:  StoredProcedure [dbo].[spActualizarValoracion]    Script Date: 9/27/2019 11:42:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[spActualizarValoracion] @nombreASPInput NVARCHAR(64),@nombreSitioInput NVARCHAR(64) AS
BEGIN
	DECLARE @idASP INT;
	EXEC spGetIDAsp @nombreASPInput,@idASP OUTPUT;
	IF @idASP IS NOT NULL
		BEGIN
			DECLARE @idSitio INT;
			EXEC spGetIDSitio @idASP,@nombreSitioInput,@idSitio OUTPUT;
			IF @idSitio IS NOT NULL
				BEGIN
					DECLARE @temp TABLE(promRP FLOAT,promRTI FLOAT,promVR FLOAT,promA FLOAT,promAcc FLOAT)

					--EXEC spActualizarValoracion 'Volcan Irazu','Crater'
					INSERT INTO @temp(promRP,promRTI,promVR,promA,promAcc)
					SELECT AVG(CAST(RR.relacionPropositoASP AS FLOAT)) AS promRP, AVG(CAST(RR.relacionTemaInterpretativoASP AS FLOAT)) AS promRTI, AVG(CAST(RR.variedadRecurso AS FLOAT)) AS promVR,AVG(CAST(RR.atractivo AS FLOAT)) as promA, AVG(CAST(RR.accesibilidad AS FLOAT)) AS promAcc
					FROM (RatingRecurso RR JOIN Recursos R ON RR.idRecurso=R.id) JOIN Sitios S ON R.idSitio=S.id WHERE S.id = @idSitio
					
					BEGIN TRY
						BEGIN TRANSACTION
							UPDATE Sitios
							SET Sitios.valoracionRelacionPropositoASP = (SELECT T.promRP FROM @temp T),
								Sitios.valoracionRelacionTemasInterpretativos = (SELECT T.promRTI FROM @temp T),
								Sitios.valoracionVariedadRecurso = (SELECT T.promVR FROM @temp T),
								Sitios.valoracionAtractivo = (SELECT T.promA FROM @temp T),
								Sitios.valoracionAccesibilidad = (SELECT T.promAcc FROM @temp T)

							WHERE Sitios.id=@idSitio
						COMMIT
					END TRY
					BEGIN CATCH
						IF @@TRANCOUNT > 0
							ROLLBACK
							RETURN -1*@@ERROR
					END CATCH
				END
			ELSE
				BEGIN
					PRINT 'Sitio no existe en este ASP'
					RETURN -1
				END
		END
	ELSE
		BEGIN
			PRINT 'ASP no existe'
			RETURN -1
		END
END
GO
/****** Object:  StoredProcedure [dbo].[spAgregarASP]    Script Date: 9/27/2019 11:42:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[spAgregarASP] @nombreInput NVARCHAR(64),@ubicacionInput NVARCHAR(256) AS
	BEGIN
		DECLARE @idASP INT;
		EXEC spGetIDAsp @nombreInput, @idASP OUTPUT;
		IF @idASP IS NULL
			BEGIN TRY
				BEGIN TRANSACTION
					INSERT INTO ASP(nombre,ubicacion,fechaCreacion,activo) VALUES (@nombreInput,@ubicacionInput,CONVERT(NVARCHAR(10),GETDATE(),103),1)
				COMMIT
				RETURN 0
			END TRY
			BEGIN CATCH
				IF @@TRANCOUNT > 0
					ROLLBACK
					RETURN -1*@@ERROR
			END CATCH
		ELSE
			BEGIN
				DECLARE @activo BIT;
				EXEC spASPActivo @idASP,@activo OUTPUT
				IF @activo = 0
					BEGIN TRY
						BEGIN TRANSACTION
							UPDATE ASP
								SET ASP.activo = 1,
									ASP.fechaCreacion = CONVERT(NVARCHAR(15),GETDATE(),103)
								WHERE ASP.id = @idASP
						COMMIT
						RETURN 0
					END TRY
					BEGIN CATCH
						IF @@TRANCOUNT > 0
							ROLLBACK
							RETURN -1*@@ERROR
					END CATCH
				ELSE
					BEGIN
						PRINT 'Ya existe ese ASP' 
						RETURN -1
					END
			END
	END	
GO
/****** Object:  StoredProcedure [dbo].[spAgregarOportunidad]    Script Date: 9/27/2019 11:42:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[spAgregarOportunidad] 
	@nombreASPInput NVARCHAR(64),
	@nombreSitioInput NVARCHAR(64),
	@descripcionInput NVARCHAR(512),
	@observacionesInput NVARCHAR(1024) AS
BEGIN
	DECLARE @idASP INT;
	EXEC spGetIDAsp @nombreASPInput,@idASP OUTPUT;

	DECLARE @ASPActivo BIT;
	EXEC spASPActivo @idASP, @ASPActivo OUTPUT;

	IF @idASP IS NOT NULL AND @ASPActivo = 1
		BEGIN

			DECLARE @idSitio INT;
			EXEC spGetIDSitio @idASP,@nombreSitioInput,@idSitio OUTPUT;

			DECLARE @sitioActivo BIT;
			EXEC spSitioActivo @idSitio,@sitioActivo OUTPUT;

			IF @idSitio IS NOT NULL AND @sitioActivo = 1
				BEGIN

					DECLARE @idOportunidad INT;
					DECLARE @lowDescripcion NVARCHAR(512);
					EXEC spGetIDOportunidad @idASP,@descripcionInput,@idOportunidad OUTPUT;

					IF @idOportunidad IS NULL
						BEGIN
							BEGIN TRY
								BEGIN TRANSACTION
									INSERT INTO Oportunidades(idSitio,descripcion,observaciones,fechaModificacion,activo)
									VALUES (@idSitio,@descripcionInput,@observacionesInput,CONVERT(NVARCHAR(15),GETDATE(),103),1)
								COMMIT
								RETURN 0
							END TRY
							BEGIN CATCH
								IF @@TRANCOUNT > 0
									ROLLBACK
									RETURN -1*@@ERROR
							END CATCH
						END
					ELSE
						BEGIN

							DECLARE @oportunidadActiva BIT;
							EXEC spOportunidadActivo @idOportunidad,@oportunidadActiva OUTPUT;

							IF @oportunidadActiva = 0
								BEGIN TRY
									BEGIN TRANSACTION
										
										UPDATE Oportunidades
										SET Oportunidades.activo = 1,
											Oportunidades.fechaModificacion = CONVERT(NVARCHAR(15),GETDATE(),103)
					
									COMMIT
									RETURN 0
								END TRY
								BEGIN CATCH
									IF @@TRANCOUNT > 0
										ROLLBACK
										RETURN -1*@@ERROR
								END CATCH
							ELSE
								BEGIN
									PRINT 'Ya existe esa oportunidad'
									RETURN -1
								END
						END
				END	
			ELSE
				BEGIN
					PRINT 'No existe ese sitio'
					RETURN -1
				END
		END
	ELSE
		BEGIN
			PRINT 'No existe ese ASP'
			RETURN -1
		END
END
GO
/****** Object:  StoredProcedure [dbo].[spAgregarRecurso]    Script Date: 9/27/2019 11:42:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[spAgregarRecurso] 
	@nombreASPInput NVARCHAR(64),
	@nombreSitioInput NVARCHAR(64),
	@nombreTipoRecursoInput NVARCHAR(64),
	@nombreRecursoInput NVARCHAR(128),
	@rUbicacion nvarchar(128),
	@rTraslape nvarchar(128),
	@rCondicion nvarchar(128),
	@rAtractivos nvarchar(128),
	@rSoporte bit,
	@rCapacidad int,
	@rHectareas float,
	@rOportunidades nvarchar(128),
	--Rating de recurso puntajes de 1-3
	@rRelacionPropositoASP INT,
	@rRelacionTemaInterpretativoASP INT,
	@rVariedadRecurso INT,
	@rAtractivo INT,
	@rAccesibildad INT AS

BEGIN
	DECLARE @idASP INT;
	EXEC spGetIDAsp @nombreASPInput,@idASP OUTPUT;

	DECLARE @ASPActivo BIT;
	EXEC spASPActivo @idASP, @ASPActivo OUTPUT;

	IF @idASP IS NOT NULL AND @ASPActivo = 1
		BEGIN
			DECLARE @idSitio INT;
			EXEC spGetIDSitio @idASP,@nombreSitioInput,@idSitio OUTPUT;

			DECLARE @sitioActivo BIT;
			EXEC spSitioActivo @idSitio,@sitioActivo OUTPUT;

			IF @idSitio IS NOT NULL AND @sitioActivo = 1
				BEGIN

					DECLARE @idRecurso INT;
					EXEC spGetIDRecurso @idSitio,@nombreRecursoInput,@idRecurso OUTPUT;
					
					IF @idRecurso IS NULL
						BEGIN
							BEGIN TRY
								DECLARE @idTipoRecurso INT;
								EXEC spGetIDTipoRecurso @nombreTipoRecursoInput,@idTipoRecurso OUTPUT;
								BEGIN TRANSACTION

									INSERT INTO Recursos(idTipoRecurso,idSitio,nombre,ubicacion,traslape,condicion,atractivos,soporte,capacidad,hectareas,oportunidades,fechaModificacion,activo)
									VALUES (@idTipoRecurso,@idSitio,@nombreRecursoInput,@rUbicacion,@rTraslape,@rCondicion,@rAtractivos,@rSoporte,@rCapacidad,@rHectareas,@rOportunidades,CONVERT(NVARCHAR(15),GETDATE(),103),1)
									

									INSERT INTO RatingRecurso(idRecurso,relacionPropositoASP,relacionTemaInterpretativoASP,variedadRecurso,atractivo,accesibilidad,fechaModificacion)
									SELECT MAX(id) as idRecurso,@rRelacionPropositoASP,@rRelacionTemaInterpretativoASP,@rVariedadRecurso,@rAtractivo,@rAccesibildad,CONVERT(NVARCHAR(15),GETDATE(),103) FROM Recursos
									
									EXEC spActualizarValoracion @nombreASPInput, @nombreSitioInput
									
								COMMIT
								RETURN 0
							END TRY
							BEGIN CATCH
								IF @@TRANCOUNT > 0
								ROLLBACK
								RETURN -1*@@ERROR
							END CATCH
						END
					ELSE
						BEGIN
							
							DECLARE @recursoActivo BIT;
							EXEC spRecursoActivo @idRecurso,@recursoActivo OUTPUT;

							IF @idRecurso = 0
								BEGIN TRY
									BEGIN TRANSACTION
										
										UPDATE Recursos
											SET Recursos.activo = 1,
												Recursos.fechaModificacion = CONVERT(NVARCHAR(15),GETDATE(),103)
												WHERE Recursos.id = @idRecurso

									COMMIT
									RETURN 0
									END TRY
								BEGIN CATCH
									IF @@TRANCOUNT > 0
										ROLLBACK
										RETURN -1*@@ERROR
								END CATCH
							ELSE
								BEGIN
									PRINT 'Recurso ya existe'
									RETURN -1
								END
						END

				END
			ELSE
				BEGIN
					PRINT 'No existe ese sitio'
					RETURN -1
				END
		END
	ELSE
		BEGIN
			PRINT 'No existe ese ASP'
			RETURN -1
		END
END
GO
/****** Object:  StoredProcedure [dbo].[spAgregarSitio]    Script Date: 9/27/2019 11:42:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[spAgregarSitio]
	@nombreASPInput NVARCHAR(64),
	@nombreSitioInput NVARCHAR(64),
	@ubicacionInput NVARCHAR(256),
	@zonificacionInput BIT,
	@nombreTipoFiguraInput NVARCHAR(32),
	@tamanoInput NVARCHAR(512) AS

	BEGIN
		DECLARE @idASP INT;
		DECLARE @activoASP BIT;
		EXEC spGetIDAsp @nombreASPInput,@idASP OUTPUT;
		EXEC spASPActivo @idASP,@activoASP OUT;
		IF @idASP IS NOT NULL AND @activoASP = 1
			BEGIN
				DECLARE @idSitio INT;
				EXEC spGetIDSitio @idASP,@nombreSitioInput,@idSitio OUTPUT;
				IF @idSitio IS NULL
					BEGIN
						BEGIN TRY
							DECLARE @idTipoFigura INT;
							EXEC spGetIDTipoFigura @nombreTipoFiguraInput,@idTipoFigura OUTPUT
							BEGIN TRANSACTION
								INSERT INTO Sitios(idASP,nombre,ubicacion,zonificacion,idTipoFigura,tamano,valoracionRelacionPropositoASP,valoracionRelacionTemasInterpretativos,valoracionVariedadRecurso,valoracionAtractivo,valoracionAccesibilidad,fechaCreacion,activo)
								VALUES (@idASP,@nombreSitioInput,@ubicacionInput,@zonificacionInput,@idTipoFigura,@tamanoInput,0,0,0,0,0,CONVERT(VARCHAR(10),GETDATE(),103),1)
							COMMIT
							RETURN 0
						END TRY
						BEGIN CATCH
							IF @@TRANCOUNT > 0
								ROLLBACK
								RETURN -1*@@ERROR
						END CATCH
					END
				ELSE
					BEGIN
						DECLARE @activo BIT;
						EXEC spSitioActivo @idSitio,@activo OUTPUT
						IF @idSitio = 0
							BEGIN TRY
								BEGIN TRANSACTION
									UPDATE Sitios
										SET Sitios.activo = 1,
											Sitios.fechaCreacion = CONVERT(NVARCHAR(15),GETDATE(),103)
										WHERE Sitios.id = @idSitio
								COMMIT
								RETURN 0
							END TRY
							BEGIN CATCH
								IF @@TRANCOUNT > 0
									ROLLBACK
									RETURN -1*@@ERROR
							END CATCH
					ELSE
						BEGIN
							PRINT 'Sitio ya existe'
							RETURN -1
						END
					END
			END
		ELSE
			BEGIN
				
				PRINT 'ASP no existe'
				RETURN -1
			END
	END
GO
/****** Object:  StoredProcedure [dbo].[spASPActivo]    Script Date: 9/27/2019 11:42:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[spASPActivo] @idASP INT, @activoOut BIT OUTPUT AS
BEGIN
	
	IF (SELECT A.activo FROM ASP A WHERE A.id = @idASP) = 0
		SET @activoOut = 0
	ELSE
		SET @activoOut = 1
	
END
GO
/****** Object:  StoredProcedure [dbo].[spBuscarASP]    Script Date: 9/27/2019 11:42:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[spBuscarASP] @nombreASPInput NVARCHAR(64) AS
BEGIN
	
	IF @nombreASPInput LIKE '*'
		BEGIN
			SELECT A.nombre AS [Nombre], A.ubicacion AS [Ubicacion], A.fechaCreacion AS [Fecha de creacion del ASP] FROM ASP A WHERE A.activo = 1 
		END
	ELSE
		BEGIN
			SELECT A.nombre AS [Nombre], A.ubicacion AS [Ubicacion], A.fechaCreacion AS [Fecha de creacion del ASP] FROM ASP A WHERE LOWER(A.nombre) LIKE LOWER(@nombreASPInput) AND A.activo = 1
		END
END

GO
/****** Object:  StoredProcedure [dbo].[spBuscarRecurso]    Script Date: 9/27/2019 11:42:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[spBuscarRecurso] @nombreASPinput NVARCHAR(64),@nombreSitioInput NVARCHAR(64),@nombreRecursoInput NVARCHAR(128) AS
	BEGIN
		
		DECLARE @idASP INT
		EXEC spGetIDAsp @nombreASPInput,@idASP OUTPUT;

		DECLARE @ASPactivo BIT;
		EXEC spASPActivo @idASP,@ASPactivo OUTPUT;

		IF @idASP IS NOT NULL AND @ASPactivo = 1
			BEGIN
				
				DECLARE @idSitio INT;
				EXEC spGetIDSitio @idASP,@nombreSitioInput,@idSitio OUTPUT;

				DECLARE @sitioActivo BIT;
				EXEC spSitioActivo @idSitio,@sitioActivo OUTPUT;

				IF @idSitio IS NOT NULL AND @sitioActivo = 1
					BEGIN
						
						IF @nombreRecursoInput LIKE '*'
							BEGIN
								SELECT R.nombre AS [Nombre de recurso],TR.nombre AS [Tipo de recurso],R.fechaModificacion AS [Ultima fecha de modificacion] FROM Recursos R JOIN TipoRecurso TR ON R.idTipoRecurso = TR.id WHERE R.activo = 1  AND @idSitio = R.idSitio
							END
						ELSE
							BEGIN
								SELECT R.nombre AS [Nombre de recurso],TR.nombre AS [Tipo de recurso],R.fechaModificacion AS [Ultima fecha de modificacion] FROM Recursos R JOIN TipoRecurso TR ON R.idTipoRecurso = TR.id WHERE R.activo = 1 AND LOWER(R.nombre) LIKE LOWER(@nombreRecursoInput)  AND @idSitio = R.idSitio
							END

					END
				ELSE
					BEGIN
						PRINT 'Sitio no existe'
					END

			END
		ELSE
			BEGIN
				PRINT 'ASP no existe'
			END

	END

GO
/****** Object:  StoredProcedure [dbo].[spBuscarSitio]    Script Date: 9/27/2019 11:42:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[spBuscarSitio] @nombreASPInput NVARCHAR(64),@nombreSitioInput NVARCHAR(64) AS
	BEGIN
		DECLARE @idASP INT
		EXEC spGetIDAsp @nombreASPInput,@idASP OUTPUT;

		IF @nombreSitioInput LIKE '*'
			BEGIN
				SELECT S.nombre AS [Nombre del sitio],S.ubicacion AS [Ubicacion],
				CASE WHEN S.zonificacion = 1 THEN 'Si' ELSE 'No' END AS [Zonificacion],
				(SELECT TF.nombre FROM Sitios S JOIN TipoFigura TF ON S.idTipoFigura = TF.id) AS [Forma del sitio],
				S.valoracionRelacionPropositoASP AS [Relacion con el proposito del ASP],
				S.valoracionRelacionTemasInterpretativos AS [Relacion con temas interpretativos del ASP],
				S.valoracionVariedadRecurso AS [Variedad de los recursos],
				S.valoracionAtractivo AS [Atractivo],
				S.valoracionAccesibilidad AS [Accesibilidad] 
				FROM Sitios S WHERE S.idASP = @idASP AND S.activo = 1;
			END
		ELSE
			BEGIN
				SELECT S.nombre AS [Nombre del sitio],S.ubicacion AS [Ubicacion],
				CASE WHEN S.zonificacion = 1 THEN 'Si' ELSE 'No' END AS [Zonificacion],
				(SELECT TF.nombre FROM Sitios S JOIN TipoFigura TF ON S.idTipoFigura = TF.id) AS [Forma del sitio],
				S.valoracionRelacionPropositoASP AS [Relacion con el proposito del ASP],
				S.valoracionRelacionTemasInterpretativos AS [Relacion con temas interpretativos del ASP],
				S.valoracionVariedadRecurso AS [Variedad de los recursos],
				S.valoracionAtractivo AS [Atractivo],
				S.valoracionAccesibilidad AS [Accesibilidad] 
				FROM Sitios S WHERE LOWER(S.nombre) = LOWER(@nombreSitioInput) AND S.idASP = @idASP AND S.activo = 1;
			END
	END

GO
/****** Object:  StoredProcedure [dbo].[spEliminarASP]    Script Date: 9/27/2019 11:42:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[spEliminarASP] @nombreASPInput NVARCHAR(64) AS
	BEGIN
			DECLARE @idASP INT;
			EXEC spGetIDAsp @nombreASPInput,@idASP OUTPUT;

			DECLARE @ASPActivo BIT;
			EXEC spASPActivo @nombreASPInput,@ASPActivo OUTPUT;

			IF @idASP IS NOT NULL AND @ASPActivo = 1
				BEGIN TRY
					BEGIN TRANSACTION
						UPDATE ASP
						SET ASP.activo = 0 WHERE @idASP = ASP.id;
					COMMIT
					RETURN 0
				END TRY
				BEGIN CATCH
					IF @@TRANCOUNT > 0
						ROLLBACK
						RETURN -1*@@ERROR
				END CATCH
			ELSE
				BEGIN
					PRINT 'No existe ese ASP.'
					RETURN -1
				END
	END
GO
/****** Object:  StoredProcedure [dbo].[spEliminarOportunidad]    Script Date: 9/27/2019 11:42:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[spEliminarOportunidad] @nombreASPInput NVARCHAR(64),@nombreSitioInput NVARCHAR(64), @descripcionOportunidadInput NVARCHAR(512) AS
	BEGIN
		DECLARE @idASP INT;
		EXEC spGetIDAsp @nombreASPInput,@idASP OUTPUT;

		DECLARE @ASPactivo BIT;
		EXEC spASPActivo @idASP, @ASPactivo OUTPUT;

	IF @idASP IS NOT NULL AND @ASPactivo = 1
		BEGIN
			DECLARE @idSitio INT;
			EXEC spGetIDSitio @idASP,@nombreSitioInput,@idSitio OUTPUT;

			DECLARE @sitioActivo BIT;
			EXEC spSitioActivo @idSitio,@sitioActivo OUTPUT;

			IF @idSitio IS NOT NULL AND  @sitioActivo = 1
				BEGIN
					
					DECLARE @idOportunidad INT;
					EXEC spGetIDOportunidad @idASP,@descripcionOportunidadInput,@idOportunidad OUTPUT;

					DECLARE @oportunidadActivo BIT;
					EXEC spOportunidadActivo @idOportunidad,@oportunidadActivo OUTPUT;

					IF @idOportunidad IS NOT NULL AND @oportunidadActivo = 1
						BEGIN
							BEGIN TRY
								BEGIN TRANSACTION
									UPDATE Oportunidades
									SET Oportunidades.activo = 0,
										Oportunidades.fechaModificacion = CONVERT(NVARCHAR(15),GETDATE(),103)
										WHERE Oportunidades.id = @idOportunidad
								COMMIT
								RETURN 0
							END TRY
							BEGIN CATCH
								IF @@TRANCOUNT > 0
								ROLLBACK
								RETURN -1*@@ERROR
							END CATCH
						END
					ELSE
						BEGIN
							PRINT 'Oportunidad no existe'
							RETURN -1
						END
				END
			ELSE
				BEGIN
					PRINT 'No existe ese sitio'
					RETURN -1
				END
		END
	ELSE
		BEGIN
			PRINT 'No existe ese ASP'
			RETURN -1
		END
	END
GO
/****** Object:  StoredProcedure [dbo].[spEliminarRecurso]    Script Date: 9/27/2019 11:42:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[spEliminarRecurso] @nombreASPInput NVARCHAR(64), @nombreSitioInput NVARCHAR(64), @nombreRecursoInput NVARCHAR(64) AS
	BEGIN
		DECLARE @idASP INT;
		EXEC spGetIDAsp @nombreASPInput,@idASP OUTPUT;

		DECLARE @ASPActivo BIT;
		EXEC spASPActivo @nombreASPInput,@ASPActivo OUTPUT;

		IF @idASP IS NOT NULL AND @ASPActivo = 1
			BEGIN
				DECLARE @idSitio INT;
				EXEC spGetIDSitio @idASP,@nombreSitioInput,@idSitio OUTPUT;

				DECLARE @sitioActivo BIT;
				EXEC spSitioActivo @idSitio,@sitioActivo OUTPUT;

				IF @idSitio IS NOT NULL AND @sitioActivo = 1
					BEGIN
						DECLARE @idRecurso INT;
						EXEC spGetIDRecurso @idSitio,@nombreRecursoInput,@idRecurso OUTPUT;

						DECLARE @recursoActivo BIT;
						EXEC spRecursoActivo @idRecurso, @recursoActivo OUTPUT;

						IF @idRecurso IS NOT NULL AND @recursoActivo = 1
							BEGIN
								BEGIN TRY
									BEGIN TRANSACTION
										UPDATE Recursos
											SET Recursos.activo = 0,
												Recursos.fechaModificacion = CONVERT(NVARCHAR(15),GETDATE(),103)
												WHERE Recursos.id = @idRecurso
									COMMIT
									RETURN 0
								END TRY
								BEGIN CATCH
									IF @@TRANCOUNT > 0
									ROLLBACK
									RETURN -1*@@ERROR
								END CATCH
							END
						ELSE
							BEGIN
								PRINT 'Recurso NO existe'
								RETURN -1
							END
					END
				ELSE
					BEGIN
						PRINT 'No existe ese sitio'
						RETURN -1
					END
			END
		ELSE
			BEGIN
				PRINT 'No existe ese ASP'
				RETURN -1
			END
		END
GO
/****** Object:  StoredProcedure [dbo].[spEliminarSitio]    Script Date: 9/27/2019 11:42:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[spEliminarSitio] @nombreASPInput NVARCHAR(64), @nombreSitioInput NVARCHAR(64) AS
	BEGIN
		DECLARE @idASP INT;
		EXEC spGetIDAsp @nombreASPInput,@idASP OUTPUT;

		DECLARE @ASPActivo BIT;
		EXEC spASPActivo @nombreASPInput,@ASPActivo OUTPUT;

		IF @idASP IS NOT NULL AND @ASPActivo = 1
			BEGIN
				DECLARE @idSitio INT;
				EXEC spGetIDSitio @idASP,@nombreSitioInput,@idSitio OUTPUT;

				DECLARE @sitioActivo BIT;
				EXEC spSitioActivo @idSitio,@sitioActivo OUTPUT;

				IF @idSitio IS NOT NULL AND @sitioActivo = 1
					BEGIN
						BEGIN TRY
							BEGIN TRANSACTION
								UPDATE Sitios
								SET Sitios.activo = 0
								WHERE @idSitio = Sitios.id;
							COMMIT
						END TRY
						BEGIN CATCH
							IF @@TRANCOUNT > 0
								ROLLBACK
								RETURN -1*@@ERROR
						END CATCH
					END
				ELSE
					BEGIN
						PRINT 'Sitio en este ASP no existe'
						RETURN -1
					END
			END
		ELSE
			BEGIN
				PRINT 'ASP no existe'
				RETURN -1
			END
	END
GO
/****** Object:  StoredProcedure [dbo].[spGetAspName]    Script Date: 9/27/2019 11:42:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[spGetAspName]
AS
BEGIN
BEGIN TRY

	SELECT A.nombre FROM ASP A WHERE A.activo = 1;
	RETURN 1

END TRY
BEGIN CATCH
	If @@TRANCOUNT>0 ROLLBACK
		Return -1*@@ERROR
END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[spGetFechaModificacionRecurso]    Script Date: 9/27/2019 11:42:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[spGetFechaModificacionRecurso] @nombreASPInput NVARCHAR(64),@nombreSitioInput NVARCHAR(64),@nombreRecursoInput NVARCHAR(128),@ultimaFechaModificacion NVARCHAR(15) OUTPUT AS
BEGIN
		DECLARE @idASP INT;
		EXEC spGetIDAsp @nombreASPInput,@idASP OUTPUT;

		DECLARE @aspActivo BIT;
		EXEC spASPActivo @idASP,@aspActivo OUTPUT;

		IF @idASP IS NOT NULL AND @ASPactivo = 1
			BEGIN
				DECLARE @idSitio INT;
				EXEC spGetIDSitio @idASP,@nombreSitioInput,@idSitio OUTPUT;

				DECLARE @activoSitio BIT;
				EXEC spSitioActivo @idSitio,@activoSitio OUTPUT;

				IF @activoSitio = 1 AND @idSitio IS NOT NULL
					BEGIN
						
						DECLARE @idRecurso INT;
						EXEC spGetIDRecurso @idSitio,@nombreRecursoInput,@idRecurso OUTPUT;

						DECLARE @activoRecurso BIT;
						EXEC spRecursoActivo @idRecurso,@activoRecurso OUTPUT;

						IF @idRecurso IS NOT NULL  AND @activoRecurso = 1
							SET @ultimaFechaModificacion = (SELECT R.fechaModificacion FROM Recursos R WHERE R.id = @idRecurso)
						ELSE
							BEGIN
								PRINT 'Recurso no existe'
								RETURN -1
							END
					END
				ELSE
					BEGIN
						PRINT 'Sitio no existe'
						RETURN -1
					END
			END
		ELSE
			BEGIN
				PRINT 'No existe ese ASP'
				RETURN -1;
			END
	END

GO
/****** Object:  StoredProcedure [dbo].[spGetFechaMoficiacionRecruso]    Script Date: 9/27/2019 11:42:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[spGetFechaMoficiacionRecruso] @nombreASPInput NVARCHAR(64),@nombreSitioInput NVARCHAR(64),@nombreRecursoInput NVARCHAR(128),@ultimaFechaModificacion NVARCHAR(15) OUTPUT AS
BEGIN
		DECLARE @idASP INT;
		EXEC spGetIDAsp @nombreASPInput,@idASP OUTPUT;

		DECLARE @aspActivo BIT;
		EXEC spASPActivo @idASP,@aspActivo OUTPUT;

		IF @idASP IS NOT NULL AND @ASPactivo = 1
			BEGIN
				DECLARE @idSitio INT;
				EXEC spGetIDSitio @idASP,@nombreSitioInput,@idSitio OUTPUT;

				DECLARE @activoSitio BIT;
				EXEC spSitioActivo @idSitio,@activoSitio OUTPUT;

				IF @activoSitio = 1 AND @idSitio IS NOT NULL
					BEGIN
						
						DECLARE @idRecurso INT;
						EXEC spGetIDRecurso @idSitio,@nombreRecursoInput,@idRecurso OUTPUT;

						DECLARE @activoRecurso BIT;
						EXEC spRecursoActivo @idRecurso,@activoRecurso OUTPUT;

						IF @idRecurso IS NOT NULL  AND @activoRecurso = 1
							SET @ultimaFechaModificacion = (SELECT R.fechaModificacion FROM Recursos R WHERE R.id = @idRecurso)
						ELSE
							BEGIN
								PRINT 'Recurso no existe'
								RETURN -1
							END
					END
				ELSE
					BEGIN
						PRINT 'Sitio no existe'
						RETURN -1
					END
			END
		ELSE
			BEGIN
				PRINT 'No existe ese ASP'
				RETURN -1;
			END
	END

GO
/****** Object:  StoredProcedure [dbo].[spGetIDAsp]    Script Date: 9/27/2019 11:42:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[spGetIDAsp] @nombreInput NVARCHAR(64),@idOutput INT OUTPUT AS
BEGIN
	SET @idOutput = (SELECT A.id FROM ASP A WHERE LOWER(A.nombre) = LOWER(@nombreInput));
END
GO
/****** Object:  StoredProcedure [dbo].[spGetIDOportunidad]    Script Date: 9/27/2019 11:42:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[spGetIDOportunidad] @idASP INT,@descripcionOportunidad NVARCHAR(512),@idOutput INT OUTPUT AS
BEGIN
	SET @idOutput = (SELECT O.id FROM Oportunidades O WHERE LOWER(O.descripcion) = LOWER(@descripcionOportunidad));
END
GO
/****** Object:  StoredProcedure [dbo].[spGetIDRecurso]    Script Date: 9/27/2019 11:42:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[spGetIDRecurso] @idSitio INT, @nombreRecurso NVARCHAR(64),@idOutput INT OUTPUT AS
BEGIN
	SET @idOutput = (SELECT R.id FROM Recursos R WHERE R.idSitio = @idSitio AND LOWER(@nombreRecurso) LIKE LOWER(R.nombre));
END
GO
/****** Object:  StoredProcedure [dbo].[spGetIDSitio]    Script Date: 9/27/2019 11:42:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[spGetIDSitio] @idASP INT,@nombreSitio NVARCHAR(64),@idOutput INT OUTPUT AS
BEGIN
	SET @idOutput = (SELECT S.id FROM Sitios S WHERE S.idASP = @idASP AND LOWER(S.nombre) = LOWER(@nombreSitio));
END
GO
/****** Object:  StoredProcedure [dbo].[spGetIDTipoFigura]    Script Date: 9/27/2019 11:42:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[spGetIDTipoFigura] @nombreTipoFigura NVARCHAR(32),@idTipoFigura INT OUTPUT AS
	BEGIN
		SET @idTipoFigura = (SELECT TF.id FROM TipoFigura TF WHERE LOWER(TF.nombre) LIKE LOWER(@nombreTipoFigura))
		IF @idTipoFigura IS NULL
			BEGIN
				PRINT CONCAT('No existe figura ',@nombreTipoFigura)
				RETURN -1
			END
		ELSE
			BEGIN
				RETURN 0
			END
	END
GO
/****** Object:  StoredProcedure [dbo].[spGetIDTipoRecurso]    Script Date: 9/27/2019 11:42:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[spGetIDTipoRecurso] @nombreTipoRecursoInput NVARCHAR(128), @idRecurso INT OUTPUT AS
	BEGIN
		SET @idRecurso = (SELECT TR.id FROM TipoRecurso TR WHERE LOWER(TR.nombre) LIKE LOWER(@nombreTipoRecursoInput));
		IF @idRecurso IS NOT NULL
			BEGIN
				RETURN 1;
			END
		ELSE
			BEGIN
				PRINT 'No existe ese tipo de recurso'
				RETURN -1;
			END
	END
GO
/****** Object:  StoredProcedure [dbo].[spGetRatingCaracteristicasRecurso]    Script Date: 9/27/2019 11:42:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[spGetRatingCaracteristicasRecurso] @nombreASPInput NVARCHAR(64),@nombreSitioInput NVARCHAR(64),@nombreRecursoInput NVARCHAR(128) AS
	BEGIN
		DECLARE @idASP INT;
		EXEC spGetIDAsp @nombreASPInput,@idASP OUTPUT;

		DECLARE @aspActivo BIT;
		EXEC spASPActivo @idASP,@aspActivo OUTPUT;

		IF @idASP IS NOT NULL AND @ASPactivo = 1
			BEGIN
				DECLARE @idSitio INT;
				EXEC spGetIDSitio @idASP,@nombreSitioInput,@idSitio OUTPUT;

				DECLARE @activoSitio BIT;
				EXEC spSitioActivo @idSitio,@activoSitio OUTPUT;

				IF @activoSitio = 1 AND @idSitio IS NOT NULL
					BEGIN
						
						DECLARE @idRecurso INT;
						EXEC spGetIDRecurso @idSitio,@nombreRecursoInput,@idRecurso OUTPUT;

						DECLARE @activoRecurso BIT;
						EXEC spRecursoActivo @idRecurso,@activoRecurso OUTPUT;

						IF @idRecurso IS NOT NULL  AND @activoRecurso = 1
							BEGIN
								SELECT RR.relacionPropositoASP AS [Relacion con el ASP],RR.relacionTemaInterpretativoASP AS [Relacion con los temas interpretativos del ASP], RR.variedadRecurso AS [Variedad del recurso],RR.atractivo AS [Atractivo],RR.accesibilidad AS [Accesibilidad] FROM RatingRecurso RR WHERE @idRecurso = RR.idRecurso;
							END
						ELSE
							BEGIN
								PRINT 'Recurso no existe'
								RETURN -1
							END
					END
				ELSE
					BEGIN
						PRINT 'Sitio no existe'
						RETURN -1
					END
			END
		ELSE
			BEGIN
				PRINT 'No existe ese ASP'
				RETURN -1;
			END
	END

GO
/****** Object:  StoredProcedure [dbo].[spGetRecursos]    Script Date: 9/27/2019 11:42:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[spGetRecursos](
        @nombreSitio varchar(50)
		)
AS
BEGIN
	BEGIN TRY

		DECLARE @idSitio int

			SELECT @idSitio = id FROM Sitios S WHERE @nombreSitio = S.nombre

		SELECT R.nombre FROM Recursos R WHERE R.activo = 1 AND R.idSitio = @idSitio;
		RETURN 1

	END TRY
	BEGIN CATCH
		If @@TRANCOUNT>0 ROLLBACK
			Return -1*@@ERROR
	END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[spGetSitios]    Script Date: 9/27/2019 11:42:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spGetSitios] @nombreASP NVARCHAR(64)
AS
BEGIN
	SELECT Sitios.nombre
	FROM Sitios
	INNER JOIN ASP
	ON Sitios.idASP = ASP.id where LOWER(ASP.nombre)=LOWER (@nombreASP);
END
GO
/****** Object:  StoredProcedure [dbo].[spLogin]    Script Date: 9/27/2019 11:42:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[spLogin] @nombreUsuarioInput NVARCHAR(50), @passwordInput NVARCHAR(50)
	AS
	BEGIN
	BEGIN TRY
		DECLARE @existeUsuario NVARCHAR(50) = (SELECT U.usuario FROM Usuario U WHERE U.usuario = @nombreUsuarioInput);
		IF (@existeUsuario IS NOT NULL) /* Revisa existencia de usuario */
			BEGIN
				DECLARE @foundPassword CHAR(50)= (SELECT U.contrasena FROM Usuario U WHERE @nombreUsuarioInput= U.usuario);
				DECLARE @isAdmin BIT = (SELECT U.admin FROM Usuario U WHERE U.usuario = @nombreUsuarioInput); 
				IF (@foundPassword=@passwordInput) /* Revisa si la contrasenna es la correcta */
					BEGIN
						IF @isAdmin = 1 
							BEGIN
								RETURN 1 /*1 para admin*/
							END
						ELSE
							BEGIN
								RETURN 2; /*2 para cliente*/
							END
					END
				ELSE
					BEGIN
						RETURN -1;
					END
			END
		ELSE
			BEGIN
				RETURN 0;
			END
	END TRY
	BEGIN CATCH
		If @@TRANCOUNT>0 ROLLBACK
			Return -1*@@ERROR
	END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[spModificarOportunidad]    Script Date: 9/27/2019 11:42:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[spModificarOportunidad] 
	@nombreASPInput NVARCHAR(64),
	@nombreSitioInput NVARCHAR(64),
	@nombreRecursoInput NVARCHAR(128),
	@nombreOportunidadInput NVARCHAR(32),
	@descripcionInput NVARCHAR(512),
	@observacionesInput NVARCHAR(1024) AS
	
	BEGIN
		DECLARE @idASP INT;
		EXEC spGetIDAsp @nombreASPInput,@idASP OUTPUT;
		IF @idASP IS NOT NULL
		BEGIN
			DECLARE @idSitio INT;
			EXEC spGetIDSitio @idASP,@nombreSitioInput,@idSitio OUTPUT;
			IF @idSitio IS NULL
				BEGIN
					DECLARE @idRecurso INT;
					EXEC spGetIDRecurso @idSitio,@nombreRecursoInput,@idRecurso OUTPUT;
					IF @idRecurso IS NOT NULL
						BEGIN
							BEGIN TRY
								BEGIN TRANSACTION
									UPDATE Oportunidades
										SET Oportunidades.descripcion = @descripcionInput,
											Oportunidades.observaciones = @observacionesInput,
											Oportunidades.fechaModificacion = CONVERT(NVARCHAR(15),GETDATE(),103)

								COMMIT
							END TRY
							BEGIN CATCH
								IF @@TRANCOUNT > 0
								ROLLBACK
								RETURN -1*@@ERROR
							END CATCH
						END
					ELSE
						BEGIN
							PRINT 'Recurso no existe'
							RETURN -1
						END
				END
			ELSE
				BEGIN
					PRINT 'No existe ese sitio'
					RETURN -1
				END
		END
	ELSE
		BEGIN
			PRINT 'No existe ese ASP'
			RETURN -1
		END
	END
GO
/****** Object:  StoredProcedure [dbo].[spModificarRecurso]    Script Date: 9/27/2019 11:42:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[spModificarRecurso] 
	@nombreASPInput NVARCHAR(64),
	@nombreSitioInput NVARCHAR(64),
	@nombreTipoRecursoInput NVARCHAR(64),
	@nombreRecursoInput NVARCHAR(128),
	@rUbicacion nvarchar(128),
	@rTraslape nvarchar(128),
	@rCondicion nvarchar(128),
	@rAtractivos nvarchar(128),
	@rSoporte bit,
	@rCapacidad int,
	@rHectareas float,
	@rOportunidades nvarchar(128),
	--Rating de recurso puntajes de 1-3
	@rRelacionPropositoASP INT,
	@rRelacionTemaInterpretativoASP INT,
	@rVariedadRecurso INT,
	@rAtractivo INT,
	@rAccesibildad INT AS
	BEGIN
		DECLARE @idASP INT;
	EXEC spGetIDAsp @nombreASPInput,@idASP OUTPUT;
	IF @idASP IS NOT NULL
		BEGIN
			DECLARE @idSitio INT;
			EXEC spGetIDSitio @idASP,@nombreSitioInput,@idSitio OUTPUT;
			IF @idSitio IS NOT NULL
				BEGIN
					DECLARE @idRecurso INT;
					EXEC spGetIDRecurso @idSitio,@nombreRecursoInput,@idRecurso OUTPUT;
					IF @idRecurso IS NOT NULL
						BEGIN
							BEGIN TRY
								DECLARE @idTipoRecurso INT;
								EXEC spGetIDTipoRecurso @nombreTipoRecursoInput,@idTipoRecurso OUTPUT;
								BEGIN TRANSACTION

									UPDATE Recursos
										SET Recursos.idTipoRecurso = @idTipoRecurso,
											Recursos.idSitio = @idSitio,
											Recursos.nombre = @nombreRecursoInput,
											Recursos.ubicacion = @rUbicacion nvarchar(128),
											Recursos.traslape = @rTraslape nvarchar(128),
											Recursos.condicion= @rCondicion nvarchar(128),
											Recursos.atractivos = @rAtractivos nvarchar(128),
											Recursos.soporte = @rSoporte bit,
											Recursos.capacidad = @rCapacidad int,
											Recursos.hectareas = @rHectareas float,
											Recursos.oportunidades = @rOportunidades nvarchar(128),
											Recursos.fechaModificacion = CONVERT(NVARCHAR(15),GETDATE(),103)
										WHERE Recursos.id = @idRecurso


									EXEC spActualizarRatingRecurso @nombreASPInput,@nombreSitioInput,@nombreRecursoInput ,@rRelacionPropositoASP,@rRelacionTemaInterpretativoASP ,@rVariedadRecurso,@rAtractivo,@rAccesibildad

									EXEC spActualizarValoracion @nombreASPInput, @nombreSitioInput
									
								COMMIT
							END TRY
							BEGIN CATCH
								IF @@TRANCOUNT > 0
								ROLLBACK
								RETURN -1*@@ERROR
							END CATCH
						END
					ELSE
						BEGIN
							PRINT 'Recurso no existe'
							RETURN -1
						END
				END
			ELSE
				BEGIN
					PRINT 'No existe ese sitio'
					RETURN -1
				END
		END
	ELSE
		BEGIN
			PRINT 'No existe ese ASP'
			RETURN -1
		END
	END
GO
/****** Object:  StoredProcedure [dbo].[spModificarSitio]    Script Date: 9/27/2019 11:42:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[spModificarSitio] 
	@nombreASPInput NVARCHAR(64),
	@nombreSitioInput NVARCHAR(64),
	@ubicacionInput NVARCHAR(256),
	@nombreTipoFigura NVARCHAR(32),
	@convenienciaInput NVARCHAR(512),
	@calidadInput NVARCHAR(512),
	@tamanoInput NVARCHAR(512) AS
	BEGIN
		DECLARE @idASP INT;
		EXEC spGetIDAsp @nombreASPInput,@idASP OUTPUT;
		IF @idASP IS NOT NULL
			BEGIN
				DECLARE @idSitio INT;
				EXEC spGetIDSitio @idASP,@nombreSitioInput,@idSitio OUTPUT;
				DECLARE @idTipoFigura INT;
				EXEC spGetIDTipoFigura @nombreTipoFigura,@idTipoFigura OUTPUT;
				IF @idSitio IS NOT NULL
					BEGIN
						BEGIN TRY
							BEGIN TRANSACTION
								UPDATE Sitios
								SET 
									Sitios.idASP = @idASP,
									Sitios.nombre = @nombreSitioInput,
									Sitios.ubicacion = @ubicacionInput,
									Sitios.idTipoFigura = @idTipoFigura,
									Sitios.conveniencia = @convenienciaInput,
									Sitios.calidad = @calidadInput,
									Sitios.tamano = @calidadInput,
									Sitios.fechaCreacion = CONVERT(NVARCHAR(15),GETDATE(),103)
									WHERE Sitios.id = @idSitio
							COMMIT
						END TRY
						BEGIN CATCH
							IF @@TRANCOUNT > 0
								ROLLBACK
								RETURN -1*@@ERROR
						END CATCH
					END
				ELSE
					BEGIN
						PRINT 'Sitio en este ASP no existe'
						RETURN -1
					END
			END
		ELSE
			BEGIN
				PRINT 'ASP no existe'
				RETURN -1
			END
	END
GO
/****** Object:  StoredProcedure [dbo].[spOportunidadActivo]    Script Date: 9/27/2019 11:42:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[spOportunidadActivo] @idOportunidad INT, @activoOut BIT OUTPUT AS
BEGIN
	
	IF (SELECT O.activo FROM Oportunidades O WHERE o.id = @idOportunidad) = 0
		SET @activoOut = 0
	ELSE
		SET @activoOut = 1
	
END
GO
/****** Object:  StoredProcedure [dbo].[spRecursoActivo]    Script Date: 9/27/2019 11:42:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[spRecursoActivo] @idRecurso INT, @activoOut BIT OUTPUT AS
BEGIN
	
	IF (SELECT R.activo FROM Recursos R WHERE R.id = @idRecurso) = 0
		SET @activoOut = 0
	ELSE
		SET @activoOut = 1
	
END
GO
/****** Object:  StoredProcedure [dbo].[spSitioActivo]    Script Date: 9/27/2019 11:42:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[spSitioActivo] @idSitio INT, @activoOut BIT OUTPUT AS
BEGIN
	
	IF (SELECT S.activo FROM Sitios S WHERE S.id = @idSitio) = 0
		SET @activoOut = 0
	ELSE
		SET @activoOut = 1
	
END
GO
