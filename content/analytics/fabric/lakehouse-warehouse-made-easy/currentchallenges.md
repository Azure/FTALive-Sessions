# Current Challenges building a MDW

#### [prev](./introduction.md) | [home](./readme.md)  | [next](./currentchallenges.md)

## Current Landscape of building a MDW in Azure
Building a MDW presents many challenges. Some of these challenges are intrinsic to ALL DWs such as Data Modelling, whereas others are technology based and can therefore be simplified, improved and/or solved. </br> </br>
What do *we* mean when talking about MDWs in Azure...
![EnterpriseEDW](https://learn.microsoft.com/en-us/azure/architecture/example-scenario/analytics/media/enterprise-bi-scoped-architecture.png 'Enterprise BI Architecture diagram')


## Challenge #1 - Data needs to be copied & transformed 
Consider the an existing MDW pattern:
1. Data is copied from source to a RAW zone in a data lake in ??? format
1. Data is then copied and transformed into higher zones within the Data Lake in  Parquet
1. For the presentation layer, data is transferred to a different location & format. For this example, into a Data Mart hosted in an Azure SQL DB.
1. Data is copied from Azure SQL DB into Power BI.

Challenges: 
* Let's count the different data formats
  * How do I even pick the file formats?
* Let's count the number of copies
  * Where is the best place to perform the transformations?

A 'Data Lake' is not a monolithic construct. It can be made up of several pieces such as Azure Storage Accounts, Azure Data Lake Gen2 (ADLSv2) accounts and even storage external to Azure such as AWS S3.</br>

Challenges:
* How do I access & process data that is not directly within my main Data Lake storage?

## Challenge #2 - Spark vs SQL
When building a MDW on Azure, many organisations must make a decision to choose between performing transformations in SQL or Spark. This can have flow on effects in how the data is eventually stored. </br>
Many considerations for choosing SQL vs Spark.
* SQL
  * Transformations are written in SQL, saved as Stored Procedures.
  * Compute occurs inside SQL SMP or MPP engine.
  * Storage *usually* tightly coupled to compute.
  * Engine generally supports full ACID properties *across tables* or even other databases
  * Skillset available within the market
* Spark
  * Transformations are written in Python, saved within notebooks.
  * Compute occurs inside scale-out Apache Spark engine.
  * Separation of compute and storage
  * Flexibility to still write SQL
  * Skillset less available within the market (but improving rapidly)

Challenges:
* If I choose Spark, I need to train all my SQL gurus on how to use it.
* If I choose SQL, I'm *potentially* going to couple compute + storage together again.

## Challenge #3 - Building a Data Warehouses on Dedicated SQL Pools
Data Warehouses are complex and often expensive and slow to implement. Dedicated SQL Pools (formerly SQL DW) is Microsoft's MPP SQL architecture and it can do things other engines can only dream of... But.

* They have copped some flak, but are still needed! (we just have *more* options now)
* "Not cool". Wrong!
* Properly designed and built DW will out perform everything
* One does not simply build a DW..


#### Demo: Things to consider before deploying Dedicated SQL Pool
Sub-title: 
![OneDoesNotSimpleCreateTable](./Images/OneDoesNotSimplyCreateTable.jpg)
<!-- Purpose of this demo is to talk through some of the knowledge a customer must have before creating their first table. 
Prep: Have a pre-created Dedicated SQL Pool created-->
1. Engine choice: SQL Server, Azure SQL Hyperscale, Dedicated SQL Pool (standalone or Synapse). Many decision points ([see reference](https://learn.microsoft.com/en-us/azure/architecture/data-guide/relational-data/data-warehousing)), but let's choose Dedicated SQL Pool because that's where you build a DW, right?
1. [Service Level / SKU choice](https://learn.microsoft.com/en-us/azure/synapse-analytics/sql-data-warehouse/memory-concurrency-limits#service-levels) and [cost](https://azure.microsoft.com/en-us/pricing/details/synapse-analytics/)
1. Looks & smells like SQL Server, but.. [MPP architecture](https://learn.microsoft.com/en-us/azure/synapse-analytics/sql-data-warehouse/massively-parallel-processing-mpp-architecture#synapse-sql-architecture-components) and [Distributions](https://learn.microsoft.com/en-us/azure/synapse-analytics/sql-data-warehouse/sql-data-warehouse-tables-distribute)
1. [Indexes](https://learn.microsoft.com/en-us/azure/synapse-analytics/sql-data-warehouse/sql-data-warehouse-tables-index)
    1. [Clustered Column Store Indexes (CCIs)](https://learn.microsoft.com/en-us/sql/relational-databases/indexes/columnstore-indexes-overview?view=sql-server-ver16). Important to understand back-to-front, when a CCI <> a CCI (rowgroups & deltastore)
    1. [Clustered, Non-clustered & Heaps](https://learn.microsoft.com/en-us/azure/synapse-analytics/sql-data-warehouse/sql-data-warehouse-tables-overview)
    1. Partitioning. (Intentionally not providing a link! If you know your need them, you know)
1. [Queries](https://learn.microsoft.com/en-us/azure/synapse-analytics/sql-data-warehouse/cheat-sheet)
1. Create table!

## Challenge #4 - Deploying a full 'Analytics Platform' is hard!
As we moved from IaaS to PaaS that was an industry sigh of relief that we didnt need to install products anymore, nor login to a VM. All the "boring" stuff was taken care of by our cloud provider. Phew. </br>
However, every single Azure MDW solution will require *at least* more than one service which needs to communicate with one another. With the introduction of Private Endpoints, the complexity level to implement a full Enterprise Data Platform in Azure increased dramatically. </br> </br>
Let's review this diagram. It's a lot, and it's still missing stuff!

![EZAnalyticsPlatform](https://learn.microsoft.com/en-us/azure/architecture/example-scenario/analytics/media/azure-synapse-landing-zone.svg)
Source: https://learn.microsoft.com/en-us/azure/architecture/example-scenario/analytics/synapse-analytics-landing-zone

Examples: </br>
* https://learn.microsoft.com/en-us/azure/architecture/example-scenario/data/small-medium-data-warehouse
* https://learn.microsoft.com/en-us/azure/architecture/example-scenario/analytics/synapse-analytics-landing-zone 
* https://learn.microsoft.com/en-us/azure/architecture/example-scenario/dataplate2e/data-platform-end-to-end?tabs=portal
* https://learn.microsoft.com/en-us/azure/architecture/example-scenario/analytics/secure-data-lakehouse-synapse


Challenges
* Especially for smaller organisations, the deployment of a secure end-to-end Analytics Platform is hard to implement (and potentially overkill to requirements).
* Sometimes still need IaaS to glue PaaS services together.
* Billing model.


