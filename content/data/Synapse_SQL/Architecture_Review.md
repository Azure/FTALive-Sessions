## Synapse SQL dedicate pool and SQL serverless pool review

#### What is the difference of SQL dedicate pool and SQL serverless pool options inside of Synapse?



***\*[Home](../tobedefined.md)\**** - [Next >](test.md)

##### Architecture Overview

For dedicated SQL pool, the unit of scale is an abstraction of compute power that is known as a [data warehouse unit](https://docs.microsoft.com/en-us/azure/synapse-analytics/sql/resource-consumption-models).

For serverless SQL pool, being serverless, scaling is done automatically to accommodate query resource requirements. As topology changes over time by adding, removing nodes or failovers, it adapts to changes and makes sure your query has enough resources and finishes successfully. For example, the image below shows serverless SQL pool utilizing 4 compute nodes to execute a query.

![text](.\sql-architecture.png?raw=true)

Synapse SQL uses a node-based architecture. Applications connect and issue T-SQL commands to a Control node, which is the single point of entry for Synapse SQL.

The Azure Synapse SQL Control node utilizes a distributed query engine to optimize queries for parallel processing, and then passes operations to Compute nodes to do their work in parallel.

The Compute nodes store all user data in Azure Storage and run the parallel queries. The Data Movement Service (DMS) is a system-level internal service that moves data across the nodes as necessary to run queries in parallel and return accurate results.

With decoupled storage and compute, when using Synapse SQL one can benefit from independent sizing of compute power irrespective of your storage needs. For serverless SQL pool scaling is done automatically, while for dedicated SQL pool one can:

- Grow or shrink compute power, within a dedicated SQL pool, without moving data.
- Pause compute capacity while leaving data intact, so you only pay for storage.
- Resume compute capacity during operational hours.

**Control Node**
The Control node is the brain of the architecture. It is the front end that interacts with all applications and connections.

In Synapse SQL, the distributed query engine runs on the Control node to optimize and coordinate parallel queries. When you submit a T-SQL query to dedicated SQL pool, the Control node transforms it into queries that run against each distribution in parallel.

In serverless SQL pool, the DQP engine runs on Control node to optimize and coordinate distributed execution of user query by splitting it into smaller queries that will be executed on Compute nodes. It also assigns sets of files to be processed by each node.

**Compute Nodes**
The Compute nodes provide the computational power.

In dedicated SQL pool, distributions map to Compute nodes for processing. The number of compute nodes ranges from 1 to 60, and is determined by the service level for the dedicated SQL pool and it impacts the cost. 

In serverless SQL pool, each Compute node is assigned task and set of files to execute task on. Task is distributed query execution unit, which is actually part of query user submitted. Automatic scaling is in effect to make sure enough Compute nodes are utilized to execute user query.

**Dedicated SQL pool:**

At a high level, the basic query **flow** is: When a query is executed it will be sent to the Controle Node that will optimize and coordinate the parallel queries. The Compute nodes, the muscles, will provide the computational power for the execution and the distributions will be mapped to those nodes according to the DW size. Using this concept the engine will divide the work of executing the query into 60 smaller queries that will run in parallel to obtain the data from the distributions. The pattern of the distributed data will be chosen when the table is created. 

**Concurrency:**
In a few words, as this topic would demand a full post about it. Inside the dedicated SQL pools, you must organize the priority of the user execution and how many resources this user would be able to get for the query execution. So concurrency is limited per service level and can be managed and prioritized, more information follows the doc: [Memory and concurrency limits - Azure Synapse Analytics | Microsoft Docs](https://docs.microsoft.com/en-us/azure/synapse-analytics/sql-data-warehouse/memory-concurrency-limits)

 **Some scenarios as an example:**
- Physical data warehouse - As data are stored, organized, and modeled inside of the database.
- Reports
- Dashboards that demand a fast sub response
- A scenario where managing Query Concurrency is a business need. Former SQL DW enables you to resource governor the query executions inside of the database. [Workload classification for dedicated SQL pool - Azure Synapse Analytics | Microsoft Docs](https://docs.microsoft.com/en-us/azure/synapse-analytics/sql-data-warehouse/sql-data-warehouse-workload-classification)
 

**Serverless SQL Pool:**

At a high level, the query **flow** is basically: A query is submitted to the front-end node ( control node). An execution plan is created and passed to the Distributed Query Processing which will break this execution into "pieces/tasks" and assign them to the backend nodes(BE) for execution. So, the BEs will receive assigned tasks to execute the query against the storage files organized in units.

**Concurrency:**
It is not limited in the same way Dedicated SQL Pool is. The dedicated SQL Pool has a very clear documented limitation with a number of active queries according to the service level in use. More information here: [Memory and concurrency limits - Azure Synapse Analytics | Microsoft Docs](https://docs.microsoft.com/en-us/azure/synapse-analytics/sql-data-warehouse/memory-concurrency-limits)

In Serverless SQL Pool you could have a varied number of active queries,not a fixed value, and It works as follows: ([Monitoring Synapse serverless SQL open connections - Microsoft Tech Community](https://techcommunity.microsoft.com/t5/azure-synapse-analytics-blog/monitoring-synapse-serverless-sql-open-connections/ba-p/3298577))

- The number of active sessions and requests would depend on the query complexity and amount of data scanned. 
- I mean...As with any SQL, a serverless SQL pool could handle many different sessions that are executing lightweight queries or complex heavy queries consuming most of the resources while the other queries wait.

**Some scenarios :**
- Basic discovery and exploration.
- Logical data warehouse - As the data are the files inside of the storage. Views and external tables can be used to organize this.
- Reports
- Data transformation.



###### Reference:

[Synapse SQL architecture - Azure Synapse Analytics | Microsoft Docs](https://docs.microsoft.com/en-us/azure/synapse-analytics/sql/overview-architecture)
[Understand Synapse dedicated SQL pool (formerly SQL DW) and Serverless SQL pool - Microsoft Tech Community](https://techcommunity.microsoft.com/t5/azure-synapse-analytics-blog/understand-synapse-dedicated-sql-pool-formerly-sql-dw-and/ba-p/3594628)
