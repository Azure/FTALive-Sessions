# Split of Data (Cont)

[prev](./splitofdata2.md.md) | [home](./introduction.md)  | [next](./dataoperations.md)

This is in continuation for database scenarios which help you narrow down your storage options. 

>Note: ACID stands for atomicity, consistency, isolation, and durability.
>
> Atomicity means that all transactions either succeed or fail completely.</br>
> Consistency guarantees relate to how a given state of the data is observed by simultaneous operations.</br>
> Isolation refers to how simultaneous operations potentially conflict with one another.</br>
> Durability means that committed changes are permanent.</br>

## Analytical Data

**Data Lakehouse** helps you **store data into various layers/zones**. However with the growing volumes of data, you might not want to have additional OLTP or OLAP stores apart from the Data Lakehouse. Without TLog capabilities, you can see the before and after image of data through different layers but not capture the exact changes made. This brings into picture a needs to not just store the refined form of data but the ability to track delta records (transformation made) to arrive at the higher layers. This is achieved through Delta Lake architectures

### 7) Delta Lakes

**Delta Lake** is an open source project that **enables building a lakehouse architecture on top of data lakes**. It implements the concept of **Delta Lake Transaction Log** which is an ordered record of every transaction that has ever been performed on a Delta Lake table since its inception.

![DeltaLake](/images/DeltaLakeTopofLakehouse.png)

The transaction log is the mechanism through which Delta Lake is able to offer the guarantee of atomicity.Delta Lake provides ACID transactions, scalable metadata handling, and **unifies streaming and batch data processing** on top of existing data lakes, such as S3, ADLS, GCS, and HDFS. It eliminates the need of having additional OLTP engines due to its logging facility.Specifically, 

![DeltaTables](/images/DeltaTables.png)

Delta tables consist of data stored in Parquet files and metadata stored in the transaction log.
The Parquet files enable you to track the evolution of the data. Indexes and statistics about the files
are maintained to increase query efficiency. The Delta Lake transaction log can be appended to by multiple writers that are mediated by optimistic concurrency control that provide serializable ACID transactions. Changes to the table are stored as ordered atomic units called commits. The log can be read in parallel by a cluster of Spark executors.

![DeltaLakeQueries](/images/DeltaLakeQueries.png)

Delta Lake offers:

- **ACID transactions on Spark**: Serializable isolation levels ensure that readers never see inconsistent data.
- **Scalable metadata handling**: Leverages Spark distributed processing power to handle all the metadata for petabyte-scale tables with billions of files at ease.
- **Streaming and batch unification**: A table in Delta Lake is a batch table as well as a streaming source and sink. Streaming data ingest, batch historic backfill, interactive queries all just work out of the box.
- **Schema enforcement**: Automatically handles schema variations to prevent insertion of bad records during ingestion.
- **Time travel**: Data versioning enables rollbacks, full historical audit trails, and reproducible machine learning experiments.
- **Upserts and deletes**: Supports merge, update and delete operations to enable complex use cases like change-data-capture, slowly-changing-dimension (SCD) operations, streaming upserts, and so on.

#### When to use Delta Lake solutions

Consider Delta Lake solutions when you first have a requirement for Data Lake

- Data lake stores are often used in event streaming or IoT scenarios, because they can persist large amounts of relational and nonrelational data without transformation or schema definition.
And you need ability **to handle ACID properties within the heirarchical storage layer.**

![DeltaLake](/images/DeltaLakeUsage.png)

## Additional Information

- [Synapse – Data Lake vs. Delta Lake vs. Data Lakehouse](https://techcommunity.microsoft.com/t5/azure-synapse-analytics-blog/synapse-data-lake-vs-delta-lake-vs-data-lakehouse/ba-p/3673653)
- [What is a Delta Lake](https://learn.microsoft.com/azure/synapse-analytics/spark/apache-spark-what-is-delta-lake)
- [Delta Lake Z order](https://delta.io/blog/2023-06-03-delta-lake-z-order/)
- [Convert from Parquet to Delta](https://delta.io/blog/2022-09-23-convert-parquet-to-delta/)
- [How to create Delta Tables](https://delta.io/blog/2022-10-25-create-delta-lake-tables/)
- [Delta Lake Merge](https://delta.io/blog/2023-02-14-delta-lake-merge/)
- [How to use Delta Lake generated columns](https://delta.io/blog/2023-04-12-delta-lake-generated-columns/)
- [Delta Lake Time Travel](https://delta.io/blog/2023-02-01-delta-lake-time-travel/)
- [Easier data model management for Power BI using Delta Live Tables](https://techcommunity.microsoft.com/t5/analytics-on-azure-blog/easier-data-model-management-for-power-bi-using-delta-live/ba-p/3500698)
- [Delta Lake: Keeping It Fast and Clean](https://towardsdatascience.com/delta-lake-keeping-it-fast-and-clean-3c9d4f9e2f5e)

## POC Repos

- [Data warehousing with dedicated SQL pool in Azure Synapse Analytics](https://learn.microsoft.com/azure/synapse-analytics/guidance/proof-of-concept-playbook-dedicated-sql-pool)
- [Data lake exploration with serverless SQL pool in Azure Synapse Analytics](https://learn.microsoft.com/azure/synapse-analytics/guidance/proof-of-concept-playbook-serverless-sql-pool)
- [Big data analytics with Apache Spark pool in Azure Synapse Analytics](https://learn.microsoft.com/azure/synapse-analytics/guidance/proof-of-concept-playbook-spark-pool)
- [FTA Analytics Box](https://github.com/Azure/AnalyticsinaBox/tree/main)

> FTA Repo contains:</br>
> Pattern 1: Azure Synapse Analytics workspace with a Data Lake and Serverless & Dedicated SQL Pools. </br>
> Pattern 2: Azure Synapse Analytics workspace with a Data Lake, Serverless & Dedicated SQL Pools and Spark Pools.</br>
> Pattern 3: Streaming solution with an Azure Function (Event Generator), Event Hubs, Synapse with Spark Pool and Streaming Notebook and a Data Lake (ADLSv2). Deployed via Azure DevOps.</br>
> Pattern 4: Batch loading example from a source SQL database through to a Data Lake using Synapse Spark.</br>
> Pattern 5: Metadata Driven Synapse Pipelines with Azure SQL DB Source, Data Lake/Parquet Sink and Synapse Serverless Star Schema </br>

## Videos Glossary

- [Getting Started with Delta Lake](https://delta.io/blog/2020-09-16-getting-started-with-delta-lake/)
