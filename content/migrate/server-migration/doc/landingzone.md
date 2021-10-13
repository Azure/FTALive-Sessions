# Milestone: Design and Build Landing Zone

#### [prev](./assess.md) | [home](./welcome.md)  | [next](./replication.md)

The Landing Zone architecture and implementation will be defined by your specific company requirements. There is no Landing Zone architecture which is one-size fits all. The following content can be used as a checklist to incorporate within your migration project plan to ensure best practices.

**CAF Reference:** [Ready - Landing Zone Design Areas](https://docs.microsoft.com/en-us/azure/cloud-adoption-framework/ready/landing-zone/design-areas)

## **1 Design AD Connect to AAD** 

### &nbsp;&nbsp;&nbsp;&nbsp;1.1\. Registration of custom domain in AAD.

### &nbsp;&nbsp;&nbsp;&nbsp;1.2\. Setup AD Connect appliance.

### &nbsp;&nbsp;&nbsp;&nbsp;1.3\. Role assignments based on  Azure AD roles.

## **2 Design Governance** 

&nbsp;&nbsp;&nbsp;&nbsp;2.1\. Use of Management Groups, number and purpose of Subscriptions.

### &nbsp;&nbsp;&nbsp;&nbsp;2.2\. Resource Groups.

### &nbsp;&nbsp;&nbsp;&nbsp;2.3\. Naming Conventions.

### &nbsp;&nbsp;&nbsp;&nbsp;2.4\. Policies.

### &nbsp;&nbsp;&nbsp;&nbsp;2.5\. RBAC.

### &nbsp;&nbsp;&nbsp;&nbsp;2.6\. Locks.

### &nbsp;&nbsp;&nbsp;&nbsp;2.7\. Tags.

### &nbsp;&nbsp;&nbsp;&nbsp;2.8\. Cost Management.

## **3 Design Vnet Topology** 

### &nbsp;&nbsp;&nbsp;&nbsp;3.1\. Hub and spoke or single vnet?

### &nbsp;&nbsp;&nbsp;&nbsp;3.2\. Subnets.

## **4 Design Hybrid Connectivity** 

### &nbsp;&nbsp;&nbsp;&nbsp;4.1\. What services to use?

- &nbsp;&nbsp;&nbsp;&nbsp;First Party: ExpressRoute, VPN, point to site, vWAN
- &nbsp;&nbsp;&nbsp;&nbsp;Third Party: VPN NVAs
 
## **5 Design ADDS** 

### &nbsp;&nbsp;&nbsp;&nbsp;5.1\. Number of forest and domains to sync?

### &nbsp;&nbsp;&nbsp;&nbsp;5.2\. How many domain controllers servers will be built?

## **6 Design DNS** 

### &nbsp;&nbsp;&nbsp;&nbsp;6.1\. Number of zones to sync.

### &nbsp;&nbsp;&nbsp;&nbsp;6.2\. How many DNS servers will be built?

### &nbsp;&nbsp;&nbsp;&nbsp;6.3\. What will be the DNS forwarding configuration?

### &nbsp;&nbsp;&nbsp;&nbsp;6.4\. Will DNS assignment be at NIC vs. Vnet scope if multiple zones?

## **7 Design DMZ(s)** 

### &nbsp;&nbsp;&nbsp;&nbsp;7.1\. Need for public (Internet facing) and/or private (internal networks such as on-premises) separate DMZ infraestructure?

### &nbsp;&nbsp;&nbsp;&nbsp;7.2\. What services to use?

- &nbsp;&nbsp;&nbsp;&nbsp;First Party: Azure Firewall, Application Gateway and Network Security Groups

- &nbsp;&nbsp;&nbsp;&nbsp;Third Party: Third Party: NVAs configured in HA form

### &nbsp;&nbsp;&nbsp;&nbsp;7.3\.Which services need to be chained Azure Firewall/NVA + Application Gateway + NSGs?

### &nbsp;&nbsp;&nbsp;&nbsp;7.4\. Traffic filtering requirements for the below bi-directional connectivity scenarios:

- &nbsp;&nbsp;&nbsp;&nbsp;Internet <-> Azure

- &nbsp;&nbsp;&nbsp;&nbsp;On-prem <-> Azure

- &nbsp;&nbsp;&nbsp;&nbsp;Hub <-> Spoke

- &nbsp;&nbsp;&nbsp;&nbsp;Spoke <-> Spoke

## **8 Design Management:** 

### &nbsp;&nbsp;&nbsp;&nbsp;8.1\. Monitoring
- &nbsp;&nbsp;&nbsp;&nbsp;Use of VM monitoring extensions?

- &nbsp;&nbsp;&nbsp;&nbsp;diagnostics storage accounts

- &nbsp;&nbsp;&nbsp;&nbsp;How will you use Azure Monitor provided metrics and diagnostics? Will you stream to a log analytics or third party?

- &nbsp;&nbsp;&nbsp;&nbsp;Will you leverage Azure Monitor workbooks/Insights?

- &nbsp;&nbsp;&nbsp;&nbsp;How many log analytics workspaces will you deploy?
 
- &nbsp;&nbsp;&nbsp;&nbsp;Will you enable Security Center/Defender Free or Standard?

### &nbsp;&nbsp;&nbsp;&nbsp;8.2\. OS Patching 

### &nbsp;&nbsp;&nbsp;&nbsp;8.3\. Antivirus and/or endpoint protection

### &nbsp;&nbsp;&nbsp;&nbsp;8.4\. Licensing (KMS, AHUB or PAYG)

## **9 Design BCDR** 

### &nbsp;&nbsp;&nbsp;&nbsp;9.1\. Backup

### &nbsp;&nbsp;&nbsp;&nbsp;9.2\. Use of availability sets

### &nbsp;&nbsp;&nbsp;&nbsp;9.3\. Use of availability zones

### &nbsp;&nbsp;&nbsp;&nbsp;9.4\. What will be your secondary region?

## **10 Landing Zone Implementation based on Designs** 