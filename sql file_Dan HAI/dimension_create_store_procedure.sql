CREATE PROCEDURE PopulateDimensionTables
AS
BEGIN
    SET NOCOUNT ON;

    -- Insert into Brand table
    INSERT INTO [dw].[Brand] (BrandName)
    SELECT DISTINCT brand
    FROM [tempstage].[FuelPrices] as source
    WHERE brand IS NOT NULL
        AND NOT EXISTS (SELECT 1 FROM [dw].[Brand] b WHERE b.BrandName = source.brand);

    -- Insert into Site table
    INSERT INTO [dw].[Site] (TradingName, Location, Address, Phone, Latitude, Longitude)
    SELECT DISTINCT [trading-name], Location, Address, Phone, Latitude, Longitude
    FROM [tempstage].[FuelPrices] as source
    WHERE NOT EXISTS (
        SELECT 1 FROM [dw].[Site] s
        WHERE s.TradingName = source.[trading-name]
        AND s.Location = source.Location
        AND s.Address = source.Address -- need to include 3 attributes info as trading name + location + address as unique combination
    );

    -- Insert into SiteFeatures table
    INSERT INTO [dw].[SiteFeatures] (SiteID, SiteFeatures)
    SELECT s.SiteID, source.[site-features]
    FROM [tempstage].[FuelPrices] as source
    INNER JOIN [dw].[Site] s ON source.[trading-name] = s.TradingName AND source.Location = s.Location AND source.Address = s.Address -- need to include 3 attributes info as trading name + location + address as unique combination
    WHERE source.[site-features] IS NOT NULL
    AND NOT EXISTS (
        SELECT 1 FROM [dw].[SiteFeatures] sf
        WHERE sf.SiteID = s.SiteID
        AND sf.SiteFeatures = source.[site-features]
    );

    SET NOCOUNT OFF;
END
GO
