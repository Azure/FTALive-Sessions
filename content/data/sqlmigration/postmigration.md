# Post Migration

#### [prev](./migrationexecution.md) | [home](./readme.md)  | [next](./qna.md)

## Initial Tasks
Congratulations on completing the migration! But the work is not finished yet..
1. **Run validation tests** to test the database migration was successful. This usually involves turning on the application for testers only. 
1. **Validate performance** of the platform in Azure meets technical and business expectations. 
1. **Capture new performance baselines** to enable comparison of old/new system, and, as a reference point going forward.
1. **Optimize for cost** through right-sizing and scaling up/down through automation
1. **Enable additional features** many of which are only available in Azure!


## Best Practices
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
      </ul>
      </td>
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
            <li> 
            <a href="https://docs.microsoft.com/en-us/azure/advisor/advisor-security-recommendations"> Azure Advisor, </a> 
            <a href="https://docs.microsoft.com/en-us/azure/azure-sql/database/sql-vulnerability-assessment?view=azuresql&tabs=azure-powershell"> Vulnerability Assessment, </a>
            <a href="https://docs.microsoft.com/en-us/azure/defender-for-cloud/defender-for-cloud-introduction"> Microsoft Defender for Cloud </a>
            <li><a href="https://docs.microsoft.com/en-us/azure/azure-sql/virtual-machines/windows/performance-guidelines-best-practices-checklist?view=azuresql">Best practices for SQL Server on Azure VMs</a></li>
            <li>Network</li>
            <li>Access Management</li>
            <li>Encryption</li>
            <li>Threat Detection </li>
            </ul>
        </td>
    </tr>
<tr>
      <td align="center" bgcolor=" #ccffff" >Cost Optimization</td>
      <td align="left" bgcolor="white"> Managing costs to maximize the value delivered. </td>
</tr>
<tr>
        <td align="center" bgcolor="white"> </td>
        <td align="left" bgcolor="white">         
            <ul>
            <li><a href="https://docs.microsoft.com/en-us/azure/azure-sql/virtual-machines/windows/pricing-guidance?view=azuresql"> Pricing Guidance SQL Server on VM's</a></li>
            <li><a href="https://docs.microsoft.com/en-us/azure/azure-sql/database/reserved-capacity-overview?view=azuresql">Reserve Capacity for Paas Instance</a></li>  
            <li><a href="https://docs.microsoft.com/en-us/azure/cost-management-billing/cost-management-billing-overview?WT.mc_id=costmanagementcontent_docsacmhorizontal_-inproduct-learn"> Understanding of Cost and Billing works</a>    
            <li> Creating Alerts </li>
            <li> Scaling Automation </li>
            <li> <a href="https://docs.microsoft.com/en-us/azure/cost-management-billing/costs/tutorial-acm-create-budgets">Creating Budgets </a></li>  
            </ul>
        </td>
    </tr>
    <tr>
      <td align="center" bgcolor="#ffe0cc" >Operational Excellence</td>
      <td align="left" bgcolor="white"> Operations processes that keep a system running in production. </td>
    </tr>
    <tr>
        <td align="center" bgcolor="white"> </td>
        <td align="left" bgcolor="white">         
        <ul>
        <li><a href="https://docs.microsoft.com/en-us/azure/architecture/checklist/data-ops"> DataOps CheckList </a></li>
        </ul>
        </td>
    </tr>
</tbody>
</table>


