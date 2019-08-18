USE ASPReports
GO

DROP TABLE IF EXISTS Sitios
CREATE TABLE Sitios(id INT,nombre NVARCHAR(128),ubicacion NVARCHAR(512),conveniencia NVARCHAR(512))
GO

--Identity for TipoRecurso?
DROP TABLE IF EXISTS TipoRecurso
CREATE TABLE TipoRecurso(id INT IDENTITY(1,1), nombre NVARCHAR(64))
INSERT INTO TipoRecurso(nombre) VALUES ("Natural")
INSERT INTO TipoRecurso(nombre) VALUES ("Etnografico")
INSERT INTO TipoRecurso(nombre) VALUES ("Geologico")
INSERT INTO TipoRecurso(nombre) VALUES ("De paisaje")
INSERT INTO TipoRecurso(nombre) VALUES ("Arquitectonico ")
INSERT INTO TipoRecurso(nombre) VALUES ("Arqueologico")
GO

DROP TABLE IF EXISTS Recursos
CREATE TABLE Recursos(id INT,idTipoRecurso INT,idSitio INT,nombre NVARCHAR(128), relacionPropositoASP INT, relacionTemaInterpretativoASP INT, variedadRecurso INT, accesibilidad INT)
GO

DROP TABLE IF EXISTS Oportunidades
CREATE TABLE Oportunidades(id INT, idRecurso INT,nombre NVARCHAR(256))
GO
