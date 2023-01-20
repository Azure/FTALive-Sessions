
## Azure Data Factory

### Securing Data Factory  
This section covers securing Azure Data Factory. Securing the Azure Synapse Workspace will be covered later. 


[<Back](https://github.com/LiliamLeme/FTALive-Sessions_Synapse_SQL/blob/main/content/data/ModernDatawarehouse-Security/Dedicated%20SQL%20Pool_data.md)\- [Next >](https://github.com/LiliamLeme/FTALive-Sessions_Synapse_SQL/blob/main/content/data/ModernDatawarehouse-Security/Network.md)


#### Overview

Data Factory is the cloud-based ETL and data integration service that allows you to create data-driven workflows for orchestrating data movement and transforming data at scale. Using Azure Data Factory, you can create and schedule data-driven workflows (called pipelines) that can ingest data from disparate data stores. You can build complex ETL processes that transform data visually with data flows or by using compute services such as Azure HDInsight Hadoop, Azure Databricks, and Azure SQL Database.

Pipelines in Azure Synapse are the same as Azure Data Factory pipelines. It’s just been embedded into Azure Synapse Studio.

**Data Access**

A vital security goal of an organization is to protect their data stores from random access over the internet, may it be an on-premises or a Cloud/ SaaS data store.


Typically a cloud data store controls access using the below mechanisms:

•     Private Link from a Virtual Network to Private Endpoint enabled data sources

•     Firewall rules that limit connectivity by IP address

•     Authentication mechanisms that require users to prove their identity

•     Authorization mechanisms that restrict users to specific actions and data


**Data Access Strategies for Azure Data Factory**

•    Private Link - You can create an Azure Integration Runtime within Azure Data Factory Managed Virtual Network and it will leverage private endpoints to securely connect to supported data stores. Traffic between Managed Virtual Network and data sources travels the Microsoft backbone network and is not exposed to the public network.

•    Trusted Service - Azure Storage (Blob, ADLS Gen2) supports firewall configuration that enables select trusted Azure platform services to access the storage account securely. 

•    Trusted Services enforces Managed Identity authentication, which ensures no other data factory can connect to this storage unless approved to do so using it's managed identity. 

•    Unique Static IP - You will need to set up a self-hosted integration runtime to get a Static IP for Data Factory connectors. This mechanism ensures you can block access from all other IP addresses.

•    Static IP range - You can use Azure Integration Runtime's IP addresses to allow list it in your storage (say S3, Salesforce, etc.). It certainly restricts IP addresses that can connect to the data stores but also relies on Authentication/ Authorization rules.
With the introduction of Static IP address range, you can now allow list IP ranges for the particular Azure integration runtime region to ensure you don’t have to allow all Azure IP addresses in your cloud data stores. This way, you can restrict the IP addresses that are permitted to access the data stores.

•    Service Tag - A service tag represents a group of IP address prefixes from a given Azure service (like Azure Data Factory). Microsoft manages the address prefixes encompassed by the service tag and automatically updates the service tag as addresses change, minimizing the complexity of frequent updates to network security rules. It is useful when filtering data access on IaaS hosted data stores in Virtual Network.

•    Allow Azure Services - Some services lets you allow all Azure services to connect to it in case you choose this option.

[Data access strategies through Azure Data Factory | Microsoft Learn](
https://learn.microsoft.com/en-us/azure/data-factory/data-access-strategies#data-access-strategies-through-azure-data-factory)


**Integration Runtime**

The Integration Runtime (IR) is the compute infrastructure used by Azure Data Factory and Azure Synapse pipelines to provide  data integration capabilities across different network environments.

For example:
In Data Factory and Synapse pipelines, an activity defines the action to be performed. 

A linked service defines a target data store or a compute service. An integration runtime provides the bridge between activities and linked services. 

It's referenced by the linked service or activity, and provides the compute environment where the activity is either run directly or dispatched. 

This allows the activity to be performed in the closest possible region to the target data store or compute service to maximize performance while also allowing flexibility to meet security and compliance requirements.

**Integration runtime types**
Data Factory offers three types of Integration Runtime (IR), and you should choose the type that best serves your data integration capabilities and network environment requirements. The three types of IR are:

•    Azure 

•    Self-hosted

•    Azure-SSIS

| IR Type                                         | Public Network Support                                       | Private Link Support                              |
| :----------------------------------------------------------- | :----------------------------------------------------------- | :----------------------------------------------------------- |
| Azure                           |Data Flow, Data movement, Activity dispatch                                              | Data Flow, Data movement, Activity dispatch                                                         |
|Self-hosted                                                              |Data movement, Activity dispatch       | Data movement, Activity dispatch
|Azure-SSIS                                          | SSIS package execution       | SSIS package execution

**Note:**
Outbound controls vary by service for Azure IR. In Synapse, workspaces have options to limit outbound traffic from the managed virtual network when utilizing Azure IR. In Data Factory, all ports are opened for outbound communications when utilizing Azure IR. Azure-SSIS IR can be integrated with your vNET to provide outbound communications controls.

**Azure IR network environment**
Azure Integration Runtime supports connecting to data stores and computes services with public accessible endpoints. Enabling Managed Virtual Network, Azure Integration Runtime supports connecting to data stores using private link service in private network environment. 

**Self-hosted IR network environment**
If you want to perform data integration securely in a private network environment that doesn't have a direct line-of-sight from the public cloud environment, you can install a self-hosted IR in your on-premises environment behind a firewall, or inside a virtual private network. The self-hosted integration runtime only makes outbound HTTP-based connections to the internet.

**Azure-SSIS IR network environment**
The Azure-SSIS IR can be provisioned in either public network or private network. On-premises data access is supported by joining Azure-SSIS IR to a virtual network that is connected to your on-premises network.


**Common data integration security requirements**

Azure Active Directory (AAD) access control to data and endpoints
Managed Identity (MI) to prevent key management processes
Virtual Network (VNET) isolation of data and endpoints

1.)  Use the Internet to connect to data stores/ secrets store over TLS

​        •    Security – secure data using all supported Auth mechanism
​        •    Recommendation – Use Azure IR / SSIS IR

2.)  Use the Internet to connect to data stores/ secrets store over TLS only from known sources using ‘Trusted Services’ firewall exception

