USE ASPReports
GO

/* PROC para el login */
DROP PROC IF EXISTS spLogin
GO

CREATE PROC spLogin @nombreUsuarioInput NVARCHAR(50), @passwordInput NVARCHAR(50),@adminBIT BIT OUTPUT AS
	BEGIN
		DECLARE @existeUsuario NVARCHAR(50) = (SELECT U.usuario FROM Usuario U WHERE U.usuario = @nombreUsuarioInput);
		IF (@existeUsuario IS NOT NULL) /* Revisa existencia de usuario */
			BEGIN
				DECLARE @foundPassword CHAR(50)= (SELECT U.contrasena FROM Usuario U WHERE @nombreUsuarioInput= U.usuario);
				DECLARE @isAdmin BIT = (SELECT U.admin FROM Usuario U WHERE U.usuario = @nombreUsuarioInput); 
				IF (@foundPassword=@passwordInput) /* Revisa si la contrasenna es la correcta */
					BEGIN
						IF @isAdmin = 1 
							BEGIN
								SET @adminBIT = 1;
								RETURN 1 /*1 para admin*/
							END
						ELSE
							BEGIN
								SET @adminBIT = 0;
								RETURN 0; /*2 para cliente*/
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
	END
GO

--PROC para sacar el ID del tipo de recurso usando el nombre
DROP PROC IF EXISTS spGetIDTipoRecurso 
GO
CREATE PROC spGetIDTipoRecurso @nombreTipoRecursoInput NVARCHAR(128), @idRecurso INT OUTPUT AS
	BEGIN
		SET @idRecurso = (SELECT TR.id FROM TipoRecurso TR WHERE TR.nombre LIKE @nombreTipoRecursoInput);
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

--PROC para el calculo de la valoracion(promedio) de un sitio
DROP PROC IF EXISTS spActualizarValoracion
GO
CREATE PROC spActualizarValoracion @nombreASPInput NVARCHAR(64),@nombreSitioInput NVARCHAR(64) AS
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
