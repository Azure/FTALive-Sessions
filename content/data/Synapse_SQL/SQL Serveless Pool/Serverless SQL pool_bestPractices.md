#### **Synapse Serverless SQL pool** 

[Back<](https://github.com/LiliamLeme/FTALive-Sessions_Synapse_SQL/blob/main/content/data/Synapse_SQL/SQL%20Serveless%20Pool/Serveless_Query_Basics.md) -[Home](https://github.com/LiliamLeme/FTALive-Sessions_Synapse_SQL/blob/main/content/data/Synapse_SQL/SQL%20Serveless%20Pool/Agenda_serveless.md)\- [>Next](https://github.com/LiliamLeme/FTALive-Sessions_Synapse_SQL/blob/main/content/data/Synapse_SQL/SQL%20Serveless%20Pool/SynapseCETAS.md)

#### Best Practices

**CSV optimizations**

Here are best practices for using CSV files in serverless SQL pool.

**Use PARSER_VERSION 2.0 to query CSV files**

You can use a performance-optimized parser when you query CSV files. For details, see [PARSER_VERSION](https://learn.microsoft.com/en-us/azure/synapse-analytics/sql/develop-openrowset).

**Manually create statistics for CSV files**

Serverless SQL pool relies on statistics to generate optimal query execution plans. Statistics are automatically created for columns in Parquet files when needed, as well as CSV files when using OPENROWSET. At this moment, statistics aren't automatically created for columns in CSV files when using external tables. Create statistics manually for columns that you use in queries, particularly those used in DISTINCT, JOIN, WHERE, ORDER BY, and GROUP BY. Check [statistics in serverless SQL pool](https://learn.microsoft.com/en-us/azure/synapse-analytics/sql/develop-tables-statistics#statistics-in-serverless-sql-pool) for details.

**Use proper collation to utilize predicate pushdown for character columns**

Data in a Parquet file is organized in row groups. Serverless SQL pool skips row groups based on the specified predicate in the WHERE clause, which reduces IO. The result is increased query performance.

Predicate pushdown for character columns in Parquet files is supported for Latin1_General_100_BIN2_UTF8 collation only. You can specify collation for a particular column by using a WITH clause. If you don't specify this collation by using a WITH clause, the database collation is used.

**Optimize repeating queries**

Here are best practices for using CETAS in serverless SQL pool.

**Use CETAS to enhance query performance and joins**

[CETAS](https://learn.microsoft.com/en-us/azure/synapse-analytics/sql/develop-tables-cetas) is one of the most important features available in serverless SQL pool. CETAS is a parallel operation that creates external table metadata and exports the SELECT query results to a set of files in your storage account.

You can use CETAS to materialize frequently used parts of queries, like joined reference tables, to a new set of files. You can then join to this single external table instead of repeating common joins in multiple queries.

As CETAS generates Parquet files, statistics are automatically created when the first query targets this external table. The result is improved performance for subsequent queries targeting table generated with CETAS.

##### References:

This page explains common best practices as seen with a lot of customers. You can find the full list of best practices at the following page: https://learn.microsoft.com/en-us/azure/synapse-analytics/sql/best-practices-serverless-sql-pool 

There is also a YouTube channel which explains best practices from both Serverless and Dedicated SQL Pools which can be found over here: https://www.youtube.com/playlist?list=PLzUAjXZBFU9NA7VzOjOzpuNzEE8ZmRbRP
