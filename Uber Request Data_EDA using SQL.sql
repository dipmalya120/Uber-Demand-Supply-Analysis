USE ProjectDB
GO

-- Viewing Uber Request Data
SELECT * FROM [Uber Request Data];

-- Total Trip Requests
SELECT COUNT(*) AS [Total_Trip_Requests] FROM [Uber Request Data];

-- Total Trip Requests by Trip Status
SELECT 
    [Status],
    COUNT(*) AS Total_Trips,
    FORMAT(100.0 * COUNT(*) / SUM(COUNT(*)) OVER (), 'N0') + '%' AS Percentage
FROM [Uber Request Data]
GROUP BY [Status]
ORDER BY Percentage DESC;

-- Trip Requests by Pickup Point
SELECT 
    [Pickup_point],
    COUNT(*) AS Total_Trips,
    FORMAT(100.0 * COUNT(*) / SUM(COUNT(*)) OVER (), 'N0') + '%' AS Percentage
FROM [Uber Request Data]
GROUP BY [Pickup_point]
ORDER BY Percentage DESC;

-- Distribution of Trip Requests by Trip Status and Pickup Point
SELECT 
    [Status],
    SUM(CASE WHEN [Pickup_point] = 'Airport' THEN 1 ELSE 0 END) AS Airport,
    SUM(CASE WHEN [Pickup_point] = 'City' THEN 1 ELSE 0 END) AS City
FROM [Uber Request Data]
GROUP BY [Status];

-- Percentage of the previous distribution
SELECT 
    [Status],
    FORMAT(100.0 * SUM(CASE WHEN [Pickup_point] = 'Airport' THEN 1 ELSE 0 END) 
           / NULLIF(SUM(1), 0), 'N0') + '%' AS Airport,
    FORMAT(100.0 * SUM(CASE WHEN [Pickup_point] = 'City' THEN 1 ELSE 0 END) 
           / NULLIF(SUM(1), 0), 'N0') + '%' AS City
FROM [Uber Request Data]
GROUP BY [Status];

-- Viewing dimension table Hourly_Bins
SELECT * FROM [Hourly_Bins];

-- Distribution of Trip Requests by Trip Status throughout the day
SELECT 
    hb.[Start_Hour],
    hb.[End_Hour],
    COUNT(CASE 
              WHEN urd.[Status] = 'Trip Completed' 
                   AND CAST(urd.[Request_timestamp] AS TIME) >= hb.[Start_Hour] 
                   AND CAST(urd.[Request_timestamp] AS TIME) < hb.[End_Hour] 
                   THEN 1 
         END) AS [Trip Completed],
    COUNT(CASE 
              WHEN urd.[Status] = 'Cancelled' 
                   AND CAST(urd.[Request_timestamp] AS TIME) >= hb.[Start_Hour] 
                   AND CAST(urd.[Request_timestamp] AS TIME) < hb.[End_Hour] 
                   THEN 1 
         END) AS [Cancelled],
    COUNT(CASE 
              WHEN urd.[Status] = 'No Cars Available' 
                   AND CAST(urd.[Request_timestamp] AS TIME) >= hb.[Start_Hour] 
                   AND CAST(urd.[Request_timestamp] AS TIME) < hb.[End_Hour] 
                   THEN 1 
         END) AS [No Cars Available]
FROM Hourly_Bins hb
LEFT JOIN [Uber Request Data] urd
    ON (CAST(urd.[Request_timestamp] AS TIME) >= hb.[Start_Hour]
        AND CAST(urd.[Request_timestamp] AS TIME) < hb.[End_Hour])
GROUP BY hb.[Start_Hour], hb.[End_Hour]
ORDER BY hb.[Start_Hour];

