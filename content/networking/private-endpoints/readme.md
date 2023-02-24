# FTA Live - Private Endpoints

## Agenda

- [Why use Private Endpoints?](why-pe.md)
- [What we see in the field at Fast Track for Azure](field-experience.md)
- [How Private Endpoints Work](overview.md)
- Misconceptions about Private Endpoints
- [DNS Refresher](dns-pe.md) - what you need to know for Private Endpoints
- [Private Endpoint Security and Routing](security-and-routing.md)
- Creating Private Endpoints
- Creating DNS
- Creating Routing
- Private Inbound Access (NOT private endpoints!)
- Weird Services (Storage Accounts having multiple endpoints)
- AMPLS and Data Services (Portal, ???, Ingestion)

### content creation
	1. [brandon] Why use Private Endpoints✅/field experience✅
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
	4. [brandon] ✅Configuring DNS for Private Endpoints
		a. ✅Required records
			i. ✅✅
		b. ✅Implementation options:
			i. ✅IPrivate DNS Zones
			ii. ✅ICustom DNS
		c. ✅IAccess from on-prem: DNS forwarding approaches 
			i. ✅IConditional forwarders
			ii. ✅IPrivate Resolver
			iii. ✅IAzure Firewall Proxy
	5. [matthew] Troubleshooting
		a. Name resolution
			i. 'nslookup' example
		b. Traffic routing
		c. Filtering by NSGs and NVAs
	6. [brandon] ⌛Private Endpoint security and routing (Framing out)
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
