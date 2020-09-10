-- Datenbankerstellung

-- Keys (Schl�ssel)
	-- Primary Key (Hauptschl�ssel)
	-- Foreign Keys (Fremdschl�ssel)

-- Normalformen
	-- 1. NF: atomar
	-- 2. NF: PK
	-- 3. NF: keine "transitiven" Abh�ngigkeiten


CREATE DATABASE Test1

USE Test1

CREATE TABLE Bestellungen
	(
		BestellNr int IDENTITY(1, 1) PRIMARY KEY,
		KundenID int,
		Test varchar(30)
--		...

	)


CREATE TABLE Kunden
	(
		KundenID int identity PRIMARY KEY,
		Vorname nvarchar(30),
		Nachname nchar(30)
--      ...
	)


CREATE TABLE Demo
	(
		Demo1 int identity,
		Demo2 int,
		Demo3 varchar(30)
--		...
		CONSTRAINT PK_Demo PRIMARY KEY (Demo1, Demo2)
	)

SELECT * fROM Demo

CREATE TABLE Produkte
	(
		ProduktID int identity PRIMARY KEY,
		Produktname nchar(30),
		Preis money
--		...
		
	)



ALTER TABLE Bestellungen
ADD CONSTRAINT FK_Bestellungen_Kunden FOREIGN KEY (KundenID) REFERENCES Kunden(KundenID)


-- DROP TABLE Demo


SELECT *
FROM Produkte


INSERT INTO Produkte
	VALUES ('Spaghetti', 1.90)



INSERT INTO Produkte
	VALUES (1.90, 'Spaghetti')
	-- Cannot convert a char value to money. The char value has incorrect syntax.



INSERT INTO Produkte(Produktname, Preis)
	VALUES ('Tartufo', 5.90)


SELECT *
FROM Produkte




INSERT INTO Produkte(Preis, Produktname)
	VALUES (4.99, 'Tiramisu')


SELECT *
FROM Produkte

-- Werte ver�ndern
UPDATE Produkte
SET Preis = 5.30
WHERE ProduktID = 4


SELECT *
FROM Produkte

-- Tabelle selbst �ndern
ALTER TABLE Produkte
ALTER COLUMN Produktname nchar(50)


-- neue Spalte hinzuf�gen
ALTER TABLE Produkte
ADD Email varchar(50)
--  upps, Fehler passiert

ALTER TABLE Produkte
DROP COLUMN Email


ALTER TABLE Kunden
ADD Email varchar(50)

SELECT *
FROM Kunden

