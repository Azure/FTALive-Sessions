# Post Migration

#### [prev](./migrationexecution.md) | [home](./readme.md)  | [next](./faq.md)

## Post Migration
### Perform Tests
1.  **Develop validation tests:** To test the database migration, you need to use SQL queries. Create validation queries to run against both the source and target databases. Your validation queries should cover the scope you've defined.
2.  **Set up a test environment:** The test environment should contain a copy of the source database and the target database. Be sure to isolate the test environment.
3.  **Run validation tests:** Run validation tests against the source and the target, and then analyze the results.
4.  **Run performance tests:** Run performance tests against the source and target, and then analyze and compare the results.

### Best Practices
|Pillar	|Description|
|:---|:---|
|`Reliability`|	The ability of a system to recover from failures and continue to function.|
|`Security`	|Protecting applications and data from threats.|
|`Cost Optimization`	|Managing costs to maximize the value delivered.|
|`Operational Excellence`|	Operations processes that keep a system running in production.|
|`Performance Efficiency`|	The ability of a system to adapt to changes in load.|

1. Baselining
2. Resiliency
    * Configure HA/DR strategy
    * Perform Test Drills
    * Backup/Restore (Automated/ LTR)
3. Security
    * [Security Best Practices SQL DB & SQL MI](https://docs.microsoft.com/en-us/azure/azure-sql/database/security-best-practice?view=azuresql)
    A firewall that enables you to create firewall rules limiting connectivity by IP address,
        - Server-level firewall accessible from the Azure portal
        - Database-level firewall rules accessible from SSMS
        - Secure connectivity to your database using secure connection strings
        - Use access management
        - Data encryption
        - SQL Database auditing
        - SQL Database threat detection
    * [Best practices for SQL Server on Azure VMs](https://docs.microsoft.com/en-us/azure/azure-sql/virtual-machines/windows/performance-guidelines-best-practices-checklist?view=azuresql)

 4. Performance
    *   [Monitoring and Performance Tuning Paas DB's](https://docs.microsoft.com/en-us/azure/azure-sql/database/monitor-tune-overview?view=azuresql)
    *   [Post-migration Validation and Optimization Guide](https://docs.microsoft.com/en-us/sql/relational-databases/post-migration-validation-and-optimization-guide?view=sql-server-2017)
5. Cost