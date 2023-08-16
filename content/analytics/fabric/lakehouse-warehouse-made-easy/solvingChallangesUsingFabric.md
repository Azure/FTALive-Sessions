
# How does Microsoft Fabric solve The current challenges in Data Analytics Solution?

## SaaS Foundation

- **all-in-one** analytics solution under one platform, all data services are seamlessly integrated.
  - Services within Microsoft Fabric:
    - *Data Engineering*: Empowers data engineers with Spark for transformation and Lakehouse democratization. Integrates with Data Factory for scheduling.
    - *Data Factory*: Unites Power Query's simplicity with Azure's scale. 200+ connectors enable efficient data movement.
    - *Data Science*: Seamlessly deploys Azure Machine Learning models. Enriches data for predictive BI insights.
    - *Data Warehouse*: High SQL performance, scalable with independent compute/storage. Utilizes Delta Lake format.
    - *Real-Time Analytics*: Excels with high-volume, semi-structured observational data.
    - *Power BI*: Leading BI platform for intuitive Fabric data access.

- **Less management overhead**. Fabric allows creators to concentrate on producing their best work, freeing them from the need to integrate, manage, or understand the underlying infrastructure that supports the experience.

- **Enterprise Capabilities are pre-provisioned as part of the tenant**
  - [Flexible Licensing](https://learn.microsoft.com/en-us/fabric/enterprise/licenses)
    - [Pause and Resume Capacity](https://learn.microsoft.com/en-us/fabric/enterprise/pause-resume)
    - [ability to resize the Capacities.](https://learn.microsoft.com/en-us/fabric/enterprise/scale-capacity)
  - Inbuilt Monitoring App [[Microsoft Fabric Capacity metrics app](https://learn.microsoft.com/en-us/fabric/enterprise/metrics-app-install?tabs=1st)]

- **Data Governance** </br>
 Data Governance capabilities that are provided in Microsoft Fabric:
  - [Information Protection](https://learn.microsoft.com/en-us/fabric/governance/information-protection)
  - [Item Endorsement](https://learn.microsoft.com/en-us/fabric/get-started/endorsement-promote-certify#promote-items) (Promotion, Certification)
  - [Lineage](https://learn.microsoft.com/en-us/fabric/governance/lineage)
  - [Impact Analysis](https://learn.microsoft.com/en-us/fabric/governance/impact-analysis) on the items
  
## OneLake, OneCopy, OneSecurity
### [OneLake](https://learn.microsoft.com/en-us/fabric/onelake/onelake-overview)

OneLake is a single, unified, logical data lake for the whole organization. Like OneDrive, OneLake comes automatically with every Microsoft Fabric tenant and is designed to be the single place for all your analytics data.

![OneLake](https://learn.microsoft.com/en-us/fabric/onelake/media/onelake-overview/use-same-copy-of-data.png)

- Each tenant is allocated a singular Azure Data Lake known as OneLake, which is provisioned automatically upon the addition of a new Fabric tenant. Within each tenant, numerous workspaces can be established, facilitating workload separation and department-specific access control across the organization.
- The data in OneLake is automatically indexed for discovery, MIP labels, lineage, PII scans, sharing, governance and compliance

- **[Shortcuts](https://learn.microsoft.com/en-us/fabric/onelake/onelake-shortcuts)** Shortcuts allow organization to easily share data between users and applications without having to move and duplicate information unnecessarily.
- The data of all Fabric elements such as data warehouses and Lakehouse is automatically stored in OneLake using the **delta parquet** format.

### OneCopy

OneLake targets to maximize the utility derived from a single copy of data, eliminating the need for data duplication or movement. We will no longer have to duplicate data to utilize it with a different engine.

- One Copy of data with capability to access it from multiple compute engines (T-SQL, Spark, Analysis Services, etc.).

### OneSecurity

[Getting Started with OneLake Security](https://learn.microsoft.com/en-us/fabric/onelake/get-started-security)

- OneLake is a hierarchical data lake, similar to Azure Data Lake Gen2, WIndows File system. This structure allows us to provide data access to be set at different levels like
  - workspace security (Roles: Admin, Members, Contributor, Viewer)
  - item security (Roles : Read, ReadAll, ReadData, Write)
  - object security. (Roles: GRANT/DENY on SQL objects)
- [Sharing capabilities](https://learn.microsoft.com/en-us/fabric/get-started/share-items) :  We can share items to the internal user or to the external user from the same workspace.
- Authentication (Azure AD credential pass through, Service Principal)

## [DirectLake](https://learn.microsoft.com/en-us/power-bi/enterprise/directlake-overview) - New Storage Mode in Power BI

The objective of DirectLake mode is to address the limitations found in both Direct Query and Import modes, while also integrating the benefits of each of these modes.

Storage Mode| Pros| Cons
---------|----------|---------
 Direct Query | Real Time Data, No limitation in Data size, No overhead in Data Refresh | Lower in Performance, Limited DAX support, Less data source compatibility
 Import Mode | Faster in performance, Additional Data Transformation, Offline access, no dependency with the source system once the data is loaded | Data Staleness, Very large volume of data, ETL overhead during Data Refresh, Data copy is required.

![DirectLake](https://learn.microsoft.com/en-us/power-bi/enterprise/media/directlake-overview/directlake-diagram.png)

- Direct Lake is a fast-path to load the data from the lake straight into the Power BI engine, ready for analysis.
- By directly fetching data from OneLake, Direct Lake mode removes the need for data import.
- Unlike DirectQuery, it doesn't involve translation to different query languages or execution on other databases, leading to performance comparable to import mode.
- This approach enables real-time updates from the data source without the requirement for explicit imports, blending the benefits of DirectQuery and import modes while removing their drawbacks.



## What is Lakehouse?
Lakehouse are data architectures that allow organizations to store and manage structured and unstructured data in a single location, using various tools and frameworks to process and analyze that data. This can include SQL-based queries and analytics, as well as machine learning and other advanced analytics techniques.

- **Key Capabilities**
  - Delta tables are the foundation of Lakehouse tables, offering features like ACID transactions, time travel, and schema evolution.
  - These Lakehouse tables can be interacted with via pyspark in notebooks for both reading and writing, as well as through the SQL endpoint for read-only operations.
  
### How many different ways we can upload the data into Lakehouse?
- **[Data Engineering with Spark](https://learn.microsoft.com/en-us/fabric/data-engineering/data-engineering-overview)**
- **[Data Pipelines](https://learn.microsoft.com/en-us/fabric/data-factory/data-factory-overview)**
- **[Dataflow](https://learn.microsoft.com/en-us/fabric/data-factory/create-first-dataflow-gen2)**

### Which option to be used when?
[Decision Guide](https://learn.microsoft.com/en-us/fabric/get-started/decision-guide-pipeline-dataflow-spark)

### **Data Engineering with Spark**
![Data Engineering Home Page](https://learn.microsoft.com/en-us/fabric/data-engineering/media/data-engineering-overview/data-engineering-artifacts.png)
Data engineering in Microsoft Fabric enables users to design, build, and maintain infrastructures and systems that enable their organizations to collect, store, process, and analyze large volumes of data.

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

### Demo 1.1 : Data Ingestion in Lakehouse using Data Engineering Notebook

- Source: [TpcH data](https://www.tpc.org/TPC_Documents_Current_Versions/download_programs/tools-download-request5.asp?bm_type=TPC-H&bm_vers=3.0.1&mode=CURRENT-ONLY)
- Destination: Lakehouse
- Ingestion method: Using the Data Engineering Notebook.
- Important Links :
  - [Creating Delta Tables in Microsoft Fabric](https://learn.microsoft.com/en-us/training/modules/work-delta-lake-tables-fabric/3-create-delta-tables)
  - [working with delta table in spark.](https://learn.microsoft.com/en-us/training/modules/work-delta-lake-tables-fabric/4-work-delta-data)

### Demo 1.2 : Data Aggregation and Time Travel of Delta tables in Lakehouse

- [Time Traveling in Delta table](https://techcommunity.microsoft.com/t5/azure-synapse-analytics-blog/synapse-spark-delta-time-travel/ba-p/3646789)

### Demo 1.3 : Creating Dimension and Fact tables in Lakehouse for the PBI reporting

### Demo 1.4 : Create PBI dataset/model and PBI Report using DirectLake mode

## Data Warehouse

Data warehousing workloads benefit from the rich capabilities of the ***SQL engine over an open data format***, enabling customers to focus on data preparation, analysis and reporting over a single copy of their data stored in their Microsoft OneLake.

### How many different ways we can upload the data into Data Warehouse?

- **[COPY INTO](https://learn.microsoft.com/en-us/sql/t-sql/statements/copy-into-transact-sql?view=fabric&preserve-view=true) / [CTAS](https://learn.microsoft.com/en-us/fabric/data-warehouse/ingest-data-tsql#creating-a-new-table-with-the-result-of-a-query-by-using-create-table-as-select-ctas) T-SQL command**- Code rich data ingestion operation for the highest data ingestion throughput possible.
- Data pipeline - Low code or no code approach for moving the data.
- Dataflow - code free approach including some custom transformations. 

### Key Capabilities
- Schema support.
- [Multi-table transactions support](https://learn.microsoft.com/en-us/fabric/data-warehouse/transactions) - For example, we can commit inserts to multiples tables, or, none of the tables if an error arises.
- [cross database queries are possible](https://learn.microsoft.com/en-us/fabric/data-warehouse/query-warehouse#write-a-cross-database-query).
- [Clone table is supported ](https://learn.microsoft.com/en-us/fabric/data-warehouse/clone-table) - A zero-copy clone creates a replica of the table by copying the metadata, while still referencing the same data files in OneLake. 

[**Limitations in Data Warehouse**](https://learn.microsoft.com/en-us/fabric/data-warehouse/tables#limitations)

<!-- 
Demo: Ingest data into Delta Tables. Present in Power BI via Direct Lake.

Still need to decide on lakehouse or warehouse, but, not ‘locked in’. All engines can access the delta tables.
Demo: Talk through decision tree
Demo: Build Warehouse, read via Lakehouse. Vise Versa.

Warehouse – it’s like a super evolution & simplification of Dedicated SQL Pool.
Demo: Compared Dedicated SQL Pool vs Warehouse

It’s easy to get started on Fabric. Can leverage low-code approaches, and progress from there as your solution matures.
‘All in one’ billing with CUs.
SaaS benefits over PaaS (but also some downsides).
Demo: Compare the ‘full’ Azure analytics architecture vs Fabric.
Talk: Briefly cover CUs (the awesomeness of bursting and smoothing). -->
