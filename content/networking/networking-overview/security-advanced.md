# Security (Advanced)

#### [prev](./topology-advanced.md) | [home](./readme.md)  | [next](./mgmt.md)

## Third Party vs. Native

As part of network planning, you can use either Azure Native Network Virtual Appliances or third party items.  This is often times a decision unique to your environment.  To decide if it is appropriate, you can ask the following questions:

* Will my organization benefit from bringing our existing skillset?
* Do we do management at scale of NVAs, that can allow us to manage the Azure network in tandem with onprem networks, through policy deployments?
* Are there specific features not found in the Azure native solutions, that are important for my organization?
* Am I prepared to have to learn the differences between the NVA on prem vs. in Azure?
* Am I prepared to have to manage the scaling and management of the resources?

## Azure Firewall

### Azure Firewall Standard vs. Premium

Azure Firewall has two SKUs, with Premium having the following features over Standard:

* **TLS Inspection** - Azure Firewall Premium is able to terminate and inspect TLS connections to detect, alert, and mitigate malicious activity.
* **IDPS** - Azure Firewall Premium provides a signature-based intrusion detection and prevention system by looking for specific patterns or known malicious instruction sequences.  This looks at Layers 4-7.
* **URL Filtering** - Azure Firewall Premium extends the FQDN filtering ability to use the whole url, such as `www.contoso.com/a/c` instead of just `www.contoso.com`.
* **Web categories** - Azure Fireall Premium allows for filtering based on a web sites category at a more fine-tuned version than in standard.  Like URL filtering, this now looks at the whole URL, instead of just the host.

[More on Azure Firewall Premium Features](https://docs.microsoft.com/azure/firewall/premium-features)

### Azure Firewall Policies

### Azure Firewall Management with Forced Tunneling

### Azure Firewall Dashboard

Azure firewall has a [monitoring workbook](https://github.com/Azure/Azure-Network-Security/tree/master/Azure%20Firewall/Workbook%20-%20Azure%20Firewall%20Monitor%20Workbook) that can be helpful for monitoring and managing the Azure Firewall environment.
## Web Application Firewalls

### Selecting Front Door vs. App Gateway

### Web Application Firewall Reporting

## Azure Defender for Cloud Features

### Just In Time Access

### Secure Score
