## RISE with SAP and Sentinel integration
#### [prev](./Scenarios.md) | [home](./introduction.md)  | [next](./HanaAuditConfig.md)
### SAP-Certified

SAP solutions are certified by SAP for integration scenarios with SAP ECC via `SAP S/4HANA®Cloud, private edition (RISE with SAP), SAP S/4HANA(on-premise software), S/4-BC-XAL 1.0 ‒ S/4 EXTERNAL ALERT AND MONITORING 1.0 (for S/4)`.

<img width="409" alt="image" src="https://user-images.githubusercontent.com/57655797/230809063-8d8b7c85-f624-4169-bbea-d2a08cce94bd.png">

SAP Certified Solutions Directory: [Microsoft Sentinel 1.0](https://www.sap.com/dmc/exp/2013_09_adpd/enEN/#/solutions?id=s:33db1376-91ae-4f36-a435-aafa892a88d8)

#### Related information

[What's new with Microsoft Sentinel at Secure](https://techcommunity.microsoft.com/t5/microsoft-sentinel-blog/what-s-new-with-microsoft-sentinel-at-secure/ba-p/3780900)

### Sentinel for SAP BTP (Preview)

Microsoft Sentinel solution for **SAP Business Technology Platform (SAP BTP)** is in preview for limited users.

If you are interested in joining our preview program, please [Sign Up](https://forms.office.com/pages/responsepage.aspx?id=DQSIkWdsW0yxEjajBLZtrQAAAAAAAAAAAAYAAI_bnbFUMFNKRVlLQVhGV0tFM1NHVTVKUVFRRk5MSi4u) here.

#### Major features

- Analytics rules specific to SAP BTP
- Workbooks dedicated to SAP BTP

※ It is assumed that the **audit log acquisition API (Audit Log Management Service)** of the subaccount of the Cloud Foundry environment is used.

![image](https://github.com/Azure/FTALive-Sessions/assets/57655797/6d693b82-0a39-403d-90fe-18cd4180c74f)


#### Deploy

Refer to [Deploy Microsoft Sentinel Solution for SAP® BTP](https://learn.microsoft.com/en-us/azure/sentinel/sap/deploy-sap-btp-solution) to build Sentinel for BTP.

#### Related information

[What’s new: Sentinel Solution for SAP BTP](https://techcommunity.microsoft.com/t5/microsoft-sentinel-blog/what-s-new-sentinel-solution-for-sap-btp/ba-p/3780794)

### Network connection and integration

#### Virtual network connectivity with SAP RISE/ECS

[Virtual network peering](https://learn.microsoft.com/en-us/azure/virtual-network/virtual-network-peering-overview) is used as a basis (recommended) for connecting `RISE with SAP Enterprise Cloud Services (ECS)` and your own Azure environment.

- Both the SAP Vnet and the customer Vnet are secured with a [Network security groups (NSG)](https://learn.microsoft.com/en-us/azure/virtual-network/network-security-groups-overview) to allow communication on the SAP and database ports via Vnet peering. Communication between peered Vnets is secured via these NSGs, limiting communication to the customer's SAP environment.
- Vnet peering can be set up in the same region as the SAP managed environment as well as with global Vnet peering between any two Azure regions. If SAP RISE/ECS is available on Azure, the Azure region should preferably match the workloads running in your virtual network due to network latency and Vnet peering costs. However, customers with central SAP instances from multiple countries/regions should use Global Vnet Peering to connect virtual networks across Azure regions.

<img width="775" alt="image" src="https://user-images.githubusercontent.com/57655797/231385822-1183d949-5240-4a1b-85af-1fad890744f8.png">

※Attention
- Since SAP RISE/ECS runs in SAP's Azure tenants and subscriptions, set up virtual network peering between different tenants.
- To achieve this, you need to set up a peering with the Azure resource ID of the network provided by SAP and have the peering approved by SAP.
- For step-by-step details, follow the process described in [Create a vnet peering - different subscriptions](https://learn.microsoft.com/en-us/azure/virtual-network/create-peering-different-subscriptions?tabs=create-peering-portal), but you'll need to contact your SAP representative for exact steps.

#### Connection between SAP RISE/ECS and Sentinel

<img width="723" alt="image" src="https://user-images.githubusercontent.com/57655797/231384345-f616da27-171c-4cbf-b323-9b5e38e52beb.png">

- For SAP RISE/ECS, deploy Microsoft Sentinel solution on customer's Azure subscription. (Sentinel is managed by the customer)
- Connection with SAP RISE/ECS requires a private network connection from the customer's Vnet. Typically, you connect via Vnet peering.
- Authentication methods supported by SAP RISE/ECS are SAP username and password or X509/SNC certificate. Currently, only RFC-based connections are possible in the SAP RISE/ECS environment.

＜Notes on running Sentinel in SAP RISE/ECS environment＞

1. The following log fields/sources require additional change requests (transport requests):
  - Client IP address information from SAP security audit log, DB table logs (preview), spool output log.
  - Follow the steps in [Retrieve additional information from SAP (optional)](https://learn.microsoft.com/en-us/azure/sentinel/sap/prerequisites-for-deploying-sap-continuous-threat-monitoring).

2. SAP infrastructure and operating system logs aren't available to Sentinel in RISE, including VMs running SAP, SAPControl(SAP start/stop management function) data sources, network resources placed within ECS.　　　　　　　

3. SAP monitors elements of the Azure infrastructure and operation system independently.

#### Related information

[Integrating Azure with SAP RISE managed workloads](https://learn.microsoft.com/en-us/azure/sap/workloads/rise-integration#microsoft-sentinel-with-sap-rise)
</br>
#### [prev](./Scenarios.md) | [home](./introduction.md)  | [next](./HanaAuditConfig.md)
