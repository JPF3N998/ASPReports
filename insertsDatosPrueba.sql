USE [ASPReports]

--Insert usarios
INSERT INTO Usuario(nombre,cedula,correo,usuario,contrasena,admin,activo) VALUES ('Administrador','123456789','admin@sinac.co.cr','admin','admin',1,1)
INSERT INTO Usuario(nombre,cedula,correo,usuario,contrasena,admin,activo) VALUES ('Nacho','987654321','nacho@sinac.co.cr','nacho','nacho',0,1)

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

EXEC	[dbo].[spAgregarRecurso]
		@nombreASPInput = N'Volcan Irazu',
		@nombreSitioInput = N'Crater',
		@nombreTipoRecursoInput = N'Natural',
		@nombreRecursoInput = N'Lago',
		@ubicacionInput = N'Cartago',
		@anomaliaInput = N'no se',
		@traslapeInput = N'ni idea',
		@condicionInput = N'ak7',
		@atractivosInput = N'muchos',
		@soportaUsoInput = 1,
		@capacidadInput = N'5',
		@hectareasInput = N'5000',
		@oportunidadesUsoInput = N'muchas',
		@rRelacionPropositoASP = 2,
		@rRelacionTemaInterpretativoASP = 3,
		@rVariedadRecurso = 1,
		@rAtractivo = 2,
		@rAccesibildad = 3,
		@responsableInput = N'987654321'
								
EXEC	[dbo].[spAgregarRecurso]
		@nombreASPInput = N'Volcan Irazu',
		@nombreSitioInput = N'Crater',
		@nombreTipoRecursoInput = N'Natural',
		@nombreRecursoInput = N'Foliles',
		@ubicacionInput = N'Cartagp',
		@anomaliaInput = N'no se',
		@traslapeInput = N'ni idea',
		@condicionInput = N'ak7',
		@atractivosInput = N'muchos',
		@soportaUsoInput = 1,
		@capacidadInput = N'5',
		@hectareasInput = N'5000',
		@oportunidadesUsoInput = N'muchas',
		@rRelacionPropositoASP = 2,
		@rRelacionTemaInterpretativoASP = 3,
		@rVariedadRecurso = 1,
		@rAtractivo = 2,
		@rAccesibildad = 3,
		@responsableInput = N'987654321'

EXEC	[dbo].[spAgregarRecurso]
		@nombreASPInput = N'Volcan Irazu',
		@nombreSitioInput = N'Crater',
		@nombreTipoRecursoInput = N'Natural',
		@nombreRecursoInput = N'Arboles anaranjados de fondo',
		@ubicacionInput = N'Cartagp',
		@anomaliaInput = N'no se',
		@traslapeInput = N'ni idea',
		@condicionInput = N'ak7',
		@atractivosInput = N'muchos',
		@soportaUsoInput = 1,
		@capacidadInput = N'5',
		@hectareasInput = N'5000',
		@oportunidadesUsoInput = N'muchas',
		@rRelacionPropositoASP = 2,
		@rRelacionTemaInterpretativoASP = 3,
		@rVariedadRecurso = 1,
		@rAtractivo = 2,
		@rAccesibildad = 3,
		@responsableInput = N'987654321'

	--Insert Oportunidades
INSERT INTO Oportunidades(idSitio,descripcion,observaciones,fechaModificacion,responsable,activo)
	VALUES (3, 'Zona para crear mas camino', 'Gran variedad de arboles', CONVERT(NVARCHAR(15),GETDATE(),103),'Administrador', 1)
INSERT INTO Oportunidades(idSitio,descripcion,observaciones,fechaModificacion,responsable,activo)
	VALUES (1, 'Zona para crear area techado', 'Tiene vista al crater', CONVERT(NVARCHAR(15),GETDATE(),103),'Administrador', 1)
