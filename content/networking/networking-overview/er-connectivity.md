# ExpressRoute Connectivity

[prev](./vpn-connectivity.md) | [home](./readme.md)  | [next](./vwan.md)

## When to Use ExpressRoute?

- Lower and more consistent latency and throughput is required than is achievable over the internet
- VPN connectivity does not provide required bandwidth
- Private connectivity to Microsoft cloud services is required

## Where do I start?

- Talk to your current connectivity provider first
- For new environments, review the list of [**providers and peering locations**](https://docs.microsoft.com/azure/expressroute/expressroute-locations-providers)
- Review the ExpressRoute [**configuration workflow**](https://docs.microsoft.com/azure/expressroute/expressroute-workflows) to understand the setup process and to find links to details on each step.

## Configuring ExpressRoute Connectivity

![Basic ExpressRoute diagram](./png/exr-reco.png)
ExpressRoute is a **connection to Microsoft**, which can in turn be used to connect to Azure other Microsoft cloud services via **peerings**. ExpressRoute connectivity is established by deploying an ExpressRoute **Circuit** in Azure. To connect to resources in a VNet over ExpressRoute, a **Virtual Network Gateway** is deployed in your VNet, which you then connect to your Circuit. Each Circuit can be connected to multiple gateways, and a gateway can have multiple circuit connections.

- **Circuit**: ExpressRoute configuration resource for provider, bandwidth, billing type, routing, etc.
  - Circuit SKU affects number of connected VNets, scope of connectivity, number of route prefixes, and M365 access
  ![ExpressRoute circuit SKU scope of access](./png/er-sku-scope.png)

- **Circuit Bandwidth**:
  - Purchase options are 'metered' or 'unlimited', indicating how egress traffic will be charged (ingress is free). 'Metered' is more cost-effective at lower utilization (less than ~70% sustained)
  - Because connection is redundant, you have 2x the purchased bandwidth available but no resiliency over your purchased amount
  - Bandwidth can be increased, as long as the provider has capacity on your connection

- [**ExpressRoute Peering Types**](https://docs.microsoft.com/azure/expressroute/expressroute-circuit-peerings): peering types determine the services available over ExpressRoute.
  - *Private Peering*: connect to your private Azure resources via an ExpressRoute VNet Gateway
  - *Microsoft Peering*: connect to Microsoft services, including PaaS services, Microsoft 365, and Dynamics
  - *Public Peering*: legacy version of Microsoft Peering

- [**Routing Requirements**](https://docs.microsoft.com/azure/expressroute/expressroute-routing): Microsoft peering requires registered ASN and public IP addresses; private peering can use private IPs and ASNs

- [**High-availability and Disaster Recovery**](https://docs.microsoft.com/azure/expressroute/designing-for-high-availability-with-expressroute):

  ![HA ExpressRoute with more specific routes diagram](./png/er-dr-morespecificroute.png)

  - Use multiple peering locations and providers for maximum resiliency
  - For Private Peering, remember that your ER peering location is not the same as your region Azure datacenters and could be impacted separately by a disaster

- [**Pricing**](https://azure.microsoft.com/pricing/details/expressroute/): For Private Peering, account for Circuit, Gateway, egress, and carrier charges

### Advanced Scenarios

- [**Coexistence of ExpressRoute and VPN Gateways**](https://docs.microsoft.com/azure/expressroute/expressroute-howto-coexist-resource-manager)
  - [Provide a failover for ExpressRoute connectivity](https://learn.microsoft.com/azure/expressroute/use-s2s-vpn-as-backup-for-expressroute-privatepeering)
  - Connect branch locations to Azure
  - [Encrypt traffic over ExpressRoute](https://docs.microsoft.com/azure/expressroute/site-to-site-vpn-over-microsoft-peering) to meet regulatory requirements