​        •    Security – secure data using MSI Auth + Service Firewall
​        •    Recommendation – Use ‘Allow Trusted Services…’ in Storage/ Key Vault firewall + Azure IR/ Self-hosted IR/ SSIS IR

3.)  Use a private network/ virtual network to connect to data stores over TLS

​        •    Security – secure data using Auth + compute injection/ peering with the private network
​        •    Recommendation – Use Self-hosted IR/ SSIS IR within your Virtual Network/ Private network.

[Create and configure a self-hosted integration runtime | Microsoft Learn](
https://learn.microsoft.com/en-us/azure/data-factory/create-self-hosted-integration-runtime)


**Data Movement**

Azure Data Factory including Azure Integration Runtime and Self-hosted Integration Runtime does not store any temporary data, cache data or logs except for linked service credentials for cloud data stores, which are encrypted by using certificates.

**Cloud scenario**

In this scenario, both your source and your destination are publicly accessible through the internet. These include managed cloud storage services such as Azure Storage, Azure Synapse Analytics, Azure SQL Database, Azure Data Lake Store, Amazon S3, Amazon Redshift, SaaS services such as Salesforce, and web protocols such as FTP and OData. 

**Hybrid scenario**
In this scenario, either your source or your destination is behind a firewall or inside an on-premises corporate network. Or, the data store is in a private network or virtual network (most often the source) and is not publicly accessible. Database servers hosted on virtual machines also fall under this scenario.

**Securing data store credentials**

•   **Cloud**

•       Store encrypted credentials in an Azure Data Factory managed store. Data Factory helps protect your data store credentials by encrypting them with certificates managed by Microsoft. These certificates are rotated every two years (which includes certificate renewal and the migration of credentials). 

•   Store credentials in Azure Key Vault. You can also store the data store's credential in Azure Key Vault. Data Factory retrieves the credential during the execution of an activity. 

[Security recommendations for Blob storage | Microsoft Learn](
https://learn.microsoft.com/en-us/azure/storage/blobs/security-recommendations )

[Store credentials in Azure Key Vault | Microsoft Learn](
https://learn.microsoft.com/en-us/azure/data-factory/store-credentials-in-key-vault )

•   **Hybrid**

Hybrid scenarios require self-hosted integration runtime to be installed in an on-premises network, inside a virtual network (Azure), or inside a virtual private cloud (Amazon). The self-hosted integration runtime must be able to access the local data stores. 

•   **On-premises data store credentials**

The credentials can be stored within data factory or be referenced by data factory during the runtime from Azure Key Vault. If storing credentials within data factory, it is always stored encrypted on the self-hosted integration runtime.

Store credentials locally. If you directly use the Set-AzDataFactoryV2LinkedService cmdlet with the connection strings and credentials inline in the JSON, the linked service is encrypted and stored on self-hosted integration runtime. In this case the credentials flow through Azure backend service, which is extremely secure, to the self-hosted integration machine where it is finally encrypted and stored. The self-hosted integration runtime uses Windows DPAPI to encrypt the sensitive data and credential information.

Store credentials in Azure Key Vault. You can also store the data store's credential in Azure Key Vault. Data Factory retrieves the credential during the execution of an activity. 

Store credentials locally without flowing the credentials through Azure backend to the self-hosted integration runtime. If you want to encrypt and store credentials locally on the self-hosted integration runtime without having to flow the credentials through data factory backend, follow the steps in Encrypt credentials for on-premises data stores in Azure Data Factory. All connectors support this option. The self-hosted integration runtime uses Windows DPAPI to encrypt the sensitive data and credential information.

Use the New-AzDataFactoryV2LinkedServiceEncryptedCredential cmdlet to encrypt linked service credentials and sensitive details in the linked service. You can then use the JSON returned (with the EncryptedCredential element in the connection string) to create a linked service by using the Set-AzDataFactoryV2LinkedService cmdlet.

**Encryption in Transit**

If the cloud data store supports HTTPS or TLS, all data transfers between data movement services in Data Factory and a cloud data store are via secure channel HTTPS or TLS.

All connections to Azure SQL Database and Azure Synapse Analytics require encryption (SSL/TLS) while data is in transit to and from the database. 

Use TDE, SSE or other encryption mechanism supported by data stores

Tip: When you're authoring a pipeline by using JSON, add the encryption property and set it to true in the connection string. For Azure Storage, you can use HTTPS in the connection string.

All data transfers are via secure channel HTTPS and TLS over TCP to prevent man-in-the-middle attacks during communication with Azure services.
The following table summarizes the network and self-hosted integration runtime configuration recommendations based on different combinations of source and destination locations for hybrid data movement where the source is On-Premise


| Destination                                         | Network Configuration                                       | Integration Runtime Setup                               |
| :----------------------------------------------------------- | :----------------------------------------------------------- | :----------------------------------------------------------- |
| Virtual machines and cloud services deployed in virtual networks                           | IPSec VPN (point-to-site or site-to-site)                                              | The self-hosted integration runtime should be installed on an Azure virtual machine in the virtual network.                                                         |
|Virtual machines and cloud services deployed in virtual networks                                                              |ExpressRoute (private peering)       | The self-hosted integration runtime should be installed on an Azure virtual machine in the virtual network.
|Azure-based services that have a public endpoint                                          | ExpressRoute (Microsoft peering)       | The self-hosted integration runtime can be installed on-premises or on an Azure virtual machine.


**Data at Rest**

Some data stores support encryption of data at rest. We recommend that you enable the data encryption mechanism for those data stores.

Data stores that support TDE (transparent data encryption)
•    Azure Synapse Analytics

•    Azure SQL Database

•    Azure Data Lake Store

•    Azure Blog Storage and Azure Table Storage

•    Amazon S3

•    Amazon Redshift


•    Salesforce supports Shield Platform Encryption

[Security considerations for data movement in Azure Data Factory | Microsoft Learn](
https://learn.microsoft.com/en-us/azure/data-factory/data-movement-security-considerations)


**Managed Identity for Azure Data Factory**

Managed identities eliminate the need to manage credentials. Managed identities provide an identity for the service instance when connecting to resources that support Azure Active Directory (Azure AD) authentication. For example, the service can use a managed identity to access resources like Azure Key Vault, where data admins can securely store credentials or access storage accounts. The service uses the managed identity to obtain Azure AD tokens.

There are two types of supported managed identities:

System-assigned: You can enable a managed identity directly on a service instance. When you allow a system-assigned managed identity during the creation of the service, an identity is created in Azure AD tied to that service instance's lifecycle. By design, only that Azure resource can use this identity to request tokens from Azure AD. So when the resource is deleted, Azure automatically deletes the identity for you.
User-assigned: You may also create a managed identity as a standalone Azure resource. You can create a user-assigned managed identity and assign it to one or more instances of a data factory. In user-assigned managed identities, the identity is managed separately from the resources that use it.

**Managed identity provides the below benefits:**

•    Store credential in Azure Key Vault, in which case-managed identity is used for Azure Key Vault authentication.

•    Access data stores or computes using managed identity authentication, including Azure Blob storage, Azure Data Explorer, Azure Data Lake Storage Gen1, Azure Data Lake Storage Gen2, Azure SQL Database, Azure SQL Managed Instance, Azure Synapse Analytics, REST, Databricks activity, Web activity, and more. Check the connector and activity articles for details.

•    Managed identity is also used to encrypt/decrypt data and metadata using the customer-managed key stored in Azure Key Vault, providing double encryption.

**Managed Virtual Network**

When you create an Azure integration runtime within a Data Factory managed virtual network, the integration runtime is provisioned with the managed virtual network. It uses private endpoints to securely connect to supported data stores.

Creating an integration runtime within a managed virtual network ensures the data integration process is isolated and secure.

**Benefits of using a managed virtual network:**

With a managed virtual network, you can offload the burden of managing the virtual network to Data Factory. You don't need to create a subnet for an integration runtime that could eventually use many private IPs from your virtual network and would require prior network infrastructure planning.

Deep Azure networking knowledge isn't required to do data integrations securely. Instead, getting started with secure ETL is much simpler for data engineers.

A managed virtual network along with managed private endpoints protects against data exfiltration.

![image](https://user-images.githubusercontent.com/24648322/213683974-1c5d806e-65cd-4921-bf86-dceeefc04b7f.png)

[Azure Data Factory managed virtual network | Microsoft Learn](
https://learn.microsoft.com/en-us/azure/data-factory/managed-virtual-network-private-endpoint )

**Managed private endpoints**

Managed private endpoints are private endpoints created in the Data Factory managed virtual network that establishes a private link to Azure resources. Data Factory manages these private endpoints on your behalf.

Data Factory supports private links. You can use Azure private link to access Azure platform as a service (PaaS) services like Azure Storage, Azure Cosmos DB, and Azure Synapse Analytics.

When you use a private link, traffic between your data stores and managed virtual network traverses entirely over the Microsoft backbone network. Private link protects against data exfiltration risks. You establish a private link to a resource by creating a private endpoint.

A private endpoint uses a private IP address in the managed virtual network to effectively bring the service into it. Private endpoints are mapped to a specific resource in Azure and not the entire service. Customers can limit connectivity to a specific resource approved by their organization. 

[Azure security baseline for Data Factory| Microsoft Learn](
https://learn.microsoft.com/en-us/security/benchmark/azure/baselines/data-factory-security-baseline)
