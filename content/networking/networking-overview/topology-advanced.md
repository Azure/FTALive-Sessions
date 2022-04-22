# Topology

#### [prev](./connectivity.md) | [home](./readme.md)  | [next](./mgmt.md)

## Hub and spoke 

A working example for a hub and spoke topology.

![Topology Diagram](png/topology-210726.png)

## Address scheme

Use a /16 for each region. 

Location | Type | Name | Address Space
---|---|---|---
Primary Region | vnet | hub     | 10.1.0.0/22
Primary Region | vnet | spoke1  | 10.1.4.0/24
Primary Region | vnet | spoke2  | 10.1.5.0/24
Primary Region | vnet | ...     | ...
Primary Region | vnet | spokeN  | 10.1.254.0/24
Primary Region | pool | P2S VPN | 10.1.255.0/24

> Primary region supernet 10.1.0.0/16

Location | Type | Name | Address Space
---|---|---|---
Secondary Region | vnet | hub      | 10.2.0.0/22
Secondary Region | vnet | spoke1   | 10.2.4.0/24
Secondary Region | vnet | spoke2   | 10.2.5.0/24
Secondary Region | vnet |      ... | ...
Secondary Region | vnet | spokeN   | 10.2.254.0/24
Secondary Region | pool | P2S VPN  | 10.2.255.0/24

> Secondary region supernet 10.2.0.0/16

## Hub subnets

Use a single address space of 10.x.0.0/22 for each hub divided into the following subnets.

Subnet Name | Network | Bits | Size | Usable | Reserved | First | Last | Broadcast
---|---|---|---|---|---|---|---|---
GatewaySubnet                   | .0.0   | /24 | 256 | 251 |   .1,   .2,   .3 |   .4 | .254 | .255
AzureFirewallSubnet             | .1.0   | /26 |  64 |  59 |   .1,   .2,   .3 |   .4 |  .62 |  .63
AzureFirewallManagementSubnet   | .1.64  | /26 |  64 |  59 |  .65,  .66,  .67 |  .68 | .126 | .127
NvaSubnet1                      | .1.128 | /28 |  16 |  11 | .129, .130, .131 | .132 | .142 | .143
NvaSubnet2                      | .1.144 | /28 |  16 |  11 | .145, .146, .147 | .148 | .158 | .159 
NvaSubnet3                      | .1.160 | /28 |  16 |  11 | .161, .162, .163 | .164 | .174 | .175
NvaSubnet4                      | .1.176 | /28 |  16 |  11 | .177, .178, .179 | .180 | .190 | .191
AzureBastionSubnet              | .1.192 | /27 |  32 |  27 | .193, .194, .195 | .196 | .222 | .223
RouteServerSubnet               | .1.224 | /27 |  32 |  27 | .225, .226, .227 | .228 | .254 | .255
ApplicationGatewaySubnet1       | .2.0   | /25 | 128 | 123 |   .1,   .2,   .3 |   .4 | .126 | .127
ApplicationGatewaySubnet2       | .2.128 | /25 | 128 | 123 | .129, .130, .131 | .132 | .254 | .255
ApplicationGatewaySubnet3       | .3.0   | /25 | 128 | 123 |   .1,   .2,   .3 |   .4 | .126 | .127
VmSubnet1                       | .3.128 | /28 |  16 |  11 | .129, .130, .131 | .132 | .142 | .143
VmSubnet2                       | .3.144 | /28 |  16 |  11 | .145, .146, .147 | .148 | .158 | .159
(spare)                         | .3.160 | /27 |  32 |  27 | .161, .162, .163 | .164 | .190 | .191
(spare)                         | .3.192 | /26 |  64 |  59 | .193, .194, .195 | .196 | .254 | .255

> Reserve .255.0/24 for Point to Site VPN.

## Spoke subnets

Spoke vnets are dynamic and map to an application or group of (heavily) related applications. Spoke vnets vary in size but are usually smaller rather than larger and subnets align to the application's requirements.

## Other topologies

There is no golden topology that will fit every workload scenario.
- Consider the workload.
- Consider availability requirements (including global and regional).
- Consider peering costs.
- Don't underestimate hidden costs and administrative overheads.

## Advanced scenarios

* [Virtual WAN](https://docs.microsoft.com/azure/virtual-wan/virtual-wan-about)
* [ExpressRoute Global Reach](https://docs.microsoft.com/azure/expressroute/expressroute-global-reach)
* [Coexistance of ER and VPN Gateways](https://docs.microsoft.com/azure/expressroute/expressroute-howto-coexist-resource-manager)

## Private connectivity to PaaS resources

We recommend adopting strategies like Zero Trust and moving the focus from network perimeters to Identity. However not everyone or system can make this shift today. We have increasing support for private access to normally public services. There are a few different approaches to this:

* [Dedicated Service](https://docs.microsoft.com/azure/virtual-network/virtual-network-for-azure-services) - Deploy dedicated but managed infrastructure inside your VNet e.g SQL Managed Instance or App Service Environment
* [Service Endpoint](https://docs.microsoft.com/azure/virtual-network/virtual-network-service-endpoints-overview) - Allow ACLd Access to a public endpoint, firewall other access. Not accessible from remote networks
* [Private Endpoints](https://docs.microsoft.com/azure/private-link/private-endpoint-overview) - Provision private ip address in the virtual network that will enable access to public resource. Not supported for all services see [Availbilty](https://docs.microsoft.com/azure/private-link/private-link-overview#availability)

OPINION: 
>Relying heavily on these mechanisms will make integration increasingly difficult, some services will have a loss of features when IP addresses are restricted. Remember many of the services were designed for a public cloud. Examples:

>* [Azure SQL import/export service](https://docs.microsoft.com/azure/azure-sql/database/network-access-controls-overview#allow-azure-services)
>* Managing some storage account settings from the portal [Storage Recommendations](https://docs.microsoft.com/azure/storage/blobs/security-recommendations#networking)
>* Using PowerBI to easily integrate with data services

## Alternatives to private connectivity

You may not need a full hybrid network to support your workloads. Some services offer their own connectivity options which might be worth exploring if you only need connectivity for 1 or two solutions. 

Examples:

* [Azure Relay](https://docs.microsoft.com/azure/azure-relay/relay-what-is-it)
* [Data Gateway](https://docs.microsoft.com/en-us/data-integration/gateway/service-gateway-onprem)
* Exposing services using [Mutual Certificate Authentication](https://docs.microsoft.com/azure/api-management/api-management-howto-mutual-certificates)