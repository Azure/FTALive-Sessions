# Split of Data (Cont)

[prev](./splitofdata2.md.md) | [home](./introduction.md)  | [next]()

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

**Delta Lake** is an open source project that **enables building a lakehouse architecture on top of data lakes**. It implements the concept of **Delta Lake Transaction Log** which is an ordered record of every transaction that has ever been performed on a Delta Lake table since its inception.</br>

![DeltaLakeTopOfDataLakehouse](/images/DeltaLakeTopofLakehouse.png)

The transaction log is the mechanism through which Delta Lake is able to offer the guarantee of atomicity.Delta Lake provides ACID transactions, scalable metadata handling, and **unifies streaming and batch data processing** on top of existing data lakes, such as S3, ADLS, GCS, and HDFS. It eliminates the need of having additional OLTP engines due to its logging facility.Specifically, Delta Lake offers:

- **ACID transactions on Spark**: Serializable isolation levels ensure that readers never see inconsistent data.
- **Scalable metadata handling**: Leverages Spark distributed processing power to handle all the metadata for petabyte-scale tables with billions of files at ease.
- **Streaming and batch unification**: A table in Delta Lake is a batch table as well as a streaming source and sink. Streaming data ingest, batch historic backfill, interactive queries all just work out of the box.
- **Schema enforcement**: Automatically handles schema variations to prevent insertion of bad records during ingestion.
- **Time travel**: Data versioning enables rollbacks, full historical audit trails, and reproducible machine learning experiments.
- **Upserts and deletes**: Supports merge, update and delete operations to enable complex use cases like change-data-capture, slowly-changing-dimension (SCD) operations, streaming upserts, and so on.

## Additional Information

- [Synapse – Data Lake vs. Delta Lake vs. Data Lakehouse](https://techcommunity.microsoft.com/t5/azure-synapse-analytics-blog/synapse-data-lake-vs-delta-lake-vs-data-lakehouse/ba-p/3673653)
- [What is a Delta Lake](https://learn.microsoft.com/azure/synapse-analytics/spark/apache-spark-what-is-delta-lake)
