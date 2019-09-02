USE ASPReports
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
				EXEC spGetIDSitio @idASP,@nombreSitioInput,@idSitio OUTPUT;
				IF @idSitio IS NULL
					BEGIN
						BEGIN TRY
							BEGIN TRANSACTION
								INSERT INTO Sitios(idASP,nombre,ubicacion,conveniencia,calidad,tamano,capacidad,observacionesDisenoInfraestructura,valoracionRelacionPropositoASP,valoracionRelacionTemasInterpretativos,valoracionVariedadRecurso,valoracionAtractivo,valoracionAccesibilidad,fechaCreacion,activo)
								VALUES (@idASP,@nombreSitioInput,@ubicacionInput,@convenienciaInput,@calidadInput,@tamanoInput,@capacidadInput,@observacionesDisenoInfraestructuraInput,0,0,0,0,0,CONVERT(VARCHAR(10),GETDATE(),103),1)
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

--PROC para agregar los ratings a los atributos de recurso

DROP PROC IF EXISTS spActualizarRatingAtributos
GO
CREATE PROC spActualizarRatingAtributos 
	@nombreASPInput NVARCHAR(64),
	@nombreSitioInput NVARCHAR(64),
	@nombreRecursoInput NVARCHAR(128),
	@rDisponibilidad INT,
	@rCapacidadAbsorcionUsoTuristico INT,
	@rCapacidadTolerarUsoTuristico INT,
	@rInteresPotencialAvisitantes INT,
	@rImportanciaSPTI INT AS
BEGIN
	DECLARE @idASP INT;
	EXEC spGetIDAsp @nombreASPInput,@idASP OUTPUT;
	IF @idASP IS NOT NULL
		BEGIN
			DECLARE @idSitio INT;
			EXEC spGetIDSitio @idASP,@nombreASPInput,@idSitio OUTPUT;
			IF @idSitio IS NOT NULL
				BEGIN
					DECLARE @idRecurso INT;
					EXEC spGetIDRecurso @idSitio, @nombreRecursoInput,@idRecurso OUTPUT;
					IF @idRecurso IS NOT NULL
						BEGIN
							BEGIN TRY
								BEGIN TRANSACTION
									UPDATE AtributosRecurso
										SET AtributosRecurso.disponibilidad = @rDisponibilidad,
											AtributosRecurso.capacidadAbsorcionUsoTuristico  = @rCapacidadAbsorcionUsoTuristico,
											AtributosRecurso.capacidadTolerarUsoTuristico = @rCapacidadTolerarUsoTuristico,
											AtributosRecurso.interesPotencialAvisitantes = @rInteresPotencialAvisitantes,
											AtributosRecurso.importanciaSPTI = @rImportanciaSPTI,
											AtributosRecurso.fechaModificacion = CONVERT(NVARCHAR(15),GETDATE(),103)
										WHERE @idRecurso = AtributosRecurso.idRecurso
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

--PROC para actualizar los ratings de un recurso
DROP PROC IF EXISTS spActualizarRatingRecurso
GO
CREATE PROC spActualizarRatingRecurso
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
			EXEC spGetIDSitio @idASP,@nombreASPInput,@idSitio OUTPUT;
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

--PROC para agregar recursos con sus ratings y atributos

DROP PROC IF EXISTS spAgregarRecurso
GO
CREATE PROC spAgregarRecurso 
	@nombreASPInput NVARCHAR(64),
	@nombreSitioInput NVARCHAR(64),
	@nombreTipoRecursoInput NVARCHAR(64),
	@nombreRecursoInput NVARCHAR(128),
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
					IF @idRecurso IS NULL
						BEGIN
							BEGIN TRY
								DECLARE @idTipoRecurso INT;
								EXEC spGetIDTipoRecurso @nombreTipoRecursoInput,@idTipoRecurso OUTPUT;
								BEGIN TRANSACTION

									INSERT INTO Recursos(idTipoRecurso,idSitio,nombre,activo) VALUES (@idTipoRecurso,@idSitio,@nombreRecursoInput,1)
									

									INSERT INTO RatingRecurso(idRecurso,relacionPropositoASP,relacionTemaInterpretativoASP,variedadRecurso,atractivo,accesibilidad,fechaModificacion)
									SELECT MAX(id) as idRecurso,@rRelacionPropositoASP,@rRelacionTemaInterpretativoASP,@rVariedadRecurso,@rAtractivo,@rAccesibildad,CONVERT(NVARCHAR(15),GETDATE(),103) FROM Recursos
									
									INSERT INTO AtributosRecurso(idRecurso,disponibilidad,capacidadAbsorcionUsoTuristico,capacidadTolerarUsoTuristico,interesPotencialAvisitantes,importanciaSPTI,fechaModificacion)
									SELECT MAX(id),@rDisponibilidad,@rCapacidadAbsorcionUsoTuristico,@rCapacidadTolerarUsoTuristico,@rInteresPotencialAvisitantes,@rImportanciaSPTI,CONVERT(NVARCHAR(15),GETDATE(),103) FROM Recursos
									
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
							PRINT 'Recurso ya existe'
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

--PROC para agregar una oportunidad
DROP PROC IF EXISTS spAgregarOportunidad
GO
CREATE PROC spAgregarOportunidad 
	@nombreASPInput NVARCHAR(64),
	@nombreSitioInput NVARCHAR(64),
	@nombreRecursoInput NVARCHAR(128),
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
									INSERT INTO Oportunidades(idRecurso,descripcion,observaciones,fechaModificacion,activo)
									VALUES (@idRecurso,@descripcionInput,@observacionesInput,CONVERT(NVARCHAR(15),GETDATE(),103),1)
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


/*
EXEC spAgregarASP 'Volcan Irazu','Cartago'
GO
EXEC spAgregarSitio 'Volcan Irazu','Crater','Ubicacion? Diay... adentro?','conveniencia','calidad','tamano','muchos','Infraestructura buena'
GO
EXEC spAgregarRecurso 'Volcan Irazu','Crater','De paisaje','Mirador',3,5,4,2,4,1,2,3,3,2
GO
EXEC spAgregarRecurso 'Volcan Irazu','Crater','De paisaje','Parqueo',2,4,5,1,2,2,5,3,2,1
GO
SELECT * FROM ASP
SELECT * FROM Sitios
SELECT * FROM RatingRecurso
SELECT * FROM Recursos
SELECT * FROM AtributosRecurso

EXEC spActualizarValoracion 'Volcan Irazu','Crater'

declare @res int
exec spGetIDTipoRecurso 'De paisaje', @res output
print convert(nvarchar(10),@res)
*/



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