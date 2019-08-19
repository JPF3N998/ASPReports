USE ASPReports
GO

/* PROC para el login */
DROP PROC IF EXISTS spLogin
GO

CREATE PROC spLogin @nombreUsuarioInput char(50), @passwordInput char(50),@adminBIT BIT OUTPUT AS
	BEGIN
		DECLARE @existeUsuario BIT = (SELECT Usuario U FROM U.usuario WHERE U.usuario = @nombreUsuarioInput );
		
		IF (@existeUsuario = 1) /* Revisa existencia de usuario */
			BEGIN
				DECLARE @foundPassword CHAR(50)= (SELECT U.contrasena FROM Usuario U WHERE @nombreUsuarioInput= U.usuario);
				DECLARE @isAdmin BIT = (SELECT U.admin FROM Usuario U WHERE U.usuario = @nombreUsuarioInput); 
				IF (@foundPassword=@passwordInput) /* Revisa si la contrasenna es la correcta */
					BEGIN
						IF @isAdmin = 1 /*Es administrador*/
							BEGIN
								SET @adminBIT = 1;
								RETURN 1 /*1 para admin*/
							END
						ELSE
							BEGIN
								SET @adminBIT = 0;
								RETURN 2; /*2 para cliente*/
							END
						
					END
				ELSE
					BEGIN
						RETURN 0;
					END
			END
		ELSE
			BEGIN
				RETURN 0;
			END
	END
GO

declare @bit bit;
exec spLogin 'admin','admin', @bit output
print @bit