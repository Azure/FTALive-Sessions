# Migrate classic Cloud Services to Cloud Services Extended Support Using the Automated Migration Feature

#### [home](./readme.md) | [prev](./migration-options.md) | [next](./common-errors.md)

The automated migration feature enables a seamless, platform orchestrated migration of existing Cloud Services (classic) deployments to Cloud Services (extended support).
- The public IP address on the Cloud Service deployment remains the same after migration to Azure Resource Manager and is exposed as a Basic SKU IP (dynamic or static) resource.
- The DNS name and domain (cloudapp.net) for the migrated cloud service remains the same.

## Validate Migration is Supported
- Open your classic Cloud Service in the Azure Portal
- Navigate to the Migrate to ARM blade using the left-hand menu
- If the classic Cloud Service is deployed to a classic Virtual Network, the migration tool will require that it examine the virtual network to ensure it can be migrated to ARM along with your classic Cloud Service
- Click the Validate button
    - The migration tool will validate that the migration will not be prevented by common unsupported scenarios. Refer to [this document](https://learn.microsoft.com/en-us/azure/cloud-services-extended-support/in-place-migration-technical-details#unsupported-configurations--migration-scenarios) for a list of unsupported scenarios. 
    - If validation is successful, then all deployments are supported and ready to be prepared.
    - If validation fails, a list of unsupported scenarios will be displayed and need to be fixed before migration can continue. Refer to [this document](https://learn.microsoft.com/en-us/azure/cloud-services-extended-support/in-place-migration-common-errors#common-migration-errors) for a list of common migration errors and the associated mitigation steps.

## Prepare for the migration
- If the validation is successful, the migration tool will allow you to execute the prepare phase of the migration. Click the Prepare button.
- During the prepare phase the migration tool duplicates the resource metadata in Azure Resource Manager. All resources are locked for create/update/delete operations to ensure resource metadata is in sync across Azure Service Manager and Azure Resource Manager. All read operations will work using both Cloud Services (classic) and Cloud Services (extended support) APIs.
- If the prepare is successful, the migration is ready for commit. All Cloud Services in a virtual network are available for read operations using both Cloud Services (classic) and Cloud Services (extended support) Azure portal blades. The Cloud Service (extended support) deployment can now be tested to ensure proper functioning before finalizing the migration.
- If the prepare fails, review the error, address any issues, and retry the prepare. Refer to the unsupported scenarios and common migration errors documentation referenced earlier.

### Commit or abort the migration
- If the prepare is successful, you will be presented with the option to Commit or Abort the migration. Type 'yes' to confirm the migration and click the Commit button. Once the commit has finished, the migration is complete and the Cloud Services Extended Support instance is unlocked for all operations.
- If you wish to discontinue with the migration, click the Abort button to roll back the previous steps. Once the abort finishes, the classic Cloud Service instance is unlocked for all operations.
