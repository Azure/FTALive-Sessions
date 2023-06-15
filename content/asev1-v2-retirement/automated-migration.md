# Migrate ASE v1 / v2 to ASE v3 Using the Automated Migration Feature

#### [home](./readme.md) | [prev](./migration-options.md) | [next](./backup-restore.md)

## Validate Migration is Supported
- Open your ASE v1 / v2 in the Azure Portal
- Navigate to the Migration blade using the left-hand menu
- The Migration blade will validate if automated migration is supported for your App Service Environment.
- If migration is not supported for your ASE, a banner will appear at the top of the page and include an error message and a reason.
- If migration is supported for your ASE, you will be able to proceed to the next step in the process.

## Generate IP Addresses for your new App Service Environment v3
- In this step you will confirm that you understand the implications of generating new IP addresses for your ASE
- This process will take approximately 15 minutes to complete
- You will not be able make any modifications to your existing ASE during this time

## Update Dependent Resources with new IP Addresses
- When the previous steps completes the new IP addresses for you ASE v3 will be displayed.
- Use the new IP addresses to update any resources or network components to ensure your solution still functions following migration.
- It is your responsiblity to make these changes.
- Do not proceed to the next step until you have completed these changes.

## Delegate your ASE Subnet
- App Service Environment v3 requires the subnet it's in to have a single delegation of **Microsoft.Web/hostingEnvironments**.
- Confirm the subnet is properyly delegated and update if necessary before continuing.

## Confirm there are no locks on the virtual network
- If there are resource locks on the virtual network, including those inherited from the subscription or resource group, they will need to be removed before proceeding with the migration
- The locks can be re-applied following migration.

## Select Configurations
### Zone Redundancy
- If your existing ASE is in a region that supports zone redundancy, you can choose to make your new ASE v3 zone redundant
- This option can only be set during creation of your ASE v3 and cannot be removed later

### Custom Domain Suffix
- If your existing App Service Environment uses a custom domain suffix, you are required to configure one for your ASE v3.
- You are required to provide this information before proceeding to migration if your existing ASE uses a custom domain suffix
- If your existing ASE is **not** using a custom domain suffix and you would like to use one with your ASE v3, you can configure one once migration has completed.

## Migrate to ASE v3
- The migration takes up to three hours to migrate from v2 to v3
- The migration takes up to six hours to migrate from v1 to v3