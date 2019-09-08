USE ASPReports
GO


--PROC para la eliminacion *logica* de un ASP
DROP PROC IF EXISTS spEliminarASP
GO
CREATE PROC spEliminarASP @nombreASPInput NVARCHAR(64) AS
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

--PROC para la eliminacion *logica* de un sitio
DROP PROC IF EXISTS spEliminarSitio
GO
CREATE PROC spEliminarSitio @nombreASPInput NVARCHAR(64), @nombreSitioInput NVARCHAR(64) AS
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

--PROC para la eliminacion "logica" de un recurso
DROP PROC IF EXISTS spEliminarRecurso
GO
CREATE PROC spEliminarRecurso @nombreASPInput NVARCHAR(64), @nombreSitioInput NVARCHAR(64), @nombreRecursoInput NVARCHAR(64) AS
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

--PROC para eliminar Oportunidades
DROP PROC IF EXISTS spEliminarOportunidad
GO
CREATE PROC spEliminarOportunidad @nombreASPInput NVARCHAR(64),@nombreSitioInput NVARCHAR(64), @descripcionOportunidadInput NVARCHAR(512) AS
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