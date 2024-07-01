# Security In Microsoft Fabric

## Introduction 
Fabric security is:
* **Always On** - Every interaction with Fabric is encrypted and authenticated using Microsoft Entra ID. All communication between Fabric experiences is encrypted and travels through the Microsoft backbone network, and also encrypted at rest. 
* **Securable** - To control access to Fabric, you can add extra security features such as Private Links or Entra Conditional Access. Fabric can also connect to data protected by a firewall or a private network using gateways.
* **Compliant** - Fabric allows for data sovereignty controls out of the box with multiple geographic capacities. Fabric also supports a wide range of compliance standards.
* **Governable** - Fabric comes with a set of governance tools such as [data lineage](https://learn.microsoft.com/en-us/fabric/governance/lineage), and is interoperable with Microsoft Purview features including [information protection labels](https://learn.microsoft.com/en-us/fabric/governance/information-protection), [data loss prevention](https://learn.microsoft.com/en-us/purview/dlp-learn-about-dlp).

## Authentication
Microsoft Fabric is a Software as a Service (SaaS) platform like many other Microsoft services such Microsoft Office and OneDrive. All Microsoft SaaS services including Fabric, use Microsoft Entra ID as their cloud-based identity provider. Fabric does not support basic authentication (username/password), keys, credentials or other forms of authentication.

## Data Encryption
### Data at rest
All Fabric data stores are encrypted at rest by using Microsoft-managed keys. Fabric data includes customer data as well as system data and metadata. While data can be processed in memory in an unencrypted state, it's never persisted to permanent storage while in an unencrypted state.

### Data in transit
Data in transit across the public internet between Microsoft services is always encrypted with at least TLS 1.2. Fabric negotiates to TLS 1.3 whenever possible.

## Data Security
Fabric offers a multi-layer security model that provides both simplicity and flexibility in managing data access. Security can be set for an entire workspace, for individual items, or through granular permissions in each Fabric engine.

![alt text](./images/image-5.png)

### Fabric Workspace Permissions
There are four roles available in Workspaces, listed below with increasing level of access.
* Viewer - Can view all content in the workspace, but can't modify.
* Contributor - Can view and modify all content in the workspace.
* Member - Can view, modify and share all content in the workspace and grant Contributer and Viewer permission.
* Admin - Full access to the workspace. All the above permission plus the ability to grant admin permission and delete the workspace.

For additional details see this [Learn article](https://learn.microsoft.com/en-us/fabric/get-started/roles-workspaces#-workspace-roles)

### Fabric Item Permission
Item permissions are used to control access to individual Fabric items within a workspace. Different Fabric items have different permissions. Item permissions are confined to a specific item and don't apply to other items.

* [Semantic model](https://learn.microsoft.com/en-us/power-bi/connect-data/service-datasets-permissions)
* [warehouse](https://learn.microsoft.com/en-us/fabric/data-warehouse/share-warehouse-manage-permissions)
* [Lakehouse](https://learn.microsoft.com/en-us/fabric/data-engineering/lakehouse-sharing)
* [Data science](https://learn.microsoft.com/en-us/fabric/data-science/models-experiments-rbac)
* [Real-Time Analytics](https://learn.microsoft.com/en-us/azure/data-explorer/kusto/management/security-roles)

### Granular Engine Permissions / Compute Permissions

Many Fabric engines allow fine-grained access control such as table, column, and row-level security.

* [Data Warehouse Security and SQL Endpoint Security in Lakehouse](https://learn.microsoft.com/en-us/fabric/data-warehouse/security) 
    - [Object-level security](https://learn.microsoft.com/en-us/fabric/data-warehouse/sql-granular-permissions)
    - [Column-level security](https://learn.microsoft.com/en-us/fabric/data-warehouse/column-level-security)
    - [Row-level security](https://learn.microsoft.com/en-us/fabric/data-warehouse/row-level-security)
    - [Dynamic Data Masking](https://learn.microsoft.com/en-us/fabric/data-warehouse/dynamic-data-masking)
* [Power BI security](https://learn.microsoft.com/en-us/power-bi/enterprise/service-admin-power-bi-security)
    - [Row Level Security in Power BI](https://learn.microsoft.com/en-us/fabric/security/service-admin-row-level-security)
    - [Object Level Security in Power BI](https://learn.microsoft.com/en-us/fabric/security/service-admin-object-level-security?tabs=table)
* [Real Time Analytics Row Level Security](https://learn.microsoft.com/en-us/azure/data-explorer/kusto/management/row-level-security-policy)
* [OneLake Data Access Security](https://learn.microsoft.com/en-us/fabric/onelake/security/get-started-data-access-roles)

### External Tenant data sharing in Microsoft Fabric
* This is a [tenant level feature that needs to be enabled](https://learn.microsoft.com/en-us/fabric/governance/external-data-sharing-enable). 
* Supported Fabric Items are: Lakehouse and KQL databases.

###  Common Data Access Security Scenarios:

| **Scenario** 	| **Role and Responsibilities** 	| **Direction** 	|
|---------------|---------------|-------------------|
| Wingtip Toys is structured with a single tenant for the entire organization and divided into three capacities, </br> each representing a different region: the United States, Europe, and Asia. </br> Each capacity includes a workspace for every department within the organization, including the sales department. </br> In the sales department, there is a manager, a sales team lead, and sales team members. <br> Additionally, Wingtip Toys employs one analyst for the entire organization|**Manager**:		View and modify all content in the sales department in the entire organization <br> **Team lead**:		View and modify all content in the sales department in a specific region <br> **Sales team member**:	View stats of other sale members in the region and View and modify his own sales report <br> **Analyst**:		View all content in the sales department in the entire organization| **Manager**:		A member role for all the sales workspaces in the organization </br> **Team lead**:		A member role for the sales workspace in the region </br> **Sales team member**:	No roles for any of the sales workspaces and Access to a specific report that lists the member's sale figures . <br> **Analyst**:		A viewer role for all the sale workspaces in the organization. <br><br>  Using **row-level security**, the report is set up so that each sales member can only see their own sale figures. Team leads can see the sales figures of all the sale members in their region, and the sales manager can see sale figures of all the sale members in the organization.
|Veronica and Marta work together. Veronica is the owner of a report she want's to share with Marta. <br> If Veronica shares the report with Marta, Marta will be able to access it regardless of the workspace role she has.||Marta should have viewer permission on the report, no permission is needed in the workspace level|

## Network Security

Fabric's default security settings include:
* Microsoft Entra ID which is used to authenticate every request. Upon successful authentication, requests are routed to the appropriate backend service through secure Microsoft managed endpoints.
* Internal traffic between experiences in Fabric is routed over the Microsoft backbone network.
* Traffic between clients and Fabric is encrypted using at least the Transport Layer Security (TLS) 1.2 protocol

### Inbound Security (traffic coming into Fabric from the internet)
There are 2 options for securing inbound traffic to Fabric:

1. [Entra Conditional Access](https://learn.microsoft.com/en-us/fabric/security/security-conditional-access) - When a user authenticates access is determined based on a set of policies that might include IP address, location, and managed devices.
2. [Private links](https://learn.microsoft.com/en-us/fabric/security/security-private-links-overview) - Fabric uses a private IP address from your virtual network. The endpoint allows users in your network to communicate with Fabric over the private IP address using private links.

    ![alt text](./images/image.png)

### Outbound Security (different ways to import and connect to data from a secure network into fabric)

1. **[Trusted workspace access:](https://learn.microsoft.com/en-us/fabric/security/security-trusted-workspace-access)**

    This option utilises the [Workspace Identity](https://learn.microsoft.com/en-us/fabric/security/workspace-identity) to allow connections to ADLSv2 accounts.</br> </br>
    **Applicable to:** Spark compute in Data Engineering experience, OneLake, Data Pipeline, Fabric Data warehouse COPY command and Dataflows v2
    
    **Licensing Requirement:** Fabric workspace identity can only be created in workspaces associated with a Fabric capacity (F64 or higher).
    
    ![alt text](./images/image-1.png)

2. [**Managed Virtual Network and Managed Private Endpoints**](https://learn.microsoft.com/en-us/fabric/security/security-managed-private-endpoints-overview)

    **Applicable to:** Spark compute in Data Engineering experience.
    
    **Licensing Requirement:** F64 or above and Trial capacity.

    ![alt text](./images/image-2.png)

    * A managed virtual network for your workspace, along with managed private endpoints, allows you to access data sources that are behind firewalls or otherwise blocked from public access.
    * Managed virtual networks are virtual networks that are created and managed by Microsoft for each Fabric workspace. Managed virtual networks provide network isolation for Fabric Spark workloads, meaning that the compute clusters are deployed in a dedicated network and are no longer part of the shared virtual network.
    * You don't need to create a subnet for the Spark clusters based on peak load, as this is managed for you by Microsoft Fabric.
    * Managed private endpoints are not supported in all the regions. See [list](https://learn.microsoft.com/en-us/fabric/security/security-managed-private-endpoints-overview#limitations-and-considerations).


### Data Gateway

1. [On-Premises Data Gateway](https://learn.microsoft.com/en-us/power-bi/connect-data/service-gateway-onprem) - The gateway acts as a bridge between your on-premises data sources and Fabric. The gateway is installed on a server within your network and it allows Fabric to connect to your data sources through a secure channel. Communication is initiated from Data Gateway (outbound) to Fabric, so there is no need to open inbound ports or make changes to your network.

    **Applicable to**: Dataflow Gen2, Data Pipeline, Power BI Service directly connection to the datasource

    **Licensing Requirement:** Any F SKU.

![alt text](./images/image-3.png)

2. [Virtual Network (VNet) Data Gateway ](https://learn.microsoft.com/en-us/data-integration/vnet/overview)- The VNet gateway allows you to connect from Microsoft Cloud services to your Azure data services within a VNet, without the need of an on-premises data gateway.

    **Applicable to**: Dataflow Gen2, Power BI Service directly connecting to datasources.

    **Licensing Requirement:** Recommended to use capacity > F8.

![alt text](./images/image-4.png)

### Common Network Security Scenarios:

| **Scenario** 	| **Tools** 	| **Direction** 	|
|--------------	|-----------	|---------------	|
|As an ETL developer, I aim to load large volumes of data into Fabric at scale from multiple source systems and tables. </br> The source data is on-premises or in other cloud environments, protected by firewalls and/or Azure data sources with private endpoints.  | Use [data pipeline copy activity](https://learn.microsoft.com/en-us/fabric/data-factory/data-factory-overview#data-pipelines) with [On Premises Data Gateway ](https://learn.microsoft.com/en-us/data-integration/gateway/service-gateway-onprem)       	| Outbound  |
|As a power user, I want to load data into Fabric from the source systems I have access to. Since I am not a developer, </br> I need to transform the data using a low-code interface. The source data is located on-premises or in another cloud environment and is behind firewalls.              	|    [Use on-premises data gateway](https://learn.microsoft.com/en-us/data-integration/gateway/service-gateway-onprem) with [Dataflow Gen 2](https://learn.microsoft.com/en-us/fabric/data-factory/data-factory-overview#dataflows)   	|      Outbound         	|
|As a power user, I want to load data into Fabric from the source systems I have access to. The source data is in Azure behind private endpoints, </br> and I do not want to install or maintain on-premises data gateway infrastructure.|Use a [VNet data gateway](https://learn.microsoft.com/en-us/data-integration/vnet/overview) with [Dataflow Gen 2](https://learn.microsoft.com/en-us/fabric/data-factory/data-factory-overview#dataflows).|Outbound|
|As a developer proficient in writing data ingestion code using Spark notebooks, I want to load data into Fabric from the source systems I have access to. </br> The source data is in Azure behind private endpoints, and I do not want to install or maintain on-premises data gateway infrastructure.|Use [Fabric notebooks](https://learn.microsoft.com/en-us/fabric/data-engineering/how-to-use-notebook) with [Azure private endpoints](https://learn.microsoft.com/en-us/azure/private-link/manage-private-endpoint?tabs=manage-private-link-powershell).|Outbound|
|I want to ensure that my Fabric endpoints are protected from the public internet.|As a SaaS service, the Fabric back end is already protected from the public internet.</br> For additional protection, use [Microsoft Entra conditional access policies](https://learn.microsoft.com/en-us/fabric/security/security-conditional-access) for Fabric and/or </br> enable [private links at tenant level](https://learn.microsoft.com/en-us/fabric/security/security-private-links-overview) for Fabric and block public internet access.|Inbound|
|I want to ensure that Fabric can be accessed from only within my corporate network </br> and/or from compliant devices. </br> Also, they should use the MFA authentication |Use [Microsoft Entra conditional access policies](https://learn.microsoft.com/en-us/fabric/security/security-conditional-access) for Fabric.| Inbound|
|I want to lock down my entire Fabric tenant from the public internet and allow access only from within my virtual networks.|[Enable private links at tenant level](https://learn.microsoft.com/en-us/fabric/security/security-private-links-overview) for Fabric and block public internet access.| Inbound|
|||
