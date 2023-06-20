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

- [Azure SQL Database](https://azure.microsoft.com/products/azure-sql/database/): A Fully managed database engine automates updates, provisioning, and backup.
- [Azure SQL Managed Instance](https://azure.microsoft.com/products/azure-sql/managed-instance/): SQL Managed Instance is an intelligent cloud database service combining the broadest SQL Server engine compatibility (back to SQL Server 2008) with the benefits of a fully managed, up-to-date platform as a service.
- [SQL Server on Azure VM](https://azure.microsoft.com/products/virtual-machines/sql-server/): Simple, familiar SQL Server for versatile Linux &/or Windows virtual machines.
- [Azure Cache for Redis](https://azure.microsoft.com/products/cache/): A quick caching layer to the application architecture. It's a secure data cache and messaging broker that provides high throughput and low-latency access to data for applications as a managed service.
- [Azure Cosmos DB](https://learn.microsoft.com/azure/cosmos-db/): A fully managed, distributed NoSQL & relational database for modern app development. It provides 6 different API's NoSQL, MongoDB, PostgreSQL, Apache Cassandra, Apache Gremlin & Table.
- [Azure Database for MariaDB](https://azure.microsoft.com/products/mariadb/): A relational database service based on the open-source MariaDB Server engine. It works with popular open-source frameworks and languages and usually used for content management apps.
- [Azure Database for MySQL](https://azure.microsoft.com/products/mysql/): A relational database service powered by the MySQL community edition. It works well with Cognitive Services, Kubernetes Service, Application services. Often used to deploy popular web apps, including Magento, Shopify, Moodle, Alfresco, Drupal, and WordPress.
- [Azure Database for PostgreSQL](https://azure.microsoft.com/products/postgresql/): A relational database service based on the open-source Postgres database engine. It has extension such as Cron, PostGIS, and PLV8, and popular frameworks and languages like Ruby on Rails, Python with Django, Java with Spring Boot, and Node.js.

Likewise you can also find choices for you File stores under Storage section

- [Storage Account](https://azure.microsoft.com/products/category/storage/):
- 1.  [Azure Blob Storage](https://azure.microsoft.com/products/storage/blobs/):  Azure Blob Storage is optimized for storing massive amounts of unstructured data.It helps you create data lakes for your analytics needs, and provides storage to build powerful cloud-native and mobile apps.Users or client applications can access objects in Blob Storage via HTTP/HTTPS, from anywhere in the world. Objects in Blob Storage are accessible via the Azure Storage REST API, Azure PowerShell, Azure CLI, or an Azure Storage client library.
- 2. [Azure Data Lake Storage Gen2](https://azure.microsoft.com/products/storage/data-lake-storage/):Blob Storage supports Azure Data Lake Storage Gen2 (heirarchical storage accounts), Microsoft's enterprise big data analytics solution for the cloud. Designed from the start to service multiple petabytes of information while sustaining hundreds of gigabits of throughput. Azure Data Lake Storage Gen2 is primarily designed to work with Hadoop and all frameworks that use the Apache Hadoop Distributed File System (HDFS) as their data access layer.
- 3. [Azure Files](https://azure.microsoft.com/products/storage/files/):Azure Files offers fully managed file shares in the cloud that are accessible via the industry standard Server Message Block (SMB) protocol, Network File System (NFS) protocol, and Azure Files REST API. Azure file shares can be mounted concurrently by cloud or on-premises deployments. Mainly used as file shares
- 

## Compute Layer(Integration,Operation)

Some services offer a storage layer along with compute. They are as follows
-[Azure Data Explorer](https://azure.microsoft.com/products/data-explorer/): Azure Data Explorer is a fast, fully managed data analytics service for real-time analysis on large volumes of data streaming. You can use Azure Data Explorer to collect, store, and analyze diverse data
-[Azure Databricks](https://azure.microsoft.com/products/databricks/)
Azure Databricks has Data lakehouse foundation built on an open data lake for unified and governed data.
Azure Databricks deploys compute clusters using cloud resources in your account to process and store data in object storage

the Azure Databricks workspace, an environment for accessing all of your Azure Databricks objects.
load data into a lakehouse backed by Delta Lake

HDInsight clusters can use the following storage options:
Azure Data Lake Storage Gen2, Azure Data Lake Storage Gen1, Azure Storage General Purpose v2, Azure Storage General Purpose v1, Azure Storage Block blob (only supported as secondary storage)

Service which offer only compute
-[Azure Data Factory](https://azure.microsoft.com/products/data-factory/): It is a serverless integration service which has in-built connectors to than 90 different types of sources. You can use ADF to construct ETL (extract, transform, and load) and ELT (extract, load, and transform) processes using intuitive environment or writing your own code.
-[Azure Analysis Services](https://azure.microsoft.com/products/analysis-services/)
Services that offer

## Presentation layer(consolidation and governance)