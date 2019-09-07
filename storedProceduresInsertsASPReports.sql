USE ASPReports
GO

--PROC para la creacion de un ASP, si esta desactivado, se activa

DROP PROC IF EXISTS spAgregarASP
GO

CREATE PROC spAgregarASP @nombreInput NVARCHAR(64),@ubicacionInput NVARCHAR(256) AS
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

--PROC para la creacion de un sitio

DROP PROC IF EXISTS spAgregarSitio
GO

CREATE PROC spAgregarSitio
	@nombreASPInput NVARCHAR(64),
	@nombreSitioInput NVARCHAR(64),
	@ubicacionInput NVARCHAR(256),
	@zonificacionInput BIT,
	@nombreTipoFiguraInput NVARCHAR(32),
	@convenienciaInput NVARCHAR(512),
	@calidadInput NVARCHAR(512),
	@tamanoInput NVARCHAR(512),
	@capacidadInput NVARCHAR(128),
	@observacionesDisenoInfraestructuraInput NVARCHAR(1024) AS

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
								INSERT INTO Sitios(idASP,nombre,ubicacion,zonificacion,idTipoFigura,conveniencia,calidad,tamano,capacidad,observacionesDisenoInfraestructura,valoracionRelacionPropositoASP,valoracionRelacionTemasInterpretativos,valoracionVariedadRecurso,valoracionAtractivo,valoracionAccesibilidad,fechaCreacion,activo)
								VALUES (@idASP,@nombreSitioInput,@ubicacionInput,@zonificacionInput,@idTipoFigura,@convenienciaInput,@calidadInput,@tamanoInput,@capacidadInput,@observacionesDisenoInfraestructuraInput,0,0,0,0,0,CONVERT(VARCHAR(10),GETDATE(),103),1)
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

									INSERT INTO Recursos(idTipoRecurso,idSitio,nombre,fechaModificacion,activo) VALUES (@idTipoRecurso,@idSitio,@nombreRecursoInput,CONVERT(NVARCHAR(15),GETDATE(),103),1)
									

									INSERT INTO RatingRecurso(idRecurso,relacionPropositoASP,relacionTemaInterpretativoASP,variedadRecurso,atractivo,accesibilidad,fechaModificacion)
									SELECT MAX(id) as idRecurso,@rRelacionPropositoASP,@rRelacionTemaInterpretativoASP,@rVariedadRecurso,@rAtractivo,@rAccesibildad,CONVERT(NVARCHAR(15),GETDATE(),103) FROM Recursos
									
									INSERT INTO AtributosRecurso(idRecurso,disponibilidad,capacidadAbsorcionUsoTuristico,capacidadTolerarUsoTuristico,interesPotencialAvisitantes,importanciaSPTI,fechaModificacion)
									SELECT MAX(id),@rDisponibilidad,@rCapacidadAbsorcionUsoTuristico,@rCapacidadTolerarUsoTuristico,@rInteresPotencialAvisitantes,@rImportanciaSPTI,CONVERT(NVARCHAR(15),GETDATE(),103) FROM Recursos
									
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

--PROC para agregar una oportunidad
DROP PROC IF EXISTS spAgregarOportunidad
GO
CREATE PROC spAgregarOportunidad 
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