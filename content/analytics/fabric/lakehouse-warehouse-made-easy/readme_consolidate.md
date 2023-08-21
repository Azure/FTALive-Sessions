## Microsoft Fabric

Microsoft Fabric brings together new and existing components from Power BI, Azure Synapse, and Azure Data Factory into a single integrated environment. These components are then presented in various customized user experiences.
</br>

![Fabric Diagram](https://learn.microsoft.com/en-us/fabric/get-started/media/microsoft-fabric-overview/saas-foundation.png 'Fabric Services') </br>
(Image source: [Microsoft Fabric Overview](https://learn.microsoft.com/en-us/fabric/get-started/microsoft-fabric-overview))
</br>

Let's explore how Microsoft Fabric can help address the existing challenges we could encounter when constructing the analytics solution.

## Challenge: Deploying a full 'Analytics Platform' is hard!
As we moved from IaaS to PaaS there was an industry sigh of relief that we didn't need to install products anymore, nor login to a VM. All the "boring" stuff was taken care of by our cloud provider. Phew. </br>
However, every single Azure MDW solution will require *at least* more than one service which needs to communicate with one another. With the introduction of Private Endpoints, the complexity level to implement a full Enterprise Data Platform in Azure increased significantly. </br> </br>
Let's review this diagram. It's a lot, and it's still missing stuff!

![EZAnalyticsPlatform](https://learn.microsoft.com/en-us/azure/architecture/example-scenario/analytics/media/azure-synapse-landing-zone.svg)
[Source](https://learn.microsoft.com/en-us/azure/architecture/example-scenario/analytics/synapse-analytics-landing-zone)

Additional Architecture Examples:
* https://learn.microsoft.com/en-us/azure/architecture/example-scenario/data/small-medium-data-warehouse
* https://learn.microsoft.com/en-us/azure/architecture/example-scenario/analytics/synapse-analytics-landing-zone 
* https://learn.microsoft.com/en-us/azure/architecture/example-scenario/dataplate2e/data-platform-end-to-end?tabs=portal
* https://learn.microsoft.com/en-us/azure/architecture/example-scenario/analytics/secure-data-lakehouse-synapse


**Challenges**
* Especially for smaller organisations, the deployment of a secure end-to-end Analytics Platform is complex (and potentially overkill to requirements).
* Sometimes still need IaaS to glue PaaS services together.
* Billing model.

## Solution: How does Microsoft Fabric simplify the deployment of a comprehensive analytics solution?
### SaaS Foundation

- **all-in-one** analytics solution under one platform, all data services are seamlessly integrated.
  - Services within Microsoft Fabric:
    - *Data Engineering*: Empowers data engineers with Spark for transformation and Lakehouse democratization. Integrates with Data Factory for scheduling.
    - *Data Factory*: Unites Power Query's simplicity with Azure's scale. 200+ connectors enable efficient data movement.
    - *Data Science*: Seamlessly deploys Azure Machine Learning models. Enriches data for predictive BI insights.
    - *Data Warehouse*: High performance SQL, scalable with independent compute / storage. Utilizes Delta Lake format for data files.
    - *Real-Time Analytics*: Excels with high-volume, semi-structured observational data.
    - *Power BI*: Leading BI platform for intuitive Fabric data access.
- **Less management overhead**. Fabric allows creators to concentrate on producing their best work, freeing them from the need to integrate, manage, or understand the underlying infrastructure that supports the experience.
- **Enterprise Capabilities are pre-provisioned as part of the tenant**
  - [Flexible Licensing](https://learn.microsoft.com/en-us/fabric/enterprise/licenses)
    - [Pause and Resume Capacity](https://learn.microsoft.com/en-us/fabric/enterprise/pause-resume)
    - [Ability to resize Capacities](https://learn.microsoft.com/en-us/fabric/enterprise/scale-capacity)
  - [Inbuilt Monitoring App](https://learn.microsoft.com/en-us/fabric/enterprise/metrics-app-install?tabs=1st)
- **Data Governance** capabilities that are provided in Microsoft Fabric:
  - [Information Protection](https://learn.microsoft.com/en-us/fabric/governance/information-protection)
  - [Item Endorsement](https://learn.microsoft.com/en-us/fabric/get-started/endorsement-promote-certify#promote-items) (Promotion, Certification)
  - [Lineage](https://learn.microsoft.com/en-us/fabric/governance/lineage)
  - [Impact Analysis](https://learn.microsoft.com/en-us/fabric/governance/impact-analysis) on the items

### **Demo** : Let's explore how we can access the Microsoft Fabric today.

### FAQ
1. What happened to Power BI? 
1. [How do I enable Fabric?](https://techcommunity.microsoft.com/t5/educator-developer-blog/step-by-step-guide-to-enable-microsoft-fabric-for-microsoft-365/ba-p/3831115)
1. [Can I trial Fabric?](https://learn.microsoft.com/en-us/fabric/get-started/fabric-trial#start-the-fabric-preview-trial)
1. Is it a replacement to Azure Synapse?
1. When will it go GA?
</br>
</br>

--------------------------------------------------------------------
--------------------------------------------------------------------

## Challenge: Multiple file formats, duplication of data and multiple transfers within an analytics solution

Consider an example MDW pattern:
1. Data is copied from source to a Raw zone within a data lake in .json format.
1. Data is then transformed & copied into higher zones within the Data Lake in  Parquet.
1. For the presentation layer, data is transferred to a different location & format. For this example, into a Data Mart hosted in an Azure SQL DB.
1. Data is copied from Azure SQL DB into Power BI.

Challenges: 
* Let's count the different data formats.
* Decisions around file formats and storage mechanisms.
* Let's count the number of copies
* Decisions around preparing the data in the right format, with the right engine at the right time.

Additional Challenge: </br>
A 'Data Lake' is not a monolithic construct. It can be made up of several pieces such as Azure Storage Accounts, Azure Data Lake Gen2 (ADLSv2) accounts and even storage external to Azure such as AWS S3.</br>

Challenges:
* How do I access & process data that is not directly within my main Data Lake storage?

## Solution: OneLake, OneCopy & OneSecurity in Microsoft Fabric
### [OneLake](https://learn.microsoft.com/en-us/fabric/onelake/onelake-overview)

OneLake is a single, unified, logical data lake for the whole organization. Like OneDrive, OneLake comes automatically with every Microsoft Fabric tenant and is designed to be the single place for all your analytics data.

![OneLake](https://learn.microsoft.com/en-us/fabric/onelake/media/onelake-overview/use-same-copy-of-data.png)
(Image source: [OneLake overview](https://learn.microsoft.com/en-us/fabric/onelake/onelake-overview))
- Each tenant is allocated a single 'Data Lake' known as OneLake, which is provisioned automatically upon the addition of a new Fabric tenant. Within each tenant, numerous workspaces can be established, facilitating workload separation and department-specific access control across the organization.
- The data in OneLake is automatically indexed for discovery.
- [Microsoft Information Protection (MIP) labels](https://blog.fabric.microsoft.com/en-us/blog/microsoft-365-data-microsoft-fabric-better-together/)
- Lineage, PII scans, sharing, governance and compliance.

- **[Shortcuts](https://learn.microsoft.com/en-us/fabric/onelake/onelake-shortcuts)** Shortcuts allow organization to easily share data between users and applications without having to move and duplicate information unnecessarily.
- The data of all Fabric elements such as Data Warehouse and Lakehouse is automatically stored in OneLake using the **delta parquet** format.

### OneCopy
OneLake targets to maximize the utility derived from a single copy of data, eliminating the need for data duplication or movement. We will no longer have to duplicate data to utilize it with a different engine.

- One Copy of data with capability to access it from multiple compute engines (T-SQL, Spark, Power BI etc.).

### OneSecurity
[Getting Started with OneLake Security](https://learn.microsoft.com/en-us/fabric/onelake/get-started-security)

- OneLake is a hierarchical data lake, similar to Azure Data Lake Gen2 and Windows File System. This structure allows us to provide data access to be set at different levels like
  - Workspace security (Roles: Admin, Members, Contributor, Viewer)
  - Item security (Roles : Read, ReadAll, ReadData, Write)
  - Object security. (Roles: GRANT/DENY on SQL objects)
- [Sharing](https://learn.microsoft.com/en-us/fabric/get-started/share-items):  We can share items to the internal or external users or from the same workspace.
- Authentication (Azure AD credential pass through, Service Principal).

### Demo: OneLake

--------------------------------------------------------------------
--------------------------------------------------------------------


## Challenge: Lakehouse vs Warehouse / Spark or SQL?
When building a MDW on Azure, many organisations must make a decision to choose between the storage, compute and language options of Lakehouse vs Warehouse and Spark vs SQL.  </br>
Some considerations:
* Warehouse / SQL
  * Transformations are written in SQL & saved as Stored Procedures.
  * Compute occurs inside SQL SMP or MPP engine.
  * Storage *usually* tightly coupled to compute.
  * Engine generally supports full ACID properties *across tables* or even other databases.
  * Historical and large skill-set within the market.
* Lakehouse / Spark
  * Transformations are written in Python, Spark SQL, Scala, R or Java. saved within notebooks.
  * Compute occurs inside scale-out Apache Spark engine.
  * Separation of compute and storage.
  * Flexibility to still write SQL.
  * Emerging skill-set within the market (but improving)

## Solution: What if we could combine both the Spark and SQL engines together?

### What is Lakehouse?
Lakehouses are data architectures that allow organisations to store and manage structured and unstructured data in a single location, using various tools and frameworks to process and analyze that data. This can include SQL-based queries and analytics, as well as machine learning and other advanced analytics techniques.

- **Key Capabilities**
  - **Delta tables** are the foundation of Lakehouse tables, offering features like ACID transactions, time travel, and schema evolution.
  - These Lakehouse tables can be interacted with via PySpark in notebooks for both reading and writing, as well as through the SQL endpoint for read-only operations.
  
#### How many different ways we can upload the data into Lakehouse?
- **[Data Engineering with Spark](https://learn.microsoft.com/en-us/fabric/data-engineering/data-engineering-overview)**
- **[Data Pipelines](https://learn.microsoft.com/en-us/fabric/data-factory/data-factory-overview)**
- **[Dataflow](https://learn.microsoft.com/en-us/fabric/data-factory/create-first-dataflow-gen2)**

#### Which option to be used when?
[Decision Guide](https://learn.microsoft.com/en-us/fabric/get-started/decision-guide-pipeline-dataflow-spark)

#### **Data Engineering with Spark**
![Data Engineering Home Page](https://learn.microsoft.com/en-us/fabric/data-engineering/media/data-engineering-overview/data-engineering-artifacts.png) </br>
Data Engineering in Microsoft Fabric enables users to design, build, and maintain infrastructures and systems that enable their organizations to collect, store, process, and analyze large volumes of data.

**Key Capabilities**
- **[Autotune](https://learn.microsoft.com/en-us/fabric/data-engineering/autotune?tabs=sparksql)** automatically tunes Apache Spark configurations to minimize workload execution time and optimizes workloads. It basically uses the below property to adjust the performance.
  - *spark.sql.shuffle.partitions* - configures the number of partitions to use when shuffling data for joins or aggregations. Default is 200.
  - *spark.sql.autoBroadcastJoinThreshold* - configures the maximum size in bytes for a table that will be broadcasted to all worker nodes when performing a join. Default is 10 MB.
  - *spark.sql.files.maxPartitionBytes* - the maximum number of bytes to pack into a single partition when reading files. Works for Parquet, JSON and ORC file-based sources. Default is 128 MB.
- [**Starter pool**](https://learn.microsoft.com/en-us/fabric/data-engineering/spark-compute#starter-pools) enables us to start the spark session within 5-10 seconds without any manual setup. With every Fabric capacity, we get a default spark pool.
- We can create our own [**custom spark pool**](https://learn.microsoft.com/en-us/fabric/data-engineering/capacity-settings-management) as well.
- [**V-Order optimization**](https://learn.microsoft.com/en-us/fabric/data-engineering/delta-optimization-and-v-order?tabs=sparksql) is enabled by default. V-Order is a write time optimization to the parquet file format that enables lightning-fast reads under the Microsoft Fabric compute engines, such as Power BI, SQL, Spark and others.  V-Order sorting has a 15% impact on average write times but provides up to 50% more compression.
  
### **Data Pipelines**

Data Factory capabilities in Microsoft Fabric.

### Lakehouse Demos
#### 1.1 - Data Ingestion in Lakehouse using Data Engineering Notebook

- Source: [TpcH data](https://www.tpc.org/TPC_Documents_Current_Versions/download_programs/tools-download-request5.asp?bm_type=TPC-H&bm_vers=3.0.1&mode=CURRENT-ONLY)
- Destination: Lakehouse
- Ingestion method: Using the Data Engineering Notebook.
- Important Links :
  - [Creating Delta Tables in Microsoft Fabric](https://learn.microsoft.com/en-us/training/modules/work-delta-lake-tables-fabric/3-create-delta-tables)
  - [Working with delta table in spark.](https://learn.microsoft.com/en-us/training/modules/work-delta-lake-tables-fabric/4-work-delta-data)


#### Demo 1.2 - Creating Dimension and Fact tables in Lakehouse for the PBI reporting

### Data Warehouse
Data warehousing workloads benefit from the rich capabilities of the ***SQL engine over an open data format***, enabling customers to focus on data preparation, analysis and reporting over a single copy of their data stored in their Microsoft OneLake.

#### How many different ways we can upload the data into Data Warehouse?

- **[COPY INTO](https://learn.microsoft.com/en-us/sql/t-sql/statements/copy-into-transact-sql?view=fabric&preserve-view=true) / [CTAS](https://learn.microsoft.com/en-us/fabric/data-warehouse/ingest-data-tsql#creating-a-new-table-with-the-result-of-a-query-by-using-create-table-as-select-ctas) T-SQL command**- Code rich data ingestion operation for the highest data ingestion throughput possible.
- Data pipeline - Low code or no code approach for moving the data.
- Dataflow - code free approach including some custom transformations. 

#### Key Capabilities
- Schema support.
- [Multi-table transactions support](https://learn.microsoft.com/en-us/fabric/data-warehouse/transactions) - For example, we can commit inserts to multiples tables, or, none of the tables if an error arises.
- [Cross database queries are possible](https://learn.microsoft.com/en-us/fabric/data-warehouse/query-warehouse#write-a-cross-database-query).
- [Clone table is supported ](https://learn.microsoft.com/en-us/fabric/data-warehouse/clone-table) - A zero-copy clone creates a replica of the table by copying the metadata, while still referencing the same data files in OneLake. </br>
</br>

[**Limitations in Data Warehouse**](https://learn.microsoft.com/en-us/fabric/data-warehouse/tables#limitations)
</br>
</br>

--------------------------------------------------------------------
--------------------------------------------------------------------

## Challenge: Power BI Import Mode or DirectQuery

Storage Mode| Pros| Cons
---------|----------|---------
 Direct Query | Real Time Data, No limitation in Data size, No overhead in Data Refresh | Lower in Performance, Limited DAX support, Less data source compatibility
 Import Mode | Faster in performance, Additional Data Transformation, Offline access, no dependency with the source system once the data is loaded | Data Staleness, Very large volume of data, ETL overhead during Data Refresh, Data copy is required.

## Solution: DirectLake Mode.

The objective of DirectLake mode is to address the limitations found in both Direct Query and Import modes, while also integrating the benefits of each of these modes.


![DirectLake](https://learn.microsoft.com/en-us/power-bi/enterprise/media/directlake-overview/directlake-diagram.png)

- Direct Lake is a fast-path to load the data from the lake straight into the Power BI engine, ready for analysis.
- By directly fetching data from OneLake, Direct Lake mode removes the need for data import.
- Unlike DirectQuery, it doesn't involve translation to different query languages or execution on other databases, leading to performance comparable to import mode.
- This approach enables real-time updates from the data source without the requirement for explicit imports, blending the benefits of DirectQuery and import modes while removing their drawbacks.

#### Demo : Create PBI dataset/model and PBI Report using DirectLake mode


## Summary
Below is a summary of what was covered in this session.

1. Data format decision made: Microsoft has 'gone big' on Delta Parquet (also known as Delta Tables, V-Ordered Tables, Verti-Parquet). 
1. Engines modified to support common data storage medium
1. PaaS vs SaaS
1. Less data copies. Less duplication
1. Create a Lakehouse, let Warehouse query the data.
1. Create a Warehouse, let Lakehouse query the data.
1. Power BI Direct Lake mode - best of both worlds.
