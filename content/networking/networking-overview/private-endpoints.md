# Private Endpoints

**[prev](./basics.md) | [home](./readme.md)  | [next](./security-overview.md)**

## Private connectivity to PaaS resources

We recommend adopting strategies like Zero Trust and moving the focus from network perimeters to Identity. However not everyone or system can make this shift today. We have increasing support for private access to normally public services. There are a few different approaches to this:

* [Dedicated Service](https://docs.microsoft.com/azure/virtual-network/virtual-network-for-azure-services) - Deploy dedicated but managed infrastructure inside your VNet e.g SQL Managed Instance or App Service Environment
* [Service Endpoint](https://docs.microsoft.com/azure/virtual-network/virtual-network-service-endpoints-overview) - Allow ACLd Access to a public endpoint, firewall other access. Not accessible from remote networks
* [Private Endpoints](https://docs.microsoft.com/azure/private-link/private-endpoint-overview) - Provision private ip address in the virtual network that will enable access to public resource. Not supported for all services see [Availability](https://docs.microsoft.com/azure/private-link/private-link-overview#availability)

OPINION:
>Relying heavily on these mechanisms will make integration increasingly difficult, some services will have a loss of features when IP addresses are restricted. Remember many of the services were designed for a public cloud. Examples:

>* [Azure SQL import/export service](https://docs.microsoft.com/azure/azure-sql/database/network-access-controls-overview#allow-azure-services)
>* Managing some storage account settings from the portal [Storage Recommendations](https://docs.microsoft.com/azure/storage/blobs/security-recommendations#networking)
>* Using PowerBI to easily integrate with data services

## Private DNS and Azure Private Endpoints

In order to leverage Private Endpoints, you will need to configure DNS appropriately.

When you enable Private Endpoints on a PaaS service, its public DNS record will change from resolving to an IP, to resolving to an alias that will then need to be looked up.  So if your host name for the service is myservice.azureservices.net, instead of resolving to an IP address, it will resolve to myservice.privatelink.azureservices.net.

With that in mind, you need to have a resolution in your DNS solution to resolve the alias.  If you enable a Private DNS Zone along with the Private Endpoint through the portal experience, it will be attached the virtual network and function appropriately by default.  

![Simple diagram of Private DNS Zones and Azure Private Endpoints](https://docs.microsoft.com/azure/private-link/media/private-endpoint-dns/single-vnet-azure-dns.png)

However, if you want resolution from on-prem - or if you want to use the hybrid private DNS topology discussed above - you will have additional considerations.

![A diagram of on-prem DNS and Private Endpoints](https://docs.microsoft.com/azure/private-link/media/private-endpoint-dns/on-premises-using-azure-dns.png)

There are many different configurations that can support this, but in general you should:

* Use public DNS public name (non-privatelink) to the privatelink name
* Use your private DNS to resolve the privatelink name (either with a record in your DNS zone, or by forwarding to a Private DNS Zone)

Although difference services structure their host names in different ways, so pay attention to each service.

See [Private endpoint DNS integration](https://docs.microsoft.com/azure/private-link/private-endpoint-dns) for more details.

## Alternatives to private connectivity

You may not need a full hybrid network to support your workloads. Some services offer their own connectivity options which might be worth exploring if you only need connectivity for 1 or two solutions.

Examples:

* [Azure Relay](https://docs.microsoft.com/azure/azure-relay/relay-what-is-it)
* [Data Gateway](https://docs.microsoft.com/data-integration/gateway/service-gateway-onprem)
* Exposing services using
[Mutual Certificate Authentication](https://docs.microsoft.com/azure/api-management/api-management-howto-mutual-certificates)
