# Resiliency Overview

#### [home](./readme.md)  | [next](./backup.md)

## Motivation
As part of modern, cloud operations we must implement solutions to minimize interruptions and ensure rapid recovery when needed.

### DR Events
Operational downtime can happen anytime and to any business.

- **Natural causes:** Hurricanes, earthquakes, floods...
- **Human / System causes:** Security breaches (Ransomware), operational errors, component failures...

## Design Resiliency
Make sure you are considering resiliency among your requirements when designing solutions.

  - Failure mode analysis to identify all fault points.
  - Eliminate all single points of failure.
  - Identify critical dependencies & establish SLAs into tiers for each application

Sample tiers:

|        | Availability SLA |     RPO    |    RTO   |
|:------:|:----------------:|:----------:|:--------:|
| Tier 0 |      99.995      |      0     |     0    |
| Tier 1 |       99.99      |  5 minutes |  1 hour  |
| Tier 2 |       99.95      | 30 minutes |  4 hours |
| Tier 3 |       99.9       |   4 hours  |  8 hours |
| Tier 4 |        99        |  24 hours  | 72 hours |

## Protect & Recover 
Business requirements should drive the type of solution leveraged for each protected workload.

  - Choose between Azure Backup or Azure Site Recovery to protect VMs
  - Use native replication or failover capabilities of PaaS services

| Failure type | Resilience strategy |
|---|---|
| Hardware failure | Deploy VMs across different fault domains via Availability Sets |
| Datacenter failure | Deploy VMs across different availability zones within a single region |
| Regional failure | Replicate VMs into another region via Azure Site Recovery |
| Accidental data deletion or corruption | Back up the data and VM disks via Azure Backup |
  
### Additional learning resources

[Cloud Adoption Framework Management Guide - Protect & Recover](https://docs.microsoft.com/en-us/azure/cloud-adoption-framework/manage/azure-management-guide/protect-recover?tabs=AzureBackup%2Csiterecovery)

[Well-Architected Framework - Resiliency & Dependencies](https://docs.microsoft.com/en-us/azure/architecture/framework/resiliency/design-resiliency)

[Whitepaper - Resilience in Azure](https://aka.ms/resilience-in-azure-whitepaper)
