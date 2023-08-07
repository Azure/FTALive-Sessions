# How does Microsoft Fabric solve The current challanges in Data Analytics Solution?

## SaaS Foundation

- **all-in-one** analytics solution under one platform, all data services are seamlessly integrated.
  - Here are the services that Microsoft Fabric offers:

    - *Data Engineering*: Empowers data engineers with Spark for transformation and lakehouse democratization. Integrates with Data Factory for scheduling.    
    - *Data Factory*: Unites Power Query's simplicity with Azure's scale. 200+ connectors enable efficient data movement.    
    - *Data Science*: Seamlessly deploys Azure Machine Learning models. Enriches data for predictive BI insights.    
    - *Data Warehouse*: High SQL performance, scalable with independent compute/storage. Utilizes Delta Lake format.    
    - *Real-Time Analytics*: Excels with high-volume, semi-structured observational data.    
    - *Power BI*: Leading BI platform for intuitive Fabric data access.

-  **Less management overhead**. Fabric allows creators to concentrate on producing their best work, freeing them from the need to integrate, manage, or understand the underlying infrastructure that supports the experience.
  
- **Enterprise Capabilities are pre-provisioned as part of the teannt**
  - [Flexible Licensing](https://learn.microsoft.com/en-us/fabric/enterprise/licenses)
    - [Pause and Resume Capacity](https://learn.microsoft.com/en-us/fabric/enterprise/pause-resume)
    - [ability to resize the Capacities.](https://learn.microsoft.com/en-us/fabric/enterprise/scale-capacity) 
  - Inbuilt Monitoring App [[Microsoft Fabric Capacity metrices app](https://learn.microsoft.com/en-us/fabric/enterprise/metrics-app-install?tabs=1st) ]

  
- **Data Governance**
  Here are some inbilt Data Governance capabilities that are provided in Micrsoft Fabric.
  - [ Information Protection ](https://learn.microsoft.com/en-us/fabric/governance/information-protection)
  - [Item Endorsement](https://learn.microsoft.com/en-us/fabric/get-started/endorsement-promote-certify#promote-items) (Promotion, Cetrification)
  - [Lineage](https://learn.microsoft.com/en-us/fabric/governance/lineage)
  - [Impact Analysis](https://learn.microsoft.com/en-us/fabric/governance/impact-analysis) on the items
  


## OneLake, OneCopy, OneSecurity

### OneLake
OneLake is a single, unified, logical data lake for the whole organization. Like OneDrive, OneLake comes automatically with every Microsoft Fabric tenant and is designed to be the single place for all your analytics data.

- Each tenant is allocated a singular Azure Data Lake known as OneLake, which is provisioned automatically upon the addition of a new Fabric tenant. Within each tenant, numerous workspaces can be established, facilitating workload separation and department-specific access control across the organization.
- **[Shortcuts](https://learn.microsoft.com/en-us/fabric/onelake/onelake-shortcuts)** Shortcuts allow organization to easily share data between users and applications without having to move and duplicate information unnecessarily.
- The data of all Fabric elements such as data warehouses and lakehouses is automatically stored in OneLake using the **delta parquet** format.


### OneCopy
OneLake tragets to maximize the utility derived from a single copy of data, eliminating the need for data duplication or movement. We will no longer have to duplicate data to utilize it with a different engine.

- One Copy of data with capabilty to access it from multiple compute engines (T-SQL, Spark, Analysis Services, etc.). 

### OneSecurity
[Getting Started with OneLake Security](https://learn.microsoft.com/en-us/fabric/onelake/get-started-security)

* OneLake is a hierarchical data lake, similar to Azure Data Lake Gen2, WIndows File system. This structure allows us to provide data access to be set at different levels like 
  * workspace security (Roles: Admin, Members, Contributor, Viewer)
  * item security (Roles : Read, ReadAll, ReadData, Write)
  * object security. (Roles: GRANT/DENY on SQL objects)

* [Sharing capabilities](https://learn.microsoft.com/en-us/fabric/get-started/share-items) :  We can share items to the internal user or to the external user from the same workspace. 
* Authetication (Azure AD credential pass through, Service Principal)

## [DirectLake](https://learn.microsoft.com/en-us/power-bi/enterprise/directlake-overview) - New Storage Mode in Power BI

The objective of DirectLake mode is to address the limitations found in both Directquery and Import modes, while also integrating the benefits of each of these modes.

Storage Mode| Pros| Cons
---------|----------|---------
 Direct Query | Real Time Data, No limitation in Data size, No overhead in Data Refresh | Lower in Performance, Limited DAX support, Less data source compatibility
 Import Mode | Faster in performance, Additional Data Tranformation, Offline access, no depedency with the source system once the data is loaded | Data Staleness, Very large volume of data, ETL overhead during Data Refresh, Data copy is required.

![DirectLake](https://learn.microsoft.com/en-us/power-bi/enterprise/media/directlake-overview/directlake-diagram.png)

- Direct Lake is a fast-path to load the data from the lake straight into the Power BI engine, ready for analysis. 
- By directly fetching data from OneLake, Direct Lake mode removes the need for data import. 
- Unlike DirectQuery, it doesn't involve translation to different query languages or execution on other databases, leading to performance comparable to import mode. 
- This approach enables real-time updates from the data source without the requirement for explicit imports, blending the benefits of DirectQuery and import modes while evading their drawbacks. Direct Lake mode is well-suited for analyzing extensive datasets and data sources that undergo frequent updates.

<!-- Standardise on Delta Parquet. - Done
Accessible to all engines within Fabric - Done
Accessible by external Spark engines  - Done-->
<!-- Power BI Direct Lake mode - 
Connect to Azure (ADLSv2) and other cloud storage!
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
