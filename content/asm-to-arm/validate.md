# Validate Stage

#### [prev](./premigration.md) | [home](./readme.md)  | [next](./prepare.md)

**INSERT WORKFLOW HERE**

# Platform-Supported Validate
There are three primary tools that can be used to run the Validate stage in the Platform-Supported migration process:
1. [Azure Portal](https://learn.microsoft.com/en-us/azure/virtual-machines/migration-classic-resource-manager-overview#migration-of-storage-accounts)
2. [Azure PowerShell](https://learn.microsoft.com/en-us/azure/virtual-machines/migration-classic-resource-manager-ps)
3. [Azure CLI](https://learn.microsoft.com/en-us/azure/virtual-machines/migration-classic-resource-manager-cli)

Prior to each primary resource (e.g. Virtual Network) being migrated, the first step is a validation stage which checks for remaining pre-requisites prior to migration. This will run a check against unsupported features and configurations that will prevent ARM equivalent resources from being prepared.

# Enhance Migration Plan with Validation Info
It is typical that the majority of resources evaluated during the Validate stage will return with errors that will prevent migration from proceeding. Microsoft documents [the most common migration errors](https://learn.microsoft.com/en-us/azure/virtual-machines/migration-classic-resource-manager-errors#list-of-errors) however, occasionally some error may not appear in the first attempt of validating. **For more complex scenarios, it is recommended to attempt two different methods (Portal _and_ PowerShell for example) to identify potential blockers that may not have been found.

Also crucial to gathering this Validation info is to review [checks that are not performed](https://learn.microsoft.com/en-us/azure/virtual-machines/migration-classic-resource-manager-deep-dive#checks-not-done-in-the-validate-operation) during validation. Below is the list of checks as of March 30th, 2023:
|**Networking checks not in the validate operation**|
|---|
A virtual network having both ER and VPN gateways.
A virtual network gateway connection in a disconnected state.
All ER circuits are pre-migrated to Azure Resource Manager stack.
Azure Resource Manager quota checks for networking resources. For example: static public IP, dynamic public IPs, load balancer, network security groups, route tables, and network interfaces.
All load balancer rules are valid across deployment and the virtual network.
Conflicting private IPs between stop-deallocated VMs in the same virtual network.

# Frequent Validation Failures
| Failure | Risk | How to Proceed |
|---|---|---|
|XML-based VM Extensions (e.g. BGInfo) | Low | ARM supports JSON extensions; most XML extensions have an equivalent to be reinstalled post migration.
|Storage Account contains .vhd files | Low | Simply migrate storage accounts **after** linked-VM resources have been migrated.|
|Azure Backup for VMs configured | Medium | Your migration plan should include removal of back-up (retain data), migration of VNET/VM(s), re-organization into proper resource groups, and re-enabling Azure Backup. _[See more](https://aka.ms/vmbackupmigration)._|
|VMs in Multiple Availability Sets | Medium | You will need to remove the VMs from all but at most 1 availability set, then proceed. |
|Network ACLs added to VM | High | Re-assess necessary connectivity to VM, ensure ports are available, remove ACLs and include updating ARM NSG/Load-balancers in post-migrate steps.|
|Virtual Network Peerings | High | VMs will remain running, but private network availability may become unavailable. Remove the VNET Peer, migrate, then re-establish the peer post migration.|

# Additional Considerations
Again, the key outcome to the Validate stage is to refine the overall migration plan. Make note of which blockers can safely be removed ahead of time, which blockers should be removed when ready for migration, and what will need to be addressed once the migration has completed.

**INSERT ADDITIONAL COMMENTS HERE**
