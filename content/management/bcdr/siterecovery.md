# Azure Site Recovery

### Replication Scenarios

- [Azure VMs](https://docs.microsoft.com/en-us/azure/site-recovery/azure-to-azure-support-matrix) from region to region
- On-premises [VMware / Physical](https://docs.microsoft.com/en-us/azure/site-recovery/vmware-physical-azure-support-matrix), [Hyper-V](https://docs.microsoft.com/en-us/azure/site-recovery/hyper-v-azure-support-matrix)

- [Availability Zone to Availabilty Zone](https://docs.microsoft.com/en-us/azure/site-recovery/azure-to-azure-how-to-enable-zone-to-zone-disaster-recovery) (within the same Azure region)

### Recovery Plans

- Define the [boot sequence](https://docs.microsoft.com/en-us/azure/site-recovery/recovery-plan-overview#model-apps) for VMs after failover.
- Include manual or [automated steps](https://docs.microsoft.com/en-us/azure/site-recovery/recovery-plan-overview#automate-tasks-in-recovery-plans) as part of your recovery plan.

- Recovery plans can be developed for each workload (Example: [IIS web app recovery plan](https://docs.microsoft.com/en-us/azure/site-recovery/site-recovery-iis#create-a-recovery-plan))

### Failover and Failback

- Planned and test failovers will have zero data loss while unplanned will have minimal data loss (based on the recovery point)
- VMware failback requires some [additional infrastructure](https://docs.microsoft.com/en-us/azure/site-recovery/failover-failback-overview#vmwarephysical-reprotectionfailback).

### Specialized Workloads

- Consider dependencies on [Active Directory](https://docs.microsoft.com/en-us/azure/site-recovery/site-recovery-active-directory) in recovery plans or deploy an additional domain controller to the DR region.
- For SQL Server, there are [many choices](https://docs.microsoft.com/en-us/azure/site-recovery/site-recovery-sql).  Review the database platform's native DR capabilities. 

- For replication of encrypted Azure VMs be sure to [copy the disk encryption keys](https://docs.microsoft.com/en-us/azure/site-recovery/azure-to-azure-how-to-enable-replication-ade-vms) to the DR region. 

### Additional learning resources

[Capacity Planning for VMware replication](https://docs.microsoft.com/en-us/azure/site-recovery/site-recovery-plan-capacity-vmware)

[Azure Site Recovery via Policy](https://docs.microsoft.com/en-us/azure/site-recovery/azure-to-azure-how-to-enable-policy)