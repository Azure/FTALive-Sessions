# Migration Execution

#### [prev](./migrationplanning.md) | [home](./readme.md)  | [next](./postmigration.md)

## Migration Execution

|SQL on Azure VM ![](/images/SQLVM_icon.png "SQL_VM")|Azure SQL MI ![](/images/SQLMI_icon.png "SQL_MI")|Azure SQL DB![](/images/SQLDB_icon.png "SQL_DB")|
|:---|:---|:---|
| **`Online`** | **`Online`**  | **`Online`**  |
|[Azure Migrate using DMA]()|[Azure Migrate using DMA](https://docs.microsoft.com/en-us/azure/migrate/how-to-create-azure-sql-assessment)|[Azure Migrate using DMA]()|[Azure Migrate using DMA](https://docs.microsoft.com/en-us/azure/migrate/how-to-create-azure-sql-assessment)|
| [DMS using ADS Online- Azure VM](https://docs.microsoft.com/en-us/azure/dms/tutorial-sql-server-to-virtual-machine-online-ads)  |[DMS using ADS Online- SQL MI](https://docs.microsoft.com/en-us/azure/dms/tutorial-sql-server-managed-instance-online-ads)| NA |
| NA | [DMS without using ADS Online-SQL MI](https://docs.microsoft.com/en-us/azure/dms/tutorial-sql-server-managed-instance-online)|[DMS without using ADS Online- SQL DB](https://docs.microsoft.com/en-us/azure/dms/tutorial-sql-server-to-azure-sql) |
|[Transactional Replication](https://docs.microsoft.com/en-us/sql/relational-databases/replication/transactional/transactional-replication?view=sql-server-ver16)|[Transactional Replication](https://docs.microsoft.com/en-us/azure/azure-sql/managed-instance/replication-transactional-overview?view=azuresql)|[Transactional Replication](https://docs.microsoft.com/en-us/azure/azure-sql/database/replication-to-sql-database?view=azuresql) |
|NA|[Azure Data Factory](https://docs.microsoft.com/en-us/azure/data-factory/connector-azure-sql-managed-instance)|[Azure Data Factory](https://docs.microsoft.com/en-us/azure/data-factory/connector-azure-sql-database?tabs=data-factory) |
|[Adding Replica](https://docs.microsoft.com/en-us/previous-versions/azure/virtual-machines/windows/sqlclassic/virtual-machines-windows-classic-sql-onprem-availability)|[Log Relay Service](https://docs.microsoft.com/en-us/azure/azure-sql/managed-instance/log-replay-service-migrate?view=azuresql)| |
||[Managed Instance Link](https://docs.microsoft.com/en-us/azure/azure-sql/managed-instance/managed-instance-link-feature-overview?view=azuresql)| |
|  **`Offline`**  | **`Offline`**  | **`Offline`**   |
|[DMS using ADS Offline- AzureVM](https://docs.microsoft.com/en-us/azure/dms/tutorial-sql-server-to-virtual-machine-offline-ads)| [DMS using ADS Offline- SQL MI](https://docs.microsoft.com/en-us/azure/dms/tutorial-sql-server-managed-instance-offline-ads)| NA |
| NA | [DMS without using ADS - SQL MI](https://docs.microsoft.com/en-us/azure/dms/tutorial-sql-server-to-managed-instance)|[DMS without using ADS - SQL DB](https://docs.microsoft.com/en-us/azure/dms/tutorial-sql-server-to-azure-sql)|
|Perform an on-premises [backup using compression and restore](https://docs.microsoft.com/en-us/azure/azure-sql/virtual-machines/windows/migrate-to-vm-from-sql-server?view=azuresql#back-up-and-restore)|[Import/Export BACPAC Wizard](https://docs.microsoft.com/en-us/azure/azure-sql/database/database-import?view=azuresql)|[Import/Export BACPAC Wizard](https://docs.microsoft.com/en-us/azure/azure-sql/database/database-import?view=azuresql)|
|[Backup to URL and Restore](https://docs.microsoft.com/en-us/azure/azure-sql/virtual-machines/windows/migrate-to-vm-from-sql-server?view=azuresql#backup-to-url-and-restore-from-url) | [Native Backup and Restore](https://docs.microsoft.com/en-us/azure/azure-sql/managed-instance/restore-sample-database-quickstart?view=azuresql)| |
| [Detach and Attach from URL](https://docs.microsoft.com/en-us/azure/azure-sql/virtual-machines/windows/migrate-to-vm-from-sql-server?view=azuresql#detach-and-attach-from-a-url)|||
|[Convert to VM and Upload](https://docs.microsoft.com/en-us/azure/azure-sql/virtual-machines/windows/migrate-to-vm-from-sql-server?view=azuresql#convert-to-a-vm-upload-to-a-url-and-deploy-as-a-new-vm)|||
|[Ship Hard Drive](https://docs.microsoft.com/en-us/azure/azure-sql/virtual-machines/windows/migrate-to-vm-from-sql-server?view=azuresql#ship-a-hard-drive)|||


## Demos
**1) [DMA](https://docs.microsoft.com/en-us/azure/dms/tutorial-sql-server-to-azure-sql) Migration Option**<br />

**2) [Migrate SQL Server to an Azure SQL Managed Instance online](https://docs.microsoft.com/en-us/azure/dms/tutorial-sql-server-managed-instance-online-ads) using Azure Data Studio with DMS** <br />

**3) [Migrate SQL Server to SQL Server on Azure Virtual Machine online](https://docs.microsoft.com/en-us/azure/dms/tutorial-sql-server-to-virtual-machine-online-ads) using Azure Data Studio with DMS** <br />


### **Good to know links**
* Choose a [migration method for SQL on Azure VM](https://docs.microsoft.com/en-us/azure/azure-sql/virtual-machines/windows/migrate-to-vm-from-sql-server?view=azuresql#choose-a-migration-method)
* Choose a [migration method for Azure SQL MI](https://docs.microsoft.com/en-us/azure/azure-sql/migration-guides/managed-instance/sql-server-to-managed-instance-overview?view=azuresql#migration-tools)
* Choose a [migraiton method for Azure SQL DB](https://docs.microsoft.com/en-us/azure/azure-sql/migration-guides/database/sql-server-to-sql-database-overview?view=azuresql#migration-tools)
* SQL MI and SQL DB provide instance configurations. If you are using [FCI for SQL server on Azure VM's](https://docs.microsoft.com/en-us/azure/azure-sql/virtual-machines/windows/failover-cluster-instance-prepare-vm?view=azuresql&tabs=single-subnet) please refer the pre-requisites 
* [AG Single Subnet](https://docs.microsoft.com/en-us/azure/azure-sql/virtual-machines/windows/availability-group-azure-portal-configure?view=azuresql)
* [AG Multi Subnet](https://docs.microsoft.com/en-us/azure/azure-sql/virtual-machines/windows/availability-group-manually-configure-prerequisites-tutorial-multi-subnet?view=azuresql)
* [SQL on Linux](https://docs.microsoft.com/en-us/sql/linux/sql-server-linux-overview?view=sql-server-ver16&viewFallbackFrom=azuresql)
