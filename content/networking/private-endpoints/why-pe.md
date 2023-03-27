# Why use Private Endpoints?

Private Endpoints are a helpful tool to *provide private network/IP address for Azure services*.  They work with Azure Private Link to project the equivalent of a NIC resources for an Azure service not running in your virtual network, like a Storage Account or SQL Database.

![Private Endpoint Example](./img/pe-example.png)

Private Endpoints can be used for the following scenarios:

- Keeping PaaS traffic within your private network.
- Having an known private IP for accessing the service, instead of having to use the variable of a service endpoint.
- Access from your on-prem network to an Azure service via private networking (VPN or ExpressRoute)
- Standardizing network allow and deny rules to use NSGs and ASGs, instead of service specific firewalls.

You should note that it isn't the only tool for securing network access to Azure services.  Azure services have their own firewalls, and identity boundaries are important for security even with private endpoints

Private endpoints provide a private networking posture for Azure resources, at the cost of additional subscription billing and overhead.
