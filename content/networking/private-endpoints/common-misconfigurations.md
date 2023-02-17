# Common Private Endpoint Misconfigurations

The following misconfigurations are common for customers. Refer to [Troubleshooting Private Endpoints](./troubleshooting.md) for more information. 

1) DNS configuration is not complete for the requested service (or a consistent approach is not followed for every service using Private Endpoints)
2) Private DNS Zones
    a) Private DNS Zone not linked to DNS forwarder VNET
    b) Private DNS Zone exists but is missing a  link to Private Endpoint (a DNS Zone Group resource), resulting in a missing 'A' record
    c) Multiple, segmented Private DNS Zones for the same zone name. Since a VNET cannot be linked to multiple Private DNS Zones with overlapping namespace, this prevents correctly linking the Private DNS Zones to the DNS server's VNET.
    d) Uncoordinated approach to DNS (ie, custom DNS configuration is used instead of Private DNS Zones or new Private DNS Zone created when one already exists)
3) On-prem:
    a) conditional forwarder forwards requests to 168.63.129.16 directly
    b) conditional forwarder zone name has 'privatelink' subdomain
    c) clients are using a different DNS service than where the conditional forwarder is configured (for example, on VPN)
    d) forwarded queries from on-prem DNS cannot reach the Azure DNS forwarder (routing or hybrid connectivity issues)