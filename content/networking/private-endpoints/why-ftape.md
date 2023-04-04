# Why do an FTA Live on Private Endpoints?

[home](./readme.md)  | [next](./overview.md)

Many customers implement private endpoints to provide private network access to services not deployed inside of a virtual network.  This enables the following scenarios:

- Private connectivity from on-prem networks.
- Private connectivity between Azure resources.
- Keeping PaaS service traffic within their VNETs to improve their security posture.
- Centralized management and observability for network Access Control Lists and logs.
- Alignment with security guidelines for topics like Zero Trust or industry regulatory controls.

However, in doing so, customers often miss key implementation requirements.  This can create issues accessing the services that private endpoints are meant to protect, resulting in project delays, and even the impression that private endpoints are not reliable.

In the field, we see the following common challenges, and the resulting impacts:

| Challenge | Impact|
|---|---|
| Misunderstanding for how Private Endpoints work, and the functionality they provide. | Customers might be applying Private Endpoints to workloads that do not need them, or might not plan appropriately. |
| Customers do not plan to implement the DNS layer of the Private Endpoint solution. | Customers are unable to resolve IP addresses to private endpoints, or take on additional unneeded management overhead in order to manage DNS. |
| When issues occur, customers do not have clear troubleshooting steps. | Addressing private endpoint issues becomes complicated and time consuming. |
| Specific services have unique considerations based on how the services operate. | It can be unclear to customers about how to address, and how to plan for the private endpoint patterns that they need for the service. |

In this discussion, we want to provide some guidance on how to address these challenges, whether you are implementing private endpoints for the first time, or are looking to improve the management of your existing environment.

[home](./readme.md)  | [next](./overview.md)
