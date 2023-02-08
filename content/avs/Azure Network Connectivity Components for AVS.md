# Azure Network Connectivity & Components for AVS

### Basic AVS Network Connectivity 

**What is AVS Managed ExpressRoute?**  
An AVS Managed ExpressRoute is provisioned for you at the time of AVS deployment. When AVS is deployed, it’s isolated and because you will likely need connectivity to other resources, and ExpressRoute is deployed for you. You can then connect other vNETs or via an ExpressRoute back to on-prem.

See: [What is Azure ExpressRoute?](https://learn.microsoft.com/en-us/azure/expressroute/expressroute-introduction)

**What is Global Reach?**  
Global Reach is used to connect private clouds to on-premises environments. It connects circuits directly at the Microsoft Enterprise Edge (MSEE) level. The connection requires a virtual network (vNet) with an ExpressRoute circuit to on-premises in your subscription. 

See: [Peer on-premises environments to Azure VMware Solution - Azure VMware Solution | Microsoft Learn](https://learn.microsoft.com/en-us/azure/azure-vmware/tutorial-expressroute-global-reach-private-cloud)

**What is an ExpressRoute Gateway?**  
You must first create a virtual network gateway before connecting AVS. A virtual network gateway serves two purposes: it exchanges IP routes between the networks and routes network traffic.  

See: [About ExpressRoute virtual network gateways - Azure | Microsoft Learn](https://learn.microsoft.com/en-us/azure/expressroute/expressroute-about-virtual-network-gateways)

**What is a VPN Gateway?**  
While ExpressRoute is the preferred way to connect an on premise network to AVS, a VPN Gateway can be used.
![image](https://user-images.githubusercontent.com/101416142/217544535-c22e6f97-d865-4c9a-bf66-53a8c1108db5.png)  

See: [Configure a site-to-site VPN in vWAN for Azure VMware Solution - Azure VMware Solution | Microsoft Learn](https://learn.microsoft.com/en-us/azure/azure-vmware/configure-site-to-site-vpn-gateway)

### Other Azure Networking Components related to AVS

**What is vWAN?**  
Azure Virtual WAN is a networking service that brings many networking, security, and routing functionalities together to provide a single operational interface. The Virtual WAN architecture is a hub and spoke architecture with scale and performance built in for branches (VPN/SD-WAN devices), users (Azure VPN/OpenVPN/IKEv2 clients), ExpressRoute circuits, and virtual networks.

See: [Virtual WAN documentation | Microsoft Learn](https://learn.microsoft.com/en-us/azure/virtual-wan/)

**What is Azure Firewall?**  
Azure Firewall is a cloud-native and intelligent network firewall security service that provides the best of breed threat protection for your cloud workloads running in Azure. It's a fully stateful, firewall as a service with built-in high availability and unrestricted cloud scalability. It provides both east-west and north-south traffic inspection.  

See: [What is Azure Firewall? | Microsoft Learn](https://learn.microsoft.com/en-us/azure/firewall/overview)

**What are Azure Route Servers?**  
Azure Route Server simplifies dynamic routing between your network virtual appliance (NVA) and your virtual network. It allows you to exchange routing information directly through Border Gateway Protocol (BGP) routing protocol between any NVA that supports the BGP routing protocol and the Azure Software Defined Network (SDN) in the Azure Virtual Network (VNet) without the need to manually configure or maintain route tables. Azure Route Server is a fully managed service and is configured with high availability.  

See: [Quickstart: Create and configure Route Server using the Azure portal | Microsoft Learn](https://learn.microsoft.com/en-us/azure/route-server/quickstart-configure-route-server-portal)

**What are 3rd party Firewalls and layer 3 NVA's and why would you use them?**  
When moving to Azure VMware Solution, customers may want to maintain operational consistency with their current 3rd-party networking and security platforms. The types of 3rd-party platforms could include solutions from many different vendors.
Typically NVAs are used for north-south traffic inspection.  

See: [Enterprise-scale network topology and connectivity for Azure VMware Solution - Cloud Adoption Framework | Microsoft Learn](https://learn.microsoft.com/en-us/azure/cloud-adoption-framework/scenarios/azure-vmware/eslz-network-topology-connectivity)

**What are Route-Tables?**  
If you want to change any of Azure's default routing, you do so by creating a route table. Route tables are typically used when implementing User Defined Routing or by using BGP between your on-prem network gateway and Azure.  

See: [Create, change, or delete an Azure route table | Microsoft Learn](https://learn.microsoft.com/en-us/azure/virtual-network/manage-route-table)

**What is an Application Gateway?**  
An Azure Application Gateway is a web traffic load balancer that enables you to manage traffic to your web applications. They can operate at both layer 4 and layer 7.  

 [home](./readme.md) | [next](https://github.com/jasonamedina/FTALive-Sessions/blob/main/content/avs/Scenario%201.md)
