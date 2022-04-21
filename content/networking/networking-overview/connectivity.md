# Connectivity

#### [prev](./concepts.md) | [home](./readme.md)  | [next](./topology.md)

## Connectivity between Azure Virtual Networks
Use [Virtual network peering](https://docs.microsoft.com/en-us/azure/virtual-network/virtual-network-peering-overview), fundamental in hub and spoke model.

### Peering Key points
* Cross Subscription, Tenant and Region Connectivty
* Peering charge per gb
* Peering is not transative without the use of NVA and UDR
* Limitations with basic load balancers and some services see [Requirements and constraints](https://docs.microsoft.com/en-us/azure/virtual-network/virtual-network-manage-peering#requirements-and-constraints) for more detail

Alternatives
* S2S VPN
* Shared ER Circuit

![VNet Reference](png/local-or-remote-gateway-in-peered-virtual-network.png)

## Connectivity to another network outside of Azure
If you need to communicate with services (using a private ip) in another network  there are a few options depending on what your requirements are:
the two main options are
* [VPN](https://docs.microsoft.com/en-us/azure/vpn-gateway/vpn-gateway-about-vpngateways)
* [Express Route](https://docs.microsoft.com/en-us/azure/expressroute/expressroute-introduction)

The Azure Architecture center has a a great article comparing the two [here](https://docs.microsoft.com/en-us/azure/architecture/reference-architectures/hybrid-networking/) also review the gateway [planning table](https://docs.microsoft.com/en-us/azure/vpn-gateway/vpn-gateway-about-vpngateways#planningtable)

### VPN key points
* [Devices](https://docs.microsoft.com/en-us/azure/vpn-gateway/vpn-gateway-about-vpn-devices) - validated devices and supported IPSec/IKE settings
* [SKU](https://docs.microsoft.com/en-us/azure/vpn-gateway/vpn-gateway-about-vpngateways#gwsku) - determines aggregate througput
* Routing - Can use either [BGP](https://docs.microsoft.com/en-us/azure/vpn-gateway/vpn-gateway-bgp-overview) or static routes using [Local Network Gateways](https://docs.microsoft.com/en-us/azure/vpn-gateway/vpn-gateway-about-vpn-gateway-settings#lng)
* [Availability Design](https://docs.microsoft.com/en-us/azure/vpn-gateway/vpn-gateway-highlyavailable)
* Expect provisioning to take 40-60 minutes

### Express Route key points
* [Peering Locations](https://docs.microsoft.com/en-us/azure/expressroute/expressroute-locations-providers) -  MSEE is not equal to an Azure Region
* [Peering Types](https://docs.microsoft.com/en-us/azure/expressroute/expressroute-circuit-peerings) - Microsoft and private, do I need 1 or the other or both?
* [Routing Requirements](https://docs.microsoft.com/en-us/azure/expressroute/expressroute-routing) - Public IP, ASN, etc
* [High Availabililty](https://docs.microsoft.com/en-us/azure/expressroute/designing-for-high-availability-with-expressroute) - Path redundancy and first mile considerations
* [Disaster Recovery](https://docs.microsoft.com/en-us/azure/expressroute/designing-for-disaster-recovery-with-expressroute-privatepeering) - Designing for disaster recovery with ExpressRoute
* [Pricing](https://azure.microsoft.com/en-us/pricing/details/expressroute/) -  For private peering dont forget to take into account circuit, gateway, egress and carrier charges.

## For more advanced scenarios make sure you are aware of
* [Virtual WAN](https://docs.microsoft.com/en-us/azure/virtual-wan/virtual-wan-about)
* [ExpressRoute Global Reach](https://docs.microsoft.com/en-us/azure/expressroute/expressroute-global-reach)
* [Coexistance of ER and VPN Gateways](https://docs.microsoft.com/en-us/azure/expressroute/expressroute-howto-coexist-resource-manager)

## Private connectivity to PaaS resources
We recommend adopting strategies like Zero Trust and moving the focus from network perimeters to Identity. However not everyone or system can make this shift today. We have increasing support for private access to normally public services. There are a few different approaches to this:
* [Dedicated Service](https://docs.microsoft.com/en-us/azure/virtual-network/virtual-network-for-azure-services) - Deploy dedicated but managed infrastructure inside your VNet e.g SQL Managed Instance or App Service Environment
* [Service Endpoint](https://docs.microsoft.com/en-us/azure/virtual-network/virtual-network-service-endpoints-overview) - Allow ACLd Access to a public endpoint, firewall other access. Not accessible from remote networks
* [Private Endpoints](https://docs.microsoft.com/en-us/azure/private-link/private-endpoint-overview) - Provision private ip address in the virtual network that will enable access to public resource. Not supported for all services see [Availbilty](https://docs.microsoft.com/en-us/azure/private-link/private-link-overview#availability)

OPINION: 
>Relying heavily on these mechanisms will make integration increasingly difficult, some services will have a loss of features when IP addresses are restricted. Remember many of the services were designed for a public cloud. Examples:
>* [Azure SQL import/export service](https://docs.microsoft.com/en-us/azure/azure-sql/database/network-access-controls-overview#allow-azure-services)
>* Managing some storage account settings from the portal [Storage Recommendations](https://docs.microsoft.com/en-us/azure/storage/blobs/security-recommendations#networking)
>* Using PowerBI to easily integrate with data services

## Alternatives to private connectivity
You may not need a full hybrid network to support your workloads. Some services offer their own connectivity options which might be worth exploring if you only need connectivity for 1 or two solutions. 

Examples:
* [Azure Relay](https://docs.microsoft.com/en-us/azure/azure-relay/relay-what-is-it)
* [Data Gateway](https://docs.microsoft.com/en-us/data-integration/gateway/service-gateway-onprem)
* Exposing services using [Mutual Certificate Authentication](https://docs.microsoft.com/en-us/azure/api-management/api-management-howto-mutual-certificates)

