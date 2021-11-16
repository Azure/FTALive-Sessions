# Concepts

#### [prev](./why.md) | [home](./welcome.md)  | [next](./basics.md)

Icon | Short Name | Full Name
--|--|--
![vnet icon](svg/virtualnetworks.svg)       | VNet | Virtual Network
![nsg icon](svg/networksecuritygroups.svg)  | NSG | Network Security Group
![udr icon](svg/routetables.svg)            | UDR | User Defined Route / Route Table
![nic icon](svg/networkinterfaces.svg)      | NIC | Network Interface Card
![ilb icon](svg/loadbalancers.svg)          | ILB | Internal Load Balancer
![nva icon](svg/azurefirewalls.svg)         | NVA | Network Virtual Appliance
![gw icon](svg/virtualnetworkgateways.svg)  | GW | Gateway
![gw icon](svg/publicipaddresses.svg)       | PIP | Public IP Address
![waf icon](png/waf-icon.png) | WAF | Web Application Firewall

## VNet 
A logical address space housing virtual subnets. 
- Special subnets exist for interacting with the platform.
- Special subnets are identified by their name, e.g. `GatewaySubnet`.
- Can be connected to other VNets using Peering.

## NSG
A semi-statefull (*read non-statefull) low level (layer 3) packet filter. 
- Rules based on ip address and port. 
- Has constructs to determine Azure services instead of using IP addresses. 
- Associated to subnets, virtual machines or both.

## UDR
A routing table that allows users to override system routes.
- Associated to subnets.
- Inherited by NICs of VM and certain platform services.

## NIC
A virtual network card to connect virtual machines to a subnet.
- Assigned to a single virtual machine and associated to a subnet.
- House 1 or more IP configurations for the VM (including public and private IP address)
- Virtual machine can have more than one (but this is not a good idea).
- Make routing decisions and part of the wider routing platform.

## ILB
A low cost, very fast load balancer capable of maintaining flow symmetry.
- Not actually a resource;
- A rule within the underlying virtual network fabric.

## NVA
An essential part of the Hub and Spoke topology.
- Azure Firewall is the native NVA option.
- Non-native options include 3rd party appliances.
- High level filtering (layer 7) between VNets, subnets, internet and on-premises. 

## GW
Gateways facilitate more comprehensive connectivity options.
- There are VPN Gateways and ExpressRoute Gateways.
- Linked to the GatewaySubnet.
- Make routing decisions.

## Endpoints

Public endpoints
- Take the form of a public IP address or public DNS Name.
- Azure services and any resource that can be assigned a public IP resource.
- Not always static or deterministic.

Private endpoints
- Take the form of a private IP address.
- Any resource that can be associated to a subnet.
- Not always static or deterministic.

Service endpoints
- Metadata containing routing information and service identifiers.
- Used to optimise routing between VNets and Azure services (using the network back-plane).
- Used to identify Azure services in NSG and Azure Firewall rules.  

Private Link
- Takes the form of a private IP address and private DNS Name.
- Associated to Azure services.
- You are responsible for the hosting the DNS name and correct name resolution.

 ## WAF
 A Web Application Firewall in a PAAS Firewall which inspects requests on their way to an origin web server, and will block requests before they reach the server.
- Web application firewall is used in context with an Application Gateway, Azure Front Door or Azure CDN (Preview).
- WAF provides centralized protection of your web applications against a number of layer 7 attack types. These include SQL injection attacks, cross-site scripting attacks, large request bodies, malformed HTTP requests, and many others. They can also enforce IP address restrictions, including blocking requests from IP addresses known to be used by malicious bots.
- WAFs can be deployed at the edge (using Front Door or CDN), or regionally on an Application Gateway instance.
