USE ASPReports
GO


--PROC para la eliminacion *logica* de un ASP
DROP PROC IF EXISTS spEliminarASP
GO
CREATE PROC spEliminarASP @nombreASPInput NVARCHAR(64) AS
	BEGIN
			DECLARE @idASP INT;
			EXEC spGetIDAsp @nombreASPInput,@idASP OUTPUT;
			IF @idASP IS NOT NULL
				BEGIN TRY
					BEGIN TRANSACTION
						UPDATE ASP
						SET ASP.activo = 0 WHERE @idASP = ASP.id;
					COMMIT
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

--PROC para la eliminacion *logica* de un sitio
DROP PROC IF EXISTS spEliminarSitio
GO
CREATE PROC spEliminarSitio @nombreASPInput NVARCHAR(64), @nombreSitioInput NVARCHAR(64) AS
	BEGIN
		DECLARE @idASP INT;
		EXEC spGetIDAsp @nombreASPInput,@idASP OUTPUT;
		IF @idASP IS NOT NULL
			BEGIN
				DECLARE @idSitio INT;
				EXEC spGetIDSitio @idASP,@nombreSitioInput,@idSitio OUTPUT;
				IF @idSitio IS NOT NULL
					BEGIN
						BEGIN TRY
							BEGIN TRANSACTION
								UPDATE Sitios
								SET Sitios.activo = 0 WHERE @idSitio = Sitios.id;
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

--PROC para la eliminacion "logica" de un recurso
DROP PROC IF EXISTS spEliminarRecurso
GO
CREATE PROC spEliminarRecurso @nombreASPInput NVARCHAR(64), @nombreSitioInput NVARCHAR(64), @nombreRecursoInput NVARCHAR(64) AS
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
								BEGIN TRANSACTION
									UPDATE Recursos
										SET Recursos.activo = 0
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

--PROC para eliminar Oportunidades
DROP PROC IF EXISTS spEliminarOportunidad
GO
CREATE PROC spEliminarOportunidad @nombreASPInput NVARCHAR(64),@nombreSitioInput NVARCHAR(64), @nombreRecursoInput NVARCHAR(64) AS
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