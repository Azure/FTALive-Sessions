## Synapse Serverless SQL pool 

[Back<](https://github.com/LiliamLeme/FTALive-Sessions_Synapse_SQL/blob/main/content/data/Synapse_SQL/SQL%20Serveless%20Pool/Serveless_Query_Basics.md) -[Home](https://github.com/LiliamLeme/FTALive-Sessions_Synapse_SQL/blob/main/content/data/Synapse_SQL/SQL%20Serveless%20Pool/Agenda_serveless.md)\- [>Next](https://github.com/LiliamLeme/FTALive-Sessions_Synapse_SQL/blob/main/content/data/Synapse_SQL/SQL%20Serveless%20Pool/FilenameFilepath.md)

### CETAS

When using serverless SQL pool, CETAS is used to create an external table and export query results to Azure Storage Blob or Azure Data Lake Storage Gen2.

**Example**: 

These example use CETAS to save the results of the super join in a folder configured in the data source configuration. Hence, this sample relies on the credential, data source, and external file format created previously.

https://raw.githubusercontent.com/Azure-Samples/Synapse/main/SQL/Samples/LdwSample/SampleDB.sql

1. Lets first check the time it takes to run this query using the public repository:

   ```
   \------------------------------------------------------------------------------
   --Super Join
   --+-16SECONDS
   \------------------------------------------------------------------------------
   SELECT top 10000* 
   FROM 
   (
     SELECT *
     FROM OPENROWSET(
     BULK (
        'https://azureopendatastorage.blob.core.windows.net/censusdatacontainer/release/us_population/year=2010/*.parquet'  )
       , FORMAT='PARQUET'
     )AS [us_population] 
   ) AS us_population
   INNER jOIN
   (
     SELECT *
     FROM 
     OPENROWSET(
     BULK (
       'https://azureopendatastorage.blob.core.windows.net/censusdatacontainer/release/us_population_county/year=2010/*.parquet'  		)
       , FORMAT='PARQUET'
     )AS [us_population_county]  
   ) AS us_population_county
   ON us_population_county.countyName = us_population.countyName
   ```

   2. Now, lets check  how much time can be saved from the query execution while using CETAS

   ```
   \------------------------------------------------------------------------------
   ---CETAS
   \------------------------------------------------------------------------------
   
   --Format for my CETAS
     CREATE EXTERNAL FILE FORMAT Parquet_file 
     WITH (   FORMAT_TYPE = PARQUET   )
   \---------------------------------------
   
   --Auth
   CREATE DATABASE SCOPED CREDENTIAL MSI WITH IDENTITY = 'Managed Identity'
   \---------------------------------------
   
   --Storage path where the result set will be materialized
     CREATE EXTERNAL DATA SOURCE LLive
     WITH (
     LOCATION = 'https://StorageName.dfs.core.windows.net/Container/LLive/CETAS',
     CREDENTIAL = [MSI]
     ) 
   
     \---------------------------------------
     --CETAS DDL
     CREATE EXTERNAL TABLE FactSale_CETAS
     WITH (
       LOCATION = 'FactSale_CETAS/',
       DATA_SOURCE = LLive,
       FILE_FORMAT = Parquet_file
         ) 
     AS
     SELECT top 10000 us_population.decennialTime
             , us_population.StateName
             , us_population.countyName
             , us_population.population
             , us_population.race 
     FROM 
     (
       SELECT  *    FROM 
       OPENROWSET(
        BULK (
          'https://azureopendatastorage.blob.core.windows.net/censusdatacontainer/release/us_population/year=2010/*.parquet'  )
         , FORMAT='PARQUET'
       )AS [us_population] 
     ) AS us_population
     INNER jOIN
     (
       SELECT *   FROM 
       OPENROWSET(
         BULK (               	'https://azureopendatastorage.blob.core.windows.net/censusdatacontainer/release/us_population_county/year=2010/*.parquet'  )
        , FORMAT='PARQUET'
      )AS [us_population_county]  
     ) AS us_population_county
     ON us_population_county.countyName = us_population.countyName
   
   \--------------------------
   --Query
    SELECT *   FROM  FactSale_CETAS
   
   \--------------------------
   --Clean
   --Need to drop files on the Storage manually
   
    DROP EXTERNAL TABLE FactSale_CETAS
   ```

   

   #### Supported Data Types:

   CETAS can be used to store result sets with following SQL data types:

   - binary

   - varbinary

   - char

   - varchar

   - nchar

   - nvarchar

   - smalldate

   - date

   - datetime

   - datetime2

   - datetimeoffset

   - time

   - decimal

   - numeric

   - float

   - real

   - bigint

   - tinyint

   - smallint

   - int

   - bigint

   - bit

   - money

   - smallmoney

   - uniqueidentifier

     

   ##### **Conclusion**:

   CETAS is an easy way to consolidate information for an intermediate query step ( when a sub-query result will be used to join other tables in a complex query join) or an even query with multiple aggregations. It improves the performance and cost, as subsequent queries will process fewer data

##### Reference:

[CREATE EXTERNAL TABLE AS SELECT (CETAS) in Synapse SQL - Azure Synapse Analytics | Microsoft Docs](https://docs.microsoft.com/en-us/azure/synapse-analytics/sql/develop-tables-cetas)

[How to use CETAS on serverless SQL pool to improve performance and automatically recreate it - Microsoft Tech Community](https://techcommunity.microsoft.com/t5/azure-synapse-analytics-blog/how-to-use-cetas-on-serverless-sql-pool-to-improve-performance/ba-p/3548040)



