-- Created by GitHub Copilot in SSMS - review carefully before executing

-- 100 zufällige Tickets mit realistischen Preisen erstellen
DECLARE @Counter INT = 1;
DECLARE @RouteCount INT;
DECLARE @RandomRouteID INT;
DECLARE @RandomDate DATE;
DECLARE @RandomTime TIME;
DECLARE @RandomSeats INT;
DECLARE @BasePrice DECIMAL(10,2);

-- Zuerst einige Beispielrouten erstellen
INSERT INTO dbo.Routes (DepartureCityID, ArrivalCityID, DepartureStationID, ArrivalStationID)
SELECT 
    ds.CityID,
    as_city.CityID,
    ds.StationID,
    as_station.StationID
FROM dbo.BusStations ds
CROSS JOIN (
    SELECT TOP 5 CityID FROM dbo.Cities WHERE CityID != (SELECT TOP 1 CityID FROM dbo.BusStations WHERE StationID = 1)
) as_city
CROSS JOIN dbo.BusStations as_station
WHERE ds.StationName LIKE '%ZOB%'
AND as_station.CityID = as_city.CityID
AND as_station.StationName LIKE '%ZOB%';

-- Zufällige Tickets generieren
WHILE @Counter <= 100
BEGIN
    -- Zufällige Route auswählen
    SELECT TOP 1 @RandomRouteID = RouteID 
    FROM dbo.Routes 
    ORDER BY NEWID();
    
    -- Zufälliges Datum (nächste 30 Tage)
    SET @RandomDate = DATEADD(DAY, ABS(CHECKSUM(NEWID()) % 30), GETDATE());
    
    -- Zufällige Uhrzeit zwischen 6:00 und 22:00
    SET @RandomTime = DATEADD(MINUTE, (ABS(CHECKSUM(NEWID()) % 960) + 360), '00:00:00');
    
    -- Zufällige Sitzanzahl (20-50)
    SET @RandomSeats = (ABS(CHECKSUM(NEWID()) % 31) + 20);
    
    -- Preis basierend auf Distanz berechnen (15-80 Euro)
    SET @BasePrice = (ABS(CHECKSUM(NEWID()) % 66) + 15) + (CAST(ABS(CHECKSUM(NEWID()) % 100) AS DECIMAL(10,2)) / 100);
    
    INSERT INTO dbo.AvailableTickets (RouteID, DepartureDate, DepartureTime, AvailableSeats, Price, BusNumber)
    VALUES (
        @RandomRouteID,
        @RandomDate,
        @RandomTime,
        @RandomSeats,
        @BasePrice,
        'BUS' + RIGHT('000' + CAST(@Counter AS VARCHAR(3)), 3)
    );
    
    SET @Counter = @Counter + 1;
END;