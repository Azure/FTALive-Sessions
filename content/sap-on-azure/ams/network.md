# Network Setup for Azure Monitor for SAP (AMS) Solutions

#### [prev](./availability&pricing.md) | [home](./introduction.md)  | [next](./providers.md)

## Subnet Requirement

A new empty/dummy subnet is required for Azure Monitor for SAP (AMS) Solutions where the Azure Functions would be hosted.
</br></br> Subnet should be created with an **IPv4/28** block or larger.


## Configure outbound internet access

In most of the use cases, Customers/Partners restrict or block outbound internet access to their SAP applications. However, Azure Monitor for SAP **(AMS)** solutions requires network connectivity between the subnet that you configured for deployment of Azure Monitor for SAP **(AMS)** Solutions and the systems that you want to monitor. Before you deploy an Azure Monitor for SAP solutions resource, you need to configure outbound internet access for the subnet where AMS managed resource group resides, or the deployment will fail. 

</br>There are multiple methods to address restricted or blocked outbound internet access. Choose the method that works best for your use case:

* Use the **Route All feature** in Azure functions
* Use **service tags** with a **network security group (NSG)** for your subnet hosting Azure Monitor for SAP **(AMS)** Solutions
* Use a **private endpoint** for your subnet

## Route All

**Route All** is a standard feature of virtual network integration in Azure Functions, which is deployed as part of Azure Monitor for SAP solutions. Enabling or disabling this setting only affects traffic from Azure Functions. This setting doesn't affect any other incoming or outgoing traffic within your virtual network.

You can configure the Route All setting when you create an Azure Monitor for SAP solutions resource through the Azure portal. If your SAP environment doesn't allow outbound internet access, disable Route All. If your SAP environment allows outbound internet access, keep the default setting to enable Route All.

You can only use this option before you deploy an Azure Monitor for SAP solutions resource. It's not possible to change the Route All setting after you create the Azure Monitor for SAP solutions resource.

## Use of Service Tags in NSG

A service tag represents a group of IP address prefixes from a given Azure service.
</br> If you use NSGs, you can create Azure Monitor for SAP solutions-related virtual network service tags to allow appropriate traffic flow for your deployment.

Below mentioned **service tags** have to be whitelisted(allowed) on NSG with source as the subnet where Azure Functions are deployed.

* Azure Monitor
* Azure Key Vault
* Storage
* Azure Resource Manager
* Virtual Network or comma seperated IP addresses of the source system

## Use private endpoint

You can enable a private endpoint by creating a new subnet in the same virtual network as the system that you want to monitor. No other resources can use this subnet. It's not possible to use the same subnet as Azure Functions for your private endpoint.

Create a private endpoint connection for the following resources inside the managed resource group:

* Azure Key Vault resources
* Azure Storage resources
* Azure Log Analytics workspaces

## Additional Information

* [Network Configuration for Azure Monitor for SAP (AMS) solutions](https://learn.microsoft.com/en-us/azure/virtual-machines/workloads/sap/create-network-azure-monitor-sap-solutions)



 #### [prev](./availability&pricing.md) | [home](./introduction.md)  | [next](./providers.md)
