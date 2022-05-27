# DNS Zones in Azure

**[prev](./basics.md) | [home](./readme.md)  | [next](./security-overview.md)**

>This is in addition to the DNS discussion in **[Vnet Basics](basics.md)**.  From that discussion, you should be aware of:

> * How VMs send DNS requests to the Azure backbone
> * How to direct Azure DNS requests to a DNS server or service

## Public DNS Zones

Public DNS zones (just called DNS zones) are hosted namespaces that perform domain resolution for names.  Inside of the Zone, you are able to list DNS records like you would in any common DNS systems.  One key limitation is that Private DNS zones do not do conditional forwarding.

Creating a DNS Zone does not register the domain name.  That process still requires the work of a registrar, although more Azure services allow domain registration bundled with them.

Once you create an Azure DNS zone, you will have a list of name servers available for the zone.  You will have to set these as the name servers in the registrar that you registered the domain with.

Once completed, public resolution of your name space will occur against your Azure DNS zone.

## Private DNS Zones with Azure Native DNS

Private DNS Zones are namespaces that allows you to perform name resolution.  Inside of the Zone, you are able to list DNS records like you would in any common DNS systems.  One key limitation is that Private DNS zones do not do conditional forwarding.

![Flowchart of DNS resolution](https://docs.microsoft.com/azure/dns/media/private-dns-overview/scenario.png)

Once you create a Zone, you can link it to your virtual networks.  Once linked, these records will be available whenever resources the virtual networks default DNS lookup feature.  A virtual network can be linked to multiple Private DNS zones, and the Private DNS zone can be linked to multiple virtual networks.

When you link a virtual network to a DNS zone, you can also select to enable auto registration.  If auto registration is enabled, virtual machines deployed to the virtual network will add themselves to the DNS zone.

For example, if we have the private DNS zone *contoso.com* linked to VNET1 with registration enabled, when VM1 is created on VNET1 it will create a record for VM1.contoso.com.

A virtual network can only register to one DNS zone, but multiple virtual networks can register to the same DNS zone.

## Hybrid Private DNS

Because of the inability to do conditional forwarding, and integration of existing DNS systems, organizations often use Private DNS zones along with their existing DNS systems in a hybrid configuration.

In this configuration, the virtual network DNS targets are set to the VMs that house the DNS system.  This performs the first level of resolution, and allows for non-Azure corporate resources to be resolved easily.

However, for any names in a Private DNS zone, the DNS system can forward that traffic to the Azure DNS resolver. This can be done by creating a conditional forward for that domain, forwarding to the IP address **168.63.129.16** from within and Azure virtual network.  This IP address will then perform the lookup and return the value.
