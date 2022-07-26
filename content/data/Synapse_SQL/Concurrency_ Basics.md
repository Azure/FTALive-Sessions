## Synapse SQL dedicate pool SQL Dedicated Pools ( former DW)

##### Concurrency Consideration Basics



## What are resource classes

The performance capacity of a query is determined by the user's resource class. Resource classes are pre-determined resource limits in Synapse SQL pool that govern compute resources and concurrency for query execution. Resource classes can help you configure resources for your queries by setting limits on the number of queries that run concurrently and on the compute-resources assigned to each query. There's a trade-off between memory and concurrency.

- Smaller resource classes reduce the maximum memory per query, but increase concurrency.
- Larger resource classes increase the maximum memory per query, but reduce concurrency.

There are two types of resource classes:

- Static resources classes, which are well suited for increased concurrency on a data set size that is fixed.
- Dynamic resource classes, which are well suited for data sets that are growing in size and need increased performance as the service level is scaled up.



## Concurrency maximums for resource classes

To ensure each query has enough resources to execute efficiently, Synapse SQL tracks resource utilization by assigning concurrency slots to each query. The system puts queries into a queue based on importance and concurrency slots. Queries wait in the queue until enough concurrency slots are available. 



**Example: <tbd>**



##### Reference:

[Memory and concurrency limits - Azure Synapse Analytics | Microsoft Docs](https://docs.microsoft.com/en-us/azure/synapse-analytics/sql-data-warehouse/memory-concurrency-limits)

[Resource classes for workload management - Azure Synapse Analytics | Microsoft Docs](https://docs.microsoft.com/en-us/azure/synapse-analytics/sql-data-warehouse/resource-classes-for-workload-management)