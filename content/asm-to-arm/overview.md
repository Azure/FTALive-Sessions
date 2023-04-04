# Azure Classic Migration Overview

#### [prev](./readme.md) | [home](./readme.md)  | [next](./premigration.md)

**Image of Session Overview**
# Infrastructure Migration

## [Pre-Migration Steps](./premigration.md)
Prior to migration, there are a few key steps that will lead to a smoother migration experience.
- Inventory your classic resource types
- Review [supported resources for migration](https://learn.microsoft.com/en-us/azure/virtual-machines/migration-classic-resource-manager-overview#supported-resources-for-migration)
- Review [unsupported features and configurations](https://learn.microsoft.com/en-us/azure/virtual-machines/migration-classic-resource-manager-overview#unsupported-features-and-configurations)
- Understand the [classic migration process](https://learn.microsoft.com/en-us/azure/virtual-machines/migration-classic-resource-manager-deep-dive)

## [Validate](./validate.md)
There are a few different options for running the platform-supported migration sequence. Whether using the Azure Portal, PowerShell, or the Azure CLI, you will need to run Validation on each of the following classic resources:
- Express Route Circuits 
- Virtual Networks
- Cloud Services
- Storage Accounts

The validate step will provide a list of **most** unsupported configurations you will need to address prior to migration. Capturing these lists and creating an inventory will help to sequence your migration. Some configurations can be removed without disruption immediately, others require a bit more planning and coordination.

**Key note here:** On occasion, the validate step [may not return all unsupported configurations](https://learn.microsoft.com/en-us/azure/virtual-machines/migration-classic-resource-manager-deep-dive#checks-not-done-in-the-validate-operation). For complex environments we recommend running validate, remediating low-impact items, and rerunning the validate step to catch additional blockers for migration.

## [Prepare](./prepare.md)
The Prepare stage simulates the transformation of IaaS resources between Classic and Resource Manager (ARM). In [the portal](https://learn.microsoft.com/en-us/azure/virtual-machines/migration-classic-resource-manager-deep-dive#prepare), both classic and resource manager resources will appear. **Resources will appear in a resource group with the name of the Virtual Network or Cloud Service with "-Migrated" appended to the name.**

More details later, but the purpose of this stage is to understand the ARM equivalent resources post-migration.

## [Commit and Abort](./migrate.md)
During these steps, the Azure platform will either Commit the changes presented in the Prepare stage, or Abort the changes and remove the ARM resources. 
- Migration is a one-way operation.
- The operation is idempotent. On failure, re-run the operation again. 

## [Post-Migration Activities](./postmigration.md)
After the Commit operation, your resources will be migrated successfully migrate to the ARM management plane. We recommend a number of steps post-migration that are not strictly migration, but highly recommended as part of the newer ARM platform. 

# Platform as a Service Migration
Along with Azure Classic infrastructure, there are various Azure PaaS services impacted by Azure Service Management retirement. Below is the list of most common impacted services.

### [Azure Cloud Services web/worker roles](https://learn.microsoft.com/en-us/azure/cloud-services-extended-support/in-place-migration-overview). The first compute service introduced as part of Azure was called Cloud Service web/worker roles. These are Windows VMs that could deploy and execute code and run in redundant clusters. A web role runs IIS and is used for IIS hosted apps, and a worker role is used for back-end processing code. Migrating web/worker roles follows the same approach as VMs with the validate, prepare/abort, commit process. Azure has introduced a new ARM based Cloud Service Extendended Support service to allow web/workers to run in ARM. The in-place migration will migrate individual cloud services over to ARM, or a vnet of multiple services over to ARM. 
- Cloud Services can be migrated both individual or as part of a classic virtual network.
- If a virtual network container both web/worker role Cloud Services and classic VMs, the web/worker roles should first be moved out of the virtual network to a separate classic virtual network, then both virtual networks can be migrated individually.
- For very old cloud services that use tee-shirt sized VMs, these tee-shirt sku sizes should first be upgrade to currently supported sku sizes before migrating to Cloud Service Extendend Support. 
### [Azure App Services Environment v1 and v2 migration to v3](https://learn.microsoft.com/en-us/azure/app-service/environment/migrate). Azure App Service Envornment (ASE) v1 and v2 platforms is built on Azure Cloud Services and is subsequently being retired on Aug 31, 2024. A migration utility has been built to automate the migration of ASEv1 and ASEv2 to the new ASEv3. This is the best approach for moving an App Service Environment to a supported state. 
### [Azure App Services Environment v1 and v2 migration to v3](https://learn.microsoft.com/en-us/azure/logic-apps/ise-manage-integration-service-environment). The Azure Logic App Integrated Service Envornment (ISE) platform is built on Azure Cloud Services and is subsequently being retired on Aug 31, 2024. The core migration strategy is to [export ISE workflows](https://learn.microsoft.com/en-us/azure/logic-apps/export-from-ise-to-standard-logic-app) and import them into a Logic Apps Standard app. 