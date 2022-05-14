# Welcome to FastTrack for Azure Live - SQL Migrations

## We will start 1-2 minutes after the scheduled time to accommodate those still connecting

This call will not be recorded due to the wide audience and to encourage questions.

**Questions?** Feel free to type them in the chat window at any time. Note that questions you post will be public.

**Slideless** No PowerPoint, we promise! As we update this content (aka.ms link to be created soon) you will get the changes straight away.

**Feedback** Please give us your feedback on https://aka.ms/ftalive-feedback

**Prerequisites**
You will need:

- Microsoft Teams desktop client or Teams web client to view presentation.
- Optional headphones to make it easier to listen to and interact with the presenters.

## SQL Migrations Assessment

### **Introduction to Azure SQL Platform**

The family of SQL cloud databases providing flexible options for application migration, modernization, and development.

[Azure SQL](https://azure.microsoft.com/products/azure-sql/#product-overview)

[What is Azure SQL?](https://docs.microsoft.com/azure/azure-sql/azure-sql-iaas-vs-paas-what-is-overview?view=azuresql)

[Azure SQL deployment options](https://docs.microsoft.com/learn/modules/azure-sql-intro/3-deployment-options)

**Choosing an Azure SQL Target**
[Feature comparison of Azure SQL Database, Azure SQL Managed Instance and SQL Server on a VM](https://techcommunity.microsoft.com/t5/fasttrack-for-azure/feature-comparison-of-azure-sql-database-azure-sql-managed/ba-p/3154789)

[T-SQL differences between SQL Server & Azure SQL Managed Instance - Azure SQL Managed Instance](https://docs.microsoft.com/azure/azure-sql/managed-instance/transact-sql-tsql-differences-sql-server?view=azuresql)

[Resolving T-SQL differences-migration](https://docs.microsoft.com/azure/azure-sql/database/transact-sql-tsql-differences-sql-server?view=azuresql)

### Migration Life Cycle

**cloud migration phases**

## <img src="./images/sqlmigrationphases.png" alt="sql migration phases" style="float: left; margin-right:10px;" />

**Discover and Assess**

- Look at your requirements
- Assess your workload
- Look at deployment options
- Use the right tools
- Analyze the results
- Plan for migration

**Tools to assist with Discovery and assessment**

**Azure Migrate**
Centralized migration service, to discover and assess your datacenter, and then migrate workloads to Azure.
Discover, assess, and migrate on-premises applications, infrastructure, and data.

[Assessment Overview (migrate to Azure SQL)](https://docs.microsoft.com/azure/migrate/concepts-azure-sql-assessment-calculation)

[Create an Azure SQL assessment](https://docs.microsoft.com/azure/migrate/how-to-create-azure-sql-assessment)

**DMA**

- Free download tool
- Assess SQL Server for possible migration blockers/warnings
- Get deployment recommendations with SQLAssessment.exe
- Automate through the command line

[Overview of Data Migration Assistant](https://docs.microsoft.com/sql/dma/dma-overview?view=sql-server-ver15)

[Get Azure SQL SKU recommendations (Data Migration Assistant)](https://docs.microsoft.com/sql/dma/dma-sku-recommend-sql-db?view=sql-server-ver15)

## Demo walkthrough

This session includes live demo, please refer the following links get all demo guide

### Demo 1 - Azure Data Studio

- Cross-platform
- Extension for Azure migration
- Assess SQL Server for possible migration blockers/warnings
- Get deployment recommendations
- Offline or online migrations to Azure

[Azure SQL migration extension for Azure Data Studio](https://docs.microsoft.com/sql/azure-data-studio/extensions/azure-sql-migration-extension?view=sql-server-ver15)

[Get SKU recommendations for Azure SQL migrations](https://techcommunity.microsoft.com/t5/azure-sql-blog/get-azure-recommendation-in-azure-sql-migration-extension/ba-p/3201479)

### Demo 2 - SSMA

**SSMA**
SQL Server Migration Assistant (SSMA) is a suite of five tools designed to automate database migration to SQL Server/Azure SQL platform from Microsoft Access, DB2, MySQL, Oracle, and SAP ASE.

[SQL Server Migration Assistant](https://docs.microsoft.com/sql/ssma/sql-server-migration-assistant?view=sql-server-2017)

**Data Access Migration Toolkit**

- Visual Studio Code extension that allows you to analyze Java and .Net source code and detect data access API calls and queries
- Queries collected using the Data Access Migration Toolkit can be analyzed using Data Migration Assistant to understand any queries that may break together with any related mitigating actions.
- [Data Access Migration Toolkit](https://marketplace.visualstudio.com/items?itemName=ms-databasemigration.data-access-migration-toolkit)

  [Assess an application’s data access layer with Data Migration Assistant](https://docs.microsoft.com/sql/dma/dma-assess-app-data-layer?view=sql-server-ver15)

**SQL Server on Azure VM**

[Checklist: Best practices & guidelines](https://docs.microsoft.com/azure/azure-sql/virtual-machines/windows/performance-guidelines-best-practices-checklist?view=azuresql)

[Collect baseline: Performance best practices & guidelines](https://docs.microsoft.com/azure/azure-sql/virtual-machines/windows/performance-guidelines-best-practices-collect-baseline?view=azuresql)

**Total Cost of Ownership Calculator**
[Total Cost of Ownership (TCO) Calculator](https://azure.microsoft.com/pricing/tco/calculator/)
