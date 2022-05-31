# Operating

#### [prev](./building.md) | [home](./readme.md)  | [next](./security.md)

## Data Governance
* How do you avoid building a [data swamp](https://docs.microsoft.com/en-us/azure/cloud-adoption-framework/scenarios/cloud-scale-analytics/best-practices/data-lake-overview)? (Answer: With Governance!)
* Within your organisation, consider data ownership, curation and control
* [Microsoft Purview](https://docs.microsoft.com/en-us/azure/purview/overview)

## Azure Governance
* [Azure Policy](https://docs.microsoft.com/en-us/azure/governance/policy/overview) 
* Process
* Role Based Access Control (RBAC)

## Monitoring
* Determine monitoring requirements *before* enabling. They have likely changed compared to on-prem solution
* Build-up alerts and dashboards overtime
* [Azure Monitor for Synapse Analytics](https://docs.microsoft.com/en-us/azure/synapse-analytics/monitoring/how-to-monitor-using-azure-monitor)

## Optimization
Now that you have a solution up and running, look for opportunities to improve: 
* Performance
* [Cost](https://docs.microsoft.com/en-us/azure/cost-management-billing/cost-management-billing-overview), such as using Reserved Instances, right sizing, scaling up/down & out/in, pausing workloads and using utlising budgets