# Discovery and Assessment

#### [prev](./choosewhichsql.md) | [home](./readme.md)  | [next](./remediation.md)

## Discovery
The discovery stage identifies existing servers, instances and databases and details about the features that are being used. This process involves scanning the network to identify your organization’s SQL estate together with the version and features in use.

### Tools for Discovery
1. **[Microsoft Assessment and Planning (MAP) Toolkit:](https://www.microsoft.com/en-us/download/details.aspx?id=7826&msclkid=8e7def7ecffe11ec8c3035a0624ed880)**
The MAP Toolkit is a free tool that you download and run offline to discover your Windows and SQL Server estate. 
1. **[Azure Migrate:](https://docs.microsoft.com/en-us/azure/migrate/migrate-services-overview)**
If you are planning a larger migration to Azure, it's recommended that you leverage Azure Migrate. It is the premier service for discovering in preparation to migrate to Azure. An 'appliance' can be downloaded and installed within your on-premises environment that can perform an agentless discovery.

## Assess
Now that you have _discovered_ your SQL environment, it's time to assess it's suitability to migrate to Azure. An assessment is a point-in-time snapshot of SQL environment and measures the readiness and estimates the effect of migrating to Azure. There are two primary parts of this phase:
1. Assessment tools
1. Testing. Although the tools to assess a SQL Server workload a very mature, you _must_ test your application and database on the target platform prior to migration.

### Tools for Assessment
1. **[Azure SQL migration extension for Azure Data Studio (ADS)](https://docs.microsoft.com/en-us/sql/azure-data-studio/extensions/azure-sql-migration-extension?view=sql-server-ver16)** provides a wizard to assess your SQL Server database(s) for migration readiness, get right-sized Azure recommendations and then migrate them to Azure SQL Managed Instance or to SQL Server on Azure Virtual Machines by choosing between the online or offline migration modes. With a streamlined assessment rule-set and being able to perform end-to-end migrations, it is easy to recommend.

1. **[Data Migration Assistant (DMA)](https://www.microsoft.com/en-us/download/details.aspx?id=53595)** is a stand-alone tool to assess SQL instances and databases. It has an extensive rule-set helps detect compatibility issues that can impact database functionality in your new version of SQL Server or Azure SQL Database.

1. **[Database Experimentation Assistant (DEA)](https://docs.microsoft.com/en-us/sql/dea/database-experimentation-assistant-overview?view=sql-server-ver15)** helps you evaluate how the workload on your source server will perform in your target system. It has the ability to capture a production workload and then replay it on Azure SQL Database, Azure SQL Managed Instance and SQL Server on Linux. It also can be used to perform regular A/B testing.

## Demos
1. **MAP ToolKit with sample database assessment** </br>
Step 1: [Preparing the system for discovery stage](https://docs.microsoft.com/en-us/sql/sql-server/migrate/guides/sql-server-to-sql-server-upgrade-guide?view=sql-server-ver16#discover-stage) </br>
Step 2: Understanding Database assessments reports </br>

1. **DMA [project creation](https://docs.microsoft.com/en-us/sql/dma/dma-migrateonpremsqltosqldb?view=sql-server-ver16#create-a-new-migration-project) with [sample database](https://github.com/microsoft/sql-server-samples/tree/master/samples/databases) assessment** </br>
[Data Migration Assistant: Configuration settings](https://docs.microsoft.com/en-us/sql/dma/dma-configurationsettings?view=sql-server-ver16) </br>
[Data Migration Assistant: Best Practices](https://docs.microsoft.com/en-us/sql/dma/dma-bestpractices?view=sql-server-ver16)

1. **[Azure Data Studio (ADS) with Migration Extension](https://docs.microsoft.com/en-us/sql/azure-data-studio/extensions/azure-sql-migration-extension)**
<!--* MAP_Training_Kit.zip. Available as a separate download. Contains sample database and instructions for completing various exercises.</br>
* MAPSetup.exe. Installation package containing the tool and SQL LocalDB.</br> -->

## Additional Information
* **[SQL Server Migration Assistant(SSMA)](https://docs.microsoft.com/en-us/sql/ssma/sql-server-migration-assistant?view=sql-server-ver15)** is a tool designed to automate database migration to SQL Server from Microsoft Access, DB2, MySQL, Oracle, and SAP ASE. It helps with assessment and migrations based on the standard computer information and information about use and performance it collects. SSMA doesn't collect your name, address, or any other data related to an identified or identifiable individual.</br>
• [SQL Server Migration Assistant for Access](https://docs.microsoft.com/en-us/sql/ssma/access/sql-server-migration-assistant-for-access-accesstosql?view=sql-server-ver15)</br>
• [SQL Server Migration Assistant for DB2](https://docs.microsoft.com/en-us/sql/ssma/db2/sql-server-migration-assistant-for-db2-db2tosql?view=sql-server-ver15)</br>
• [SQL Server Migration Assistant for MySQL](https://docs.microsoft.com/en-us/sql/ssma/mysql/sql-server-migration-assistant-for-mysql-mysqltosql?view=sql-server-ver15)</br>
• [SQL Server Migration Assistant for Oracle](https://docs.microsoft.com/en-us/sql/ssma/oracle/sql-server-migration-assistant-for-oracle-oracletosql?view=sql-server-ver15) </br>
• [SQL Server Migration Assistant for SAP ASE](https://docs.microsoft.com/en-us/sql/ssma/sybase/sql-server-migration-assistant-for-sybase-sybasetosql?view=sql-server-ver15)</br>