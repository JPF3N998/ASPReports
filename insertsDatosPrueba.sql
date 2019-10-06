USE [ASPReports]

--Insert usarios
INSERT INTO Usuario(nombre,cedula,correo,usuario,contrasena,admin,activo) VALUES ('Administrador','123456789','admin@sinac.co.cr','admin','admin',1,1)
INSERT INTO Usuario(nombre,cedula,correo,usuario,contrasena,admin,activo) VALUES ('Nacho','987654321','nacho@sinac.co.cr','admin','admin',0,1)

--Insert tipo de figura
INSERT INTO TipoFigura(nombre) VALUES('Poligonal')
INSERT INTO TipoFigura(nombre) VALUES('Lineal')


--Insert ASPs
INSERT INTO ASP(nombre, ubicacion, fechaCreacion,responsable, activo) VALUES('Volcan Irazu', 'Cartago', CONVERT(NVARCHAR(10),GETDATE(),103),'Administrador',1)
INSERT INTO ASP(nombre, ubicacion, fechaCreacion,responsable, activo) VALUES('Volcan Arenal', 'Alajuela', CONVERT(NVARCHAR(10),GETDATE(),103),'Administrador',1)
INSERT INTO ASP(nombre, ubicacion, fechaCreacion,responsable, activo) VALUES('Jardin Botanico Lankester', 'Cartago', CONVERT(NVARCHAR(10),GETDATE(),103),'Administrador',1)

--Insert Sitios
INSERT INTO Sitios(idASP, idTipoFigura, nombre,ubicacion,zonificacion,tamano,capacidad,observacionesDisenoInfraestructura,valoracionRelacionPropositoASP,valoracionRelacionTemasInterpretativos,valoracionVariedadRecurso,valoracionAtractivo,valoracionAccesibilidad,fechaCreacion,responsable,activo)
	VALUES(1, 1, 'Crater', 'Volcan', 1,	'200m', '8 personas', 'Observaciones', 1,	1, 1, 1, 1, CONVERT(NVARCHAR(10),GETDATE(),103),'Administrador',1)
INSERT INTO Sitios(idASP, idTipoFigura, nombre,ubicacion,zonificacion,tamano,capacidad,observacionesDisenoInfraestructura,valoracionRelacionPropositoASP,valoracionRelacionTemasInterpretativos,valoracionVariedadRecurso,valoracionAtractivo,valoracionAccesibilidad,fechaCreacion,responsable,activo)
	VALUES(1, 1, 'Mirador', 'Volcan', 1,	'500m', '20 personas', 'Observaciones', 1,	1, 1, 1, 1, CONVERT(NVARCHAR(10),GETDATE(),103),'Administrador', 1)
INSERT INTO Sitios(idASP, idTipoFigura, nombre,ubicacion,zonificacion,tamano,capacidad,observacionesDisenoInfraestructura,valoracionRelacionPropositoASP,valoracionRelacionTemasInterpretativos,valoracionVariedadRecurso,valoracionAtractivo,valoracionAccesibilidad,fechaCreacion,responsable,activo)
	VALUES(1, 1, 'Camino', 'Parqueo', 1,	'200', '8 personas', 'Observaciones', 1,	1, 1, 1, 1, CONVERT(NVARCHAR(10),GETDATE(),103),'Administrador', 1)

--Insert Tipo Recursos
INSERT INTO TipoRecurso(nombre, fechaCreacion) VALUES ('Natural', CONVERT(NVARCHAR(15),GETDATE(),103))
INSERT INTO TipoRecurso(nombre, fechaCreacion) VALUES ('Etnografico', CONVERT(NVARCHAR(15),GETDATE(),103))
INSERT INTO TipoRecurso(nombre, fechaCreacion) VALUES ('Geologico', CONVERT(NVARCHAR(15),GETDATE(),103))
INSERT INTO TipoRecurso(nombre, fechaCreacion) VALUES ('De paisaje', CONVERT(NVARCHAR(15),GETDATE(),103))
INSERT INTO TipoRecurso(nombre, fechaCreacion) VALUES ('Arquitectonico', CONVERT(NVARCHAR(15),GETDATE(),103))
INSERT INTO TipoRecurso(nombre, fechaCreacion) VALUES ('Arqueologico', CONVERT(NVARCHAR(15),GETDATE(),103))

