--- Reading a full CSV Folder
SELECT
    count(1)
FROM
    OPENROWSET(
        BULK 'https://***.dfs.core.windows.net/***/**',
        FORMAT = 'CSV',
        PARSER_VERSION = '2.0'
    ) AS [result]

GO

--- Reading a full Parquet folder same data
SELECT
    count(1)
FROM
    OPENROWSET(
        BULK 'https://***.dfs.core.windows.net/raw/TaxiNP/**',
        FORMAT = 'PARQUET'
    ) AS [result]


--- Reading a JSON File
SELECT 
    JSON_VALUE(jsonContent, '$.meta.view.name' ) as [Name],
    JSON_VALUE(jsonContent, '$.meta.view.publicationStage' ) as [publicationStage],    
    JSON_QUERY(jsonContent, '$.meta.view.columns') AS JSONQ
FROM
    OPENROWSET(
        BULK 'https://***.dfs.core.windows.net/precon/Demo2/NYTJSON.json',
        FORMAT = 'CSV',
        FIELDQUOTE = '0x0b',
        FIELDTERMINATOR ='0x0b',
        ROWTERMINATOR = '0x0b'
    )
    WITH (
        jsonContent varchar(MAX)
    ) AS [result]