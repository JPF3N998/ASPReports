USE ASPReports
GO

DROP PROC IF EXISTS spModificarSitio
GO

CREATE PROC spModificarSitio 
	@nombreASPInput NVARCHAR(64),
	@nombreSitioInput NVARCHAR(64),
	@ubicacionInput NVARCHAR(256) AS
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
								SET Sitios.nombre = @nombreSitioInput,
									Sitios.idASP = @idASP,
									Sitios.ubicacion = @ubicacionInput,
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