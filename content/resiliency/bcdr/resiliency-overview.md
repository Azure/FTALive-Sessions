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
  - Identify critical dependencies & establish SLAs

## Protect & Recover
Business requirements should drive the type of solution leveraged for each protected workload.

  - Choose between Azure Backup or Azure Site Recovery to protect VMs
  - Use native replication or failover capabilities of PaaS services
  
### Additional learning resources

[Cloud Adoption Framework Management Guide - Protect & Recover](https://docs.microsoft.com/en-us/azure/cloud-adoption-framework/manage/azure-management-guide/protect-recover?tabs=AzureBackup%2Csiterecovery)

[Well-Architected Framework - Resiliency & Dependencies](https://docs.microsoft.com/en-us/azure/architecture/framework/resiliency/design-resiliency)
