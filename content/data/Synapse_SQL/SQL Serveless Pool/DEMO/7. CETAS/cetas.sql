USE demo1
GO

CREATE EXTERNAL DATA SOURCE ds_taxi WITH (LOCATION='https://***.dfs.core.windows.net/*/')
GO

CREATE EXTERNAL FILE FORMAT ff_parquet WITH (FORMAT_TYPE=PARQUET)
GO

CREATE EXTERNAL TABLE [Taxi_Agg_2] 
WITH
(
	LOCATION = 'Taxi_Agg/2',
	DATA_SOURCE = ds_taxi,
	FILE_FORMAT = ff_parquet,
)
AS
SELECT
    RateCodeID, 
	SUM(CAST(Passenger_Count AS BIGINT)) AS Passenger_Count
FROM
    OPENROWSET(
        BULK 'https://***.dfs.core.windows.net/*/*/*.parquet',
        FORMAT='PARQUET'
    ) AS [result]
GROUP BY RateCodeID
GO

SELECT * FROM Taxi_AGG_2