# Service Selection

[prev](./dataoperations.md) | [home](./introduction.md)  | [next](./QnA.md)

Now that we have covered type of data, type of database scenarios and types of operations its easier to list the services required for various layers of your DataAnalytics Pipeline. So when it comes to building the pipeline the first layer is the storage layer (Whether you go for ETL or ELT modelling you will have to store you data at some point).
> Note: You would have narrowed down 2 type of data:
>
>1. Data you are bringing into cloud from 1 or more sources
>2. Data you will derive after transformation.

## Storage Layer(Databases)

You can navigate through [this](https://learn.microsoft.com/azure/architecture/guide/technology-choices/data-store-decision-tree) tree  or go to the portal directly and find your options for either
Datastores (RDBMS). You can also go to the portal and under the Databases section you will find choices for Database store.

- 1. [Azure SQL Database](https://azure.microsoft.com/products/azure-sql/database/): A Fully managed database engine automates updates, provisioning, and backup.
- 2. [Azure SQL Managed Instance](https://azure.microsoft.com/products/azure-sql/managed-instance/): SQL Managed Instance is an intelligent cloud database service combining the broadest SQL Server engine compatibility (back to SQL Server 2008) with the benefits of a fully managed, up-to-date platform as a service.
- 3. [SQL Server on Azure VM](https://azure.microsoft.com/products/virtual-machines/sql-server/): Simple, familiar SQL Server for versatile Linux &/or Windows virtual machines.
- 4. [Azure Cache for Redis](https://azure.microsoft.com/products/cache/): A quick caching layer to the application architecture. It's a secure data cache and messaging broker that provides high throughput and low-latency access to data for applications as a managed service.
- 5. [Azure Cosmos DB](https://learn.microsoft.com/azure/cosmos-db/): A fully managed, distributed NoSQL & relational database for modern app development. It provides 6 different API's NoSQL, MongoDB, PostgreSQL, Apache Cassandra, Apache Gremlin & Table.
- 6. [Azure Database for MariaDB](https://azure.microsoft.com/products/mariadb/): A relational database service based on the open-source MariaDB Server engine. It works with popular open-source frameworks and languages and usually used for content management apps.
- 7. [Azure Database for MySQL](https://azure.microsoft.com/products/mysql/): A relational database service powered by the MySQL community edition. It works well with Cognitive Services, Kubernetes Service, Application services. Often used to deploy popular web apps, including Magento, Shopify, Moodle, Alfresco, Drupal, and WordPress.
- 8. [Azure Database for PostgreSQL](https://azure.microsoft.com/products/postgresql/): A relational database service based on the open-source Postgres database engine. It has extension such as Cron, PostGIS, and PLV8, and popular frameworks and languages like Ruby on Rails, Python with Django, Java with Spring Boot, and Node.js.

## Storage Layer(Files)

Likewise you can also find choices for you File stores under Storage section

- [Storage Account](https://azure.microsoft.com/products/category/storage/):
- 1.  [Azure Blob Storage](https://azure.microsoft.com/products/storage/blobs/):  Azure Blob Storage is optimized for storing massive amounts of unstructured data.It helps you create data lakes for your analytics needs, and provides storage to build powerful cloud-native and mobile apps.Users or client applications can access objects in Blob Storage via HTTP/HTTPS, from anywhere in the world. Objects in Blob Storage are accessible via the Azure Storage REST API, Azure PowerShell, Azure CLI, or an Azure Storage client library.
- 2. [Azure Data Lake Storage Gen2](https://azure.microsoft.com/products/storage/data-lake-storage/):Blob Storage supports Azure Data Lake Storage Gen2 (heirarchical storage accounts), Microsoft's enterprise big data analytics solution for the cloud. Designed from the start to service multiple petabytes of information while sustaining hundreds of gigabits of throughput. Azure Data Lake Storage Gen2 is primarily designed to work with Hadoop and all frameworks that use the Apache Hadoop Distributed File System (HDFS) as their data access layer.
- 3. [Azure Files](https://azure.microsoft.com/products/storage/files/):Azure Files offers fully managed file shares in the cloud that are accessible via the industry standard Server Message Block (SMB) protocol, Network File System (NFS) protocol, and Azure Files REST API. Azure file shares can be mounted concurrently by cloud or on-premises deployments. Mainly used as file shares
- 4. [Queue Storage](https://azure.microsoft.com/products/storage/queues/):Queue storage gives you asynchronous message queueing for communication between application components, whether they are running in the cloud, on the desktop, on-premises, or on mobile devices.
- 5. [Table Storage](https://azure.microsoft.com/products/storage/tables/): A NoSQL store for schemaless storage of structured data.Data in Azure Storage is also accessible via the REST API, which can be called by any language that makes HTTP/HTTPS requests.It provides rich client libraries for building apps with .NET, Java, Android, C++, Node.js, PHP, Ruby, and Python. The client libraries offer advanced capabilities for Table storage, including OData support for querying and optimistic locking capabilities

- [Azure NetApp Files](https://azure.microsoft.com/products/netapp/): Enterprise files storage, powered by NetApp: makes it easy for enterprise line-of-business (LOB) and storage professionals to migrate and run complex, file-based applications with no code change. These include migration (lift and shift) of POSIX-compliant Linux and Windows applications, SAP HANA, databases, high-performance compute (HPC) infrastructure and apps, and enterprise web applications.Azure NetApp Files is managed via NetApp accounts and can be accessed via NFS, SMB and dual-protocol volumes.

## Compute Layer(Integration,Operation)

### Some services offer a storage layer along with compute. They are as follows

These services offer 2 way advantages of compute and storage layers which you can design as per your organizational requirements. Most of them are compatible with Big Data.

- 1. [Azure Data Explorer](https://azure.microsoft.com/products/data-explorer/): Azure Data Explorer is a fast, fully managed data analytics service for real-time analysis on large volumes of data streaming. You can use Azure Data Explorer to collect, store, and analyze diverse data. An Azure Data Explorer cluster does all the work to ingest, process, and query your data.It can hold up to 10,000 databases and each database up to 10,000 tables.Azure Data Explorer also stores the data on Azure Storage and caches some of this data on the cluster compute nodes to achieve optimal query performance.
- 2. [Azure Synapse Analytics](https://azure.microsoft.com/products/synapse-analytics/): Azure Synapse is an enterprise analytics service that accelerates time to insight across data warehouses and big data systems.Gain insights from all your data, across data warehouses, data lakes, operational databases, and big data analytics systems.</br>
 A workspace is deployed in a specific region and has an associated ADLS Gen2 account and file system (for storing temporary data).Tables defined on files in the data lake are seamlessly consumed by either Spark or Hive. Azure Synapse Analytics allows the different workspace computational engines to share databases and tables between Apache Spark pools and serverless SQL pool.SQL and Spark can directly explore and analyze Parquet, CSV, TSV, and JSON files stored in the data lake.
- 3. [Azure Databricks](https://azure.microsoft.com/products/databricks/) :Azure Databricks has Data lakehouse foundation built on an open data lake for unified and governed data.Azure Databricks deploys compute clusters using cloud resources in your account to process and store data in object storage.Your data is stored at rest in your Azure account in the data plane
- 4. [Azure HDInsights](https://azure.microsoft.com/products/hdinsight/): Azure HDInsights is an Analytic Services used for open-source frameworks such as, Apache Spark, Apache Hive, LLAP, Apache Kafka, Hadoop and more, in your Azure environment.It can be used for various scenarios in big data processing like historical data (data that's already collected and stored) or real-time data (data that's directly streamed from the source).A Hadoop cluster consists of several virtual machines (nodes) that are used for distributed processing of tasks.This service handles implementation details of installation and configuration of individual nodes. HDInsight clusters can use the following storage options: Azure Data Lake Storage Gen2, Azure Data Lake Storage Gen1, Azure Storage General Purpose v2, Azure Storage General Purpose v1, Azure Storage Block blob (only supported as secondary storage). The default storage endpoint you specify a blob container of an Azure Storage account or Data Lake Storage.

### Service which offer only compute. They are as follows

If your source and destination in the DataAnalytics pipeline are definite these services are useful for creating the flow 

- 1. [Azure Data Factory](https://azure.microsoft.com/products/data-factory/): It is a serverless integration service which has in-built connectors to than 90 different types of sources. You can use ADF to construct ETL (extract, transform, and load) and ELT (extract, load, and transform) processes using intuitive environment or writing your own code.
- 2. [Azure Stream Analytics](https://azure.microsoft.com/products/stream-analytics/): It is a fully managed (PaaS) offering on Azure that lets you create a cluster that is compatible with reading real-time streaming data and process it with sub-milliseconds latencies. An Azure Stream Analytics job consists of an input, query, and an output. Jobs are executed on the clusters. It can connect to multiple sources and sinks
- 3. [Azure Event Hubs](https://azure.microsoft.com/products/event-hubs/): It is a modern big data streaming platform and event ingestion service. This service lets you Ingest, buffer, store, and process your stream in real time to get actionable insights.Capture your data in near-real time in an Azure Blob storage or Azure Data Lake Storage for long-term retention or micro-batch processing. Event Hubs enables you to focus on data processing rather than on data capture.It has SDKs available in various languages: .NET, Java, Python, JavaScript, you can easily start processing your streams from Event Hubs.
- 4. [Azure Analysis Services](https://azure.microsoft.com/products/analysis-services/): Much like SQL Server Analysis Services this fully managed service is used to combine data from multiple sources into a single, trusted BI semantic model.Tabular models are relational modeling constructs (model, tables, columns), articulated in tabular metadata object definitions in Tabular Model Scripting Language (TMSL) and Tabular Object Model (TOM) code.Multidimensional models and PowerPivot for SharePoint are not supported in Azure Analysis Services.

## Presentation layer(consolidation and governance)