--Insert Recursos, Atributos y Rating
INSERT INTO Recursos(idTipoRecurso,idSitio,nombre,fechaModificacion,responsable,activo)
	VALUES (1, 1, 'Lago', CONVERT(NVARCHAR(15),GETDATE(),103),'Administrador', 1)
									
INSERT INTO AtributosRecurso(idRecurso,disponibilidad,capacidadAbsorcionUsoTuristico,capacidadTolerarUsoTuristico,interesPotencialAvisitantes,importanciaSPTI,fechaModificacion,responsable)
	SELECT SCOPE_IDENTITY(), 5, 5, 5, 5, 5,CONVERT(NVARCHAR(15),GETDATE(),103),'Administrador' FROM Recursos

INSERT INTO RatingRecurso(idRecurso,relacionPropositoASP,relacionTemaInterpretativoASP,variedadRecurso,atractivo,accesibilidad,fechaModificacion,responsable)
	SELECT SCOPE_IDENTITY() as idRecurso, 3, 3, 3, 3, 3,CONVERT(NVARCHAR(15),GETDATE(),103),'Administrador' FROM Recursos


INSERT INTO Recursos(idTipoRecurso,idSitio,nombre,fechaModificacion,responsable,activo)
	VALUES (6, 1, 'Foliles', CONVERT(NVARCHAR(15),GETDATE(),103),'Administrador',1)
									
INSERT INTO AtributosRecurso(idRecurso,disponibilidad,capacidadAbsorcionUsoTuristico,capacidadTolerarUsoTuristico,interesPotencialAvisitantes,importanciaSPTI,fechaModificacion,responsable)
	SELECT SCOPE_IDENTITY(), 5, 5, 5, 5, 5,CONVERT(NVARCHAR(15),GETDATE(),103),'Administrador' FROM Recursos

INSERT INTO RatingRecurso(idRecurso,relacionPropositoASP,relacionTemaInterpretativoASP,variedadRecurso,atractivo,accesibilidad,fechaModificacion,responsable)
	SELECT SCOPE_IDENTITY() as idRecurso, 3, 3, 3, 3, 3,CONVERT(NVARCHAR(15),GETDATE(),103),'Administrador' FROM Recursos


INSERT INTO Recursos(idTipoRecurso,idSitio,nombre,fechaModificacion,responsable,activo)
	VALUES (4, 1, 'Arboles anaranjados de fondo', CONVERT(NVARCHAR(15),GETDATE(),103),'Administrador', 1)
									
INSERT INTO AtributosRecurso(idRecurso,disponibilidad,capacidadAbsorcionUsoTuristico,capacidadTolerarUsoTuristico,interesPotencialAvisitantes,importanciaSPTI,fechaModificacion,responsable)
	SELECT SCOPE_IDENTITY() as idRecurso, 5, 5, 5, 5, 5,CONVERT(NVARCHAR(15),GETDATE(),103),'Administrador' FROM Recursos

INSERT INTO RatingRecurso(idRecurso,relacionPropositoASP,relacionTemaInterpretativoASP,variedadRecurso,atractivo,accesibilidad,fechaModificacion,responsable)
	SELECT SCOPE_IDENTITY() as idRecurso, 3, 3, 3, 3, 3,CONVERT(NVARCHAR(15),GETDATE(),103),'Administrador' FROM Recursos

	--Insert Oportunidades
INSERT INTO Oportunidades(idSitio,descripcion,observaciones,fechaModificacion,responsable,activo)
	VALUES (3, 'Zona para crear mas camino', 'Gran variedad de arboles', CONVERT(NVARCHAR(15),GETDATE(),103),'Administrador', 1)
INSERT INTO Oportunidades(idSitio,descripcion,observaciones,fechaModificacion,responsable,activo)
	VALUES (1, 'Zona para crear area techado', 'Tiene vista al crater', CONVERT(NVARCHAR(15),GETDATE(),103),'Administrador', 1)
