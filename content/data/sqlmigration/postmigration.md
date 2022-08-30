# Post Migration

#### [prev](./migrationexecution.md) | [home](./readme.md)  | [next](./faq.md)

## Post Migration
### Perform Tests
1.  **Develop validation tests:** To test the database migration, you need to use SQL queries. Create validation queries to run against both the source and target databases. Your validation queries should cover the scope you've defined.
2.  **Set up a test environment:** The test environment should contain a copy of the source database and the target database. Be sure to isolate the test environment.
3.  **Run validation tests:** Run validation tests against the source and the target, and then analyze the results.
4.  **Run performance tests:** Run performance tests against the source and target, and then analyze and compare the results.

### Best Practices

<table border="10" >
  <tbody >
    <tr>
      <td align="center" bgcolor="#e6ffcc" >Reliability</td>
      <td align="left" bgcolor="white"> The ability of a system to recover from failures and continue to function.</td>
    </tr>
    <tr>
        <td align="center" bgcolor="white"> </td>
        <td align="left" bgcolor="white">         
        <ul>
        <li>Backups</li>
        <li>Perform Test DR Drills</li>
        <li>HA configs</li>
        </ul></td>
    </tr>
    <tr>
      <td align="center" bgcolor="#ffffcc" >Performance Efficiency</td>
      <td align="left" bgcolor="white"> The ability of a system to adapt to changes in load.</td>
    </tr>
    <tr>
      <td align="center" bgcolor="white"> </td>
      <td align="left" bgcolor="white">         
      <ul>
        <li><a href="https://docs.microsoft.com/en-us/azure/azure-sql/database/monitor-tune-overview?view=azuresql">Monitoring and Performance Tuning Paas DB's</a></li>
        <li><a href="https://docs.microsoft.com/en-us/sql/relational-databases/post-migration-validation-and-optimization-guide?view=sql-server-2017">Post-migration Validation and Optimization Guide </a></li>
        <li><a href ="https://docs.microsoft.com/en-us/azure/azure-sql/database/automatic-tuning-overview?view=azuresql">Automatic Tuning</a> </li>
        <li>Configuring Metrics from Portal/VM for SQL Counters possible</li>
        </td>
    </ul>
    </tr>
    <tr>
      <td align="center" bgcolor="#ffe0cc" >Security</td>
      <td align="left" bgcolor="white"> Protecting applications and data from threats </td>
    </tr>
    <tr>
        <td align="center" bgcolor="white"> </td>
        <td align="left" bgcolor="white">         
        <ul>
        <li><a href="https://docs.microsoft.com/en-us/azure/azure-sql/database/security-best-practice?view=azuresql"> Security Best Practices SQL DB & SQL MI</a></li>
        <li><a href="https://docs.microsoft.com/en-us/azure/azure-sql/virtual-machines/windows/performance-guidelines-best-practices-checklist?view=azuresql">Best practices for SQL Server on Azure VMs</a></li>
        <li>Network</li>
        <li>Access Management</li>
        <li>Encryption</li>
        <li> Threat Detection </li>
        <>
        </ul></td>
    </tr>

</tbody>
</table>

|Pillar	|Description|
|:---|:---|
|`Cost Optimization`	|Managing costs to maximize the value delivered.|
|`Operational Excellence`|	Operations processes that keep a system running in production.|
|`Performance Efficiency`|	The ability of a system to adapt to changes in load.|

