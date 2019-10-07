USE [ASPReports]
SET NOCOUNT ON;
--Insert usarios
INSERT INTO Usuario(nombre,cedula,correo,usuario,contrasena,admin,activo) VALUES ('Administrador','123456789','admin@sinac.co.cr','admin','admin',1,1)
INSERT INTO Usuario(nombre,cedula,correo,usuario,contrasena,admin,activo) VALUES ('Nacho','987654321','nacho@sinac.co.cr','nacho','nacho',0,1)

--Insert tipo de figura
INSERT INTO TipoFigura(nombre) VALUES('Poligonal')
INSERT INTO TipoFigura(nombre) VALUES('Lineal')


--Insert ASPs

EXEC spAgregarASP 'Volcan Irazu', 'Cartago','Administrador'
EXEC spAgregarASP 'Volcan Arenal', 'Alajuela','Administrador'
EXEC spAgregarASP 'Jardin Botanico Lankester', 'Cartago','Administrador'


--Insert Sitios
EXEC spAgregarSitio 'Volcan Irazu', 'Crater', 'Volcan', 1,'Poligonal',	'200m', '8 personas', 'Observaciones','Administrador'
EXEC spAgregarSitio 'Volcan Irazu', 'Mirador', 'Volcan', 1,'Lineal',	'500m', '20 personas', 'Observaciones','Administrador'
EXEC spAgregarSitio 'Volcan Irazu', 'Camino', 'Parqueo', 1,'Poligonal',	'200', '8 personas', 'Observaciones','Administrador'

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
		@nombreRecursoInput = N'Arboles anaranjados de fondo',
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


	--Insert Oportunidades
EXEC spAgregarOportunidad 'Volcan Irazu','Camino','Zona para crear mas camino','Gran variedad de arboles','Administrador'
EXEC spAgregarOportunidad 'Volcan Irazu','Mirador','Zona para crear area techado', 'Tiene vista al crater','Administrador'

