# Virtual Network Security

**[prev](./topology-overview.md) | [home](./readme.md)  | [next](./routing.md)**

## Considering Endpoint Types

Make sure to understand the endpoint type you are using and threat model controls for that endpoint.  Each of the common endpoint types has its own security options, and you should think carefully about the benefits and limitations of each type.

**Virtual NICs** are resources attached to virtual machines that connect them to the network.  They can be configured with dynamic or static IPs, and are associated with a subnet.  You commonly protect these with Network Security Groups for internal traffic, and Azure Firewalls and Web Application Firewalls for public traffic.

**Public Endpoints** are front ends of Azure services, such as Storage Accounts or Azure SQL databases.  They are publicly accessible from a routing and resolution stand point, but are able to be secured with firewall rules for specific source.  You commonly protect these with their default firewalls, or if they are holding a web application, an Azure Front Door with Web Application Firewall enabled.

**Service Endpoints** are routing rules which are associated with a subnet, but do not receive a public IP.  These allow for the routing across the Azure backbone between your virtual networks and another Azure service, such as Storage Accounts or Azure SQL databases.  The Service Endpoint will allow for routing to anything in that resource category, but individual resources have their own security configuration.  The target resources allow you to configure the firewall to allow for ingress only from specific subnets.  You can use Service and Public Endpoints together on the same resource.  You commonly protect these in the same way as the public endpoints.

**Private Endpoints** are private networking resources that use the Private Link service to communicate with a specific Azure resource, such as Storage Accounts or Azure SQL Databases.  They take up IPs in your private space, and are similar to Virtual NICs.  Once enabled on an Azure resource, the Public and Service Endpoints will cease to function for that resource, and the resource's firewall rules will not be applied.  This means that using this changes how you secure a resource.  It also has [very specific DNS considerations](https://docs.microsoft.com/azure/private-link/private-endpoint-dns) that some organizations find challenging to implement.  You commonly protect these with Network Security Groups for internal traffic, and Azure Firewalls and Web Application Firewalls for public traffic.

## Network and Application Security Groups

### Network Security Groups (NSG)

A network security group contains security rules that allow or deny inbound network traffic to, or outbound network traffic from, several types of Azure resources.

A network security group contains zero, or as many rules as desired, within Azure subscription limits. Each rule specifies the following properties:

* Name
* Priority
* Source
* Source Port ranges
* Destination
* Destination Port Ranges
* Protocol

Each Security rule is created as either Inbound or Outbound rule.
Each NSG also has default security rules which are created automatically by Azure.

It is recommended to use NSGs, even when leveraging a centralized firewall solution such as Azure Firewall, both as part of a defense-in-depth strategy and because NSGs are required to capture flow logs.

[Networking security overview](https://docs.microsoft.com/azure/virtual-network/security-overview)

#### Effective Security Rules

* Diagnostic property located on a Network Interface Card resource.
* Dynamically updated and requires the NIC to be attached to a running VM.

![Effective security rules](png/effective-security-rules.png)

[Diagnose a virtual machine network traffic filter problem](https://docs.microsoft.com/azure/virtual-network/diagnose-network-traffic-filter-problem)

#### NSG Flow Logs

Network security group (NSG) flow logs is a feature of Azure Network Watcher that allows you to log information about IP traffic flowing through an NSG. Flow data is sent to Azure Storage accounts from where you can access it as well as export it to any visualization tool, SIEM, or IDS of your choice.

[Introduction to flow logging for network security groups](https://docs.microsoft.com/azure/network-watcher/network-watcher-nsg-flow-logging-overview)

### Application Security Groups

Application security groups enable you to configure network security as a natural extension of an application's structure, allowing you to group virtual machines and define network security policies based on those groups.

To do so, you associate virtual machine interfaces with an Application Security Group that represents their function inside of the application.  Then, you can use this as a source or destination in your Network Security Group.

[Application Security Group](https://docs.microsoft.com/azure/virtual-network/application-security-groups)

### Service Tags

A service tag represents a group of IP address prefixes from a given Azure service. Microsoft manages the address prefixes encompassed by the service tag and automatically updates the service tag as addresses change, minimizing the complexity of frequent updates to network security rules.

[Service Tags](https://docs.microsoft.com/azure/virtual-network/service-tags-overview)

## Azure Bastion

Azure bastion can be used to grant remote access to VMs through a secure pane.  It doesn't provide a jump box, but instead a gateway to access a virtual machine through the portal or a client.  This gateway checks items such as MFA and conditional access for identities, and so provides additional security for accessing workloads.

[Azure Bastion](https://docs.microsoft.com/azure/bastion/bastion-overview)

## DDoS Protection

Distributed denial of service (DDoS) attacks are some of the largest availability and security concerns facing customers that are moving their applications to the cloud. A DDoS attack attempts to exhaust an application's resources, making the application unavailable to legitimate users. DDoS attacks can be targeted at any endpoint that is publicly reachable through the internet.

[DDOS Protection](https://docs.microsoft.com/azure/virtual-network/ddos-protection-overview)
