--Presione F5 para crear la base de datos junto con las tablas

/*USE master
GO

DROP DATABASE IF EXISTS ASPReports
GO

CREATE DATABASE ASPReports
GO

USE ASPReports
GO*/

------------Orden en el que se borran las tablas------------
/** DESCOMENTE PARA BORRAR LAS TABLAS
DROP TABLE IF EXISTS Usuario
GO

DROP TABLE IF EXISTS Oportunidades
GO

DROP TABLE IF EXISTS RatingRecurso
GO

DROP TABLE IF EXISTS Recursos
GO

DROP TABLE IF EXISTS TipoRecurso
GO


DROP TABLE IF EXISTS TipoFigura
GO

DROP TABLE IF EXISTS Sitios
GO

DROP TABLE IF EXISTS ASP
GO

--Resets de los identities en caso de que se necesite
DBCC CHECKIDENT ('Oportunidades', RESEED,0);
DBCC CHECKIDENT ('TipoRecurso', RESEED,0);
DBCC CHECKIDENT ('Recursos', RESEED,0);
DBCC CHECKIDENT ('RatingRecurso', RESEED,0);
DBCC CHECKIDENT ('TipoFigura', RESEED,0);
DBCC CHECKIDENT ('Sitios', RESEED,0);
DBCC CHECKIDENT ('ASP', RESEED,0);
**/
------------------------

--Creacion de la tabla de ASPs
CREATE TABLE ASP(
	id INT IDENTITY(1,1) PRIMARY KEY,
	nombre NVARCHAR(64) NOT NULL,
	ubicacion NVARCHAR(256) NOT NULL,
	fechaCreacion NVARCHAR(10) NOT NULL,
	responsable NVARCHAR(256) NOT NULL,
	activo BIT NOT NULL
)
GO

--Creacion de la tabla para los tipos de figura

CREATE TABLE TipoFigura(
	id INT IDENTITY(1,1) PRIMARY KEY,
	nombre NVARCHAR(32) NOT NULL
)
GO

--Creacion de la tabla de sitios

CREATE TABLE Sitios(
	id INT IDENTITY(1,1) PRIMARY KEY,
	idASP INT NOT NULL,
	idTipoFigura INT NOT NULL, 
	nombre NVARCHAR(64) NOT NULL,
	ubicacion NVARCHAR(256) NOT NULL,
	zonificacion BIT NOT NULL,
	tamano NVARCHAR(512) NOT NULL,
	capacidad NVARCHAR(128) NOT NULL,
	observacionesDisenoInfraestructura NVARCHAR(1024),
	valoracionRelacionPropositoASP FLOAT NOT NULL,
	valoracionRelacionTemasInterpretativos FLOAT NOT NULL,
	valoracionVariedadRecurso FLOAT NOT NULL,
	valoracionAtractivo FLOAT NOT NULL,
	valoracionAccesibilidad FLOAT NOT NULL,
	fechaCreacion NVARCHAR(10) NOT NULL,
	responsable NVARCHAR(256) NOT NULL,
	activo BIT NOT NULL,
	FOREIGN KEY (idASP) REFERENCES ASP(id),
	FOREIGN KEY (idTipoFigura) REFERENCES TipoFigura(id)
)
GO

--Punto b, pagina 12 de la herramienta del SINAC

CREATE TABLE TipoRecurso(
	id INT IDENTITY(1,1) PRIMARY KEY,
	nombre NVARCHAR(128) NOT NULL,
	fechaCreacion NVARCHAR(10) NOT NULL
)

/**
	1) Los campos relacionPropositoASP, relacionTemaInterpretativoASP,
	variedadRecurso y accesibilidad vienen del cuadro 1 de la herramienta del SINAC
	2) Los campos disponibilidad, capacidadAbsorcion, capacidadTolerar
	e importanciaSPTI vienen en el cuadro 2 de la herramienta del SINAC
**/

