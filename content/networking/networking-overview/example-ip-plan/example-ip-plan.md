# Example Address scheme

## Regional Planning

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

Spoke vnets are dynamic and map to an application or group of (heavily) related applications.

Spoke vnets vary in size but are usually smaller rather than larger and subnets align to the application's requirements.

![Example N-Tier App](https://docs.microsoft.com/azure/architecture/guide/architecture-styles/images/n-tier-physical-bastion.png)

Example sizes might be:

T-shirt Size| CIDR Size | Suited for | Hosts |
---|---|---|---|
Small | /26 | Small simple applications without much tiering or autoscaling  | 64 *minus 5 per subnet* |
Medium | /25 | More complex applications that have more tiering or autoscaling, or are broken in to smaller services  | 128 *minus 5 per subnet*
Large | /24 | Applications that have multiple tiers, and use vnet integration with app services, SQL services, or Azure Kubernetes Services **OR** a workload made up of multiple simple applications | 256 *minus 5 per subnet* |
Extra Large | /23 | A workload made up of multiple complex applications, or that uses services with significant IP address considerations  | 512 *minus 5 per subnet* |

[Read more about subnet reservations](https://docs.microsoft.com/azure/virtual-network/virtual-networks-faq#are-there-any-restrictions-on-using-ip-addresses-within-these-subnets)
