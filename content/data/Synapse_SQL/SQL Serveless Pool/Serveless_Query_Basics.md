## Synapse Serverless SQL pool 

[Back<](https://github.com/LiliamLeme/FTALive-Sessions_Synapse_SQL/blob/main/content/data/Synapse_SQL/SQL%20Serveless%20Pool/Architecture_Review.md) -[Home](https://github.com/LiliamLeme/FTALive-Sessions_Synapse_SQL/blob/main/content/data/Synapse_SQL/SQL%20Serveless%20Pool/Agenda_serveless.md)\- [>Next](https://github.com/LiliamLeme/FTALive-Sessions_Synapse_SQL/blob/main/content/data/Synapse_SQL/SQL%20Serveless%20Pool/SynapseCETAS.md)


### Query Basics

#### Permissions required

A serverless SQL pool query reads files directly from Azure Storage. Permissions to access the files on Azure storage are controlled at two levels:

- **Storage level** - User should have permission to access underlying storage files. Your storage administrator should allow Azure AD principal to read/write files, or generate SAS key that will be used to access storage.
- **SQL service level** - User should have granted permission to read data using [external table](https://docs.microsoft.com/en-us/azure/synapse-analytics/sql/develop-tables-external-tables) or to execute the `OPENROWSET` function. 
- **[Role based access control (RBAC)](https://docs.microsoft.com/en-us/azure/role-based-access-control/overview)** enables you to assign a role to some Azure AD user in the tenant where your storage is placed. A reader must have `Storage Blob Data Reader`, `Storage Blob Data Contributor`, or `Storage Blob Data Owner` RBAC role on storage account. A user who writes data in the Azure storage must have `Storage Blob Data Contributor` or `Storage Blob Data Owner` role. Note that `Storage Owner` role does not imply that a user is also `Storage Data Owner`.
- **Access Control Lists (ACL)** enable you to define a fine grained [Read(R), Write(W), and Execute(X) permissions](https://docs.microsoft.com/en-us/azure/storage/blobs/data-lake-storage-access-control#levels-of-permission) on the files and directories in Azure storage. ACL can be assigned to Azure AD users. If readers want to read a file on a path in Azure Storage, they must have Execute(X) ACL on every folder in the file path, and Read(R) ACL on the file.
- **Shared access signature (SAS)** enables a reader to access the files on the Azure Data Lake storage using the time-limited token. 

### Query to beginners: OpenRowset, Credentials, External tables

External tables, openrowset can be used to query data on SQL Serveless Pool. Follow the most basic way to query : Openrowset

OPENROWSET function in Synapse SQL reads the content of the file(s) from a data source. The data source is an Azure storage account and it can be explicitly referenced in the `OPENROWSET` function or can be dynamically inferred from URL of the files that you want to read. The `OPENROWSET` function can optionally contain a `DATA_SOURCE` parameter to specify the data source that contains files.

Syntax Example:

```
SELECT *
FROM OPENROWSET(BULK 'http://<storage account>.dfs.core.windows.net/container/folder/*.parquet',
                FORMAT = 'PARQUET') AS [file]

or



SELECT *
FROM OPENROWSET(BULK '/folder/*.parquet',
                DATA_SOURCE='storage', --> Root URL is in LOCATION of DATA SOURCE
                FORMAT = 'PARQUET') AS [file]
```



Example: 

The following example shows how you can use multiple file/folder paths in BULK parameter:

```

SELECT   TOP 10 *
FROM 
OPENROWSET(
    BULK (
     'https://azureopendatastorage.blob.core.windows.net/censusdatacontainer/release/us_population_county/year=2000/*.parquet',
'https://azureopendatastorage.blob.core.windows.net/censusdatacontainer/release/us_population_county/year=2010/*.parquet'
   )
   , FORMAT='PARQUET'
  )AS [r]
```

The following example shows how you can query csv files.

A serverless SQL pool in Azure Synapse Analytics enables you to read UTF-8 encoded text as VARCHAR columns and this is the most optimal approach for representing UTF-8 data. But you need to be careful to avoid conversion errors that might be caused by wrong collations on VARCHAR columns. 

ref: https://techcommunity.microsoft.com/t5/azure-synapse-analytics-blog/always-use-utf-8-collations-to-read-utf-8-text-in-serverless-sql/ba-p/1883633

*Note:  When HEADER_ROW = TRUE is specified: The engine read column names from the first row, and skip this row for inferencing column types (since it's always strings). After 100 rows it will try to infer schema from that data. So if there is conversation error it will not show promptly.* 

```
SELECT
   ProductKey, OrderDateKey,DueDateKey
FROM
    OPENROWSET(
        BULK 'https://administrators.blob.core.windows.net/filesystemdatalake/CSV/FFactInternetSales_DW/part-00000-94c33f6d-53f0-442d-b93f-3f042befbc36-c000.csv',
        FORMAT = 'CSV',
        PARSER_VERSION = '2.0'
        --,HEADER_ROW=TRUE 
       ) as rows
```

This example (above) will throw an error, if the header_row is in use it will not show it promptly as mentioned on the NOTE.

CSV example:

```


--The following example reads CSV file that contains header row without specifying column names and data types:



  SELECT   *
  FROM OPENROWSET(
  BULK 'https://pandemicdatalake.blob.core.windows.net/public/curated/covid-19/ecdc_cases/latest/ecdc_cases.csv',
  FORMAT = 'CSV',
  PARSER_VERSION = '2.0',
  HEADER_ROW = TRUE) as [r]



--The following example reads CSV file that doesn't contain header row without specifying column names and data types:
  SELECT   *
  FROM OPENROWSET(
  BULK 'https://pandemicdatalake.blob.core.windows.net/public/curated/covid-19/ecdc_cases/latest/ecdc_cases.csv',
  FORMAT = 'CSV',
  PARSER_VERSION = '2.0') as [r]
```



#### Format files supported:

You have two choices for input files that contain the target data for querying. Valid values are:

- 'CSV' - Includes any delimited text file with row/column separators. Any character can be used as a field separator, such as TSV: FIELDTERMINATOR = tab.
- 'PARQUET' - Binary file in Parquet format
- 'DELTA' - A set of Parquet files organized in Delta Lake (preview) format

#### Stats

Serverless SQL pool relies on statistics to generate optimal query execution plans. Statistics are automatically created for columns in Parquet files when needed. At this moment, statistics aren't automatically created for columns in CSV files. Create statistics manually for columns that you use in queries, particularly those used in DISTINCT, JOIN, WHERE, ORDER BY, and GROUP BY

When statistics are stale, new ones will be created. The algorithm goes through the data and compares it to the current state of the dataset. Manual stats are never declared stale.

> Note:
>
> Automatic recreation of statistics is turned on for Parquet files. For CSV files, statistics will be recreated if you use OPENROWSET. You need to drop and create statistics manually for CSV external tables. Check the examples below on how to drop and create statistics.

To create statistics on a column, provide a query that returns the column for which you need statistics.

By default, if you don't specify otherwise, serverless SQL pool uses 100% of the data provided in the dataset when it creates statistics.

###### The overall flow is:

1.For the engine create a global plan and the global statistics need to be created.

2.For this, FE triggers DQP and waits for global statistics.

3.For every file, the engine creates stats.

For example, to create statistics with default options (FULLSCAN) for a year column of the dataset based on the population.csv file:

Example:

*Note: CSV sampling does not work at this time, only FULLSCAN is supported for CSV.*

```
EXEC sys.sp_drop_openrowset_statistics N'SELECT 
    year
FROM OPENROWSET(
    BULK ''https://pandemicdatalake.blob.core.windows.net/public/curated/covid-19/ecdc_cases/latest/ecdc_cases.csv'',
    FORMAT = ''CSV'',
    PARSER_VERSION = ''2.0'',
    HEADER_ROW = TRUE)
WITH (
    [country_code] VARCHAR (5) COLLATE Latin1_General_BIN2,
    [country_name] VARCHAR (100) COLLATE Latin1_General_BIN2,
    [year] smallint,
    [population] bigint
) AS [r]
'

EXEC sys.sp_create_openrowset_statistics N'SELECT 
    year
FROM OPENROWSET(
    BULK ''https://pandemicdatalake.blob.core.windows.net/public/curated/covid-19/ecdc_cases/latest/ecdc_cases.csv'',
    FORMAT = ''CSV'',
    PARSER_VERSION = ''2.0'',
    HEADER_ROW = TRUE)
WITH (
    [country_code] VARCHAR (5) COLLATE Latin1_General_BIN2,
    [country_name] VARCHAR (100) COLLATE Latin1_General_BIN2,
    [year] smallint,
    [population] bigint
) AS [r]
'

SELECT 
    year
FROM OPENROWSET(
    BULK 'https://pandemicdatalake.blob.core.windows.net/public/curated/covid-19/ecdc_cases/latest/ecdc_cases.csv',
    FORMAT = ''CSV'',
    PARSER_VERSION = ''2.0'',
    HEADER_ROW = TRUE)
WITH (
    [country_code] VARCHAR (5) COLLATE Latin1_General_BIN2,
    [country_name] VARCHAR (100) COLLATE Latin1_General_BIN2,
    [year] smallint,
    [population] bigint
) AS [r]
```

#### External tables in dedicated SQL pool and serverless SQL pool

You can use external tables to:

- Query Azure Blob Storage and Azure Data Lake Gen2 with Transact-SQL statements.
- Store query results to files in Azure Blob Storage or Azure Data Lake Storage using [CETAS](https://docs.microsoft.com/en-us/azure/synapse-analytics/sql/develop-tables-cetas).
- Import data from Azure Blob Storage and Azure Data Lake Storage and store it in a dedicated SQL pool (only Hadoop tables in dedicated pool)

Example:

https://raw.githubusercontent.com/Azure-Samples/Synapse/main/SQL/Samples/LdwSample/SampleDB.sql

```
--- SCOPED CREDENTIAL
CREATE DATABASE SCOPED CREDENTIAL [sqlondemand]
WITH IDENTITY='SHARED ACCESS SIGNATURE',  
SECRET = 'sv=2018-03-28&ss=bf&srt=sco&sp=rl&st=2019-10-14T12%3A10%3A25Z&se=2061-12-31T12%3A10%3A00Z&sig=KlSU2ullCscyTS0An0nozEpo4tO5JAgGBvw%2FJX2lguw%3D'
GO

--DATA SOURCE THAT WILL USE THE CREDENTIAL TO ACCESS
-- Create external data source secured using credential
CREATE EXTERNAL DATA SOURCE SqlOnDemandDemo WITH (
    LOCATION = 'https://sqlondemandstorage.blob.core.windows.net',
    CREDENTIAL = sqlondemand
);
GO

--EXTERNAL TABLE THAT WILL USE THE DATASOURCE TO PROVIDE THE DATA
CREATE EXTERNAL TABLE DBO.population
(
    [country_code] VARCHAR (5) COLLATE Latin1_General_BIN2,
    [country_name] VARCHAR (100) COLLATE Latin1_General_BIN2,
    [year] smallint,
    [population] bigint
)
WITH (
    LOCATION = 'csv/population/population.csv',
    DATA_SOURCE = SqlOnDemandDemo,
    FILE_FORMAT = QuotedCsvWithHeader
);
GO

--SELECT
SELECT * FROM DBO.population 


```



##### Reference:

[Control storage account access for serverless SQL pool - Azure Synapse Analytics | Microsoft Docs](https://docs.microsoft.com/en-us/azure/synapse-analytics/sql/develop-storage-files-storage-access-control?tabs=user-identity)

[Use external tables with Synapse SQL - Azure Synapse Analytics | Microsoft Docs](https://docs.microsoft.com/en-us/azure/synapse-analytics/sql/develop-tables-external-tables?tabs=hadoop)

[How to use OPENROWSET in serverless SQL pool - Azure Synapse Analytics | Microsoft Docs](https://docs.microsoft.com/en-us/azure/synapse-analytics/sql/develop-openrowset)
