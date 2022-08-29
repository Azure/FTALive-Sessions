# Migration Planning

#### [prev](./remediation.md) | [home](./readme.md)  | [next](./migrationexecution.md)

## Migration Planning
![migration planning](/images/MigrationPlanning.png)
* **Other deciding factors**
  * Number of servers and databases
  * Size of databases
  * Right VM Size / Storage / Appropriate Tier/ Network Requirements
  * Code change scale
  * Downtime
  * [Total Cost of Ownership Calculator](https://azure.microsoft.com/pricing/tco/calculator/)
  * Future Usage Patterns

## Pre-migration tidy up
  * Take Backups & Validate Integrity
  * Remove Old Databases & its dependencies
  * Encryption and Sanity checks (Indexes,Plans,etc)
  * SQL Server Objects considerations (Removing Logins,Users,Jobs)
  * Check SQL Error Log
  * Run DBCC CHECKDB
  * Defining Test Cases

## Create a migration _and_ rollback plan. **Test them**

* Capture a performance baseline [Link 1](https://docs.microsoft.com/en-us/azure/azure-sql/virtual-machines/windows/performance-guidelines-best-practices-collect-baseline) | [Link 2](https://docs.microsoft.com/en-us/sql/relational-databases/performance/performance-monitoring-and-tuning-tools?view=sql-server-ver15) | [Link 3](https://docs.microsoft.com/en-us/sql/relational-databases/performance/establish-a-performance-baseline?view=sql-server-2017) | [Link 4](https://docs.microsoft.com/en-us/azure/azure-sql/migration-guides/managed-instance/sql-server-to-managed-instance-performance-baseline)
* System level objects [Link 1](https://docs.microsoft.com/en-us/sql/relational-databases/databases/manage-metadata-when-making-a-database-available-on-another-server?view=sql-server-ver15) | [Link 2](https://techcommunity.microsoft.com/t5/azure-sql-blog/automate-migration-to-sql-managed-instance-using-azure/ba-p/830801)


### **Good to know links**
  * Review [Pricing guidance for SQL Server Azure VMs.](https://docs.microsoft.com/en-us/azure/azure-sql/virtual-machines/windows/pricing-guidance)
  * Review [Service Tiers in Azure SQL Managed Instance](https://docs.microsoft.com/en-us/azure/azure-sql/managed-instance/sql-managed-instance-paas-overview?view=azuresql#service-tiers)
  * Review [Service Tiers for Azure SQL Database](https://docs.microsoft.com/en-us/azure/azure-sql/database/sql-database-paas-overview?view=azuresql#service-tiers)
  * Check [Azure Reservations.](https://docs.microsoft.com/en-us/azure/cost-management-billing/reservations/save-compute-costs-reservations)
  * Check [Azure Pricing](https://azure.microsoft.com/en-in/pricing/)
  * Check [PAY As You GO(PAYG)/ Dev Tes](https://azure.microsoft.com/en-us/pricing/dev-test/#overview)