# Discovery and Assessment

#### [prev](./choosewhichsql.md) | [home](./readme.md)  | [next](./remediation.md)


# Pre-migration
The process involves conducting an inventory of the databases that you need to migrate. 
The following two sections cover the pre-migration steps of **discover, assess.**

## Discover
The discover stage identifies existing data sources and details about the features that are being used. It's helpful to get a better understanding of and plan for the migration. This process involves scanning the network to identify all your organization’s SQL instances together with the version and features in use

### **Tools for Discovery**
**1. [Microsoft Assessment and Planning (MAP) Toolkit](https://www.microsoft.com/en-us/download/details.aspx?id=7826&msclkid=8e7def7ecffe11ec8c3035a0624ed880)**
Microsoft recommends that you use Azure Migrate to simplify your migration process. Azure Migrate provides discovery, assessment, and migration capabilities for applications, infrastructure, and data.</br>
[How it works using Azure Migrate ?](https://docs.microsoft.com/en-us/sql/sql-server/migrate/guides/sql-server-to-sql-server-upgrade-guide?view=sql-server-ver16#discover) </br>
The Azure Migrate appliance performs this discovery using the Windows OS domain or non-domain credentials or SQL Server authentication credentials that have access to the SQL Server instances and databases running on the targeted servers. This discovery process is agentless that is, nothing is installed on the target servers.</br>

## Assess
An assessment with the Discovery and assessment tool is a point in time snapshot of data and measures the readiness and estimates the effect of migrating on-premises servers to Azure

### **Tools for Assessment** (Azure Migrate, DMA, DEA)

**1. [Microsoft Assessment and Planning (MAP) Toolkit](https://www.microsoft.com/en-us/download/details.aspx?id=7826&msclkid=8e7def7ecffe11ec8c3035a0624ed880)**</br>
[How it works using Azure Migrate ? ](https://docs.microsoft.com/en-us/azure/migrate/concepts-azure-sql-assessment-calculation#types-of-assessments)
Assessments that make recommendations based on collected performance data
The Azure SQL configuration is based on performance data of SQL instances and databases, which includes: CPU utilization, Memory utilization, IOPS (Data and Log files), throughput and latency of IO operations.

**2. [Data Migration Assistant(DMA)](https://www.microsoft.com/en-us/download/details.aspx?id=53595)** is a stand-alone tool to assess SQL Servers. It helps detect compatibility issues that can impact database functionality in your new version of SQL Server or Azure SQL Database.</br>
[How it works using DMA](https://docs.microsoft.com/en-us/sql/dma/dma-migrateonpremsqltosqldb?view=sql-server-ver16)
It helps pinpoint potential problems blocking migration. It identifies unsupported features, new features that can benefit you after migration, and the right path for database migration. The detailed list of its capabilities can be found [here.](https://docs.microsoft.com/en-us/sql/dma/dma-overview?view=sql-server-ver16#capabilities)


**3. [Database Experimentation Assistant(DEA)](https://docs.microsoft.com/en-us/sql/dea/database-experimentation-assistant-overview?view=sql-server-ver15)** helps you evaluate how the workload on your source server (in your current environment) will perform in your new environment. It has the ability to capture and replay on Azure SQL Database, Azure SQL Managed Instance and SQL Server on Linux.</br>
[How it works using DEA](https://docs.microsoft.com/en-us/sql/dea/database-experimentation-assistant-overview?view=sql-server-ver15#solution-architecture-for-comparing-workloads) :DEA guides you through running an A/B test by completing three stages:</br>
	Step I) Capturing a workload trace on the source server.</br>
	Step II) Replaying the captured workload trace on target 1 and target 2.</br>
  Step III) Analyzing the replayed workload traces collected from target 1 and target 2.</br>

**4. [Azure SQL migration extension for Azure Data Studio(ADS)](https://docs.microsoft.com/en-us/sql/azure-data-studio/extensions/azure-sql-migration-extension?view=sql-server-ver16)**. It enables you to use the SQL Server assessment and migration capability in Azure Data Studio.
It provides a wizard to assess your SQL Server database(s) for migration readiness, get right-sized Azure recommendations and then migrate them to Azure SQL Managed Instance or to SQL Server on Azure Virtual Machines by choosing between the online or offline migration modes.</br>
[How it works using ADS ?](https://docs.microsoft.com/en-us/azure/dms/migration-using-azure-data-studio)
ADS is a component of Azure Database Migration Service (DMS)
With the Azure SQL migration extension, you can get a right-sized Azure recommendation to migrate your SQL Server databases to Azure SQL Managed Instance or SQL Server on Azure Virtual Machines. The extension collects and analyzes performance data from your SQL Server instance to generate a recommended SKU each for Azure SQL Managed Instance and SQL Server on Azure Virtual Machines 

**5. [SQL Server Migration Assistant(SSMA)](https://docs.microsoft.com/en-us/sql/ssma/sql-server-migration-assistant?view=sql-server-ver15)** is a tool designed to automate database migration to SQL Server from Microsoft Access, DB2, MySQL, Oracle, and SAP ASE. It helps with assessment and migrations based on the standard computer information and information about use and performance it collects. SSMA doesn't collect your name, address, or any other data related to an identified or identifiable individual.

• [SQL Server Migration Assistant for Access](https://docs.microsoft.com/en-us/sql/ssma/access/sql-server-migration-assistant-for-access-accesstosql?view=sql-server-ver15)</br>
• [SQL Server Migration Assistant for DB2](https://docs.microsoft.com/en-us/sql/ssma/db2/sql-server-migration-assistant-for-db2-db2tosql?view=sql-server-ver15)</br>
• [SQL Server Migration Assistant for MySQL](https://docs.microsoft.com/en-us/sql/ssma/mysql/sql-server-migration-assistant-for-mysql-mysqltosql?view=sql-server-ver15)</br>
• [SQL Server Migration Assistant for Oracle](https://docs.microsoft.com/en-us/sql/ssma/oracle/sql-server-migration-assistant-for-oracle-oracletosql?view=sql-server-ver15) </br>
• [SQL Server Migration Assistant for SAP ASE](https://docs.microsoft.com/en-us/sql/ssma/sybase/sql-server-migration-assistant-for-sybase-sybasetosql?view=sql-server-ver15)</br>


## Demos
**1) MAP ToolKit with sample database assessment**
Step 1: [Preping the system for discovery stage](https://docs.microsoft.com/en-us/sql/sql-server/migrate/guides/sql-server-to-sql-server-upgrade-guide?view=sql-server-ver16#discover-stage) </br>
Step 2: Understanding Database assessments reports </br>
* MAP_Training_Kit.zip. Available as a separate download. Contains sample database and instructions for completing various exercises.</br>
* MAPSetup.exe. Installation package containing the tool and SQL LocalDB.</br>

**2) DMA [project creation](https://docs.microsoft.com/en-us/sql/dma/dma-migrateonpremsqltosqldb?view=sql-server-ver16#create-a-new-migration-project) with [sample database](https://github.com/microsoft/sql-server-samples/tree/master/samples/databases) assessment**

* [Data Migration Assistant: Configuration settings](https://docs.microsoft.com/en-us/sql/dma/dma-configurationsettings?view=sql-server-ver16)
* [Data Migration Assistant: Best Practices](https://docs.microsoft.com/en-us/sql/dma/dma-bestpractices?view=sql-server-ver16)
   
**3) DEA viewing reports with sample database assessment**
* [Configure Distributed Replay for DEA](https://docs.microsoft.com/en-us/sql/dea/database-experimentation-assistant-configure-replay?view=sql-server-ver16)
* [Capture a trace in DEA](https://docs.microsoft.com/en-us/sql/dea/database-experimentation-assistant-capture-trace?view=sql-server-ver16)
* [Create analysis reports in DEA](https://docs.microsoft.com/en-us/sql/dea/database-experimentation-assistant-create-report?view=sql-server-ver16)
* [Replay a trace in DEA](https://docs.microsoft.com/en-us/sql/dea/database-experimentation-assistant-replay-trace?view=sql-server-ver16)
* [View reports in DEA](https://docs.microsoft.com/en-us/sql/dea/database-experimentation-assistant-view-report?view=sql-server-ver16)</br>

**4) [Azure Data Studio (ADS) with Migration Extension](https://docs.microsoft.com/en-us/sql/azure-data-studio/extensions/azure-sql-migration-extension)**
