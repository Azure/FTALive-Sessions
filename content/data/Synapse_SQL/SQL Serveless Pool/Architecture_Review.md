## Synapse SQL dedicate pool and SQL serverless pool review

***\*[Home](Agenda_serveless.md)\**** - [Next >](Serveless_Query_Basics.md)

##### Architecture Overview

Every Azure Synapse Analytics workspace comes with serverless SQL pool endpoints that you can use to query data in the [Azure Data Lake](https://learn.microsoft.com/en-us/azure/synapse-analytics/sql/query-data-storage) ([Parquet](https://learn.microsoft.com/en-us/azure/synapse-analytics/sql/query-data-storage#query-parquet-files), [Delta Lake](https://learn.microsoft.com/en-us/azure/synapse-analytics/sql/query-delta-lake-format), [delimited text](https://learn.microsoft.com/en-us/azure/synapse-analytics/sql/query-data-storage#query-csv-files) formats), [Cosmos DB](https://learn.microsoft.com/en-us/azure/synapse-analytics/sql/query-cosmos-db-analytical-store?toc=/azure/synapse-analytics/toc.json&bc=/azure/synapse-analytics/breadcrumb/toc.json&tabs=openrowset-key), or Dataverse.

Serverless SQL pool is a query service over the data in your data lake. It enables you to access your data through the following functionalities:

- A familiar [T-SQL syntax](https://learn.microsoft.com/en-us/azure/synapse-analytics/sql/overview-features) to query data in place without the need to copy or load data into a specialized store.
- Integrated connectivity via the T-SQL interface that offers a wide range of business intelligence and ad-hoc querying tools, including the most popular drivers.

For serverless SQL pool, being serverless, scaling is done automatically to accommodate query resource requirements. As topology changes over time by adding, removing nodes or failovers, it adapts to changes and makes sure your query has enough resources and finishes successfully. For example, the image below shows serverless SQL pool utilizing 4 compute nodes to execute a query.

With decoupled storage and compute, when using Synapse SQL one can benefit from independent sizing of compute power irrespective of your storage needs. For serverless SQL pool scaling is done automatically, while for dedicated SQL pool one can:

- Grow or shrink compute power, within a dedicated SQL pool, without moving data.
- Pause compute capacity while leaving data intact, so you only pay for storage.
- Resume compute capacity during operational hours.

Serverless SQL pool allows you to query your data lake files, while dedicated SQL pool allows you to query and ingest data from your data lake files.

![image-20221011133751346](C:\Users\lilem\AppData\Roaming\Typora\typora-user-images\image-20221011133751346.png)



 

- So     basically this is a SQL server process, which takes your query compiles it  parses it and then passes it to decrypt is distributed query processing.

- DQP     basically breaks the execution of that one complex query into many smaller     units smaller queries and distributed execution of those queries on back    ends. 
- Simple query     takes the results forwards them to the upper node. Do whatever it needs to     o with them and transforms them back to the DQP and then to the front end    and then to the customer

##### Storage:

Storage Abstraction abstracts distributed query processing from the underlying  store via data cells. Any dataset can be  mapped to a collection of cells, which allows the engine to do distributed query processing over data in diverse formats. 

###### Data Cell

Storage file are grouped in data cells which are organized per hash distribution and partition functions.

The hash-distribution is a system-defined function applied to  (a user-defined composite key c of) r that returns the hash bucket  number, or distribution, that r belongs to. The hash-distribution h is used to map cells to compute nodes.

The partitioning function p(r) is a user-defined function that takes  as input an object r and returns the partition i in which r is  positioned. This is useful for aggressive partition pruning when  range or equality predicates are defined over the partitioning key.  

##### Concurrency

Concurrency is not limited as in Dedicated SQL pool. In a Serverless SQL pool, you can have a flexible number of active queries, not a fixed value. To learn how to monitor open connections, please read [Monitoring Synapse serverless SQL open connections](https://techcommunity.microsoft.com/t5/azure-synapse-analytics-blog/monitoring-synapse-serverless-sql-open-connections/ba-p/3298577).

- The number of active sessions and requests depend on query complexity and amount of data scanned. 
- As with any SQL, a Serverless SQL pool can handle many different sessions that are executing lightweight queries or complex heavy queries consuming most of the resources while the other queries wait.

###### Reference:

[Synapse SQL architecture - Azure Synapse Analytics | Microsoft Docs](https://docs.microsoft.com/en-us/azure/synapse-analytics/sql/overview-architecture)

[Serverless SQL pool - Azure Synapse Analytics | Microsoft Learn](https://learn.microsoft.com/en-us/azure/synapse-analytics/sql/on-demand-workspace-overview)

[Monitoring Synapse serverless SQL open connections - Microsoft Community Hub](https://techcommunity.microsoft.com/t5/azure-synapse-analytics-blog/monitoring-synapse-serverless-sql-open-connections/ba-p/3298577)