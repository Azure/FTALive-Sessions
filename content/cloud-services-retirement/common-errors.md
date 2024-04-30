# Common Errors and How to Address Them

#### [home](./readme.md) | [prev](./automated-migration.md) | [next](./redeploy.md)

Three common errors we see people encounter using the automated migration feature are invalid SKU sizes, staged deployments, and Cloud Services not deployed to a virtual network. Each of these errors and the steps to mitigate them are covered below.

## Invalid SKU Sizes
- Many older Cloud Service deployments used the Azure t-shirt sized SKUs (**ExtraSmall, Small, Medium, Large, ExtraLarge**) to define their compute requirements. These SKU sizes are not supported by Cloud Services Extended Support and must be updated prior to migration. To correct this issue update the vmsize property on each of your role definitions in the ServiceDefinition.csdef file to one of the supported SKU sizes listed [here](https://learn.microsoft.com/en-us/azure/cloud-services/cloud-services-sizes-specs#av2-series) then package and redeploy your solution.

      <WebRole name="SampleWebRole" vmsize="Standard_D1_v2">

## Staged Deployments
- If you were using the "Staging" slot on your classic Cloud Service to take advantage of staged deployments, you will need to delete the deployment in your "Staging" slot before you can proceed with the migration. Cloud Services Extended Support does not support deployment slots and instead uses the concept of "paired" cloud services to implement staged deployments. More details on this feature can be found [here](https://learn.microsoft.com/en-us/azure/cloud-services-extended-support/swap-cloud-service).

## Cloud Services Not Deployed to a Virtual Network
- While many people are not aware of it, when you deploy a classic Cloud Service a default virtual network is created for the cloud service. However, the initial implementation of classic Cloud Services did not create this default virtual network. So if you have a very old cloud service, it may not have a default virtual network associated with it and the automated migration tool is not able to migrate this cloud service to a Cloud Services Extended Support instance.
- To rectify this issue, you can take your existing deployment package from your Production deployment and deploy it to your Staging slot. The deployment to the Staging slot will create a default virtual network for the cloud service. Perform a swap operation to swap the Staging slot with the default virtual network with the Production slot that does not have a virtual network associated with it. Verify the functionality of the Production slot following the swap operation and then delete the Staging slot. More details on this fix can be found [here](https://learn.microsoft.com/en-us/azure/cloud-services-extended-support/non-vnet-migration).