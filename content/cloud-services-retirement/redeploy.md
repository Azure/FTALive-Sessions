# Redeploy Your Services to Cloud Services Extended Support

#### [home](./readme.md) | [prev](./common-errors.md) | [next](./post-deployment-changes.md)

If you cannot use the automated migration feature to migrate your classic Cloud Service to Cloud Services Extended Support or you would like to perform a manual migration, you can redeploy your services to a new Cloud Services Extended Support instance.

- Cloud Services Extended Support supports web and worker roles.
- No changes are required to the design, architecture, or components of web and worker roles.
- No changes are required to the runtime code as the data plane is the same as classic Cloud Services.

Prior to redeploying your services to a Cloud Services Extended Support instance, please be aware of the following configuration changes.

- Cloud Services Extended Support must be deployed to a virtual network. Make sure to update your ServiceConfiguration.Cloud.cscfg file to include a NetworkConfiguration section with a VirtualNetworkSite entry pointing at the name of the virtual network you plan to deploy to. Make sure to include an AddressAssignments section with entries for each role specifying the subnet within the virtual network.

      <NetworkConfiguration>
        <VirtualNetworkSite name="nimccfta-cses-green-vnet" />
        <AddressAssignments>
          <InstanceAddress roleName="SwapWebRole">
            <Subnets>
              <Subnet name="cloudservice" />
            </Subnets>
          </InstanceAddress>
        </AddressAssignments>
      </NetworkConfiguration>

- If you have IP Input Endpoints defined in your ServiceDefinition.csdef file, a public IP address resource needs to be created for your Cloud Services Extended Support instance. Cloud Services Extended Support only supports the Basic IP Address SKU.
- If your service configuration (.cscfg) contains a reserved IP address, the allocation type for the public IP must be set to static.
- If you specify one or more certificates in your service configuration (.cscfg), you must choose a Key Vault for your Cloud Services Extended Support Instance and upload all of the certificates specified in your service configuration to the Key Vault.
- Key Vault only supports RSA keys with a minimum of 2,048 bits. ***If your certificates are using 1,024 bit RSA keys, you will need to recreate them prior to uploading them to Key Vault.***

Detailed instructions for redeploying your services to a Cloud Services Extended Support Instance using a variety of tools are found below.

- [Azure Portal](https://learn.microsoft.com/en-us/azure/cloud-services-extended-support/deploy-portal)
- [PowerShell](https://learn.microsoft.com/en-us/azure/cloud-services-extended-support/deploy-powershell)
- [ARM Template](https://learn.microsoft.com/en-us/azure/cloud-services-extended-support/deploy-template)
- [SDK](https://learn.microsoft.com/en-us/azure/cloud-services-extended-support/deploy-sdk)
- [Visual Studio](https://learn.microsoft.com/en-us/visualstudio/azure/cloud-services-extended-support?view=vs-2022&context=%2Fazure%2Fcloud-services-extended-support%2Fcontext%2Fcontext)

***Note:*** We will cover updating your Azure DevOps Pipeline to support deploying your services to a Cloud Services Extended Support instance in the [Post Migration Changes section](./post-deployment-changes.md)