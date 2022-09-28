
## Synapse SQL dedicate pool SQL Dedicated Pools ( former DW)

[Home](https://github.com/LiliamLeme/FTALive-Sessions_Synapse_SQL/blob/main/content/data/Synapse_SQL/Agenda.md)\- [Next >](Concurrency_%20Basics.md)

##### Distribution keys consideration basics

As mentioned before, Serverless SQL pool allows you to query your data lake files, while dedicated SQL pool allows you to query and ingest data from your data lake files.

**Distribution**

When data is ingested into dedicated SQL pool, the data is sharded into **distributions** to optimize the performance of the system. 

A distribution is the basic unit of storage and processing for parallel queries that run on distributed data. When Synapse SQL runs a query, the work is divided into 60 smaller queries that run in parallel.

Each of the 60 smaller queries runs on one of the data distributions. Each Compute node manages one or more of the 60 distributions. A dedicated SQL pool (formerly SQL DW) with maximum compute resources has one distribution per Compute node. A dedicated SQL pool (formerly SQL DW) with minimum compute resources has all the distributions on one compute node.


**What is a distributed table**

A distributed table appears as a single table, but the rows are actually stored across 60 distributions. The rows are distributed with a hash or round-robin algorithm.

- ***Hash-distribution*** improves query performance on large fact tables, and is the focus of this article. 
- ***Round-robin*** distribution is useful for improving loading speed. These design choices have a significant impact on improving query and loading performance.


**What is a replicated table**

A replicated table has a full copy of the table accessible on each Compute node. Replicating a table removes the need to transfer data among Compute nodes before a join or aggregation.


**How to design tables**

When you define a table you can choose which the pattern to distribute the data across the distributions and the compute nodes:

- Distributed:
  - Hash
  - Round Robin
- Replicated

As part of table design, understand as much as possible about your data and how the data is queried.  
For example, consider these questions:

- How large is the table?
- How often is the table refreshed?
- How the table is joined with other tables
- Do I have fact and dimension tables in a dedicated SQL pool?


## Hash-distributed tables

A hash distributed table can deliver the highest query performance for joins and aggregations on large tables. To shard data into a hash-distributed table, dedicated SQL pool uses a hash function to deterministically assign each row to one distribution. In the table definition, one of the columns is designated as the distribution column. The hash function uses the values in the distribution column to assign each row to a distribution.

The following diagram illustrates how a full (non-distributed table) gets stored as a hash-distributed table.

![text](.\hash-distributed-table.png?raw=true)

- Each row belongs to one distribution.
- A deterministic hash algorithm assigns each row to one distribution.

A hash-distributed table has a distribution column or set of columns that is the hash key.

Choosing distribution column(s) is an important design decision since the values in the hash column(s) determine how the rows are distributed. The best choice depends on several factors, and usually involves tradeoffs. Once a distribution column or column set is chosen, you cannot change it. If you didn't choose the best column(s) the first time, you can use [CREATE TABLE AS SELECT (CTAS)](https://docs.microsoft.com/en-us/sql/t-sql/statements/create-table-as-select-azure-sql-data-warehouse?toc=%2Fazure%2Fsynapse-analytics%2Fsql-data-warehouse%2Ftoc.json&bc=%2Fazure%2Fsynapse-analytics%2Fsql-data-warehouse%2Fbreadcrumb%2Ftoc.json&view=azure-sqldw-latest&preserve-view=true) to re-create the table with the desired distribution hash key.

Choose a distribution column(s)
- with data that distributes evenly across 60 distributions
- that minimizes data movement
- that has many unique values and no or few NULLs
- is not a date column

Consider using a hash-distributed table when:

- The table size on disk is more than 2 GB.
- The table has frequent insert, update, delete, merge operations.


## Round-robin distributed tables

A round-robin table is the simplest table to create and delivers fast performance when used as a staging table for loads. The assignment of rows to distributions is random. Unlike hash-distributed tables, rows with equal values are not guaranteed to be assigned to the same distribution.

A round-robin distributed table distributes data evenly across the table but without any further optimization. A distribution is first chosen at random and then buffers of rows are assigned to distributions sequentially.

Consider using the round-robin distribution for your table in the following scenarios:

- When getting started as a simple starting point since it is the default
- If there is no obvious joining key
- If there is no good candidate column for hash distributing the table
- If the table does not share a common join key with other tables
- If the join is less significant than other joins in the query
- When the table is a temporary staging table

## Replicated tables

A replicated table provides the fastest query performance when joining small tables.

A replicated table has a full copy of the table available on every Compute node. Queries run fast on replicated tables because joins on replicated tables don't require data movement. Replication requires extra storage, though, and isn't practical for large tables.

![text](.\replicated-table.png?raw=true)

Consider using a replicated table when:

- The table size on disk is less than 2 GB, regardless of the number of rows.
- The table is used in joins that would otherwise require data movement. 


## Examples

### 1 - Table design - Hash distributed - How to check if the table is well distributed or not

In this example we'll show you the performance impact if the table is affected by data skew.

``` sql
/****************************************************************************************
STEP 1 of 3 - Run this simple Select
****************************************************************************************/
SELECT  
	[CustomerKey]
	, COUNT(distinct [ProductKey]) Distinct_Prod_Count
	, SUM([OrderQuantity])[OrderQuantity_SUM]
	, SUM([SalesAmount]) [SalesAmount_SUM]
FROM [Sales].[FactSales_Skewed]
	WHERE [OrderDateKey] >= 20120101 and [OrderDateKey] <= 20201231
GROUP BY [CustomerKey]
OPTION(LABEL = 'FactSales - Slow Query')
GO

/****************************************************************************************
STEP 2 of 3 - check its MPP execution plan
change the request_id using the proper-one. The most expensive step is step2 which is ShuffleMoveOperation
This table has been created distributed=Hash(RevisionNumber)
RevisionNumber shouldn't be used as distribution column since it only has 1 valu (Very dense and not selectine) 
Rows with same value land into the same distribution (Distribution 16 in this case) and using below queries you should be able to demonstrate
the slowest distribution is the 16th.
****************************************************************************************/
SELECT * FROM SYS.Dm_pdw_exec_requests where [LABEL] = 'FactSales - Slow Query'
SELECT * FROM sys.dm_pdw_request_steps WHERE request_id = 'request_id'
SELECT * FROM sys.dm_pdw_sql_requests WHERE request_id = 'request_id' and Step_index = 2

/****************************************************************************************
STEP 3 of 3 - check how many rows are in each distribution and how to tell if the table has data skew
All rows belong to distribution 16
https://docs.microsoft.com/en-us/azure/synapse-analytics/sql-data-warehouse/sql-data-warehouse-tables-distribute?context=/azure/synapse-analytics/context/context#how-to-tell-if-your-distribution-column-is-a-good-choice
****************************************************************************************/

DBCC PDW_SHOWSPACEUSED('[Sales].[FactSales]')
GO

--All the rows belong to the same distribution that is the now the bottleneck.
--Once tha table has been created there's no way to change its distribution, we must create a new copy and distribute it using the proper column(s) using the [CREATE TABLE AS SELECT (CTAS)]--(https://docs.microsoft.com/en-us/sql/t-sql/statements/create-table-as-select-azure-sql-data-warehouse?toc=%2Fazure%2Fsynapse-analytics%2Fsql-data-warehouse%2Ftoc.json&bc=%2Fazure%2Fsynapse-analytics%2Fsql-data-warehouse%2Fbreadcrumb%2Ftoc.json&view=azure-sqldw-latest&preserve-view=true) command.
```


### 2 - Replicated Table and Joins

In this demo we'll show you how replicated tables work and their performance impact.

``` sql
/****************************************************************************************
STEP 1 of 4 - Run this query 
****************************************************************************************/

SELECT
	Dc.CustomerKey
	, Dc.FirstName + ' ' + Dc.LastName
	, Dp.ProductAlternateKey
	, Dst.SalesTerritoryRegion
	, COUNT_BIG(distinct Fis.SalesOrderNumber) SalesOrderNumber_COUNT
	, AVG(CAST(SalesAmount AS DECIMAL(38,4))) SalesAmount_AVG
	, AVG(CAST(OrderQuantity AS DECIMAL(38,4))) OrderQuantity_AVG
FROM Sales.FactInternetSales Fis
	INNER JOIN Sales.DimProduct Dp
		ON Fis.ProductKey = Dp.ProductKey
			And CAST(CAST(Fis.OrderDateKey AS CHAR(8)) AS DATETIME2) between Dp.StartDate and Dp.EndDate
	INNER JOIN Sales.DimCustomer Dc
		ON Fis.CustomerKey = Dc.CustomerKey
	INNER JOIN Sales.DimSalesTerritory Dst
		ON Dst.SalesTerritoryKey = Fis.SalesTerritoryKey
WHERE Fis.OrderDateKey >= '20210101' and Fis.OrderDateKey < '20211231' 
GROUP BY Dc.CustomerKey
	, Dc.FirstName + ' ' + Dc.LastName
	, Dp.ProductAlternateKey
	,  Dst.SalesTerritoryRegion
OPTION(LABEL = 'FactInternetSales - No Replicate Table Cache')
GO

/****************************************************************************************
STEP 2 of 4 - Identify the request_id for the query and its MPP execution plan
Multiple Broadcastmove operations are affecting performances due to Replicate table cache not available yet
*****************************************************************************************/
SELECT * FROM sys.dm_pdw_exec_requests WHERE [LABEL] = 'FactInternetSales - No Replicate Table Cache'
SELECT * FROM Sys.dm_pdw_request_steps WHERE request_id = 'request_id'

/****************************************************************************************
STEP 3 of 4 - Compare this execution and its MPP plan wih the previous one
*****************************************************************************************/

SELECT
	Dc.CustomerKey
	, Dc.FirstName + ' ' + Dc.LastName
	, Dp.ProductAlternateKey
	, Dst.SalesTerritoryRegion
	, COUNT_BIG(distinct Fis.SalesOrderNumber) SalesOrderNumber_COUNT
	, AVG(CAST(SalesAmount AS DECIMAL(38,4))) SalesAmount_AVG
	, AVG(CAST(OrderQuantity AS DECIMAL(38,4))) OrderQuantity_AVG
FROM Sales.FactInternetSales Fis
	INNER JOIN Sales.DimProduct Dp
		ON Fis.ProductKey = Dp.ProductKey
			And CAST(CAST(Fis.OrderDateKey AS CHAR(8)) AS DATETIME2) between Dp.StartDate and Dp.EndDate
	INNER JOIN Sales.DimCustomer Dc
		ON Fis.CustomerKey = Dc.CustomerKey
	INNER JOIN Sales.DimSalesTerritory Dst
		ON Dst.SalesTerritoryKey = Fis.SalesTerritoryKey
WHERE Fis.OrderDateKey >= '20210101' and Fis.OrderDateKey < '20211231' 
GROUP BY Dc.CustomerKey
	, Dc.FirstName + ' ' + Dc.LastName
	, Dp.ProductAlternateKey
	,  Dst.SalesTerritoryRegion
OPTION(LABEL = 'FactInternetSales - With Replicate Table Cache')
GO


/****************************************************************************************
STEP 4 of 4 - this execution doesn't need BroadcastMove, replicate table is in place
*****************************************************************************************/

SELECT * FROM sys.dm_pdw_exec_requests WHERE [LABEL] = 'FactInternetSales - With Replicate Table Cache'
SELECT * FROM Sys.dm_pdw_request_steps WHERE request_id = 'request_id'
```

### 3 - Compatible and incompatible join

The performance impact of not efficient queries might be drammatic, here a basic reminder about compatible and incompatible join.

![text](.\compatible.png?raw=true)

Properly joining the tables is the first step to achieve good performance.

``` sql
/****************************************************************************************
STEP 1 of 4 - Execute this query
****************************************************************************************/
SELECT 
	Fis.SalesTerritoryKey
	,Fis.OrderDateKey
	, Dsr.SalesReasonName
	, COUNT_BIG(distinct Fis.SalesOrderNumber) SalesOrderNumber_COUNT
	, AVG(CAST(SalesAmount AS DECIMAL(38,4))) SalesAmount_AVG
	, AVG(CAST(OrderQuantity AS DECIMAL(38,4))) OrderQuantity_AVG
FROM Sales.FactInternetSales_WrongDistributionColumn Fis
	INNER JOIN Sales.FactInternetSalesReason Fisr
		ON Fisr.SalesOrderNumber = Fis.SalesOrderNumber
			AND Fisr.SalesOrderLineNumber = Fis.SalesOrderLineNumber
	INNER JOIN Sales.DimSalesReason Dsr
		ON Fisr.SalesReasonKey = Dsr.SalesReasonKey
WHERE Fis.OrderDateKey >= 20120101 and Fis.OrderDateKey < 20211231
		AND Fis.SalesTerritoryKey BETWEEN 5 and 10
		AND Dsr.SalesReasonName = 'Demo Event'
	GROUP BY Fis.SalesTerritoryKey, Fis.OrderDateKey, Dsr.SalesReasonName
OPTION(LABEL = 'Incompatible Join')
GO

/****************************************************************************************
STEP 2 of 4 - Check generated MPP plan
most expensive step is ShuffleMoveOperation (step_index = 2) which moves approx 73.569.026
****************************************************************************************/
SELECT * FROM sys.dm_pdw_exec_requests WHERE [LABEL] = 'Incompatible Join'
SELECT * FROM Sys.dm_pdw_request_steps WHERE request_id = 'request_id'
GO

/****************************************************************************************
STEP 3 of 4 - Run the query again and Check generated MPP plan
****************************************************************************************/

SELECT 
	Fis.SalesTerritoryKey
	,Fis.OrderDateKey
	, Dsr.SalesReasonName
	, COUNT_BIG(distinct Fis.SalesOrderNumber) SalesOrderNumber_COUNT
	, AVG(CAST(SalesAmount AS DECIMAL(38,4))) SalesAmount_AVG
	, AVG(CAST(OrderQuantity AS DECIMAL(38,4))) OrderQuantity_AVG
FROM Sales.FactInternetSales Fis
	INNER JOIN Sales.FactInternetSalesReason Fisr
		ON Fisr.SalesOrderNumber = Fis.SalesOrderNumber
			AND Fisr.SalesOrderLineNumber = Fis.SalesOrderLineNumber
	INNER JOIN Sales.DimSalesReason Dsr
		ON Fisr.SalesReasonKey = Dsr.SalesReasonKey
WHERE Fis.OrderDateKey >= 20120101 and Fis.OrderDateKey < 20211231
		AND Fis.SalesTerritoryKey BETWEEN 5 and 10
		AND Dsr.SalesReasonName = 'Demo Event'
	GROUP BY Fis.SalesTerritoryKey, Fis.OrderDateKey, Dsr.SalesReasonName
OPTION(LABEL = 'Compatible Join')
GO

/****************************************************************************************
STEP 4 of 4 - Check generated MPP plan
ShuffleMoveOperation which moved approx 73.569.026 disappeared.
Still there is 1 shufflemove but it doesn't affect performance and it's related to aggregations
****************************************************************************************/

SELECT * FROM sys.dm_pdw_exec_requests WHERE [LABEL] = 'Incompatible Join'
SELECT * FROM sys.dm_pdw_exec_requests WHERE [LABEL] =  'Compatible Join'
SELECT * FROM Sys.dm_pdw_request_steps WHERE request_id = 'request_id'
SELECT * FROM Sys.dm_pdw_request_steps WHERE request_id = 'request_id'
GO
```

##### Reference:


[Table Design in Synapse Dedicated SQL Pool](https://docs.microsoft.com/en-us/azure/synapse-analytics/sql/develop-tables-overview)
[Guidance for designing distributed tables using dedicated SQL pool in Azure Synapse Analytics](https://docs.microsoft.com/en-us/azure/synapse-analytics/sql-data-warehouse/sql-data-warehouse-tables-distribute)
[Guidance for designing replicated tables using dedicated SQL pool in Azure Synapse Analytics](https://docs.microsoft.com/en-us/azure/synapse-analytics/sql-data-warehouse/design-guidance-for-replicated-tables)
