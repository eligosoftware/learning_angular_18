-- Created by GitHub Copilot in SSMS - review carefully before executing

-- Deutschland einfügen
INSERT INTO dbo.Countries (CountryName, CountryCode)
VALUES ('Germany', 'DE');

DECLARE @CountryID INT = SCOPE_IDENTITY();

-- Deutsche Bundesländer einfügen
INSERT INTO dbo.Regions (CountryID, RegionName)
VALUES 
    (@CountryID, 'Baden-Württemberg'),
    (@CountryID, 'Bayern'),
    (@CountryID, 'Berlin'),
    (@CountryID, 'Brandenburg'),
    (@CountryID, 'Bremen'),
    (@CountryID, 'Hamburg'),
    (@CountryID, 'Hessen'),
    (@CountryID, 'Mecklenburg-Vorpommern'),
    (@CountryID, 'Niedersachsen'),
    (@CountryID, 'Nordrhein-Westfalen'),
    (@CountryID, 'Rheinland-Pfalz'),
    (@CountryID, 'Saarland'),
    (@CountryID, 'Sachsen'),
    (@CountryID, 'Sachsen-Anhalt'),
    (@CountryID, 'Schleswig-Holstein'),
    (@CountryID, 'Thüringen');

-- Wichtige Städte einfügen
-- Bayern
DECLARE @BayernID INT = (SELECT RegionID FROM dbo.Regions WHERE RegionName = 'Bayern' AND CountryID = @CountryID);
INSERT INTO dbo.Cities (CityName, RegionID) VALUES ('München', @BayernID), ('Nürnberg', @BayernID), ('Augsburg', @BayernID);

-- Nordrhein-Westfalen
DECLARE @NRWID INT = (SELECT RegionID FROM dbo.Regions WHERE RegionName = 'Nordrhein-Westfalen' AND CountryID = @CountryID);
INSERT INTO dbo.Cities (CityName, RegionID) VALUES ('Köln', @NRWID), ('Düsseldorf', @NRWID), ('Dortmund', @NRWID), ('Essen', @NRWID), ('Bonn', @NRWID);

-- Baden-Württemberg
DECLARE @BWID INT = (SELECT RegionID FROM dbo.Regions WHERE RegionName = 'Baden-Württemberg' AND CountryID = @CountryID);
INSERT INTO dbo.Cities (CityName, RegionID) VALUES ('Stuttgart', @BWID), ('Karlsruhe', @BWID), ('Mannheim', @BWID), ('Freiburg', @BWID);

-- Berlin
DECLARE @BerlinID INT = (SELECT RegionID FROM dbo.Regions WHERE RegionName = 'Berlin' AND CountryID = @CountryID);
INSERT INTO dbo.Cities (CityName, RegionID) VALUES ('Berlin', @BerlinID);

-- Hamburg
DECLARE @HamburgID INT = (SELECT RegionID FROM dbo.Regions WHERE RegionName = 'Hamburg' AND CountryID = @CountryID);
INSERT INTO dbo.Cities (CityName, RegionID) VALUES ('Hamburg', @HamburgID);

-- Hessen
DECLARE @HessenID INT = (SELECT RegionID FROM dbo.Regions WHERE RegionName = 'Hessen' AND CountryID = @CountryID);
INSERT INTO dbo.Cities (CityName, RegionID) VALUES ('Frankfurt am Main', @HessenID), ('Wiesbaden', @HessenID), ('Kassel', @HessenID);

-- Niedersachsen
DECLARE @NiedersachsenID INT = (SELECT RegionID FROM dbo.Regions WHERE RegionName = 'Niedersachsen' AND CountryID = @CountryID);
INSERT INTO dbo.Cities (CityName, RegionID) VALUES ('Hannover', @NiedersachsenID), ('Braunschweig', @NiedersachsenID), ('Oldenburg', @NiedersachsenID);

-- Sachsen
DECLARE @SachsenID INT = (SELECT RegionID FROM dbo.Regions WHERE RegionName = 'Sachsen' AND CountryID = @CountryID);
INSERT INTO dbo.Cities (CityName, RegionID) VALUES ('Dresden', @SachsenID), ('Leipzig', @SachsenID), ('Chemnitz', @SachsenID);

-- Bremen
DECLARE @BremenID INT = (SELECT RegionID FROM dbo.Regions WHERE RegionName = 'Bremen' AND CountryID = @CountryID);
INSERT INTO dbo.Cities (CityName, RegionID) VALUES ('Bremen', @BremenID);

-- Beispiel-Bushaltestellen für einige Städte
INSERT INTO dbo.BusStations (CityID, StationName, Address)
SELECT CityID, CityName + ' Hauptbahnhof', NULL FROM dbo.Cities WHERE CityName IN ('Berlin', 'München', 'Hamburg', 'Köln', 'Frankfurt am Main');

INSERT INTO dbo.BusStations (CityID, StationName, Address)
SELECT CityID, CityName + ' ZOB', NULL FROM dbo.Cities WHERE CityName IN ('Berlin', 'München', 'Hamburg', 'Köln', 'Frankfurt am Main');