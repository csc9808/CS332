
--2
CREATE DATABASE sheep;
GO
--3
USE sheep;
GO
--4
CREATE SCHEMA ActiveHerd;
GO

CREATE TABLE ActiveHerd.breed (
BreedCategory VARCHAR(50) PRIMARY KEY NOT NULL,
BreedDescription VARCHAR(200) NOT NULL
);
GO
--5~6
CREATE TABLE ActiveHerd.shepherd (
ShepherdId INT PRIMARY KEY NOT NULL,
LastName VARCHAR(50) NOT NULL,
FirstName VARCHAR(50) NOT NULL,
ShepherdCertification BIT NOT NULL
);
GO

CREATE TABLE ActiveHerd.sheep (
IdNumber int IDENTITY PRIMARY KEY,
SheepName varchar(50) NOT NULL,
BreedCategory varchar(50) NOT NULL,
Gender char(1) NOT NULL,
ShepherdId int NOT NULL,
);
GO

CREATE TABLE ActiveHerd.shotList (
ShotType varchar(50) PRIMARY KEY,
ShotDescription varchar(255) NOT NULL,
DayCycle int NOT NULL
);
GO

CREATE TABLE ActiveHerd.injectionList (
InjectionType VARCHAR(50) PRIMARY KEY NOT NULL,
injectionDescription VARCHAR(200) NOT NULL
);
GO

CREATE TABLE ActiveHerd.sheepShots (
IdNumber int NOT NULL,
ShotType varchar(50) NOT NULL,
ShotDate date NOT NULL,
InjectionType varchar(50) NOT NULL,
PRIMARY KEY (IdNumber, ShotType, ShotDate)
);
GO
--7
ALTER TABLE ActiveHerd.sheep
ADD CONSTRAINT FK_sheep_BreedCategory FOREIGN KEY (BreedCategory) REFERENCES ActiveHerd.breed(BreedCategory);
GO

ALTER TABLE ActiveHerd.sheep
ADD CONSTRAINT FK_sheep_ShepherdId FOREIGN KEY (ShepherdId) REFERENCES ActiveHerd.shepherd(ShepherdId);
GO

ALTER TABLE ActiveHerd.sheepShots
ADD CONSTRAINT FK_sheepShots_IdNumber FOREIGN KEY (IdNumber) REFERENCES ActiveHerd.sheep(IdNumber);
GO

ALTER TABLE ActiveHerd.sheepShots
ADD CONSTRAINT FK_sheepShots_ShotType FOREIGN KEY (ShotType) REFERENCES ActiveHerd.shotList(ShotType);
GO

ALTER TABLE ActiveHerd.sheepShots
ADD CONSTRAINT FK_sheepShots_InjectionType FOREIGN KEY (InjectionType) REFERENCES ActiveHerd.injectionList(InjectionType)
GO
--8
INSERT INTO ActiveHerd.breed (BreedCategory, BreedDescription)
VALUES
('Merino', 'breeds of domestic sheep, has by very fine soft wool'),
('Dorper', 'South African Breed'),
('Texel Sheep', ' Dutch breed of domestic sheep, heavy and muscular');


INSERT INTO ActiveHerd.injectionList (InjectionType, InjectionDescription)
VALUES
('Oral Injection', 'Injection given orally'),
('Subcutaneous', 'Injection given below the skin'),
('IV', 'Injection given into the vein');

INSERT INTO ActiveHerd.shepherd (ShepherdId, LastName, FirstName, ShepherdCertification)
VALUES
(1, 'Smith', 'John', 1),
(2, 'Parker', 'Peter', 0),
(3, 'Williams', 'Dave', 1);

INSERT INTO ActiveHerd.sheep (SheepName, BreedCategory, Gender, ShepherdId)
VALUES
('Tommy', 'Merino', 'F', 1),
('Ramses', 'Dorper', 'M', 2),
('Wooly', 'Texel Sheep', 'F', 3);

INSERT INTO ActiveHerd.shotList (ShotType, ShotDescription, DayCycle)
VALUES
('Parvo', 'Vaccine for parvovirus', 365),
('CDT', 'Vaccine for clostridium perfringens and tetanus', 365),
('Pasteurella', 'Vaccine for pasteurella', 365);

--9
INSERT INTO ActiveHerd.sheepShots (IdNumber, ShotType, ShotDate, InjectionType)
SELECT s.IdNumber, sl.ShotType, GETDATE(), il.InjectionType
FROM ActiveHerd.sheep s
,ActiveHerd.shotList sl
,ActiveHerd.injectionList il
WHERE il.InjectionType = 'Oral Injection'

--10
UPDATE ActiveHerd.sheepShots
SET ShotDate = '2023-02-03'


--11
select * from ActiveHerd.sheep

select * from ActiveHerd.sheepShots

select * from ActiveHerd.breed

select * from ActiveHerd.shepherd

select * from ActiveHerd.shotList

select * from ActiveHerd.injectionList

--12
-- Does not work as foreign key remains in the other table
DELETE FROM ActiveHerd.sheep
GO
--13
--drop foreign key
ALTER TABLE ActiveHerd.sheepShots
	DROP CONSTRAINT FK_sheepShots_IdNumber
DELETE FROM ActiveHerd.sheep;

--14
DELETE FROM ActiveHerd.shepherd;

--16
DROP TABLE ActiveHerd.sheepShots
DROP TABLE ActiveHerd.shotList
DROP TABLE ActiveHerd.injectionList
DROP TABLE ActiveHerd.sheep
DROP TABLE ActiveHerd.shepherd
DROP TABLE ActiveHerd.breed

--17
USE master
ALTER DATABASE sheep SET SINGLE_USER WITH ROLLBACK IMMEDIATE
DROP DATABASE sheep;
GO