CREATE TABLE Recursos(
	id INT IDENTITY(1,1) PRIMARY KEY,
	idTipoRecurso INT NOT NULL,
	idSitio INT NOT NULL,
	nombre NVARCHAR(128) NOT NULL,
	ubicacion NVARCHAR(200) NOT NULL,
	anomalia NVARCHAR(200) NOT NULL,
	traslape NVARCHAR(200) NOT NULL,
	condicion NVARCHAR(200) NOT NULL,
	atractivos NVARCHAR(200) NOT NULL,
	soportaUso BIT NOT NULL,
	capacidad NVARCHAR(200) NOT NULL,
	hectareas NVARCHAR(200) NOT NULL,
	oportunidadesUso NVARCHAR(200) NOT NULL,
	responsable NVARCHAR(256) NOT NULL,
	fechaModificacion NVARCHAR(10) NOT NULL,
	activo BIT NOT NULL,
	FOREIGN KEY (idTipoRecurso) REFERENCES TipoRecurso(id),
	FOREIGN KEY (idSitio) REFERENCES Sitios(id)
)
GO

--Atributos para el rating de los recursos

CREATE TABLE RatingRecurso(
	id INT IDENTITY(1,1) PRIMARY KEY,
	idRecurso INT NOT NULL,
	relacionPropositoASP INT NOT NULL,
	relacionTemaInterpretativoASP INT NOT NULL,
	variedadRecurso INT NOT NULL,
	atractivo INT NOT NULL,
	accesibilidad INT NOT NULL,
	fechaModificacion NVARCHAR(10) NOT NULL,
	responsable NVARCHAR(256) NOT NULL
	FOREIGN KEY (idRecurso) REFERENCES Recursos(id)
)
GO

--Creacion de la tabla de Oportunidades

CREATE TABLE Oportunidades(
	id INT IDENTITY(1,1) PRIMARY KEY,
	idSitio INT NOT NULL,
	descripcion NVARCHAR(512) NOT NULL,
	observaciones NVARCHAR(1024) NOT NULL, --Campo para riesgos y detalles importantes
	fechaModificacion NVARCHAR(10) NOT NULL,
	responsable NVARCHAR(256) NOT NULL,
	activo BIT NOT NULL,
	FOREIGN KEY (idSitio) REFERENCES Sitios(id)
)
GO

--Creacion de la tablas para usuarios

CREATE TABLE Usuario(
	id INT PRIMARY KEY IDENTITY(1,1),
	nombre NVARCHAR(50) NOT NULL,
	cedula NVARCHAR(15) NOT NULL,
	correo NVARCHAR(50) NOT NULL,
	usuario NVARCHAR(50) NOT NULL,
	contrasena NVARCHAR(50) NOT NULL,
	admin BIT NOT NULL,
	activo BIT NOT NULL
)
GO

--Adicion de la cuenta administrador
/*INSERT INTO Usuario(nombre,cedula,correo,usuario,contrasena,admin,activo) VALUES ('Administrador','123456789','admin@sinac.co.cr','admin','admin',1,1)
INSERT INTO Usuario(nombre,cedula,correo,usuario,contrasena,admin,activo) VALUES ('Nacho','987654321','nacho@sinac.co.cr','admin','admin',0,1)
GO*/

--Notas
/**
	+ Antes de borrar un sitio, recurso o oportunidad, pedirle al usuario que ingrese el nombre del sitio,
	recurso o oportunidad para confirmar el borrado
	
	+ Campo que indica quien fue el ultimo en modificar algun recurso,sitio,etc.

**/

/*
INSERT INTO TipoRecurso(nombre,fechaCreacion) VALUES ('Natural',CONVERT(NVARCHAR(10),GETDATE(),103))
INSERT INTO TipoRecurso(nombre,fechaCreacion) VALUES ('Etnografico',CONVERT(NVARCHAR(10),GETDATE(),103))
INSERT INTO TipoRecurso(nombre,fechaCreacion) VALUES ('Geologico',CONVERT(NVARCHAR(10),GETDATE(),103))
INSERT INTO TipoRecurso(nombre,fechaCreacion) VALUES ('De paisaje',CONVERT(NVARCHAR(10),GETDATE(),103))
INSERT INTO TipoRecurso(nombre,fechaCreacion) VALUES ('Arquitectonico',CONVERT(NVARCHAR(10),GETDATE(),103))
INSERT INTO TipoRecurso(nombre,fechaCreacion) VALUES ('Arqueologico',CONVERT(NVARCHAR(10),GETDATE(),103))
GO*/