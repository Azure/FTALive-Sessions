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
* Shared ExpressRoute circuit: *no longer recommended by networking product group

## External Networks

If you need to communicate with services (using a private IP) in another network there are a few options depending on your requirements, primarily VPN or ExpressRoute. The Azure Architecture center has a a great article comparing the two [here](https://docs.microsoft.com/azure/architecture/reference-architectures/hybrid-networking/) also review the gateway [planning table](https://docs.microsoft.com/azure/vpn-gateway/vpn-gateway-about-vpngateways#planningtable):

* [VPN](https://docs.microsoft.com/azure/vpn-gateway/vpn-gateway-about-vpngateways): A Virtual Private Network connection is established by creating an encrypted tunnel between a customer VPN device (could be a dedicated device, part of a firewall, or software) and a VPN Virtual Network Gateway in Azure. VPN is best for dev/test workloads and small and medium scale production workloads. It is a good starting place for new Azure environments and connectivity to smaller sites. Because it does not require a third party's involvement to configure, it generally takes less time to bring online.
* [ExpressRoute](https://docs.microsoft.com/azure/expressroute/expressroute-introduction): ExpressRoute connectivity conceptually means running a physical wire from your datacenter to Microsoft, or--more commonly--to a provider who in turn has a direct connection to Microsoft. ExpressRoute connectivity provides the enterprise-class reliability, resiliency, and throughput required for more demanding production and mission critical workloads.

### VPN key points

* [Customer devices](https://docs.microsoft.com/azure/vpn-gateway/vpn-gateway-about-vpn-devices): Microsoft provides a list of validated devices, supported IPSec/IKE configurations, and sample scripts for configuring your VPN device.
* [Virtual Network Gateway SKUs](https://docs.microsoft.com/azure/vpn-gateway/vpn-gateway-about-vpngateways#gwsku): determines aggregate throughput, connection count, point-to-site options
* Routing options:
  * [BGP](https://docs.microsoft.com/azure/vpn-gateway/vpn-gateway-bgp-overview): BGP is required for multiple connections and active/active Gateway configurations
  * Static routes using [Local Network Gateways](https://docs.microsoft.com/azure/vpn-gateway/vpn-gateway-about-vpn-gateway-settings#lng)
* [Availability Design](https://docs.microsoft.com/azure/vpn-gateway/vpn-gateway-highlyavailable): high-availability is accomplished with multiple customer-side VPN devices and ideally active/active VPN gateway configurations
  ![VPN dual-redundancy diagram](./png/vpn-dual-redundancy.png)
* Expect VPN VNet Gateway provisioning to take 40-60 minutes

### ExpressRoute key points

![Basic ExpressRoute diagram](./png/exr-reco.png)

* [Peering Locations](https://docs.microsoft.com/azure/expressroute/expressroute-locations-providers): Microsoft Enterprise Edge (MSEE) peering locations are not Azure regions
* [Peering Types](https://docs.microsoft.com/azure/expressroute/expressroute-circuit-peerings): peering types determine the services connected to over ExpressRoute. Private Peering is typically where customers start; Microsoft Peering is recommended for customers looking to me specific compliance requirements  
  * *Private Peering*: connect to your Azure resources
  * *Microsoft Peering*: connect to Microsoft services, including PaaS services, Microsoft 365, and Dynamics
  * *Public Peering*: legacy version of Microsoft Peering
* Circuit: ExpressRoute configuration resource for provider, bandwidth, billing type, routing, etc.
  * Multiple circuits required for multiple peering locations or providers
* Virtual Network Gateway: entrypoint for traffic from your ExpressRoute Circuit to your Azure VNets 
* Bandwidth:
  * Connection is duplex--purchased bandwidth is available in both directions
  * Because connection is redundant, the customer actually has 2x the purchased bandwidth available  
* [Routing Requirements](https://docs.microsoft.com/azure/expressroute/expressroute-routing): Microsoft peering requires registered ASN and public IP addresses; private peering can use private IPs and ASNs
* [High-availability](https://docs.microsoft.com/azure/expressroute/designing-for-high-availability-with-expressroute):
  * Establish multiple connections to your provider and/or use multiple providers
  * Both BGP sessions (primary and secondary connections) need to be established for SLA
  * Use Availability Zone-aware ER gateways
  * Use multiple peering locations and providers for maximum resiliency
* [Disaster Recovery for private peering](https://docs.microsoft.com/azure/expressroute/designing-for-disaster-recovery-with-expressroute-privatepeering):
* [Pricing](https://azure.microsoft.com/pricing/details/expressroute/): For private peering, account for Circuit, Gateway, egress, and carrier charges

### Advanced Scenarios

* [Coexistance of ExpressRoute and VPN Gateways](https://docs.microsoft.com/azure/expressroute/expressroute-howto-coexist-resource-manager)
  * Provide a fail-back for ExpressRoute connectivity
  * Encrypt traffic over ExpressRoute to meet regulatory requirements