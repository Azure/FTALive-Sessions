# Load Balancers and Web Application Firewalls

**[prev](./firewalls.md) | [home](./readme.md)  | [next](./private-endpoints.md)**

## Load Balancing Options

There are four load balancer options that are Azure native:

* **Load Balancers** for single region load balancing of non-web traffic.
* **Traffic Manager** for multi-region load balancing of non-web traffic using DNS.
* **Application Gateways** for single region load balancing of web traffic.  It can also serve as a web application firewall.
* **Azure Front Door (CDN profiles)** for multi-region load balancing of web traffic and content delivery.  It can also serve as a web application firewall.

Each one has its own pros and cons, and so there is documentation that can help you select the right option for your workload.  These solutions can also work together to expand out your load balancing, so that you can load balance between front ends in different regions, and have those front ends load balance inside of their regions to backend services.  You can also layer them in with firewall services.

![Azure Load Balancing Decision Flow](https://docs.microsoft.com/azure/architecture/guide/technology-choices/images/load-balancing-decision-tree.png)

[More on selecting your load balancing options](https://docs.microsoft.com/azure/architecture/guide/technology-choices/load-balancing-overview)

**Note** that only Frontdoor and Application Gateway can be configured with WAFs, and are focused on web apps.

## Non-HTTP/S Load Balancers

### Azure Load Balancers

Azure Load Balancers are layer 4 load balancers that act as a single point of contacts for clients.  They contain rules that route traffic to a backend pool of resources, such as Virtual Machines or instances in a scale set.

There are two sub-types of load balancers:

* **Public Load Balancers** that are accessible outside of your virtual network, and load balance inbound traffic from the internet to your virtual machines.  While they can provide ingress for web traffic, Application Gateways are a better fit.
* **Private Load Balancers** that are accessible inside of your network only, and load balance against your private IP space.  On-premise networks connected via a gateway can also access these.

![Azure Load Balancer Overview](https://docs.microsoft.com/azure/load-balancer/media/load-balancer-overview/load-balancer.svg)

[Azure Load Balancer](https://docs.microsoft.com/azure/load-balancer/load-balancer-overview)

### Traffic Manager

Traffic Manager is a DNS-based traffic load balancer.  It allows you to distribute traffic to public facing applications across global regions.

You can assign different [routing methods](https://docs.microsoft.com/azure/traffic-manager/traffic-manager-routing-methods) to Traffic Manager, to determine the destination.  This can include things like client geography, performance, or others.

For example, if you had a service that was available in both East US 2 and West US 2, Traffic Manager could route clients to the closest service.  However, that service would still need to be publicly accessible, such as with an external load balancer.

Because it is DNS based, this routing occurs through providing DNS resolution to one of the regional endpoints, not by forwarding the traffic itself.

![Azure Traffic Manager Diagram](https://docs.microsoft.com/azure/traffic-manager/media/traffic-manager-how-traffic-manager-works/flow.png)

[Azure Traffic Manager](https://docs.microsoft.com/azure/traffic-manager/traffic-manager-overview)

## HTTP/S Load Balancers and Web Application Firewalls

Azure native web application firewall (WAF) service that provides powerful protection for web apps.  The service can be added to an Application Gateway, or to Azure Front Door.

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

### Web Application Firewall Reporting

Both solutions use Log Analytics for their logging purposes.  You can create queries and add them to dashboards to enable monitoring.

* [WAF logs for Frontdoor](https://docs.microsoft.com/azure/web-application-firewall/afds/waf-front-door-monitor)
* [WAF logs for App Gateway](https://docs.microsoft.com/azure/web-application-firewall/ag/application-gateway-waf-metrics)
