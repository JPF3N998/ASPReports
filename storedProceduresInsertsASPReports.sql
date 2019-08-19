USE ASPReports
GO

--PROC para traer el ID de ASP  por nombre
DROP PROC IF EXISTS spGetIDASP
GO

CREATE PROC spGetIDAsp @nombreInput NVARCHAR(64),@idOutput INT OUTPUT AS
BEGIN
	SET @idOutput = (SELECT A.id FROM ASP A WHERE A.nombre = @nombreInput);
END
GO

--PROC para traer el ID de sitio por ID del ASP y nombre del sitio
DROP PROC IF EXISTS spGetIDSitio
GO

CREATE PROC spGetIDSitio @idASP INT,@nombreSitio NVARCHAR(64),@idOutput INT OUTPUT AS
BEGIN
	SET @idOutput = (SELECT S.id FROM Sitios S WHERE S.idASP = @idASP AND S.nombre = @nombreSitio);
END
GO

--PROC para traer el ID del recurso por medio del idSitio y nombre del recurso
DROP PROC IF EXISTS spGetIDRecurso
GO

CREATE PROC spGetIDRecurso @idSitio INT, @nombreRecurso NVARCHAR(64),@idOutput INT OUTPUT AS
BEGIN
	SET @idOutput = (SELECT R.id FROM Recursos R WHERE R.idSitio = @idSitio AND @nombreRecurso= R.nombre);
END
GO

--PROC para la creacion de un ASP

DROP PROC IF EXISTS spAgregarASP
GO

CREATE PROC spAgregarASP @nombreInput NVARCHAR(64),@ubicacionInput NVARCHAR(256) AS
	BEGIN
		DECLARE @nombreASPExistente INT;
		EXEC spGetIDAsp @nombreInput, @nombreASPExistente OUTPUT;
		IF @nombreASPExistente IS NULL
			BEGIN TRY
				BEGIN TRANSACTION
					INSERT INTO ASP(nombre,ubicacion,fechaCreacion,activo) VALUES (@nombreInput,@ubicacionInput,CONVERT(NVARCHAR(10),GETDATE(),103),1)
				COMMIT
			END TRY
			BEGIN CATCH
				IF @@TRANCOUNT > 0
					ROLLBACK
					RETURN -1*@@ERROR
			END CATCH
		ELSE
			BEGIN
				PRINT 'Ya existe ese ASP.'
				RETURN -1
			END
	END	
GO

--PROC para la creacion de un sitio

DROP PROC IF EXISTS spAgregarSitio
GO

CREATE PROC spAgregarSitio
	@nombreASPInput NVARCHAR(64),
	@nombreSitioInput NVARCHAR(64),
	@ubicacionInput NVARCHAR(256),
	@convenienciaInput NVARCHAR(512),
	@calidadInput NVARCHAR(512),
	@tamanoInput NVARCHAR(512),
	@capacidadInput NVARCHAR(128),
	@observacionesDisenoInfraestructuraInput NVARCHAR(1024) AS

	BEGIN
		DECLARE @idASP INT;
		EXEC spGetIDAsp @nombreASPInput,@idASP OUTPUT;
		IF @idASP IS NOT NULL
			BEGIN
				DECLARE @idSitio INT;
				EXEC spGetIDSitio @idASP,@nombreASPInput,@idSitio OUTPUT;
				IF @idSitio IS NULL
					BEGIN
						BEGIN TRY
							BEGIN TRANSACTION
								INSERT INTO Sitios(idASP,nombre,ubicacion,conveniencia,calidad,tamano,capacidad,observacionesDisenoInfraestructura,valoracion,fechaCreacion,activo)
								VALUES (@idASP,@nombreSitioInput,@ubicacionInput,@convenienciaInput,@calidadInput,@tamanoInput,@capacidadInput,@observacionesDisenoInfraestructuraInput,0,CONVERT(VARCHAR(10),GETDATE(),103),1)
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
						PRINT 'Sitio en este ASP ya existe'
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

--PROC para agregar recursos con sus ratings y atributos


/**
TRANSACTION TEMPLATE
	IF
		BEGIN TRY
			BEGIN TRANSACTION
				//TRANSACTION
			COMMIT
		END TRY
		BEGIN CATCH
			IF @@TRANCOUNT > 0
				ROLLBACK
				RETURN -1*@@ERROR
		END CATCH
	ELSE
		BEGIN
				
		END

**/