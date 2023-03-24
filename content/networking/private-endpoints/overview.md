# How Private Endpoints Work

In the simplest scenario, Private Endpoints logically create a 'tunnel' from your VNET to a PaaS service instance, eliminating the need for a pubic endpoint to access the PaaS service. In order for clients to use the Private Endpoint (private IP) when accessing the PaaS service, you override the DNS name resolution for the service, so that a name which previously resolved to a Microsoft public IP address instead resolves to the private IP address.

This overview focuses on the simple scenario of a Storage Account and Private Endpoint for the blob service. More complex Private Endpoint scenarios, such as when the PaaS service does not have a unique DNS name per instance or when using a Private Link Service are much easier to grasp once you understand the basic scenario.

## Connectivity

**From your VNET or on-prem network to the Private Endpoint:** This connectivity and routing is similar to other traffic within and between VNETs or from on-prem to your VNET. If you already have these traffic flows working, you will not need to take additional steps.

**From the Private Endpoint to the PaaS service:** You associate the PaaS service with the Private Endpoint and the platform takes care of this for you.

## DNS

**Without Private Endpoints - Storage Account Example:**

1. A client requests a name be resolved to an IP address by DNS - for example: `mystorageaccount.blob.core.windows.net`.
1. The client's configured DNS server queries Microsoft's DNS servers (which are authoritative 'blob.core.windows.net')
1. Microsoft's DNS servers respond with a public corresponding to the Storage cluster where the Storage Account resides - for example: **20.60.128.228**
1. The client sends their storage request to **20.60.128.228**

**With Private Endpoints - Storage Account Example:**

1. A client requests a name be resolved to an IP address by DNS - for example: `mystorageaccount.blob.core.windows.net`.
1. Conceptually, the client's configured DNS server is configured ignore Microsoft DNS and resolve the name `mystorageaccount.blob.core.windows.net` itself.
1. The client's DNS server responds to the query with a private IP address corresponding to the Private Endpoint - for example: **10.0.20.34**
1. The client sends their storage request to **10.0.20.34**

>[!NOTE]
Most PaaS services use TLS certificates to encrypt data in transit. When the client makes a request of the service, the service responds with a certificate. In order for the client to trust the certificate, the name used in the request (such as `mystorageaccount.blob.core.windows.net`) must match the name on the certificate the PaaS service provides back to the client. Azure does not have a way to add custom names to these certificates, which is why we need to override the pubic DNS name resolution, instead of being able to use an alternate name mapped to the private IP.

## Creating a Private Endpoint

Private Endpoints can either be created directly or through most PaaS service networking configurations. When creating the Private Endpoint, you'll have the option of either using a Private DNS Zone or no/custom DNS configuration. A Private DNS Zone is usually what we recommend. See [DNS Option for Private Endpoints](./DNS-pe.md) for more details.

## Private Link Service

For most PaaS services, a Private Link Service resides in between your Private Endpoint and the PaaS service. You do not see it or manage it; you only work with the Private Endpoint.

It is possible to provide a Private Endpoint (and thereby 'tunnel') to IaaS resources. To do this, you need to build your own Private Link Service. Private Link Services are not the focus of this content and not necessary for most Private Endpoint deployments.
