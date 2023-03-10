# FTA Live - Private Endpoints

## Agenda

### Overview

- [Why use Private Endpoints?](why-pe.md)
- [What we see in the field at Fast Track for Azure](field-experience.md)
- [How Private Endpoints Work](overview.md)
- [DNS Concepts](dns-pe-concepts.md)
- [DNS Scenarios](dns-pe-scenarios.md)
- [Network Design for Private Endpoints](security-and-routing.md)

### Special Cases

- [Special Case - Storage Accounts](pe-sa-scenarios.md) - An overview of some special considerations for Azure Storage Accounts.
- [Special Case - Azure Data Factory, Synapse, and Purview](pe-data-scenarios.md) - An overview of some of the special considerations of the data pipeline services in Azure.
- [Special Case - AMPLS](pe-ampls-scenarios.md) - An overview of the special considerations of the Azure Monitor Private Link Service.

### content creation
	1. ✅[brandon] Why use Private Endpoints/field experience
	2. [matthew] How do Private Endpoints work?
		a. Connectivity 
		b. DNS
		c. Private Link Service
	3. [matthew] Creating Private Endpoints - demo
		a. PaaS Services
			i. Globally-unique name endpoints
				1) Storage, SQL, Key Vault
			ii. Portals and shared name endpoints [save for later or don't detail….]
				1) ADF, Synapse, HD Insight, AMPLS
	4. ✅[brandon] Configuring DNS for Private Endpoints
		a. Required records
		b. Implementation options:
			i. Private DNS Zones
			ii. Custom DNS
		c. Access from on-prem: DNS forwarding approaches 
			i. Conditional forwarders
			ii. Private Resolver
			iii. Azure Firewall Proxy
	5. [matthew] Troubleshooting
		a. Name resolution
			i. 'nslookup' example
		b. Traffic routing
		c. Filtering by NSGs and NVAs
	6. ⌛ [brandon] Private Endpoint security and routing (Framing out)
	7. [matthew] Common misconfigurations:
		1) DNS configuration is not complete for the requested service (a consistent approach is not followed) 
		2) Private DNS Zones
			a) Private DNS Zone not linked to DNS forwarder VNET
			b) Private DNS Zone missing link to Private Endpoint (DNS Zone Group), 'A' record is missing
			c) Multiple, segmented Private DNS Zones for the same zone name
			d) Mismatch with corporate policy (ie, custom DNS configuration is used instead of Private DNS Zones or new Private DNS Zone created when one already exists) 
		3) On-prem:
			a) conditional forwarder forwards requests to 168.63.129.16 directly 
			b) conditional forwarder zone name has 'privatelink' subdomain 
			c) clients are using a different DNS service than were the conditional forwarder is configured (for example, on VPN) 
			d) forwarded queries from on-prem DNS cannot reach the Azure DNS forwarder (routing or hybrid connectivity issues)
