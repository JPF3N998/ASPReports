USE ASPReports
GO


--PROC para modificacion de sitios
DROP PROC IF EXISTS spModificarSitio
GO

CREATE PROC spModificarSitio 
	@nombreASPInput NVARCHAR(64),
	@nombreSitioInput NVARCHAR(64),
	@ubicacionInput NVARCHAR(256),
	@nombreTipoFigura NVARCHAR(32),
	@convenienciaInput NVARCHAR(512),
	@calidadInput NVARCHAR(512),
	@tamanoInput NVARCHAR(512),
	@capacidadInput NVARCHAR(128),
	@observacionesDisenoInfraestructuraInput NVARCHAR(1024),
	@responsableInput NVARCHAR(256) AS
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
									Sitios.capacidad = @capacidadInput,
									Sitios.observacionesDisenoInfraestructura = @observacionesDisenoInfraestructuraInput,
									Sitios.fechaCreacion = CONVERT(NVARCHAR(15),GETDATE(),103)
									Sitios.responsable = @responsableInput,
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

--PROC para la modificacion de recursos
DROP PROC IF EXISTS spModificarRecurso
GO
CREATE PROC spModificarRecurso 
	@nombreASPInput NVARCHAR(64),
	@nombreSitioInput NVARCHAR(64),
	@nombreTipoRecursoInput NVARCHAR(64),
	@nombreRecursoInput NVARCHAR(128),
	@responsableInput NVARCHAR(256),
	--Rating de atributos del recurso puntajes de 1-5
	@rDisponibilidad INT,
	@rCapacidadAbsorcionUsoTuristico INT,
	@rCapacidadTolerarUsoTuristico INT,
	@rInteresPotencialAvisitantes INT,
	@rImportanciaSPTI INT,
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
											Recursos.fechaModificacion = CONVERT(NVARCHAR(15),GETDATE(),103),
											Recursos.responsable = @responsableInput
										WHERE Recursos.id = @idRecurso

									EXEC spActualizarRatingAtributos @nombreASPInput,@nombreSitioInput,@nombreRecursoInput,@rDisponibilidad,@rCapacidadAbsorcionUsoTuristico,@rCapacidadTolerarUsoTuristico,@rInteresPotencialAvisitantes,@rImportanciaSPTI,@responsableInput

									EXEC spActualizarRatingRecurso @nombreASPInput,@nombreSitioInput,@nombreRecursoInput ,@rRelacionPropositoASP,@rRelacionTemaInterpretativoASP ,@rVariedadRecurso,@rAtractivo,@rAccesibildad,@responsableInput

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

--PROC para la modificacion de oportunidades
DROP PROC IF EXISTS spModificarOportunidad
GO
CREATE PROC spModificarOportunidad 
	@nombreASPInput NVARCHAR(64),
	@nombreSitioInput NVARCHAR(64),
	@nombreRecursoInput NVARCHAR(128),
	@nombreOportunidadInput NVARCHAR(32),
	@descripcionInput NVARCHAR(512),
	@observacionesInput NVARCHAR(1024),
	@responsableInput NVARCHAR(256) AS
	
	BEGIN
		DECLARE @idASP INT;
		EXEC spGetIDAsp @nombreASPInput,@idASP OUTPUT;
		IF @idASP IS NOT NULL
		BEGIN
			DECLARE @idSitio INT;
			EXEC spGetIDSitio @idASP,@nombreSitioInput,@idSitio OUTPUT;
			IF @idSitio IS NULL
					BEGIN TRY
						BEGIN TRANSACTION
							UPDATE Oportunidades
								SET Oportunidades.descripcion = @descripcionInput,
									Oportunidades.observaciones = @observacionesInput,
									Oportunidades.fechaModificacion = CONVERT(NVARCHAR(15),GETDATE(),103),
									Oportunidades.responsable = @responsableInput
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