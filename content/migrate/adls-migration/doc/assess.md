# Milestone: Assess and Select Migration Wave

#### [prev](./scan.md) | [home](./welcome.md)  | [next](./landingzone.md)

The following content can be used as a checklist to incorporate within your migration project plan to ensure best practices.

**CAF Reference:** [Plan - Digital Estate Assessment ](https://docs.microsoft.com/en-us/azure/cloud-adoption-framework/plan/contoso-migration-assessment)

## **1 Identify VM Readiness** 

### &nbsp;&nbsp;&nbsp;&nbsp;1.1\.  Identify VMs marked as "ready" for migration based on assessment. 

>**Note**: Although the server is marked as "Ready" this means that Azure Infraestructure will support the necessary configuration, however the replication appliance may not support the replication of the server (E.G. SQL FCI cluster or a WSFC which needs shared disks).

### &nbsp;&nbsp;&nbsp;&nbsp;1.2\. Identify remediation plan for "conditionally ready" VMs based on assessment.

### &nbsp;&nbsp;&nbsp;&nbsp;1.3\. Identify which workloads will need lite optimization? E.G. Load Balancers, WSFC.  

### &nbsp;&nbsp;&nbsp;&nbsp;1.4\. Identify potential workloads with plans beyond lift and shift, such as replatform or modernization.

## **2 Assessment questionnaire** 

### &nbsp;&nbsp;&nbsp;&nbsp;2.1\.  Develope a questionnaire with the following points to cover:
- &nbsp;&nbsp;&nbsp;&nbsp;Business criticality (environment)
- &nbsp;&nbsp;&nbsp;&nbsp;Firewall Rules (Host and Network): Ports and Protocols 
- &nbsp;&nbsp;&nbsp;&nbsp;Backup mechanism 
- &nbsp;&nbsp;&nbsp;&nbsp;Monitor mechanism 
- &nbsp;&nbsp;&nbsp;&nbsp;Patching mechanism 
- &nbsp;&nbsp;&nbsp;&nbsp;Licensing mechanism (OS and Software)
- &nbsp;&nbsp;&nbsp;&nbsp;Re-IP server ok? (Best practice is to Re-IP)

## **3 Identify owner of VMs for questionnaire** 

### &nbsp;&nbsp;&nbsp;&nbsp;3.1\.  Have workload owners been interviewed? 

### &nbsp;&nbsp;&nbsp;&nbsp;3.2\. Is it clear who will be interviewing app owners?

## **4 Identify owner of applications for questionnaire** 

### &nbsp;&nbsp;&nbsp;&nbsp;4.1\.  Have workload owners been interviewed? 

### &nbsp;&nbsp;&nbsp;&nbsp;4.2\. Is it clear who will be interviewing app owners?

## **5 Assessment Grouping and Tuning** 

Grouping of migration waves based on questionnaires and dependency analysis tooling. Typically a migration wave is a single application, however in tighly coupled environments a migration wave may be multiple applications. 

### &nbsp;&nbsp;&nbsp;&nbsp;5.1. Cleanup dependency mapping scan (.csv) to show unique dependencies based on a the longest time range provided by the tool. If using agentless dependency mapping, you can automate this, as outlined in our [documentation](https://docs.microsoft.com/en-us/azure/migrate/how-to-create-group-machine-dependencies-agentless#visualize-network-connections-in-power-bi), using [this script](https://github.com/Azure/azure-docs-powershell-samples/blob/master/azure-migrate/dependencies-at-scale/AzMig_Dependencies.psm1). 

### &nbsp;&nbsp;&nbsp;&nbsp;5.2. Consider filtering out the noise from the dependency mapping scan (.csv) to remove known dependencies such as:

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;- Known system processess. 

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;- Known Internet based endpoints (non-RFC 1918). 

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;- Known Internal endpoints (RFC 1918) such as Filers, Active Directory, Network Appliances (e.g. Load Balancers), Management infraestructure (e.g. SCCM, SCOM, backup, etc.)

### &nbsp;&nbsp;&nbsp;&nbsp;5.3. Integrate dependency scan into visualization tooling such as PowerBI. If using agentless dependency mapping, guidance is provided within our [documentation](https://docs.microsoft.com/en-us/azure/migrate/how-to-create-group-machine-dependencies-agentless#visualize-network-connections-in-power-bi). If using agent-based dependency mapping, look to integrate log analytics with PowerBI as outlined in our [documentation](https://docs.microsoft.com/en-us/azure/azure-monitor/logs/log-powerbi). Helpful visualizations include:

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;- [Sankey](https://powerbi.microsoft.com/en-us/blog/visual-awesomeness-unlocked-sankey-diagram/) 

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;- [Network Navigator](https://appsource.microsoft.com/en-us/product/power-bi-visuals/WA104380795) 

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;- [Tassels Parallel Sets Slicer](https://appsource.microsoft.com/en-us/product/power-bi-visuals/WA200000311) 

### &nbsp;&nbsp;&nbsp;&nbsp;5.4\. Define groups of interdependent servers and create Azure Migrate groups and assessments. For example:

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; - Migration Wave/Group 1: 5 servers.

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; - Migration Wave/Group 2: 60 servers.

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; - Migration Wave/Group 3: 100 servers.

### &nbsp;&nbsp;&nbsp;&nbsp;5.5. Include additional business metadata for each server discovered to highlight criticality. For example:

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; - Environment (Prod vs. Non-Prod).

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; - Data Classification.

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; - Downtime Window Date/Time, typically based off SLAs, RTOs, RPOs, Blackout Maintenance Periods.   

### &nbsp;&nbsp;&nbsp;&nbsp;5.6\. Consider prioritization order of migration waves based on this [recommended guidance](https://docs.microsoft.com/en-us/azure/migrate/concepts-migration-planning#prioritize-workloads). Additional best practices include:

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; - Prioritize Migration Waves/Group with least number of interdependent servers. 

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; - Prioritize Migration Waves/Groups based on least business criticality. For example:

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; - Prioritize lower environments (Non-Prod vs. Prod).

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; - Least SLA and greater RTO/RPO.

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; - Backout Maintenace Periods are not conflicting with target test migration/migration date.

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; - Lowest Data Classification.

>**Note**: There are reasons when a Migration Wave/Group must be split such as:
>> - One or more of the servers in the Migration Wave/Group requires a different migration path and timelines.
>> - There's not enough resources on cutover date to attend for validation of the migrated servers.
>
>In case of the above scenarios, plan to:
>> 1. Review which are the most latency sensitive connections to dependencies and prioritize these dependencies for the migration Wave/Group.
>> 2. Schedule the left-out dependencies to be migrated on the next migration Wave/Group.

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; - Latest Operating System Version.

>**Note**: Older operating systems tend to have more issues booting in Azure or in supporting Azure management extensions/agents. E.G. WS2003, WS2008 32-bit will run in Azure, however have limited support. Additionally, applications in older operating systems are typically more sensitive to latency increase.

