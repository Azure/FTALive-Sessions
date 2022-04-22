# Inter-network Connectivity

#### [prev](./concepts.md) | [home](./readme.md)  | [next](./topology-advanced.md)

## Overview
![VNet Reference](png/local-or-remote-gateway-in-peered-virtual-network.png)

## Within Azure (between VNets)
Connectivity between VNets is usually accomplished with Azure's native [VNet Peering](https://docs.microsoft.com/azure/virtual-network/virtual-network-peering-overview) service. Peering is easy to configure and forms the foundation of a hub-and-spoke network architecture.  

### Virtual Network Peering

* Cross subscription, tenant, and region connectivity (when using Global VNet Peering)
* Peering is not transative without the use of NVA and user defined routes
* Peering is charged on both egress and ingress; excessive use peered VNets when subnets would suffice can become expensive
* Peering [requirements and constraints](https://docs.microsoft.com/azure/virtual-network/virtual-network-manage-peering#requirements-and-constraints) 

**Alternatives to Peering:**

* Site-to-site VPN
* Shared ExpressRoute Circuit

## External Networks

If you need to communicate with services (using a private IP) in another network there are a few options depending on your requirements, primarily VPN or ExpressRoute. The Azure Architecture center has a a great article comparing the two [here](https://docs.microsoft.com/azure/architecture/reference-architectures/hybrid-networking/) also review the gateway [planning table](https://docs.microsoft.com/azure/vpn-gateway/vpn-gateway-about-vpngateways#planningtable):

* [VPN](https://docs.microsoft.com/azure/vpn-gateway/vpn-gateway-about-vpngateways)
* [Express Route](https://docs.microsoft.com/azure/expressroute/expressroute-introduction)

### VPN key points
VPN is best for dev/test workloads and small and medium scale production workloads. It is a good starting place for new Azure environments and connectivity to smaller sites. Because it does not require a third party's involvement to configure, it generally takes less time to bring online.

* [Customer devices](https://docs.microsoft.com/azure/vpn-gateway/vpn-gateway-about-vpn-devices) - validated devices and supported IPSec/IKE settings
* [SKUs](https://docs.microsoft.com/azure/vpn-gateway/vpn-gateway-about-vpngateways#gwsku) - determines aggregate througput
* Routing options:
    * [BGP](https://docs.microsoft.com/azure/vpn-gateway/vpn-gateway-bgp-overview) - required for active/active Gateway configurations
    * Static routes using [Local Network Gateways](https://docs.microsoft.com/azure/vpn-gateway/vpn-gateway-about-vpn-gateway-settings#lng)
* [Availability Design](https://docs.microsoft.com/azure/vpn-gateway/vpn-gateway-highlyavailable)
* Expect provisioning to take 40-60 minutes

### ExpressRoute key points
ExpressRoute connectivity provides the enterprise-class reliability, resiliency, and throughput required for more demanding production and mission critical workloads.

* [Peering Locations](https://docs.microsoft.com/azure/expressroute/expressroute-locations-providers) - MSEE is not equal to an Azure Region
* [Peering Types](https://docs.microsoft.com/azure/expressroute/expressroute-circuit-peerings)
    * Private Peering: connect to your Azure resources
    * Microsoft Peering: connect to Microsoft services, including PaaS services, Microsoft 365, and Dynamics
    * Public Peering: legacy version of Microsoft Peering
* Circuit - ExpressRoute configuration resource for provider, bandwidth, billing type, routing, etc.
* Virtual Network Gateway - entrypoint for traffic from your ExpressRoute Circuit to your Azure VNETs
* [Routing Requirements](https://docs.microsoft.com/azure/expressroute/expressroute-routing) - Public IP, ASN, etc
* [High-availability](https://docs.microsoft.com/azure/expressroute/designing-for-high-availability-with-expressroute) - Path redundancy and first mile considerations
* [Disaster Recovery](https://docs.microsoft.com/azure/expressroute/designing-for-disaster-recovery-with-expressroute-privatepeering) - Designing for disaster recovery with ExpressRoute
* [Pricing](https://azure.microsoft.com/en-us/pricing/details/expressroute/) - For private peering, account for circuit, gateway, egress and carrier charges
