# Troubleshooting Private Endpoints

## Step 1: Name Resolution

When you client makes a request to the service for which you have created a Private Endpoint, does the client resolve the Private Endpoint's private IP address? 

### **`nslookup` Example:**

`nslookup` is a command-line tool included in many operating systems which enables you to query your DNS service for a name and see the IP address that DNS resolves your name to. Using it to attempt to resolve the IP address of your PaaS service is a great way to start troubleshooting.

#### A standard Storage Account

```powershell
PS /> nslookup mypublicstorageaccount.blob.core.windows.net
    Server:         172.31.176.1
    Address:        172.31.176.1#53
    
    Non-authoritative answer:
    mypublicstorageaccount.blob.core.windows.net     canonical name = blob.mwh20prdstr02a.store.core.windows.net.
    Name:   blob.mwh20prdstr02a.store.core.windows.net
    Address: 20.60.153.129
```

--> **20.60.153.129 is a public IP address**

#### A Storage Account with Private Endpoints and DNS configured

```powershell
PS /> nslookup myprivatestorageaccount.blob.core.windows.net
    Server:         172.31.176.1
    Address:        172.31.176.1#53
    
    Non-authoritative answer:
    myprivatestorageaccount.blob.core.windows.net     canonical name = blob.mwh20prdstr02a.store.core.windows.net.
    Name:   blob.mwh20prdstr02a.store.core.windows.net
    Address: 10.0.21.34
```

--> **10.0.21.34 is a private IP address from my Azure address space.** This is what you should see when your DNS is correctly configured. 

### DNS Configuration Checklist

If your client is not receiving a private IP address in response to your `nslookup`, check these configuration points:

- The client's DNS server is configured with either:
  - An 'A' record for the service name you are attempting to resolve, and the value is the Private Endpoint IP address
  - A conditional forwarder, forwarding requests for the PaaS DNS zone (ex: 'blob.core.windows.net') to a server which has an 'A' record for the service
- If your DNS server has a conditional forwarder:
  - Is the conditional forwarder destination IP accessible from the server? (The Azure DNS IP '168.63.129.16' is NOT reachable outside of Azure)
  - Is the conditional forwarder zone name the name _without_ '.privatelink.' included? 
- If you are using Private DNS Zones:
  - Does the Private DNS Zone have an 'A' record for the Private Endpoint's service?
  - Is the Private DNS Zone linked to the VNET of the DNS server? 

## Step 2: Connectivity

If you are receiving the correct private IP address in response to DNS queries from your client, can your client reach the resolved IP address?

### Connectivity Troubleshooting Checklist

- Is the PaaS service associated with the Private Endpoint and is the connection in an 'Approved' state?
- Does traffic leaving the client have a route to the private IP address?
  - If you are connecting from on-prem, is your ExpressRoute or VPN functioning?
- Is there a firewall between the client and Private Endpoint blocking the traffic?
  - Check on-prem firewalls for on-prem clients, central firewalls in Azure, and NSGs associated with the Private Endpoint