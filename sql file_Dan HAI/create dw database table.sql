-- create table Brand
CREATE TABLE [dw].[Brand] (
    BrandID INT IDENTITY(1,1) PRIMARY KEY CLUSTERED,
    BrandName NVARCHAR(50)
);

-- create table Site
CREATE TABLE [dw].[Site] (
    SiteID INT IDENTITY(1,1) PRIMARY KEY CLUSTERED,
    TradingName NVARCHAR(100),
    Location NVARCHAR(100),
    Address NVARCHAR(255),
    Phone NVARCHAR(20),
    Latitude DECIMAL(10, 6),
    Longitude DECIMAL(10, 6),
    FullAddress AS (CONCAT(Address, ', ', Location)) PERSISTED
);


-- create table SiteFeatures
CREATE TABLE [dw].[SiteFeatures] (
    SiteFeatureID INT IDENTITY(1,1) PRIMARY KEY CLUSTERED,
    SiteID INT FOREIGN KEY REFERENCES [dw].[Site](SiteID),
    SiteFeatures NVARCHAR(MAX)
);

-- create fact table FuelPrice
CREATE TABLE [dw].[FuelPrice] (
    FuelPriceID INT IDENTITY(1,1) PRIMARY KEY,
    BrandID INT,
    SiteID INT,
    DateID INT,
    Price DECIMAL(10, 2),
    DateCreated DATETIME DEFAULT GETDATE(),
    DateModified DATETIME NULL
);