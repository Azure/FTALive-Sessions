---- GO TO DATALAKE AND SHOW THE DIFFERENT FILES


/*

               ************
               ####....#.
             #..###.....##....
             ###.......######              ###            ###
                ...........               #...#          #...#
               ##*#######                 #.#.#          #.#.#
            ####*******######             #.#.#          #.#.#
           ...#***.****.*###....          #...#          #...#
           ....**********##.....           ###            ###
           ....****    *****....
             ####        ####
           ######        ######
##############################################################
#...#......#.##...#......#.##...#......#.##------------------#
###########################################------------------#
#..#....#....##..#....#....##..#....#....#####################
##########################################    #----------#
#.....#......##.....#......##.....#......#    #----------#
##########################################    #----------#
#.#..#....#..##.#..#....#..##.#..#....#..#    #----------#
##########################################    ############

*/


------- Query CSV File

SELECT
    TOP 100 *
FROM
    OPENROWSET(
        BULK 'https://***.dfs.core.windows.net/**/.csv',
        FORMAT = 'CSV',
        PARSER_VERSION='2.0'
    ) AS [result]



------- We need a header row

SELECT
    TOP 100 *
FROM
    OPENROWSET(
        BULK 'https://***.dfs.core.windows.net/***/***.csv',
        FORMAT = 'CSV',
        PARSER_VERSION='2.0',
------------------------------
         HEADER_ROW = TRUE

------------------------------
    ) AS [result]

---- THIS FAILS BECAUSE OF C18 And C19
---- LETS LIMIT THE AMOUNT OF COLUMNS

SELECT
    TOP 100 *
FROM
    OPENROWSET(
        BULK 'https://**.dfs.core.windows.net/***/*.csv',
        FORMAT = 'CSV',
        PARSER_VERSION='2.0',
------------------------------
         HEADER_ROW = TRUE
------------------------------
    )WITH (
        VendorID int 1,
        passenger_count int 4
    ) AS [result]


------- Query JSON File

SELECT 
    JSON_VALUE(jsonContent, '$.meta.view.name' ) as [Name],
    JSON_VALUE(jsonContent, '$.meta.view.publicationStage' ) as [publicationStage],    
    JSON_QUERY(jsonContent, '$.meta.view.columns') AS JSONQ
FROM
    OPENROWSET(
        BULK 'https://***.dfs.core.windows.net/*.json',
        FORMAT = 'CSV',
        FIELDQUOTE = '0x0b',
        FIELDTERMINATOR ='0x0b',
        ROWTERMINATOR = '0x0b'
    )
    WITH (
        jsonContent varchar(MAX)
    ) AS [result]


------- Query Parquet File

SELECT
    TOP 100 *
FROM
    OPENROWSET(
        BULK 'https://***.dfs.core.windows.net/***.parquet',
        FORMAT='PARQUET'
    ) AS [result];
GO


------- Create View Based on Openrowset
USE Demo1;
GO
DROP VIEW IF EXISTS dbo.NYTParquet;
GO
CREATE VIEW dbo.NYTParquet
AS
SELECT
     *
FROM
    OPENROWSET(
        BULK 'https://***.dfs.core.windows.net/**.parquet',
        FORMAT='PARQUET'
    ) AS [result]

------- Query the View

select top 100 * from dbo.NYTParquet




