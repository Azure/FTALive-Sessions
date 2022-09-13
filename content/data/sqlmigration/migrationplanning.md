# Migration Planning

#### [prev](./remediation.md) | [home](./readme.md)  | [next](./migrationexecution.md)

## Migration Planning
* Offline, Online and downtime planning
* Pre-migration tidy up
  * Remove old databases
  * Remove unused logins and users
  * Remove unused SQL Agent jobs
  * Check if any SQL Agent jobs are failing
  * Check SQL Error Log
  * Run DBCC CHECKDB
* Create a migration _and_ rollback plan. **Test them**
* Capture a performance baseline [Link 1](https://docs.microsoft.com/en-us/azure/azure-sql/virtual-machines/windows/performance-guidelines-best-practices-collect-baseline) | [Link 2](https://docs.microsoft.com/en-us/sql/relational-databases/performance/performance-monitoring-and-tuning-tools?view=sql-server-ver15) | [Link 3](https://docs.microsoft.com/en-us/sql/relational-databases/performance/establish-a-performance-baseline?view=sql-server-2017) | [Link 4](https://docs.microsoft.com/en-us/azure/azure-sql/migration-guides/managed-instance/sql-server-to-managed-instance-performance-baseline)
* System level objects [Link 1](https://docs.microsoft.com/en-us/sql/relational-databases/databases/manage-metadata-when-making-a-database-available-on-another-server?view=sql-server-ver15) | [Link 2](https://techcommunity.microsoft.com/t5/azure-sql-blog/automate-migration-to-sql-managed-instance-using-azure/ba-p/830801)