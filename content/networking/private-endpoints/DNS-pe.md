# DNS Refresher -  what you need to know for Private Endpoints

> This is not an over all guide for DNS in Azure, but rather specific guidance for Private Endpoints.

Your *Domain Name System* or DNS is a critical part of your Private Endpoint configuration.  Most Private Endpoint implementations run in to challenges at this level, so having a clear plan for how you are resolving the names of the private endpoints is critical.

## Why does DNS matter for Private Endpoints?

For public access, your services in Azure might share public IPs and use domain name routing to determine direction to the appropriate service.  This means that traffic needs to still contain the right header when accessing the service, in order for it to find the right backend.

In addition, security settings also look for the header - this prevents certain kinds of attacks or misdirection, and is critical for the protection of the service.

In addition, your Azure service still has its public DNS resolution.  So without a DNS change, your traffic will resolve to the public endpoint, not the private one.

You need to plan to have requests to your service resolve to the IP address of the Private Endpoint.

This is made easier by an alias being created for most services when you set up a Private Endpoint.  If you do a DNS Lookup on your service, you will see an alias for a corresponding `privatelink` domain.

For example, if you perform an NS lookup for `mysa.blob.core.windows.net` that has a Private Endpoint enabled, you will get an alias for `mysa.privatelink.blob.core.windows.net`.  This tells the requesting machine to look up that domain name.  But providing resolution for this domain name, you can redirect towards your private endpoint.

## What are my options for managing this?

There are two main options for managing the DNS for your Private Endpoints, at least when it comes to looking up resources from on-prem.

First is the manual option.  In whatever DNS solution you are using, you add a record for your private resource, using the Public DNS zone forwarders found [here](https://learn.microsoft.com/azure/private-link/private-endpoint-dns#azure-services-dns-zone-configuration).  On paper this is easy - creating a zone and record for the service that you want to access (for example, a zone for `blob.core.windows.net`), adding a record for your resource, and then adding root hints to a public DNS resolver for any other entries in this zone that are not found.

Requesting clients will then request resolution from your DNS server, which will provide the private IP for the Private Endpoint, or query the root hint to find an answer.

>🤢 Confirm this works as intended

However, this has a lot of challenges as adoption increases:

- This means there is a non-Azure configuration needed for these services.  If you are using IaC or subscription democratization to allow for teams to deploy in an agile fashion, you are now hindering that agility by requiring this additional step.
- Alternatively, you are having to manage automation for creating and destroying these records as part of your Azure deployment process, which is an additional investment.
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

## What do I need to plan for?

There is a guide for [Private endpoint DNS integration](https://learn.microsoft.com/azure/private-link/private-endpoint-dns) that explains this process in more detail!

One major call out is that Private DNS Zones and Conditional Forwarders are not always 1:1.  For example, Key Vault requires forwarders for `vault.azure.net` & `vaultcore.azure.net`, but a Private DNS Zone for `privatelink.vaultcore.azure.net` only.  Implementing just one of the forwarding zones can create intermittent issues and caching of the incorrect IP address, creating issues.  Consult the table in the above article to plan your DNS needs for a service.

## Why can't I use my own Zone name?

A common challenge is that organizations wish to use their own zone names for the resources.  While some services offer the option to set custom domain names, most need to use the existing domains.  This is because the certificates used for communication are set to expect specific CN records; if you change these, the traffic will not be permitted.
