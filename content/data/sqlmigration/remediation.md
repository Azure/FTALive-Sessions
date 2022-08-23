# Remediation

#### [prev](./discoveryandassessment.md) | [home](./readme.md)  | [next](./migrationplanning.md)

# Pre-migration
The following covers the readiness phase of pre-migration steps of **Remediation of Sevrers/Instances**

## Remediation
The remediation steps consists of activities required to fix your database and application layer before migration
Each of the assessment tools mentioned in the previous modules provide reports which reflect changes in the following 3 categories
* Breaking changes - Which will block the migration
* Behavior changes - Which will impact the functionality in use (Application and Data Layer)
* Deprecated features - Which will not be supported in the latest versions

Diagrams below provide a rough overview of how each of the tools conducts the assessment

### **Reports Overview**
**1. MAP ToolKit Assessments** ->Detection but manual remediation

This tool collects several reports which includes and inventory for server instances and the databases contained. The sample looks as follows under the database section of the toolkit. <br/>

![MAPToolKit Database Section](/images/MAPAssessment1.png#left)

**Azure VM Readiness Section** <br />
The Azure VM Readiness section provides insights on readiness for you to migrate for IAAS offering. The remediation actions however reflect in the below snapshot alone. Most of the sections are self explanatory with excels providing insights on high level overview of the Microsoft SQL Server usage assessment. <br/>
![MAPToolKit VM Section](/images/MAPAssessment2.png#left)

**SQL Server Discovery Section** <br />
Likewise the SQL Server Details section provides SQL Server database instances and other SQL Server components which are elaborated in the Excels. You will still have to review these components against the [Feature Comparison](https://techcommunity.microsoft.com/t5/fasttrack-for-azure/feature-comparison-of-azure-sql-database-azure-sql-managed/ba-p/3154789) table to evaluate/ remediate any feature which is currently in use but unsupported in the Azure SQL flavor you choose (Azure SQL MI/Azure SQL Database/SQL server on Azure VM)
These details are helpful provide the usage is accurately captured in even deciding the service tiers which maybe a potential good fit. <br/>
![MAPToolKit SQL Section](/images/MAPAssessment3.png#left)

**2. [DMA Assessments](https://docs.microsoft.com/en-us/sql/dma/dma-assesssqlonprem?view=sql-server-ver16)**
->Detection, remediation help and migration

This provides a richer interface to the assessments. You can potentially fix for every issue identified under Breaking changes, Behavior changes, and Deprecated features. You also have the option to [saving/loading multiple reports](https://docs.microsoft.com/en-us/sql/dma/dma-save-load-assessments?view=sql-server-ver16) which comes in handy 

![DMA Multireport Assessment](/images/DMAMultipleReportsLoad.png)

**SQLAssessmentConsole -> SKU Recommendaitons** <br /> DMA also comes with the [SQLAssessmentConsole](https://docs.microsoft.com/en-in/sql/dma/dma-sku-recommend-sql-db?view=sql-server-ver16) which is a command line utility to help you capture performance data and recommed appropriate target for Azure SQL SKU based on the data captured

![DMA Recommendations](/images/DMARecommendations.png)

**3. [DEA Assessments](https://docs.microsoft.com/en-in/sql/dea/database-experimentation-assistant-view-report?view=sql-server-ver16)** ->Workload specific detection. 

This provides results for specific workloads. You can review the report for performance insights based on the A/B test you performed. This may or may not detect all the breaking/deprecated changes but useful in detecting behavioral changes for given workloads. Not very frequently used for assessment of the Azure SQL flavor(On-premise version upgrade) of compatibility but more from a performance perspective.

**4. [ADS Assessments](https://docs.microsoft.com/en-us/azure/dms/migration-using-azure-data-studio)** -> Detection, remediation help and migration

The Azure SQL migration extension supports assessment, get right-sized [Azure recommendations](https://docs.microsoft.com/en-us/azure/dms/ads-sku-recommend#performance-data-collection-and-sku-recommendation) and migrate your SQL Server database(s) to Azure.
- SQL Server on Azure Virtual Machines (SQL VM)
- Azure SQL Managed Instance (SQL MI)


![ADS Recommendations](/images/ADSRecommendations.png)

## SQL Migration Flow
In general [this](https://docs.microsoft.com/en-us/sql/sql-server/migrate/dma-azure-migrate-compare-migration-tools?view=sql-server-ver15#quick-comparison) is a good table for refernce to validate which tool to use when assessing your databases/instances

![](/images/MigrationFlow.png)


## Demos
**1) [DMA Reports](https://docs.microsoft.com/en-us/sql/dma/dma-assess-sql-data-estate-to-sqldb?view=sql-server-ver16)**

**2) [SKU Recommendations through SQLAssessmentConsole](https://docs.microsoft.com/en-us/sql/dma/dma-sku-recommend-sql-db?view=sql-server-ver16)**

**3) [ADS SKU Recommendations](https://docs.microsoft.com/en-us/azure/dms/ads-sku-recommend)**
