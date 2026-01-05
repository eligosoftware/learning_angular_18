-- Tabelle für Länder
CREATE TABLE dbo.Countries
(
    CountryID INT PRIMARY KEY IDENTITY(1,1),
    CountryName NVARCHAR(100) NOT NULL UNIQUE,
    CountryCode NCHAR(2) NULL -- ISO 3166-1 alpha-2
);

-- Tabelle für Regionen
CREATE TABLE dbo.Regions
(
    RegionID INT PRIMARY KEY IDENTITY(1,1),
    CountryID INT NOT NULL,
    RegionName NVARCHAR(100) NOT NULL,
    
    CONSTRAINT FK_Regions_Countries 
        FOREIGN KEY (CountryID) REFERENCES dbo.Countries(CountryID),
    CONSTRAINT UQ_Region_Per_Country 
        UNIQUE (CountryID, RegionName)
);
-- Tabelle für Städte
CREATE TABLE dbo.Cities
(
    CityID INT PRIMARY KEY IDENTITY(1,1),
    CityName NVARCHAR(100) NOT NULL,
    RegionID INT NOT NULL,
    
    CONSTRAINT FK_Cities_Regions 
        FOREIGN KEY (RegionID) REFERENCES dbo.Regions(RegionID),
    CONSTRAINT UQ_City_Per_Region 
        UNIQUE (RegionID, CityName)
);
-- Tabelle für Bushaltestellen/Stationen
CREATE TABLE dbo.BusStations
(
    StationID INT PRIMARY KEY IDENTITY(1,1),
    CityID INT NOT NULL,
    StationName NVARCHAR(200) NOT NULL,
    Address NVARCHAR(300) NULL,
    
    CONSTRAINT FK_BusStations_Cities 
        FOREIGN KEY (CityID) REFERENCES dbo.Cities(CityID)
);

-- Tabelle für Routen zwischen Städten
CREATE TABLE dbo.Routes
(
    RouteID INT PRIMARY KEY IDENTITY(1,1),
    DepartureCityID INT NOT NULL,
    ArrivalCityID INT NOT NULL,
    DepartureStationID INT NOT NULL,
    ArrivalStationID INT NOT NULL,
    
    CONSTRAINT FK_Routes_DepartureCity 
        FOREIGN KEY (DepartureCityID) REFERENCES dbo.Cities(CityID),
    CONSTRAINT FK_Routes_ArrivalCity 
        FOREIGN KEY (ArrivalCityID) REFERENCES dbo.Cities(CityID),
    CONSTRAINT FK_Routes_DepartureStation 
        FOREIGN KEY (DepartureStationID) REFERENCES dbo.BusStations(StationID),
    CONSTRAINT FK_Routes_ArrivalStation 
        FOREIGN KEY (ArrivalStationID) REFERENCES dbo.BusStations(StationID)
);

-- Tabelle für verfügbare Tickets
CREATE TABLE dbo.AvailableTickets
(
    TicketID INT PRIMARY KEY IDENTITY(1,1),
    RouteID INT NOT NULL,
    DepartureDate DATE NOT NULL,
    DepartureTime TIME NOT NULL,
    AvailableSeats INT NOT NULL,
    Price DECIMAL(10,2) NOT NULL,
    BusNumber NVARCHAR(50) NOT NULL,
    
    CONSTRAINT FK_AvailableTickets_Routes 
        FOREIGN KEY (RouteID) REFERENCES dbo.Routes(RouteID),
    
    INDEX IX_Search NONCLUSTERED (RouteID, DepartureDate)
);