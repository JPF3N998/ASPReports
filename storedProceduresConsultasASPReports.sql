USE ASPReports
GO

--PROC para buscar ASP por nombre
DROP PROC IF EXISTS spBuscarASP 
GO
CREATE PROC spBuscarASP @nombreASPInput NVARCHAR(64) AS
BEGIN
	
	IF @nombreASPInput LIKE '*'
		BEGIN
			SELECT A.nombre AS [Nombre], A.ubicacion AS [Ubicacion], A.fechaCreacion AS [Ultima modificacion],A.responsable AS [Responsable] FROM ASP A WHERE A.activo = 1 
		END
	ELSE
		BEGIN
			SELECT A.nombre AS [Nombre], A.ubicacion AS [Ubicacion], A.fechaCreacion AS [Ultima modificacion],A.responsable AS [Responsable] FROM ASP A WHERE LOWER(A.nombre) LIKE LOWER(@nombreASPInput) AND A.activo = 1
		END
END
GO

/*
	EXEC spBuscarASP 'volcan irazu' 
*/

--PROC para buscar Sitios por nombre en el ASP
DROP PROC IF EXISTS spBuscarSitio 
GO
CREATE PROC spBuscarSitio @nombreASPInput NVARCHAR(64),@nombreSitioInput NVARCHAR(64) AS
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
				S.valoracionAccesibilidad AS [Accesibilidad],
				S.fechaCreacion AS [Ultima modificacion],
				S.responsable AS [Responsable]
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
				S.valoracionAccesibilidad AS [Accesibilidad],
				S.fechaCreacion AS [Ultima modificacion],
				S.responsable AS [Responsable]
				FROM Sitios S WHERE LOWER(S.nombre) = LOWER(@nombreSitioInput) AND S.idASP = @idASP AND S.activo = 1;
			END
	END
GO

--PROC para buscar un recurso por nombre en un sitio
DROP PROC IF EXISTS spBuscarRecurso
GO
CREATE PROC spBuscarRecurso @nombreASPinput NVARCHAR(64),@nombreSitioInput NVARCHAR(64),@nombreRecursoInput NVARCHAR(128) AS
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
								SELECT R.nombre AS [Nombre de recurso],TR.nombre AS [Tipo de recurso],R.fechaModificacion AS [Ultima modificacion],R.responsable AS [Responsable] FROM Recursos R JOIN TipoRecurso TR ON R.idTipoRecurso = TR.id WHERE R.activo = 1  AND @idSitio = R.idSitio
							END
						ELSE
							BEGIN
								SELECT R.nombre AS [Nombre de recurso],TR.nombre AS [Tipo de recurso],R.fechaModificacion AS [Ultima modificacion],R.responsable AS [Responsable] FROM Recursos R JOIN TipoRecurso TR ON R.idTipoRecurso = TR.id WHERE R.activo = 1 AND LOWER(R.nombre) LIKE LOWER(@nombreRecursoInput)  AND @idSitio = R.idSitio
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

--PROC para ver las puntuaciones de un recurso usando su nombre

DROP PROC IF EXISTS spGetRatingCaracteristicasRecurso
GO
CREATE PROC spGetRatingCaracteristicasRecurso @nombreASPInput NVARCHAR(64),@nombreSitioInput NVARCHAR(64),@nombreRecursoInput NVARCHAR(128) AS
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
								SELECT RR.relacionPropositoASP AS [Relacion con el ASP],RR.relacionTemaInterpretativoASP AS [Relacion con los temas interpretativos del ASP], RR.variedadRecurso AS [Variedad del recurso],RR.atractivo AS [Atractivo],RR.accesibilidad AS [Accesibilidad],RR.fechaModificacion AS [Ultima modificacion],RR.responsable AS [Responsable] FROM RatingRecurso RR WHERE @idRecurso = RR.idRecurso;
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

--EXEC spGetRatingCaracteristicasRecurso 'Volcan Irazu','Crater','Lago'


--PROC que retorna la ultima fecha de modifciacoin de un recurso
DROP PROC IF EXISTS spGetFechaModificacionRecurso
GO
CREATE PROC spGetFechaModificacionRecurso @nombreASPInput NVARCHAR(64),@nombreSitioInput NVARCHAR(64),@nombreRecursoInput NVARCHAR(128),@ultimaFechaModificacion NVARCHAR(15) OUTPUT AS
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
/*
DECLARE @fecha NVARCHAR(15)
EXEC spGetFechaModificacionRecurso 'Volcan Irazu','Crater','Lago',@fecha OUT
PRINT @fecha
*/