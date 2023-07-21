
SELECT
    count(1)
FROM
    OPENROWSET(
        BULK 'https://***.dfs.core.windows.net/***/**',
        FORMAT = 'CSV',
        PARSER_VERSION = '1.0'
    )WITH(PULocationID varchar(20)) AS [result]



SELECT
    count(1)
FROM
    OPENROWSET(
        BULK 'https://***.dfs.core.windows.net/***/**',
        FORMAT = 'CSV',
        PARSER_VERSION = '2.0'
    ) AS [result]
