# Security Overview

#### [prev](./topology-overview.md) | [home](./readme.md)  | [next](./routing.md)

## Considering Endpoint Types

Make sure to understand the endpoint type you are using and threat model controls for that endpoint.  Each of the common endpoint types has its own security options, and you should think carefully about the benefits and limitations of each type.

**Virtual NICs** are resources attached to virtual machines that connect them to the network.  They can be configured with dynamic or static IPs, and are associated with a subnet.  You commonly protect these with Network Security Groups for internal traffic, and Azure Firewalls and Web Application Firewalls for public traffic.

**Public Endpoints** are front ends of Azure services, such as Storage Accounts or Azure SQL databases.  They are publicly accessible from a routing and resolution stand point, but are able to be secured with firewall rules for specific source.  You commonly protect these with their default firewalls, or if they are holding a web application, an Azure Front Door with Web Application Firewall enabled.

**Service Endpoints** are routing rules which are associated with a subnet, but do not receive a public IP.  These allow for the routing across the Azure backbone between your virtual networks and another Azure service, such as Storage Accounts or Azure SQL databases.  The Service Endpoint will allow for routing to anything in that resource category, but individual resources have their own security configuration.  The target resources allow you to configure the firewall to allow for ingress only from specific subnets.  You can use Service and Public Endpoints together on the same resource.  You commonly protect these in the same way as the public endpoints.

**Private Endpoints** are private networking resources that use the Private Link service to communicate with a specific Azure resource, such as Storage Accounts or Azure SQL Databases.  They take up IPs in your private space, and are similar to Virtual NICs.  Once enabled on an Azure resource, the Public and Service Endpoints will cease to function for that resource, and the resource's firewall rules will not be applied.  This means that using this changes how you secure a resource.  It also has [very specific DNS considerations](https://docs.microsoft.com/azure/private-link/private-endpoint-dns) that some organizations find challenging to implement.  You commonly protect these with Network Security Groups for internal traffic, and Azure Firewalls and Web Application Firewalls for public traffic.

## Network Security Groups (NSG)

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

https://docs.microsoft.com/azure/virtual-network/security-overview

## Application Security Groups

Application security groups enable you to configure network security as a natural extension of an application's structure, allowing you to group virtual machines and define network security policies based on those groups.

To do so, you associate virtual machine interfaces with an Application Security Group that represents their function inside of the application.  Then, you can use this as a source or destination in your Network Security Group.

https://docs.microsoft.com/azure/virtual-network/application-security-groups

## Service Tags

A service tag represents a group of IP address prefixes from a given Azure service. Microsoft manages the address prefixes encompassed by the service tag and automatically updates the service tag as addresses change, minimizing the complexity of frequent updates to network security rules.

https://docs.microsoft.com/azure/virtual-network/service-tags-overview

## Azure Bastion

Use NSGs with Azure Bastion to create a separate administrative channel.

## DDoS Protection

Distributed denial of service (DDoS) attacks are some of the largest availability and security concerns facing customers that are moving their applications to the cloud. A DDoS attack attempts to exhaust an application's resources, making the application unavailable to legitimate users. DDoS attacks can be targeted at any endpoint that is publicly reachable through the internet.

https://docs.microsoft.com/azure/virtual-network/ddos-protection-overview

## Azure Firewall

![firewall hub spoke](https://docs.microsoft.com/azure/architecture/reference-architectures/hybrid-networking/images/spoke-spoke-routing.png)

Azure Firewall is a managed, cloud-based network security service that protects your Azure Virtual Network resources. It's a fully stateful firewall as a service with built-in high availability and unrestricted cloud scalability.

It allows you to create policies/rules of three types:

* **Network Rules** which allow for traffic from an IP address range or IP group to another IP address range or IP group for specific ports and protocols
* **Application Rules** which allow for traffic from an IP address range or IP group to a FQDN, for specific ports and protocols
* **NAT Rules** which allow for traffic from an IP address range or IP group to an IP associated with a firewall for specific ports, which is then translated to a backend IP address and port set

In addition, it applies Microsoft Threat Intelligence to protect against known malicious IPs and FQDNs.

In addition to these standard features, there is a Premium SKU which provides advanced protection that will be discussed in [Advanced Security section](security-advanced.md)

https://docs.microsoft.com/azure/firewall/overview

## WAF

Azure native web application firewall (WAF) service that provides powerful protection for web apps.  The service ca be added to an Application Gateway, or to Azure Front Door.

These solutions solve similar problems, and so there is an [Architecture Guide for selecting the correct load balancing option](https://docs.microsoft.com/azure/architecture/guide/technology-choices/load-balancing-overview).  It will also be discussed in [Advanced Security section](security-advanced.md)

WAF configurations can be set to run in one of two modes:

* **Detection mode**: Monitors and logs all threat alerts. You turn on logging diagnostics for Application Gateway in the Diagnostics section. You must also make sure that the WAF log is selected and turned on. Web application firewall doesn't block incoming requests when it's operating in Detection mode.
* **Prevention mode**: Blocks intrusions and attacks that the rules detect. The attacker receives a "403 unauthorized access" exception, and the connection is closed. Prevention mode records such attacks in the WAF logs.

### Azure Application Gateway

App Gateways are deployed inside of a virtual network, and can have private and public IPs attached to them.

They act as a level 7 load balancer inside of a single region that allows you to do site name routing to specific backends, as well as path routing.

![Azure App Gateway high level design](https://docs.microsoft.com/azure/application-gateway/media/application-gateway-url-route-overview/figure1-720.png)

![Azure App Gateway site name routing](https://docs.microsoft.com/azure/application-gateway/media/multiple-site-overview/multisite.png)

![Azure App Gateway multi site listeners](https://docs.microsoft.com/azure/application-gateway/media/multiple-site-overview/wildcard-listener-diag.png)

In addition to load balancing, Application Gateways can be enabled as a Web Application Firewall.  This protects against common web site attacks such as:

* Cross site scripting
* SQL injection
* Command injection
* HTTP request smuggling
* HTTP response splitting
* Remote file inclusion
* Crawlers and scanners
* And more...

You can enable custom rules and bot mitigation as well.

![Application Gateway with WAF](https://docs.microsoft.com/azure/web-application-firewall/media/ag-overview/waf1.png)

You can find more information [here](https://docs.microsoft.com/azure/web-application-firewall/ag/ag-overview).

### Azure Front Door

Azure Front Door is a service that exists outside of your virtual network, to handle incoming traffic from the internet.  They also act as a load balancer, but are able to balance between backends in multiple regions.  If your backend is a virtual machine or other private network item, Front Door will need a way to route traffic through it.  Application Gateways are generally the best solution for this, although firewall NATs and other solutions are also viable.

![WAF High level overview](https://docs.microsoft.com/azure/frontdoor/media/overview/front-door-overview.png)

The Front Door has similar routing options as the Application Gateway, and also can be enabled as a Web Application Firewall.  It default Azure managed rule set protects against:

* Cross site scripting
* Java Attacks
* Local file inclusion
* Remote Command exclusion
* PHP injection attacks
* SQL Injection
* And more...

You can enable custom rules and bot mitigation as well.

You can find more information [here](https://docs.microsoft.com/azure/web-application-firewall/afds/afds-overview).
