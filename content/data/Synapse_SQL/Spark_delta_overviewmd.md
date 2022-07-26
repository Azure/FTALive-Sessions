## Synapse SQL serverless pool 

***\*[Home](../tobedefined.md)\**** 



### Spark and Delta Integration overview

Azure Synapse Analytics provides multiple query runtimes that you can use to query in-database or external data. You have the choice to use T-SQL queries using a serverless Synapse SQL pool or notebooks in Apache Spark for Synapse analytics to analyze your data.

The serverless SQL pool also enables you to read the data stored in Delta Lake format, and serve it to reporting tools. A serverless SQL pool can read Delta Lake files that are created using Apache Spark, Azure Databricks, or any other producer of the Delta Lake format.

Syntax example: 

SELECT TOP 10 *
FROM OPENROWSET(
    BULK 'https://sqlondemandstorage.blob.core.windows.net/delta-lake/covid/',
    FORMAT = 'delta') as rows;



The URI in the `OPENROWSET` function must reference the root Delta Lake folder that contains a subfolder called `_delta_log`.



**Example**: <tbd>



##### Reference:

[Query Delta Lake format using serverless SQL pool - Azure Synapse Analytics | Microsoft Docs](https://docs.microsoft.com/en-us/azure/synapse-analytics/sql/query-delta-lake-format#query-partitioned-data)

[Synapse/SampleDB.sql at main · Azure-Samples/Synapse (github.com)](https://github.com/Azure-Samples/Synapse/blob/main/SQL/Samples/LdwSample/SampleDB.sql)

[Spark notebook can read data from SQL pool (microsoft.com)](https://techcommunity.microsoft.com/t5/azure-synapse-analytics-blog/query-serverless-sql-pool-from-an-apache-spark-scala-notebook/ba-p/2250968)