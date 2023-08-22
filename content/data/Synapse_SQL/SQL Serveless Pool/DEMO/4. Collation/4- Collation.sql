
SELECT
    sum(cast(total_amount as decimal(10,2))), vendorID
FROM
    OPENROWSET(
        BULK 'https://***.dfs.core.windows.net/***/**',
        FORMAT = 'PARQUET'
    ) WITH(
    total_amount varchar(200) COLLATE SQL_Latin1_General_CP1_CI_AS, 
    vendorID varchar(200) COLLATE SQL_Latin1_General_CP1_CI_AS, 
    PULocationID varchar(200) COLLATE SQL_Latin1_General_CP1_CI_AS 
    )AS [result]
    where PULocationID = 62
group by vendorID


SELECT
    sum(cast(total_amount as decimal(10,2))), vendorID
FROM
    OPENROWSET(
        BULK 'https://***.dfs.core.windows.net/***/**',
        FORMAT = 'PARQUET'
    ) WITH(
    total_amount varchar(200) COLLATE Latin1_General_100_BIN2_UTF8, 
    vendorID varchar(200) COLLATE Latin1_General_100_BIN2_UTF8, 
    PULocationID varchar(200) COLLATE Latin1_General_100_BIN2_UTF8 
    )AS [result]
    where PULocationID = 62
group by vendorID