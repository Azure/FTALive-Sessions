# Connectivity to External Networks

[prev](./readme.md) | [home](./readme.md)  | [next](./vpn-connectivity.md)

## Overview

![VNet Reference](png/local-or-remote-gateway-in-peered-virtual-network.png)

If you need to communicate with services (using a private IP) in another network there are a few options depending on your requirements, primarily VPN or ExpressRoute. The Azure Architecture center has a a great article comparing the two [here](https://docs.microsoft.com/azure/architecture/reference-architectures/hybrid-networking/) also review the gateway [planning table](https://docs.microsoft.com/azure/vpn-gateway/vpn-gateway-about-vpngateways#planningtable).

### VPN

[**VPN**](https://docs.microsoft.com/azure/vpn-gateway/vpn-gateway-about-vpngateways):
A Virtual Private Network connection is established by creating an encrypted tunnel between a customer VPN device and a VPN Virtual Network Gateway in Azure. VPN is best suited for dev/test workloads and small and medium scale production workloads. It is a good starting place for new Azure environments and connectivity to smaller sites.

### ExpressRoute

[**ExpressRoute**](https://docs.microsoft.com/azure/expressroute/expressroute-introduction):
ExpressRoute connectivity conceptually means running a physical wire from your datacenter to Microsoft, or--more commonly--to a provider who in turn has a direct connection to Microsoft. ExpressRoute connectivity provides the enterprise-class reliability, resiliency, and throughput required for more demanding production and mission critical workloads.

## Virtual Network Gateways

Virtual Network Gateways are Microsoft-managed, highly-available network gateway services used by both VPN and ExpressRoute to route traffic to your VNets.

- Comprised of 2 or more load balanced VMs
- Increasing gateway SKU scales your gateway service up or out
- Gateway SKUs determine throughput and connection counts
- For VPN, your VPN device is connecting directly to the gateway
- For ExpressRoute, your gateway is connected to the MSEE routers represented by your ExpressRoute Circuit
- Gateways take 30 to 60 minutes to provision
