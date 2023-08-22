---- Switch to Notebook Show Statistics of that file


---- Read two rowgroup
SELECT
    sum(Total_amount),vendorID,cast(tpep_pickup_datetime as date)
FROM
    OPENROWSET(
        BULK 'https://***.dfs.core.windows.net/***/PULocIDOrderParquet.parquet',
        FORMAT='PARQUET'
    ) AS [result]
    where PULocationID = 3
    group by vendorID,cast(tpep_pickup_datetime as date)


----- Read one rowgroup
SELECT
   sum(Total_amount),vendorID,cast(tpep_pickup_datetime as date)
FROM
    OPENROWSET(
        BULK 'https://***.dfs.core.windows.net/***/PULocIDOrderParquet.parquet',
        FORMAT='PARQUET'
    ) AS [result]
    where PULocationID = 2    
GROUP BY vendorID,cast(tpep_pickup_datetime as date);
GO




---- SWITCH TO SSMS!!!!!!!!!!!!!



