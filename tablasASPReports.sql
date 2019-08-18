USE ASPReports
GO

DROP TABLE IF EXISTS Sitios
CREATE TABLE Sitios(id INT,nombre NVARCHAR(128))
GO

DROP TABLE IF EXISTS TipoRecurso
CREATE TABLE TipoRecurso(id INT, nombre NVARCHAR(64))
GO

DROP TABLE IF EXISTS Recursos
CREATE TABLE Recursos(id INT,idTipoRecurso INT,idSitio INT,nombre NVARCHAR(128), relacionPropositoASP INT, relacionTemaInterpretativoASP INT, variedadRecurso INT, accesibilidad INT)
GO

DROP TABLE IF EXISTS Oportunidades
CREATE TABLE Oportunidades(id INT, idRecurso INT,nombre NVARCHAR(256))
GO
