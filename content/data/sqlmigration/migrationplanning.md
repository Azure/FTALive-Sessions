# Migration Planning

[prev](./remediation.md) | [home](./readme.md)  | [next](./migrationexecution.md)

This is the **most important phase of the migration!** </br>

## Planning Considerations

* How much downtime can the business accept? This will determine if you chose an Online or Offline migration

![migration planning](/images/MigrationPlanning.png)

* Number of servers, instances and databases
* Size of databases
* Speed of network to transfer data

## Pre-migration tidy-up

* Conduct a 'health-check' of your existing system
* Check Windows and SQL Error Log for any errors
* Run consistency checks (DBCC CHECKDB) against databases. If it's an old database, use WITH DATA_PURITY
* Ensure backups are running successfully and validate their consistency
* Remove old databases & their dependencies
* Check SQL Agent  for any unused and/or failing jobs
* Remove unused logins and orphaned users within DBs

## Create a migration _and_ rollback plan

* These plans should be _thorough_ and include timings for each activity
* Any steps that can be scripted / automated, do so (write the code before the migration!)
* Common for these plans to include > 100 steps / checks.
* Try to do as much before the migration actually starts, such as
  * Migrate SQL Agent jobs and then disable them (don't forget to add a step in your migration plan to enable these later!)
  * Migrate / create new logins
  * Create maintenance jobs
  * Setup monitoring
* Migrate validation steps
* Capture a performance baseline (see Additional Information for details)

## Test the migration plan
* Do it, time it and record the results

## Test the rollback plan

* Do it, time it and record the result
---

## Additional Information

* Capture a performance baseline [Link 1](https://docs.microsoft.com/azure/azure-sql/virtual-machines/windows/performance-guidelines-best-practices-collect-baseline) | [Link 2](https://docs.microsoft.com/sql/relational-databases/performance/performance-monitoring-and-tuning-tools?view=sql-server-ver15) | [Link 3](https://docs.microsoft.com//sql/relational-databases/performance/establish-a-performance-baseline?view=sql-server-2017) | [Link 4](https://docs.microsoft.com/azure/azure-sql/migration-guides/managed-instance/sql-server-to-managed-instance-performance-baseline)
* System level objects [Link 1](https://docs.microsoft.com/sql/relational-databases/databases/manage-metadata-when-making-a-database-available-on-another-server?view=sql-server-ver15) | [Link 2](https://techcommunity.microsoft.com/t5/azure-sql-blog/automate-migration-to-sql-managed-instance-using-azure/ba-p/830801)</br> </br>
* Review [Pricing guidance for SQL Server Azure VMs.](https://docs.microsoft.com/azure/azure-sql/virtual-machines/windows/pricing-guidance)
* Review [Service Tiers in Azure SQL Managed Instance](https://docs.microsoft.com/azure/azure-sql/managed-instance/sql-managed-instance-paas-overview?view=azuresql#service-tiers)
* Review [Service Tiers for Azure SQL Database](https://docs.microsoft.com/azure/azure-sql/database/sql-database-paas-overview?view=azuresql#service-tiers)
* Check [Azure Reservations.](https://docs.microsoft.com/azure/cost-management-billing/reservations/save-compute-costs-reservations)
* Check [Azure Pricing](https://azure.microsoft.com/pricing/)
* Check [PAY As You GO(PAYG)/ Dev Tes](https://azure.microsoft.com/pricing/dev-test/#overview)