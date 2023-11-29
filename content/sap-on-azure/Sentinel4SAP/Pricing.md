## Pricing - Microsoft Sentinel Solution for SAP​

#### [prev](./SentinelConfig.md) | [home](./introduction.md)  | [next](./Scenarios.md)

<br>
<p align="center">
<img src="/content/sap-on-azure/images/Sentinel-Pricing.png">
</p>
<br>

* **SID** stands for SAP System Identification. **SID** is a unique identification code for every R/3 installation (SAP system) consisting of a database server & several application servers. 
* **The Microsoft Sentinel for SAP solution** is free to install, but there is an additional hourly charge for activating and using the solution on ***production systems***.
* Microsoft Sentinel is billed for the volume of data analyzed in Microsoft Sentinel and stored in Azure Monitor Log Analytics workspace.
* Once Microsoft Sentinel is enabled on your Azure Monitor Log Analytics workspace, every GB of data ingested into the workspace, excluding Basic Logs, can be retained at no charge for the first 90 days.
* Retention beyond 90 days and up to 2 years will be charged per the standard [Azure Monitor pricing](https://azure.microsoft.com/en-us/pricing/details/log-analytics/) retention prices.
* If customers have to retain data for several years to fulfill compliance requirement, there is an option to store your archive data for up to 7 years.
* The connector itself is a docker image and the customer has flexibility to deploy it on-premises or in any cloud, in a VM or on Kubernetes.​

If deploying on Azure:​
- **For VM** : Customer should start with a 1 A4 – 8Core, 14GB and then scale if needed.​
- **For AKS** : Customer should start with 1 A4 (8 vCPUs, 14 GB RAM) and then scale if needed.​

### Additional Links

- [Microsoft Sentinel Pricing](https://azure.microsoft.com/en-us/pricing/details/microsoft-sentinel/)

#### [prev](./SentinelConfig.md) | [home](./introduction.md)  | [next](./Scenarios.md)
