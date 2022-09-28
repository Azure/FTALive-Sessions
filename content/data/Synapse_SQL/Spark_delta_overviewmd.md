## Synapse SQL serverless pool 

****[Home](https://github.com/LiliamLeme/FTALive-Sessions_Synapse_SQL/blob/main/content/data/Synapse_SQL/Agenda.md)\****- [Next >](SynapseCETAS.md)

### Spark and Delta Integration overview

Azure Synapse Analytics provides multiple query runtimes that you can use to query in-database or external data. You have the choice to use T-SQL queries using a serverless Synapse SQL pool or notebooks in Apache Spark for Synapse analytics to analyse your data.

The serverless SQL pool also enables you to read the data stored in Delta Lake format, and serve it to reporting tools. A serverless SQL pool can read Delta Lake files that are created using Apache Spark, Azure Databricks, or any other producer of the Delta Lake format.

Delta Lake is an open-source storage layer that brings ACID (atomicity, consistency, isolation, and durability) transactions to Apache Spark and big data workloads. The current version of Delta Lake included with Azure Synapse has language support for Scala, PySpark, and .NET. It is not on the scope of this presentation to deep dive on the Delta specifics.

The core idea of Delta Lake is simple: information about which objects are part of a Delta table are maintaned in an ACID manner, using a write-ahead log
that is itself stored in the cloud object store. Based on this transactional design,  it is possible to  add multiple features in Delta Lake that are not available in traditional cloud data lakes like: Time travel to let users query point-in-time snapshots, UPSERT, DELETE and MERGE operations.

Syntax example: 

``` sql
SELECT TOP 10 *
FROM OPENROWSET(
    BULK 'https://sqlondemandstorage.blob.core.windows.net/delta-lake/folder/',
    FORMAT = 'delta') as rows;
   ```


The URI in the `OPENROWSET` function must reference the root Delta Lake folder that contains a subfolder called `_delta_log`.



**Example**: 

https://raw.githubusercontent.com/Azure-Samples/Synapse/main/SQL/Samples/LdwSample/SampleDB.sql

1) Create an external table example:

   ``` sql
   CREATE EXTERNAL DATA SOURCE DeltaLakeStorage
   WITH ( LOCATION = 'https://sqlondemandstorage.blob.core.windows.net/delta-lake/' );
   GO
   
   SELECT TOP 10 *
   FROM OPENROWSET(
           BULK 'covid',
           DATA_SOURCE = 'DeltaLakeStorage',
           FORMAT = 'delta'
       ) as rows;
       
       --Or Bulk it directly
       
       SELECT TOP 10 *
        FROM OPENROWSET(
        BULK 'https://sqlondemandstorage.blob.core.windows.net/delta-lake/covid/',
        FORMAT = 'delta'
    ) as rows;
   ```

   

2. Create with schema:

   ``` sql
    SELECT TOP 10 *
      FROM OPENROWSET(
              BULK 'covid',
              DATA_SOURCE = 'DeltaLakeStorage',
              FORMAT = 'delta'
          )
          WITH ( date_rep date,
                 cases int,
                 geo_id varchar(6)
                 ) as rows;
   
   
   ```

   Note: With the explicit specification of the result set schema, you can minimize the type sizes and use the more precise types VARCHAR(6) for string columns instead of pessimistic VARCHAR(1000). Minimization of types might significantly improve performance of your queries.




3) Partition elimination:

``` sql
    SELECT
            YEAR(pickup_datetime) AS year,
            passenger_count,
            COUNT(*) AS cnt
    FROM  
        OPENROWSET(
            BULK 'yellow',
            DATA_SOURCE = 'DeltaLakeStorage',
            FORMAT='DELTA'
        ) nyc
    WHERE
        nyc.year = 2017
        AND nyc.month IN (1, 2, 3)
        AND pickup_datetime BETWEEN CAST('1/1/2017' AS datetime) AND CAST('3/31/2017' AS datetime)
    GROUP BY
        passenger_count,
        YEAR(pickup_datetime)
    ORDER BY
        YEAR(pickup_datetime),
        passenger_count;
```



Note: The `OPENROWSET` function will eliminate partitions that don't match the `year` and `month` in the where clause. This file/partition pruning technique will significantly reduce your data set, improve performance, and reduce the cost of the query.

##### Limitations:

Review the limitations and the known issues on Synapse serverless SQL pool self-help page. [Self Help Serveless - Azure Synapse Analytics | Microsoft Docs](https://docs.microsoft.com/en-us/azure/synapse-analytics/sql/resources-self-help-sql-on-demand?tabs=x80070002#delta-lake)

Some of the limtiations are listed here, be sure you review them before build your queries:
- [ ] External tables don't support partitioning. Use partitioned views on the Delta Lake folder to use the partition elimination. 
- [ ] Serverless SQL pools don't support time travel queries.
- [ ] The CETAS command supports only Parquet and CSV as the output formats.
- [ ] Delta Lake support isn't available in dedicated SQL pools. Make sure that you use serverless SQL pools to query Delta Lake files
- [ ] Currently, both the Spark pool and serverless SQL pool in Azure Synapse Analytics support Delta Lake format. Serverless SQL pools do not support updating Delta Lake files. Only tables in Parquet format are shared from Spark pools to a serverless SQL pool. For more information, see Shared Spark tables.

##### Reference:

[Home | Delta Lake](https://delta.io/)

[Query Delta Lake format using serverless SQL pool - Azure Synapse Analytics | Microsoft Docs](https://docs.microsoft.com/en-us/azure/synapse-analytics/sql/query-delta-lake-format#query-partitioned-data)

[Synapse/SampleDB.sql at main · Azure-Samples/Synapse (github.com)](https://github.com/Azure-Samples/Synapse/blob/main/SQL/Samples/LdwSample/SampleDB.sql)

[Spark notebook can read data from SQL pool (microsoft.com)](https://techcommunity.microsoft.com/t5/azure-synapse-analytics-blog/query-serverless-sql-pool-from-an-apache-spark-scala-notebook/ba-p/2250968)

[Create and use views in serverless SQL pool - Azure Synapse Analytics | Microsoft Learn](https://learn.microsoft.com/en-us/azure/synapse-analytics/sql/create-use-views#delta-lake-views)
