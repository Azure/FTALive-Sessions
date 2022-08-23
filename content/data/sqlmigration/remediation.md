# Remediation

#### [prev](./discoveryandassessment.md) | [home](./readme.md)  | [next](./migrationplanning.md)

## Remediation
The remediation steps consists of activities required to fix your database and application layer before migration
Each of the assessment tools mentioned in the previous modules provide reports which reflect changes in the following 3 categories
* Breaking changes - Which will block the migration
* Behavior changes - Which will impact the functionality in use (Application and Data Layer)
* Deprecated features - Which will not be supported in the latest versions

Diagrams below provide a rough overview of how each of the tools conducts the assessment

### **Reports Overview**
**1. MAP ToolKit Assessments** ->Detection but manual remediation

This tool collects several reports which includes and inventory for server instances and the databases contained. The sample looks as follows under the database section of the toolkit. 

![MAPToolKit Database Section](/images/MAPAssessment1.png#left)

##### Azure VM Readiness Section
The Azure VM Readiness section provides insights on readiness for you to migrate for IAAS offering. The remediation actions however reflect in the above snapshot alone. Most of the sections are self explanatory with excels providing insights on high level overview of the Microsoft SQL Server usage assessment. 

![MAPToolKit VM Section](/images/MAPAssessment2.png#left)![VM Readiness Excel](/images/MAPSQLSummary1.png#right)

##### Azure VM Readiness Section
Likewise the SQL Server Details section provides SQL Server database instances and other SQL Server components. 

You will still have to review these components against the [Feature Comparison](https://techcommunity.microsoft.com/t5/fasttrack-for-azure/feature-comparison-of-azure-sql-database-azure-sql-managed/ba-p/3154789) table to evaluate/ remediate any feature which is currently in use but unsupported in the Azure SQL flavor you choose (Azure SQL MI/Azure SQL Database/SQL server on Azure VM)
These details are helpful provide the usage is accurately captured in even deciding the service tiers which maybe a potential good fit. 

![MAPToolKit SQL section](/images/MAPAssessment3.png#left) 
![SQL Assessments Excel](/images/MAPSQLSummary1.png#left)![SQL Database Assessments Excel](/images/MAPSQLSummary2.png)
