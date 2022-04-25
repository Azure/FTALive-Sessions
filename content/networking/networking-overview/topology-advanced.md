# Topology (Advanced)

#### [prev](./connectivity.md) | [home](./readme.md)  | [next](./security-advanced.md)

## IP Address Management for Hub and Spoke Vnets

A working example for a hub and spoke topology.

![Topology Diagram](png/topology-210726.png)

[Reference IP Schema](./example-ip-plan/example-ip-plan.md)

### Planning Regional Supernets

To help give continuity to your IP schema, you can plan to have a supernet to refer to a specific region or scope.  A /16 supernet is a good place to start, giving plenty of room for expansion.

This assignment does not have a technical representation in Azure; there is no supernet resource in Azure that you assign resources to.  Instead you are tracking it in your IP Address Management system, which could be something like [Windows Server IPAM](https://docs.microsoft.com/windows-server/networking/technologies/ipam/ipam-top) or even a simple spreadsheet.

To start, you should plan for IP spaces in at least two regions: your primary region, and that region's [paired region](https://docs.microsoft.com/azure/availability-zones/cross-region-replication-azure).  While you might not need a secondary region right away, it is helpful to build this in to your IP address plan.

![Regional supernets - two /16 supernets](./png/ipam-regional.png)

### Planning your Hub IP Space

Hubs contains shared connectivity resources.  You should plan a hub for each region, and plan for it to be a larger vnet.

The recommended size is /22s, allowing for:

* A /24 for the Gateway Subnet
* A /26 for the Azure Firewall Subnet
* A /26 for an Azure Firewall Management Subnet (if needed)
* A /27 for Azure Bastion
* Room for VMs, Application Gateways, and third party solutions
* Ample room for expansion for new services

>If IP space limitations require reduction, you can reduce this size based off of the resources that you need in the hub and how you want to autoscale.  However, this can create challenges later as you expand.  You shouldn't downsize your hub because you *might* have issues, but if you have a clear understanding of issues that *will* occur.

![Regional hubs - two /22 virtual networks](./png/ipam-hubs.png)

You may also think about having a seperate hub for different environments if you need to seperate out network infrastructure.  This requires additional work and management, and so should only be adopted if you have a clear business case for separating out the network.  Common examples for this include:

* A requirement that only data of different sensitivities cannot use the same network appliances (The corporate and PCI networks can't share the same appliances)
* Different roles and access to network resources based on the sensitivity of the data that it manages (Delegating access to development shared connectivity to a different team than production shared connectivity)
* Using Infrastructure-as-Code to deploy and manage connectivity resources in a CI/CD fashion, and a requirement for a "non-production" network

### Planning for your Spoke IP Space



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