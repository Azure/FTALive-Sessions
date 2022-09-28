## Synapse SQL dedicate pool SQL Dedicated Pools ( former DW)

[Home](https://github.com/LiliamLeme/FTALive-Sessions_Synapse_SQL/blob/main/content/data/Synapse_SQL/Agenda.md)\- [Next >](Serveless_Querytobegin.md)

##### Concurrency Consideration Basics

CPU, memory, and IO are bundled into units of compute scale called Data Warehouse Units (DWUs). 
A DWU represents an abstract, normalized measure of compute resources and performance.
A change to your service level (SLO) alters the number of DWUs that are available to the system, which in turn adjusts the performance, and the cost, of your system.
Increasing SLO:
- Linearly changes performance of the system for scans, aggregations, and CTAS statements
- Increases the maximum number of concurrent queries and concurrency slots

Dedicated SQL Pool allows you to executo a limited number of queries at the same time. This number depends on the SLO you're dedicated SQL Pool is running on and it varies from 4 to 128 max concurrent queries.

## What are slots

To ensure each query has enough resources to execute efficiently, Synapse SQL tracks resource utilization by assigning concurrency slots to each query. 
The system puts queries into a queue based on importance and concurrency slots. Queries wait in the queue until enough concurrency slots are available.

The performance capacity of a query is determined by the user's resource class. Resource classes are pre-determined resource limits in Synapse SQL pool that govern compute resources and concurrency for query execution. Resource classes can help you configure resources for your queries by setting limits on the number of queries that run concurrently and on the compute-resources assigned to each query. There's a trade-off between memory and concurrency.

- Smaller resource classes reduce the maximum memory per query, but increase concurrency.
- Larger resource classes increase the maximum memory per query, but reduce concurrency.


Service Level | Maximum concurrent queries | Concurrency slots available | Slots used by smallrc | Slots used by mediumrc | Slots used by largerc | Slots used by xlargerc |
--- | --- | --- | --- |--- |--- |--- 
DW100c | 4 | 4 | 1 | 1 | 1 | 2
DW200c | 8 | 8 | 1 | 1 | 1 | 5
DW300c | 12 | 12 | 1 | 1 | 2 | 8
DW400c | 16 | 16 | 1 | 1 | 3 | 11
DW500c | 20 | 20 | 1 | 2 | 4 | 14
DW1000c | 32 | 40 | 1 | 4 | 8 | 28
DW1500c | 32 | 60 | 1 | 6 | 13 | 42
DW2000c | 32 | 80 | 2 | 8 | 17 | 56
DW2500c | 32 | 100 | 3 | 10 | 22 | 70
DW3000c | 32 | 120 | 3 | 12 | 26 | 84
DW5000c | 32 | 200 | 6 | 20 | 44 | 140
DW6000c | 32 | 240 | 7 | 24 | 52 | 168
DW7500c | 32 | 300 | 9 | 30 | 66 | 210
DW10000c | 32 | 400 | 12 | 40 | 88 | 280
DW15000c | 32 | 600 | 18 | 60 | 132 | 420
DW30000c | 32 | 1200 | 36 | 120 | 264 | 840

## Workload groups 

With the introduction of ***workload groups***, the concept of concurrency slots no longer applies.

Workload groups are containers for a set of requests and are the basis for how workload management, including workload isolation, is configured on a system. 

Resources per request are allocated on a percentage basis and specified in the workload group definition. However, even with the removal of concurrency slots, there are minimum amounts of resources needed per queries based on the service level. The below table defined the minimum amount of resources needed per query across service levels and the associated concurrency that can be achieved.

Service Level | Maximum concurrent queries | Min % supported for request
--- | --- | --- 
DW100c | 4 | 25%
DW200c | 8 | 12.5%
DW300c | 12 | 8%
DW400c | 16 | 6.25%
DW500c | 20 | 5%
DW1000c | 32 | 3%
DW1500c | 32 | 3%
DW2000c | 48 | 2%
DW2500c | 48 | 2%
DW3000c | 64 | 1.5%
DW5000c | 64 | 1.5%
DW6000c | 128 | 0.75%
DW7500c | 128 | 0.75%
DW10000c | 128 | 0.75%
DW15000c | 128 | 0.75%
DW30000c | 128 | 0.75%


## Concurrency maximums for resource classes

To ensure each query has enough resources to execute efficiently, Synapse SQL tracks resource utilization by assigning concurrency slots to each query. The system puts queries into a queue based on importance and concurrency slots. Queries wait in the queue until enough concurrency slots are available. 



**Example: Queries and concurrency**

In this example we'll show you the concurrency limitation

``` sql
/****************************************************************************************
STEP 1 of 4 - BEFORE RUN THIS SCALE YOUR DEDICATED SQL POOL TO DW100c

This command should never complete
Run this select after you run C3_B_Simulate_Queries.ps1 powershell script.
While PS1 script is still running (it should take hours to complete) run below query

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
OPTION(LABEL = 'Test Concurrency DW100')
GO

/****************************************************************************************
STEP 2 of 4 - Checking what is going on
You should find 4 session with status = 'running' and one with status = 'suspended' 
DW1000 allows max 4 running concurrent query. New submitted queries will be queued and their status will be 'Suspended'

https://docs.microsoft.com/en-us/azure/synapse-analytics/sql-data-warehouse/memory-concurrency-limits

****************************************************************************************/

SELECT * FROM sys.dm_pdw_exec_requests WHERE STATUS NOT IN ('Completed','Failed','Cancelled')
SELECT * FROM sys.dm_pdw_exec_requests WHERE [label] = 'Test Concurrency DW100'
SELECT * FROM sys.dm_pdw_waits WHERE session_id = 'sessions_id'
GO

/****************************************************************************************
STEP 3 of 4 - to increase the number of available concurrent queries you have to chose an higher SLO
Customer's workload can do it programmatically via Powershell, T-SQL, REST API

In this example we will leverage T-SQL code to scale to DW500c.

YOU CAN NOW STOP C3_B_Simulate_Queries.ps1 SCRIPT USING C3_C_Force_Stop_Queries.ps1

****************************************************************************************/

--Point MASTER db, your app can invoke this T/SQL and auto/scale the Dedicated Sql pool
ALTER DATABASE fasthack_performance
MODIFY (SERVICE_OBJECTIVE = 'DW500c');
GO

--It returns the current status for the scale request
SELECT TOP 1 state_desc
FROM sys.dm_operation_status
WHERE
    resource_type_desc = 'Database'
    AND major_resource_id = 'fasthack_performance'
    AND operation = 'ALTER DATABASE'
ORDER BY
    start_time DESC
GO


--How to check the scale status
DECLARE @db sysname = 'fasthack_performance'
WHILE
(
    SELECT TOP 1 state_desc
    FROM sys.dm_operation_status
    WHERE
        1=1
        AND resource_type_desc = 'Database'
        AND major_resource_id = @db
        AND operation = 'ALTER DATABASE'
    ORDER BY
        start_time DESC
) = 'IN_PROGRESS'
BEGIN
    RAISERROR('Scale operation in progress',0,0) WITH NOWAIT;
    WAITFOR DELAY '00:00:05';
END
PRINT 'Complete';
GO



/****************************************************************************************
STEP 4 of 4 - Run this select after you triggered again the C3_B_Simulate_Queries.ps1 powershell script.
While PS1 script is still running (it should take hours to complete) run below query
It should complete in few seconds
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
OPTION(LABEL = 'Test Concurrency DW500')
GO
```


##### Reference:

[Memory and concurrency limits](https://docs.microsoft.com/en-us/azure/synapse-analytics/sql-data-warehouse/memory-concurrency-limits)
[Resource classes for workload management](https://docs.microsoft.com/en-us/azure/synapse-analytics/sql-data-warehouse/resource-classes-for-workload-management)
[Workload group isolation](https://docs.microsoft.com/en-us/azure/synapse-analytics/sql-data-warehouse/sql-data-warehouse-workload-isolation)