-- Above distribution for Pickup_point as City
SELECT 
    hb.[Start_Hour],
    hb.[End_Hour],
    COUNT(CASE 
              WHEN urd.[Status] = 'Trip Completed' 
                   AND CAST(urd.[Request_timestamp] AS TIME) >= hb.[Start_Hour] 
                   AND CAST(urd.[Request_timestamp] AS TIME) < hb.[End_Hour] 
                   AND urd.[Pickup_point] = 'City'
              THEN 1 
         END) AS [Trip Completed],
    COUNT(CASE 
              WHEN urd.[Status] = 'Cancelled' 
                   AND CAST(urd.[Request_timestamp] AS TIME) >= hb.[Start_Hour] 
                   AND CAST(urd.[Request_timestamp] AS TIME) < hb.[End_Hour] 
                   AND urd.[Pickup_point] = 'City'
              THEN 1 
         END) AS [Cancelled],
    COUNT(CASE 
              WHEN urd.[Status] = 'No Cars Available' 
                   AND CAST(urd.[Request_timestamp] AS TIME) >= hb.[Start_Hour] 
                   AND CAST(urd.[Request_timestamp] AS TIME) < hb.[End_Hour] 
                   AND urd.[Pickup_point] = 'City'
              THEN 1 
         END) AS [No Cars Available]
FROM Hourly_Bins hb
LEFT JOIN [Uber Request Data] urd
    ON CAST(urd.[Request_timestamp] AS TIME) >= hb.[Start_Hour]
   AND CAST(urd.[Request_timestamp] AS TIME) < hb.[End_Hour]
GROUP BY hb.[Start_Hour], hb.[End_Hour]
ORDER BY hb.[Start_Hour];

-- Above distribution for Pickup_point as City
SELECT 
    hb.[Start_Hour],
    hb.[End_Hour],
    COUNT(CASE 
              WHEN urd.[Status] = 'Trip Completed' 
                   AND CAST(urd.[Request_timestamp] AS TIME) >= hb.[Start_Hour] 
                   AND CAST(urd.[Request_timestamp] AS TIME) < hb.[End_Hour] 
                   AND urd.[Pickup_point] = 'Airport'
              THEN 1 
         END) AS [Trip Completed],
    COUNT(CASE 
              WHEN urd.[Status] = 'Cancelled' 
                   AND CAST(urd.[Request_timestamp] AS TIME) >= hb.[Start_Hour] 
                   AND CAST(urd.[Request_timestamp] AS TIME) < hb.[End_Hour] 
                   AND urd.[Pickup_point] = 'Airport'
              THEN 1 
         END) AS [Cancelled],
    COUNT(CASE 
              WHEN urd.[Status] = 'No Cars Available' 
                   AND CAST(urd.[Request_timestamp] AS TIME) >= hb.[Start_Hour] 
                   AND CAST(urd.[Request_timestamp] AS TIME) < hb.[End_Hour] 
                   AND urd.[Pickup_point] = 'Airport'
              THEN 1 
         END) AS [No Cars Available]
FROM Hourly_Bins hb
LEFT JOIN [Uber Request Data] urd
    ON CAST(urd.[Request_timestamp] AS TIME) >= hb.[Start_Hour]
   AND CAST(urd.[Request_timestamp] AS TIME) < hb.[End_Hour]
GROUP BY hb.[Start_Hour], hb.[End_Hour]
ORDER BY hb.[Start_Hour];

-- Performance of Drivers
SELECT 
    [Driver_id],
    COUNT(CASE WHEN [Status] = 'Trip Completed' THEN 1 END) AS [Trip Completed],
    COUNT(CASE WHEN [Status] = 'Cancelled' THEN 1 END) AS [Cancelled],
    ROUND(
        CAST(COUNT(CASE WHEN [Status] = 'Trip Completed' THEN 1 END) AS FLOAT) * 100.0 /
        NULLIF(COUNT(*) * 1.0, 0), 
        2
    ) AS Completion_rate
FROM [Uber Request Data]
WHERE [Driver_id] IS NOT NULL
GROUP BY [Driver_id]
ORDER BY Completion_rate DESC;