# Service Selection

[prev](./dataoperations.md) | [home](./introduction.md)  | [next](./QnA.md)

Now that we have covered type of data, type of database scenarios and types of operations. Now its easier to list the services required for various layers of your DataAnalytics Pipeline.The first layer is the storage layer (Whether you go for ETL or ELT modelling you will have to store you data at some point)

## Storage Layer(Databases)

By now you would have narrowed down 2 type of data:

1. Data you are bringing into cloud from 1 or more sources
2. Data you will derive after transformation.

You can navigate through [this](https://learn.microsoft.com/azure/architecture/guide/technology-choices/data-store-decision-tree) tree  or go to the portal directly and find your options for either
Datastores (RDBMS). You can also go to the portal and under the Databases section you will find choices for Database store.
![Azure Portal Database Section](/images/PortalDatabase.png)
-[Azure SQL Database](https://azure.microsoft.com/products/azure-sql/database/): A Fully managed database engine automates updates, provisioning, and backup
-[Azure SQL Managed Instance](https://azure.microsoft.com/products/azure-sql/managed-instance/): SQL Managed Instance is an intelligent cloud database service combining the broadest SQL Server engine compatibility (back to SQL Server 2008) with the benefits of a fully managed, up-to-date platform as a service
Likewise you can also find choices for you File stores under Storage section
![Azure Portal Storage](/images/PortalStorage.png)

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