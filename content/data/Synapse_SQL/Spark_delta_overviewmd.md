## Synapse SQL serverless pool 

*Home* - [Next >](Summary.md)

### Spark and Delta Integration overview

Azure Synapse Analytics provides multiple query runtimes that you can use to query in-database or external data. You have the choice to use T-SQL queries using a serverless Synapse SQL pool or notebooks in Apache Spark for Synapse analytics to analyse your data.

The serverless SQL pool also enables you to read the data stored in Delta Lake format, and serve it to reporting tools. A serverless SQL pool can read Delta Lake files that are created using Apache Spark, Azure Databricks, or any other producer of the Delta Lake format.

Syntax example: 

SELECT TOP 10 *
FROM OPENROWSET(
    BULK 'https://sqlondemandstorage.blob.core.windows.net/delta-lake/folder/',
    FORMAT = 'delta') as rows;



The URI in the `OPENROWSET` function must reference the root Delta Lake folder that contains a subfolder called `_delta_log`.



**Example**: 

https://raw.githubusercontent.com/Azure-Samples/Synapse/main/SQL/Samples/LdwSample/SampleDB.sql

1) Create an external table example:

   ```
   CREATE EXTERNAL DATA SOURCE DeltaLakeStorage
   WITH ( LOCATION = 'https://sqlondemandstorage.blob.core.windows.net/delta-lake/' );
   GO
   
   SELECT TOP 10 *
   FROM OPENROWSET(
           BULK 'covid',
           DATA_SOURCE = 'DeltaLakeStorage',
           FORMAT = 'delta'
       ) as rows;
   ```

   

2. Create with schema:

   ```
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

```
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

##### Reference:

[Query Delta Lake format using serverless SQL pool - Azure Synapse Analytics | Microsoft Docs](https://docs.microsoft.com/en-us/azure/synapse-analytics/sql/query-delta-lake-format#query-partitioned-data)

[Synapse/SampleDB.sql at main · Azure-Samples/Synapse (github.com)](https://github.com/Azure-Samples/Synapse/blob/main/SQL/Samples/LdwSample/SampleDB.sql)

[Spark notebook can read data from SQL pool (microsoft.com)](https://techcommunity.microsoft.com/t5/azure-synapse-analytics-blog/query-serverless-sql-pool-from-an-apache-spark-scala-notebook/ba-p/2250968)
