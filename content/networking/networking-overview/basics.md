# VNet Basics

#### [prev](./concepts.md) | [home](./readme.md)  | [next](./topology-overview.md)

##### What is an Azure Virtual Network (VNET)?
- A self contained software-defined network
- Exists in a single region
> [!NOTE]
> Configure IP address and DNS settings outside of the VMs OS. Leave the VM to use DHCP (yes, even for NVAs)

##### VNET configuration
- Assign one or more address spaces
    - Address spaces can be added after creation
    - Address spaces with subnets cannot be modified 
- Addresses will automatically be allocated to connected services
- DNS:
    - Set to Azure provided by default, which includes DNS Zones and Private DNS Zones (if used)
    - Can be set to one or more IPs for custom DNS servers
- DDOS protection plan set at the VNET level

##### Connecting within a VNET
- Traffic within and *between* subnets allowed by default
- Use subnets to demark different applications, environments, or application tiers

##### Connecting to a VNET
- No inbound connectivity is possible except through public-facing endpoints like Public IPs, Application Gateways, and Load Balancers
- Assigning Public IPs to VMs is not recommended in production
   - Use Azure Bastion or hybrid connectivity for management access
   - Use App Gateway, Azure Firewall, or Standard Load Balancers for application traffic
- From your remote networks: use a Virtual Network Gateway or custom VPN solution, detailed in [Connectivity section](./connectivity.md)

##### Connecting from a VNET
- Default outbound NAT to a dynamic Azure Datacenter IP for internet access
- VMs with a Public IP will use the public IP address for outbound SNAT
- For persistent outbound IPs and production level SNAT port control, use NAT Gateway, a Standard Load Balancer, or a network appliance

> [!NOTE]
> More information for [**Outbound connection (flows)**](https://docs.microsoft.com/en-us/azure/virtual-network/ip-services/default-outbound-access)

##### Connecting between VNETs
- VNETs are isolated by default
- VNET peering or VPN. Covered in [Connectivity section](./connectivity.md)

### [VNET Frequently Asked Questions](https://docs.microsoft.com/en-us/azure/virtual-network/virtual-networks-faq)
