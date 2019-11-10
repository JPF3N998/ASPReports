USE ASPReports
GO

DROP PROC IF EXISTS spModificarASP
GO

CREATE PROC spModificarrASP @nombreInput NVARCHAR(64),@ubicacionInput NVARCHAR(256),@responsableInput NVARCHAR(256) AS
	BEGIN
		DECLARE @idASP INT;
		EXEC spGetIDAsp @nombreInput, @idASP OUTPUT;
		IF @idASP IS NULL
			BEGIN TRY
				BEGIN TRANSACTION
					UPDATE ASP
						SET ASP.nombre = @nombreInput,
							ASP.ubicacion = @ubicacionInput,
							ASP.fechaCreacion = CONVERT(NVARCHAR(15,GETDATE(),103)),
							ASP.responsable = @responsableInput
							WHERE ASP.id = @idASP;
					COMMIT
				PRINT @nombreInput+' actualizado exitosamente'
				RETURN 0
			END TRY
			BEGIN CATCH
				IF @@TRANCOUNT > 0
					ROLLBACK
					PRINT 'Fallo la actualizacion de '+@nombreInput
					RETURN -1*@@ERROR
			END CATCH
		ELSE
			PRINT 'No existe el ASP ' + @nombreInput;
			RETURN -1*@@ERROR
	END	
GO

--PROC para modificacion de sitios
DROP PROC IF EXISTS spModificarSitio
GO

CREATE PROC spModificarSitio 
	@nombreASPInput NVARCHAR(64),
	@nombreSitioInput NVARCHAR(64),
	@ubicacionInput NVARCHAR(256),
	@nombreTipoFigura NVARCHAR(32),
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
									Sitios.tamano = @tamanoInput,
									Sitios.capacidad = @capacidadInput,
									Sitios.observacionesDisenoInfraestructura = @observacionesDisenoInfraestructuraInput,
									Sitios.fechaCreacion = CONVERT(NVARCHAR(15),GETDATE(),103),
									Sitios.responsable = @responsableInput
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
	@ubicacionInput NVARCHAR(200) ,
	@anomaliaInput NVARCHAR(200) ,
	@traslapeInput NVARCHAR(200) ,
	@condicionInput NVARCHAR(200) ,
	@atractivosInput NVARCHAR(200) ,
	@soportaUsoInput BIT,
	@capacidadInput NVARCHAR(200) ,
	@hectareasInput NVARCHAR(200),
	@oportunidadesUsoInput NVARCHAR(200),
	--Rating de recurso puntajes de 1-3
	@rRelacionPropositoASP INT,
	@rRelacionTemaInterpretativoASP INT,
	@rVariedadRecurso INT,
	@rAtractivo INT,
	@rAccesibildad INT,
	@responsableInput NVARCHAR(256) AS
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
											Recursos.ubicacion = @ubicacionInput,
											Recursos.anomalia = @anomaliaInput,
											Recursos.traslape = @traslapeInput,
											Recursos.condicion = @condicionInput,
											Recursos.atractivos = @atractivosInput,
											Recursos.soportaUso = @soportaUsoInput,
											Recursos.capacidad = @capacidadInput,
											Recursos.hectareas = @hectareasInput,
											Recursos.oportunidadesUso = @oportunidadesUsoInput,
											Recursos.fechaModificacion = CONVERT(NVARCHAR(15),GETDATE(),103),
											Recursos.responsable = @responsableInput
										WHERE Recursos.id = @idRecurso

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