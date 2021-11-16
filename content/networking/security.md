# Security

#### [prev](./topology.md) | [home](./welcome.md)  | [next](./mgmt.md)

## Network Security Groups (NSG)
A network security group contains security rules that allow or deny inbound network traffic to, or outbound network traffic from, several types of Azure resources.

A network security group contains zero, or as many rules as desired, within Azure subscription limits. Each rule specifies the following properties:

* Name
* Priority
* Source
* Source Port ranges
* Destionation 
* Destionation Port Ranges
* Protocol

Each Security rule is created as either Inboud or Outbound rule.
Each NSG also has default security rules which are created automaticly by Azure.

https://docs.microsoft.com/en-us/azure/virtual-network/security-overview

## Application Security Groups
Application security groups enable you to configure network security as a natural extension of an application's structure, allowing you to group virtual machines and define network security policies based on those groups. 

https://docs.microsoft.com/en-us/azure/virtual-network/application-security-groups

## Service Tags
A service tag represents a group of IP address prefixes from a given Azure service. Microsoft manages the address prefixes encompassed by the service tag and automatically updates the service tag as addresses change, minimizing the complexity of frequent updates to network security rules.

https://docs.microsoft.com/en-us/azure/virtual-network/service-tags-overview

## Endpoint type
Make sure to understand the endpoint type you are using and threat model controls for that endpoint.

## Azure Bastion
Use NSGs with Azure Bastion to create a separate administrative channel.

## DDoS Protection
Distributed denial of service (DDoS) attacks are some of the largest availability and security concerns facing customers that are moving their applications to the cloud. A DDoS attack attempts to exhaust an application's resources, making the application unavailable to legitimate users. DDoS attacks can be targeted at any endpoint that is publicly reachable through the internet.
https://docs.microsoft.com/en-us/azure/virtual-network/ddos-protection-overview

## Azure Firewall
Azure Firewall is a managed, cloud-based network security service that protects your Azure Virtual Network resources. It's a fully stateful firewall as a service with built-in high availability and unrestricted cloud scalability.
https://docs.microsoft.com/en-us/azure/firewall/overview

## WAF
Azure native web application firewall (WAF) service that provides powerful protection for web apps.
