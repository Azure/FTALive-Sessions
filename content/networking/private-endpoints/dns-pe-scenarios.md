# Private Endpoint Resolution Scenarios

Now that we have some of the main concepts for DNS and Private Endpoints matched out, lets talk about the three resolution scenarios that you can plan to adopt:

* **Private DNS Zone Only** - for environments that are hosted in Azure and only need to resolve private IPs backed by Azure Private DNS Zone.
* **Custom DNS Resolution in Azure** - for environments that are hosted in Azure and need to resolve private IPs back by Azure Private DNS Zone as well as by your custom DNS provider, such as Windows Server DNS, Infoblox, or some other solution.
* **Hybrid DNS Resolution** - for the environments hosted in Azure or in other data centers, that need to be able to resolve to each other.  Effectively, Azure-to-Azure, Azure-to-On-Prem, and On-prem-to-Azure are needed.

Most customers will need **Hybrid DNS Resolution**, and you should be prepared to implement that.  However, discussing these different solutions helps you build up an understanding of why you need that solution, and can help you with troubleshooting later.

In whatever DNS solution you are using, you add a record for your private resource, using the Public DNS zone forwarders found [here](https://learn.microsoft.com/azure/private-link/private-endpoint-dns#azure-services-dns-zone-configuration).

One major call out is that Private DNS Zones and Conditional Forwarders are not always 1:1.  For example, Key Vault requires forwarders for `vault.azure.net` & `vaultcore.azure.net`, but a Private DNS Zone for `privatelink.vaultcore.azure.net` only.  Implementing just one of the forwarding zones can create intermittent issues and caching of the incorrect IP address, creating issues.  Consult the table in the above article to plan your DNS needs for a service.

## Private DNS Zone Only

This is the simplest configuration, and a great place to start when testing the flow.  In production, this would only be used for an environment where you can perform *all* of your Private IP resolution from an Azure Private DNS Zone.

The over all flow for DNS resolution here is:

![Image of DNS resolution](https://learn.microsoft.com/azure/private-link/media/private-endpoint-dns/single-vnet-azure-dns.png)

To deploy it, you will need:

* A Virtual Network
* A Virtual Machine deployed to the network
* A Resource such as a SQL DB or a Storage Account
* A private DNS zone for the appropriate zone(s), linked to your virtual network
* A Private Endpoint for the resource, deployed to the network, and with an entry in the zone.

When you set it up, the Private DNS zone should have the following settings:

![An image of a Private DNS Zone with a record for a storage account](img/dnszoneexample.png)
![An image of a PRivate DNS Zone linked with the subnet](img/privednszonelink.png)

Now the resolution flow discussed before should work!



## Custom DNS Zone Provider

While you can attempt to manage your DNS records for Private Endpoints manually, it is recommended.  It is a lot of effort and it very fragile.

Instead, you should look at at implementing a hybrid resolution




First is the manual option.  I  On paper this is easy - creating a zone and record for the service that you want to access (for example, a zone for `blob.core.windows.net`), adding a record for your resource, and then adding root hints to a public DNS resolver for any other entries in this zone that are not found.

Requesting clients will then request resolution from your DNS server, which will provide the private IP for the Private Endpoint, or query the root hint to find an answer.

>🤢 Confirm this works as intended

However, this has a lot of challenges as adoption increases:

- This means there is a non-Azure configuration needed for these services.  If you are using IaC or subscription democratization to allow for teams to deploy in an agile fashion, you are now hindering that agility by requiring this additional step.
- Alternatively, you are having to manage automation for creating and destroying these records as part of your Azure deployment process, which is an additional investment.
- You create a bottle neck for accessing Azure services with your DNS.  This can make things difficult for accessing third party resources.
- You can have DNS issues in your environment that create issues connecting to Azure services.

In general, this doesn't scale well, so the second method is used.  This method involves doing conditional forwarders to the Azure DNS resolver and using Azure Private DNS.

At a high level, it works like this:

- Your on-prem DNS services have a zone for the Azure service involved.  It performs a conditional forwarder for the zone to a DNS service in Azure.
- Your DNS service in Azure forwards the traffic to the Azure DNS resolver (via virtual public IP address [168.63.129.16](https://learn.microsoft.com/azure/virtual-network/what-is-ip-address-168-63-129-16)).  Your DNS service in Azure can be one of many solutions, such as:
  - [Azure DNS Private Resolver](https://learn.microsoft.com/azure/dns/dns-private-resolver-overview)
  - [Azure Firewall DNS Proxy](https://learn.microsoft.com/azure/firewall/dns-details)
  - Domain controllers
  - Stand alone DNS servers, such as Infoblox or Windows Server DNS.
- You have an Azure Private DNS Zone attached to the network for the Service's private link address (example: `privatelink.blob.core.windows.net`).
- The Private Endpoint is attached to the Private DNS Zone through the DNS Zone Group function, meaning the IP address is added to the zone automatically.
- Azure DNS performs recursive lookups for the alias, and returns the private IP.