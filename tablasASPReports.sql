--Presione F5 para crear la base de datos junto con las tablas

USE master
GO

DROP DATABASE IF EXISTS ASPReports
GO

CREATE DATABASE ASPReports
GO

USE ASPReports
GO

DROP TABLE IF EXISTS Sitios
CREATE TABLE Sitios(
	id INT IDENTITY(1,1),
	nombre NVARCHAR(128) NOT NULL,
	ubicacion NVARCHAR(512) NOT NULL,
	conveniencia NVARCHAR(512) NOT NULL,
	calidad NVARCHAR(512) NOT NULL,
	tamano NVARCHAR(512) NOT NULL,
	capacidad NVARCHAR(128) NOT NULL,
	observacionesDisenoInfraestructura NVARCHAR(1024),
	fechaCreacion DATE NOT NULL
)
GO

--Punto b, pagina 12 de la herramienta del SINAC
DROP TABLE IF EXISTS TipoRecurso
CREATE TABLE TipoRecurso(
	id INT IDENTITY(1,1) NOT NULL,
	nombre NVARCHAR(128) NOT NULL,
	fechaCreacion VARCHAR(10) NOT NULL
)
INSERT INTO TipoRecurso(nombre,fechaCreacion) VALUES ('Natural',CONVERT(NVARCHAR(10),GETDATE(),103))
INSERT INTO TipoRecurso(nombre,fechaCreacion) VALUES ('Etnografico',CONVERT(NVARCHAR(10),GETDATE(),103))
INSERT INTO TipoRecurso(nombre,fechaCreacion) VALUES ('Geologico',CONVERT(NVARCHAR(10),GETDATE(),103))
INSERT INTO TipoRecurso(nombre,fechaCreacion) VALUES ('De paisaje',CONVERT(NVARCHAR(10),GETDATE(),103))
INSERT INTO TipoRecurso(nombre,fechaCreacion) VALUES ('Arquitectonico',CONVERT(NVARCHAR(10),GETDATE(),103))
INSERT INTO TipoRecurso(nombre,fechaCreacion) VALUES ('Arqueologico',CONVERT(NVARCHAR(10),GETDATE(),103))
GO

/**
	1) Los campos relacionPropositoASP, relacionTemaInterpretativoASP,
	variedadRecurso y accesibilidad vienen del cuadro 1 de la herramienta del SINAC
	2) Los campos disponibilidad, capacidadAbsorcion, capacidadTolerar
	e importanciaSPTI vienen en el cuadro 2 de la herramienta del SINAC
**/
DROP TABLE IF EXISTS Recursos
CREATE TABLE Recursos(
	id INT IDENTITY(1,1) NOT NULL,
	idTipoRecurso INT NOT NULL,
	idSitio INT NOT NULL,
	nombre NVARCHAR(128) NOT NULL,
	--1)
	relacionPropositoASP INT NOT NULL,
	relacionTemaInterpretativoASP INT NOT NULL,
	variedadRecurso INT NOT NULL,
	accesibilidad INT NOT NULL,
	--2)
	disponibilidad INT NOT NULL,
	capacidadAbsorcionUsoTuristico INT NOT NULL,
	capacidadTolerarUsoTuristico INT NOT NULL,
	interesPotencialAvisitantes INT NOT NULL,
	importanciaSPTI INT NOT NULL, --importancia relativa Significado, el Proposito y los temas Interpretativos del sitio
	fechaCreacion DATE NOT NULL
)
GO

DROP TABLE IF EXISTS Oportunidades
CREATE TABLE Oportunidades(
	id INT IDENTITY(1,1) NOT NULL,
	idRecurso INT NOT NULL,
	nombre NVARCHAR(256) NOT NULL,
	fechaCreacion DATE NOT NULL
)
GO

--Explicacion y ejemplo de indicador y umbrales en las paginas 21 a 25
DROP TABLE IF EXISTS IndicadorUmbrales
CREATE TABLE IndicadorUmbrales(
	id INT IDENTITY(1,1) NOT NULL,
	idOportunidad INT NOT NULL,
	optimo NVARCHAR(1024) NOT NULL,
	aceptable NVARCHAR(1024) NOT NULL,
	inaceptable NVARCHAR(1024) NOT NULL,
	acciones NVARCHAR(2048) NOT NULL,
	fechaModificacion DATE NOT NULL
)
GO