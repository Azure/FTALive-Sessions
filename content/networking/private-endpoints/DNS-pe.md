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

There are two main options for managing the DNS for your Private Endpoints.

First is the manual option.  In whatever DNS solution you are using, you add a record for your private resource's private link alias.  On paper this is easy - creating a zone and record for the service that you want to access (for example, a zone for `privatelink.blob.core.windows.net`).

Requesting clients will then:

- Go to your DNS service to resolve the public name.
- Your global hints will direct the request to a public DNS provider, and resolve to the alias.
- Your DNS service will be able to use the alias to provide the correct IP.

However, this has a lot of challenges as adoption increases:

- This means there is a non-Azure configuration needed for these services.  If you are using IaC or subscription democratization to allow for teams to deploy in an agile fashion, you are now hindering that agility by requiring this additional step.
- Alternatively, you are having to manage automation for creating and destroying these records as part of your Azure deployment process, which is an additional investment.

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

There is a guide for [Private endpoint DNS integration](https://learn.microsoft.com/azure/private-link/private-endpoint-dns) that you should review, and we should do so now.
