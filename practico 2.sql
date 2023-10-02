-- PARTE 1 DDL
-- 1)
 CREATE DATABASE `world` DEFAULT CHARACTER SET utf8mb4;
USE `world`;

-- 2)
DROP TABLE IF EXISTS `country`;
CREATE TABLE `country` (
  `Code` char(3) NOT NULL DEFAULT '',
  `Name` char(52) NOT NULL DEFAULT '',
  `Continent` varchar(35) NOT NULL DEFAULT '',
  `Region` char(26) NOT NULL DEFAULT '',
  `SurfaceArea` decimal(10,2) NOT NULL DEFAULT '0.00',
  `IndepYear` smallint DEFAULT NULL,
  `Population` int NOT NULL DEFAULT '0',
  `LifeExpectancy` decimal(3,1) DEFAULT NULL,
  `GNP` decimal(10,2) DEFAULT NULL,
  `GNPOld` decimal(10,2) DEFAULT NULL,
  `LocalName` char(45) NOT NULL DEFAULT '',
  `GovernmentForm` char(45) NOT NULL DEFAULT '',
  `HeadOfState` char(60) DEFAULT NULL,
  `Capital` int DEFAULT NULL,
  `Code2` char(2) NOT NULL DEFAULT '',
  PRIMARY KEY (`Code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS `city`;
CREATE TABLE `city` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `Name` char(35) NOT NULL DEFAULT '',
  `CountryCode` char(3) NOT NULL DEFAULT '',
  `District` char(20) NOT NULL DEFAULT '',
  `Population` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`),
  KEY `CountryCode` (`CountryCode`),
  CONSTRAINT `city_ibfk_1` FOREIGN KEY (`CountryCode`) REFERENCES `country` (`Code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS `countrylanguage`;
CREATE TABLE `countrylanguage` (
  `CountryCode` char(3) NOT NULL DEFAULT '',
  `Language` char(30) NOT NULL DEFAULT '',
  `IsOfficial` enum('T','F') NOT NULL DEFAULT 'F',
  `Percentage` decimal(4,1) NOT NULL DEFAULT '0.0',
  PRIMARY KEY (`CountryCode`,`Language`),
  KEY `CountryCode` (`CountryCode`),
  CONSTRAINT `countryLanguage_ibfk_1` FOREIGN KEY (`CountryCode`) REFERENCES `country` (`Code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 4)
DROP TABLE IF EXISTS continent;
CREATE TABLE continent (
	Name varchar(35) NOT NULL,
    SurfaceArea INT NOT NULL,
    SurfaceAreaPercentage decimal(4,1) NOT NULL,
    MostPopulousCity varchar(35) NOT NULL,
    primary key(Name)
)ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 5)
INSERT INTO continent (Name, SurfaceArea, SurfaceAreaPercentage, MostPopulousCity) VALUES 
	("Africa", 30370000, 20.4, "Cairo, Egypt"),
    ("Antartica", 14000000 , 9.2, "McMurdo Station"),
    ("Asia", 44579000 , 29.5, "Mumbai, India"),
    ("Europe", 10180000, 6.8, "Instanbul, Turquia"),
    ("North America", 24709000, 16.5, "Ciudad de México, Mexico"),
    ("Oceania", 8600000 , 5.9, "Sydney, Australia"),
    ("South America", 17840000, 12.0, "São Paulo, Brazil"); 

-- 6)
ALTER TABLE country
ADD CONSTRAINT fk_country_continent
FOREIGN KEY (Continent)
REFERENCES continent(Name);

-- PARTE 2 Consultas
SELECT Name, Region FROM country ORDER BY Name ASC;

SELECT Name, Population FROM city ORDER BY Population DESC LIMIT 10;

SELECT  Name, Region, SurfaceArea, GovernmentForm FROM country ORDER BY SurfaceArea LIMIT 10;

SELECT Name, IndepYear FROM country WHERE IndepYear IS NULL ORDER BY IndepYear ASC;

SELECT Language, Percentage FROM countrylanguage WHERE IsOfficial='T';