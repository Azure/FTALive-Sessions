## Synapse SQL dedicate pool SQL Dedicated Pools ( former DW)

##### Distribution keys consideration basics

As mentioned before, Serverless SQL pool allows you to query your data lake files, while dedicated SQL pool allows you to query and ingest data from your data lake files.

When data is ingested into dedicated SQL pool, the data is sharded into **distributions** to optimize the performance of the system. When you define a table you can choose which the pattern to distribute the data:

- Hash
- Round Robin
- Replicate

## Hash-distributed tables

A hash distributed table can deliver the highest query performance for joins and aggregations on large tables. To shard data into a hash-distributed table, dedicated SQL pool uses a hash function to deterministically assign each row to one distribution. In the table definition, one of the columns is designated as the distribution column. The hash function uses the values in the distribution column to assign each row to a distribution.

## Round-robin distributed tables

A round-robin table is the simplest table to create and delivers fast performance when used as a staging table for loads.

A round-robin distributed table distributes data evenly across the table but without any further optimization. A distribution is first chosen at random and then buffers of rows are assigned to distributions sequentially.

## Replicated tables

A replicated table provides the fastest query performance for small tables.

A table that is replicated caches a full copy of the table on each compute node. So, replicating a table removes the need to transfer data among compute nodes before a join or aggregation. Replicated tables are best utilized with small tables.



###### Reference:

[Synapse SQL architecture - Azure Synapse Analytics | Microsoft Docs](https://docs.microsoft.com/en-us/azure/synapse-analytics/sql/overview-architecture)