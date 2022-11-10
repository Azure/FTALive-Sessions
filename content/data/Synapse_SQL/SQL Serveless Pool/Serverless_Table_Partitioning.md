## Synapse Serverless SQL pool - Partitioned Data

Partitioning can improve scalability, reduce contention, and optimize performance. 
It can also provide a mechanism for dividing data by usage pattern. For example, you can archive older data in cheaper data storage.

## Why Partition data ?

- Improve performance
  - It reduce the I/O and the cost
- Improve Security
  - You can separate sensitive and nonsensitive data into different partitions and apply different security controls
- Improve flexibility
  - maximize administrative efficiency. For example, you can define different strategies for management, monitoring, backup and restore and other administrative tasks based on the importance of the data in each partition.


## Partitioning data with Synapse

Synapse Serverless SQL Pool can benefit from partitioning, it reduce the I/O and the cost($)

### Can Serverless SQL Pool create partitioned table ?

No, you can materialize results from your queries using Serverless SQL Pool but [CREATE EXTERNAL TABLE AS SELECT](https://learn.microsoft.com/en-us/azure/synapse-analytics/sql/create-use-external-tables) only allows you to control the destination folder and not subfolders/files.


### What if we use Synapse Pipeline/DataFlow or Spark ?

Spark and ADF/Synapse pipelines with [DataFlow](https://learn.microsoft.com/en-us/azure/synapse-analytics/concepts-data-flow-overview) can be used to create partitioned data.  

![text](.\DataFlow.png?raw=true)

FactInternetSales (Source) = is the original folder wich contains multiple parquet files, not partitioned. Parquet files only have OrderDateKey field but not YEAR and MONTH columns

![text](.\Not_Partitioned_Folder.png?raw=true)

YearMonth (Derived Columns) = Add the YEAR and MONTH columns calculating values from OrderDataKey original column

![text](.\DerivedColumn.png?raw=true)

FactInternetSalesPartitioned (Destination) = Writes data using partitions by YEAR and MONTH

![text](.\PartitioningDestination.png?raw=true)

And this is the result

![text](.\Partitioned_Folder.png?raw=true)


### Querying Partitioned data with Synapse Serverless SQL Pool

Now we have the not partitioned and partitioned table, we can test how Synapse Serverless SQL Pool works.

``` sql
/**********************************************************************************************************
Step 1 of 5
Create a new Serverless DB
**********************************************************************************************************/

USE master
GO

CREATE DATABASE FTALive_Serverless
GO

/**********************************************************************************************************
Step 2 of 5
Querying not partitioned folder and partitioned folder with simple filter
**********************************************************************************************************/
USE FTALive_Serverless
GO

--Filtering the /FACTINTERNETSALES/*.parquet table, all files will be scanned increasing the I/O and the cost ($) for the execution
SELECT Top 10 *
FROM
    OPENROWSET(
        BULK 'https://datalake1lf.dfs.core.windows.net/ftalive-serverless/FACTINTERNETSALES/*.parquet',
        FORMAT = 'PARQUET'
    ) r
WHERE ORDERDATEKEY = 20211025

--Filtering the /FACTINTERNETSALES_PARTITIONED/*.parquet table, all files will be scanned increasing the I/O and the cost ($) for the execution
SELECT Top 10 *
FROM
    OPENROWSET(
        BULK 'https://datalake1lf.dfs.core.windows.net/ftalive-serverless/FACTINTERNETSALES_PARTITIONED/*/*/*.parquet',
        FORMAT = 'PARQUET'
    ) r
WHERE ORDERDATEKEY = 20211025


/**********************************************************************************************************
Step 3 of 5
Metadata functions - There are functions we can leverage on to retrieve info about folders/Subfolders and files
**********************************************************************************************************/

-- but still, this query will not benefit from partition elimination
SELECT Top 10 r.filepath(1) [Year],r.filepath(2) [Month], r.filename() [FileName],*
FROM
    OPENROWSET(
        BULK 'https://datalake1lf.dfs.core.windows.net/ftalive-serverless/FACTINTERNETSALES_PARTITIONED/*/*/*.parquet',
        FORMAT = 'PARQUET'
    ) r
WHERE ORDERDATEKEY = 20211025

-- Adding the filters using the filepath function, this allows partition elimination and the query is saving tons of I/O and $
-- but you have to provide the folder name, not the [YEAR] and [MONTH] columns (Not available in our parquet)
SELECT Top 10 r.filepath(1) [Year],r.filepath(2) [Month], r.filename() [FileName],*
FROM
    OPENROWSET(
        BULK 'https://datalake1lf.dfs.core.windows.net/ftalive-serverless/FACTINTERNETSALES_PARTITIONED/*/*/*.parquet',
        FORMAT = 'PARQUET'
    ) r
WHERE ORDERDATEKEY = 20211025
	and r.filepath(1)='YEAR=2021' --(1) first level -> Year -> physical name of the folder
	AND r.filepath(2)='MONTH=10' --(2) second level -> Month -> physical name of the folder



/**********************************************************************************************************
Step 4 of 5
What about External table ?
**********************************************************************************************************/
CREATE MASTER KEY ENCRYPTION BY PASSWORD = 'Pa$$w0rd1!@'
GO

-- Configuring Managed Identity
CREATE DATABASE SCOPED CREDENTIAL [MSIToken]
WITH IDENTITY = 'Managed Identity'
GO


--Or you can create a File format and external table to make it easier
--Creating a new Data Source for this demo
CREATE EXTERNAL DATA SOURCE [MSI]
WITH (    LOCATION   = 'https://datalake1lf.dfs.core.windows.net/ftalive-serverless/',
          CREDENTIAL = [MSIToken]
)
GO

CREATE EXTERNAL FILE FORMAT [ParquetFormat] WITH (FORMAT_TYPE = PARQUET)
GO


--Columns Year and Month Are not in the List
CREATE EXTERNAL TABLE [dbo].[EXT_FACTINTERNETSALES_PARTITIONED]
(
	[PRODUCTKEY] [int],
	[ORDERDATEKEY] [int],
	[DUEDATEKEY] [int],
	[SHIPDATEKEY] [int],
	[CUSTOMERKEY] [int],
	[PROMOTIONKEY] [int],
	[CURRENCYKEY] [int],
	[SALESTERRITORYKEY] [int],
	[SALESORDERNUMBER] [varchar](8000),
	[SALESORDERLINENUMBER] [int],
	[REVISIONNUMBER] [int],
	[ORDERQUANTITY] [int],
	[UNITPRICE] [numeric](19, 4),
	[EXTENDEDAMOUNT] [numeric](19, 4),
	[UNITPRICEDISCOUNTPCT] [float],
	[DISCOUNTAMOUNT] [float],
	[PRODUCTSTANDARDCOST] [numeric](19, 4),
	[TOTALPRODUCTCOST] [numeric](19, 4),
	[SALESAMOUNT] [numeric](19, 4),
	[TAXAMT] [numeric](19, 4),
	[FREIGHT] [numeric](19, 4),
	[CARRIERTRACKINGNUMBER] [varchar](8000),
	[CUSTOMERPONUMBER] [varchar](8000)
)
WITH (DATA_SOURCE = [MSI],LOCATION = N'/FACTINTERNETSALES_PARTITIONED/*/*/*.parquet',FILE_FORMAT = [ParquetFormat])
GO

--External tables prevent you to benefit from partition elimination, [YEAR] and [MONTH] fields are not available 
SELECT TOP 10 * FROM [dbo].[EXT_FACTINTERNETSALES_PARTITIONED]
WHERE ORDERDATEKEY = 20211025
GO


/**********************************************************************************************************
Step 5 of 5
What about Views + OPENROWSET + filepath
**********************************************************************************************************/

--Create External table prevents you to use partition elimination
CREATE VIEW VW_FactInternetSales_Partitioned
AS
SELECT r.filepath(1) [Year],r.filepath(2) [Month], r.filename() [FileName],*
FROM
    OPENROWSET(
        BULK 'https://datalake1lf.dfs.core.windows.net/ftalive-serverless/FACTINTERNETSALES_PARTITIONED/*/*/*.parquet',
        FORMAT = 'PARQUET'
    ) r
GO

--Partition elimination works, but you have to provide the folder name
SELECT top 10 * FROM VW_FactInternetSales_Partitioned
WHERE ORDERDATEKEY = 20211025
	and year ='YEAR=2021'
	AND month ='MONTH=10'
```

### Querying Partitioned data with Synapse Serverless SQL Pool

Synapse Serverless SQL Pool can access Spark DB that allows you to benefit from [Shared Spark Table](https://learn.microsoft.com/en-us/azure/synapse-analytics/metadata/table). 

Synapse Serverless SQL Pool currently only shares managed and external Spark tables that store their data in Parquet, DELTA, or CSV format with the SQL engines.

### Querying Partitioned Spark table

Using Spark notebook you can create a new spark table in a new Spark DB and query it from Synapse Serverless Pool.

![text](.\SparkDb.png?raw=true)

the interesting part is that you can benefit from partion elimination just filtering by fields [YEAR] and [DATE] 

``` spark

%%csharp
spark.Sql("CREATE DATABASE FTALive_SparkDB")

%%sql
CREATE TABLE FTALive_SparkDB.factinternetsales_partitioned
    USING Parquet
    LOCATION "abfss://ftalive-serverless@datalake1lf.dfs.core.windows.net/FACTINTERNETSALES_PARTITIONED"

%%sql
DROP TABLE FTALive_SparkDB.factinternetsales_partitioned

%%pyspark
spark.sql("DROP DATABASE IF EXISTS FTALive_SparkDB CASCADE")

```

``` sql


USE ftalive_sparkdb
GO

--No partition elimination
Select Top 10 * from [dbo].[factinternetsales_partitioned] where orderdatekey = 20211025

--Yes partition elimination, this is an external table and allows partition elimination...
Select Top 10 * from [dbo].[factinternetsales_partitioned] where orderdatekey = 20211025 and year = 2021 and month = 10

```

![text](.\QuerySparkDb.png?raw=true)

### Reference:

[Azure architecture - Data partitioning guidance](https://learn.microsoft.com/en-us/azure/architecture/best-practices/data-partitioning)

[Best practices for using Data Lake G2](https://learn.microsoft.com/en-us/azure/storage/blobs/data-lake-storage-best-practices)

[CREATE EXTERNAL TABLE AS SELECT](https://learn.microsoft.com/en-us/azure/synapse-analytics/sql/create-use-external-tables)

[DataFlow](https://learn.microsoft.com/en-us/azure/synapse-analytics/concepts-data-flow-overview)

[Shared Spark Table](https://learn.microsoft.com/en-us/azure/synapse-analytics/metadata/table)

[Create and connect to Spark database with serverless SQL pool](https://learn.microsoft.com/en-us/azure/synapse-analytics/metadata/matabase#create-and-connect-to-spark-database-with-serverless-sql-pool)