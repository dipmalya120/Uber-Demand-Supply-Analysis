-- Step 1: Create the ProjectDB database
CREATE DATABASE ProjectDB;
GO

-- Step 2: Switch context to the new database
USE ProjectDB;
GO

-- Step 3: Create the table [Uber Request Data]
CREATE TABLE [Uber Request Data] (
    [Request id] INT NOT NULL PRIMARY KEY,         -- Unique ID for each ride request (Required, must be unique)
    [Pickup point] VARCHAR(255),          -- Location of rider pickup (Required)
    [Driver id] INT,                               -- Driver's ID (Optional, may be NULL if unassigned)
    [Status] VARCHAR(50),                 -- Request status (e.g., Completed, Cancelled)
    [Request timestamp] DATETIME,         -- When the request was made (Required)
    [Drop timestamp] DATETIME                     -- When the ride ended (Nullable if not completed)
);

BULK INSERT [Uber Request Data]
FROM 'C:\Users\Dipmalya.Chakraborty\Documents\Projects\Uber Request Data.csv'
WITH (
    FIRSTROW = 2,              -- Skip header row
    FIELDTERMINATOR = ',',     -- Comma-separated
    ROWTERMINATOR = '\n',      -- New line ends each row
    TABLOCK
);
 