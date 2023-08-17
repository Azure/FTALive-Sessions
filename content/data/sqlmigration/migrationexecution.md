# Migration Execution

[prev](./migrationplanning.md) | [home](./readme.md)  | [next](./postmigration.md)

Since you've planned and practice the migration, this phase should be a breeze!

## **Online** migration tools
||SQL on Azure VM ![](/images/SQLVM_icon.png "SQL_VM")|Azure SQL MI ![](/images/SQLMI_icon.png "SQL_MI")|Azure SQL DB![](/images/SQLDB_icon.png "SQL_DB")|
|:---|:---:|:---:|:---:|
Log Replay Service||[&check;](https://docs.microsoft.com/azure/azure-sql/managed-instance/log-replay-service-migrate?view=azuresql)|||
Azure Migrate using DMA|[&check;](https://docs.microsoft.com/azure/migrate/how-to-create-azure-sql-assessment)|[&check;](https://docs.microsoft.com/en-us/azure/migrate/how-to-create-azure-sql-assessment)||
DMS using ADS|[&check;](https://docs.microsoft.com/azure/dms/tutorial-sql-server-to-virtual-machine-online-ads)  |[&check;](https://docs.microsoft.com/azure/dms/tutorial-sql-server-managed-instance-online-ads)| |
DMS | | [&check;](https://docs.microsoft.com/azure/dms/tutorial-sql-server-managed-instance-online)| |
Transactional Replication|[&check;](https://docs.microsoft.com/sql/relational-databases/replication/transactional/transactional-replication?view=sql-server-ver16)|[&check;](https://docs.microsoft.com/azure/azure-sql/managed-instance/replication-transactional-overview?view=azuresql)|[&check;](https://docs.microsoft.com/azure/azure-sql/database/replication-to-sql-database?view=azuresql) |
Azure Data Factory| &check; |[&check;](https://docs.microsoft.com/azure/data-factory/connector-azure-sql-managed-instance)||
Availability Group Replica|[&check;](https://docs.microsoft.com/previous-versions/azure/virtual-machines/windows/sqlclassic/virtual-machines-windows-classic-sql-onprem-availability)|||
Managed Instance Link (Preview)| [&check;](https://docs.microsoft.com/azure/azure-sql/managed-instance/managed-instance-link-feature-overview?view=azuresql)||
<br/>

## **Offline** migration tools
||SQL on Azure VM ![](/images/SQLVM_icon.png "SQL_VM")|Azure SQL MI ![](/images/SQLMI_icon.png "SQL_MI")|Azure SQL DB![](/images/SQLDB_icon.png "SQL_DB")|
|:---|:---:|:---:|:---:|
DMS using ADS |[&check;](https://docs.microsoft.com/azure/dms/tutorial-sql-server-to-virtual-machine-offline-ads)| [&check;](https://docs.microsoft.com/azure/dms/tutorial-sql-server-managed-instance-offline-ads)|  |
DMS |  | [&check;](https://docs.microsoft.com/azure/dms/tutorial-sql-server-to-managed-instance)|[&check;](https://docs.microsoft.com/azure/dms/tutorial-sql-server-to-azure-sql)|
SQL Server Backup and restore |[&check;](https://docs.microsoft.com/azure/azure-sql/virtual-machines/windows/migrate-to-vm-from-sql-server?view=azuresql#back-up-and-restore)|&check;||
BACPAC |[&check;](https://docs.microsoft.com/azure/azure-sql/database/database-import?view=azuresql)|[&check;](https://docs.microsoft.com/azure/azure-sql/database/database-import?view=azuresql)|[&check;](https://docs.microsoft.com/azure/azure-sql/database/database-import?view=azuresql)
Detach and attach from URL | [&check;](https://docs.microsoft.com/azure/azure-sql/virtual-machines/windows/migrate-to-vm-from-sql-server?view=azuresql#detach-and-attach-from-a-url)|||
Migrate VM |[&check;](https://docs.microsoft.com/azure/azure-sql/virtual-machines/windows/migrate-to-vm-from-sql-server?view=azuresql#convert-to-a-vm-upload-to-a-url-and-deploy-as-a-new-vm)|||
Import / Export Service (Databox)|[&check;](https://docs.microsoft.com/azure/azure-sql/virtual-machines/windows/migrate-to-vm-from-sql-server?view=azuresql#ship-a-hard-drive)|||
Azure Data Factory| &check; |[&check;](https://docs.microsoft.com/azure/data-factory/connector-azure-sql-managed-instance)|[&check;](https://docs.microsoft.com/azure/data-factory/connector-azure-sql-database?tabs=data-factory) |
<br/>

## Demos
**1) [DMS](https://docs.microsoft.com/azure/dms/tutorial-sql-server-to-azure-sql) Migration Option**<br />

**2) [Migrate SQL Server to an Azure SQL Managed Instance online](https://docs.microsoft.com/azure/dms/tutorial-sql-server-managed-instance-online-ads) using Azure Data Studio with DMS** <br />

**3) [Migrate SQL Server to SQL Server on Azure Virtual Machine online](https://docs.microsoft.com/azure/dms/tutorial-sql-server-to-virtual-machine-online-ads) using Azure Data Studio with DMS** <br />

---
## Additional Information
* Choose a [migration method for SQL on Azure VM](https://docs.microsoft.com/azure/azure-sql/virtual-machines/windows/migrate-to-vm-from-sql-server?view=azuresql#choose-a-migration-method)
* Choose a [migration method for Azure SQL MI](https://docs.microsoft.com/azure/azure-sql/migration-guides/managed-instance/sql-server-to-managed-instance-overview?view=azuresql#migration-tools)
* Choose a [migraiton method for Azure SQL DB](https://docs.microsoft.com/azure/azure-sql/migration-guides/database/sql-server-to-sql-database-overview?view=azuresql#migration-tools)
* SQL MI and SQL DB provide instance configurations. If you are using [FCI for SQL server on Azure VM's](https://docs.microsoft.com/azure/azure-sql/virtual-machines/windows/failover-cluster-instance-prepare-vm?view=azuresql&tabs=single-subnet) please refer the pre-requisites 
* [AG Single Subnet](https://docs.microsoft.com/azure/azure-sql/virtual-machines/windows/availability-group-azure-portal-configure?view=azuresql)
* [AG Multi Subnet](https://docs.microsoft.com/azure/azure-sql/virtual-machines/windows/availability-group-manually-configure-prerequisites-tutorial-multi-subnet?view=azuresql)
* [SQL on Linux](https://docs.microsoft.com/sql/linux/sql-server-linux-overview?view=sql-server-ver16&viewFallbackFrom=azuresql)
