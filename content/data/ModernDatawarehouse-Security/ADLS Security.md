## Azure Data Lake Storage 

### Securing Azure Data Lake   

[<Back](https://github.com/LiliamLeme/FTALive-Sessions_Synapse_SQL/blob/main/content/data/ModernDatawarehouse-Security/Overall_security_considerations.md)\- [Next >](https://github.com/LiliamLeme/FTALive-Sessions_Synapse_SQL/blob/main/content/data/ModernDatawarehouse-Security/Overall_security_considerations.md)

#### Overview
When implementing a Modern Data Warehouse, the Data lake becomes the center of the solution instead of the relational database. 

The data lake is the storage repository, which holds the vast amount of raw data in its native format until it is needed.


**Why use a a data lake**

•	Inexpensively stores unlimited data

•	It is used to collect all data “just in case”

•	Data is stored with no modeling – “Schema on read”

•	It complements the EDW – it does not replace it 

•	It also helps to free up expensive EDW resources – we don’t have to have all the data in the EDW in order to use it 

•	It allows users quick access to data using a host of other technologies and tools

•	It serves as data science workspaces

•	It supports structured, semi-structured and unstructured data

Azure Storage provides a layered security model. This model enables you to secure and control the level of access to your storage accounts that your applications and enterprise environments demand, based on the type and subset of networks or resources used. When network rules are configured, only applications requesting data over the specified set of networks or through the specified set of Azure resources can access a storage account. You can limit access to your storage account to requests originating from specified IP addresses, IP ranges, subnets in an Azure Virtual Network (VNet), or resource instances of some Azure services.

![image](https://user-images.githubusercontent.com/24648322/213681827-84c9fc0b-b3ca-45bb-a8ce-ccb57bb92955.png)

**Network Security** 

**Configure the minimum required version of Transport Layer Security (TLS) for a storage account.**

Require that clients use a more secure version of TLS to make requests against an Azure Storage account by configuring the minimum version of TLS for that account. 

**Enable the Secure transfer required option on all of your storage accounts**

When you enable the Secure transfer required option, all requests made against the storage account must take place over secure connections. Any requests made over HTTP will fail. 

**Allow Blob public access**

When allow blob public access is enabled, one is permitted to configure container ACLs to allow anonymous access to blobs within the storage account. When disabled, no anonymous access to blobs within the storage account is permitted, regardless of underlying ACL configurations

**Enable firewall rules**	

Configure firewall rules to limit access to your storage account to requests that originate from specified IP addresses or ranges, or from a list of subnets in an Azure Virtual Network (VNet). 

**Allow trusted Microsoft services to access the storage account**

Turning on firewall rules for your storage account blocks incoming requests for data by default, unless the requests originate from a service operating within an Azure Virtual Network (VNet) or from allowed public IP addresses. Requests that are blocked include those from other Azure services, from the Azure portal, from logging and metrics services, and so on. You can permit requests from other Azure services by adding an exception to allow trusted Microsoft services to access the storage account. 

**Use private endpoints**	

A private endpoint assigns a private IP address from your Azure Virtual Network (VNet) to the storage account. It secures all traffic between your VNet and the storage account over a private link. 

You can use private endpoints for your Azure Storage accounts to allow clients on a virtual network (VNet) to securely access data over a Private Link. The private endpoint uses a separate IP address from the VNet address space for each storage account service. Network traffic between the clients on the VNet and the storage account traverses over the VNet and a private link on the Microsoft backbone network, eliminating exposure from the public internet.

If you want to restrict access to your storage account through the private endpoint only, configure the storage firewall to deny or control access through the public endpoint.

[Use private endpoints for Azure Storage | Microsoft Learn](
https://learn.microsoft.com/en-us/azure/storage/common/storage-private-endpoints?toc=%2Fazure%2Fstorage%2Fblobs%2Ftoc.json&bc=%2Fazure%2Fstorage%2Fblobs%2Fbreadcrumb%2Ftoc.json)

**Use VNet service tags**	

A service tag represents a group of IP address prefixes from a given Azure service. Microsoft manages the address prefixes encompassed by the service tag and automatically updates the service tag as addresses change. 

**Limit network access to specific networks**	

Limiting network access to networks hosting clients requiring access reduces the exposure of your resources to network attacks.
The existing IP firewall rules can be used in addition to virtual network rules to allow access from on-premise networks as well.
Configure accounts only from specific virtual networks and subnets.

**Configure network routing preference**	

You can configure network routing preference for your Azure storage account to specify how network traffic is routed to your account from clients over the Internet using the Microsoft global network or Internet routing. 

**Note:** 

By design, access to a storage account from trusted services takes the highest precedence over other network access restrictions. For this reason, if you set Public network access to Disabled after previously setting it to Enabled from selected virtual networks and IP addresses, any resource instances and exceptions you had previously configured, including Allow Azure services on the trusted services list to access this storage account, will remain in effect. As a result, those resources and services may still have access to the storage account after setting Public network access to Disabled.

To secure your storage account, you should first configure a rule to deny access to traffic from all networks (including internet traffic) on the public endpoint, by default. Then, you should configure rules that grant access to traffic from specific VNets. You can also configure rules to grant access to traffic from selected public internet IP address ranges, enabling connections from specific internet or on-premises clients. This configuration enables you to build a secure network boundary for your applications.

You can combine firewall rules that allow access from specific virtual networks and from public IP address ranges on the same storage account. Storage firewall rules can be applied to existing storage accounts, or when creating new storage accounts.

Storage firewall rules apply to the public endpoint of a storage account. You don't need any firewall access rules to allow traffic for private endpoints of a storage account. The process of approving the creation of a private endpoint grants implicit access to traffic from the subnet that hosts the private endpoint.


[Configure Azure Storage firewalls and virtual networks | Microsoft Learn](
https://learn.microsoft.com/en-us/azure/storage/common/storage-network-security?toc=%2Fazure%2Fstorage%2Fblobs%2Ftoc.json&bc=%2Fazure%2Fstorage%2Fblobs%2Fbreadcrumb%2Ftoc.json&tabs=azure-portal
)


**Secure Transfer**

You can configure your storage account to accept requests from secure connections only by setting the Secure transfer required property for the storage account. When you require secure transfer, any requests originating from an insecure connection are rejected. Microsoft recommends that you always require secure transfer for all of your storage accounts.

When secure transfer is required, a call to an Azure Storage REST API operation must be made over HTTPS. Any request made over HTTP is rejected. By default, the Secure transfer required property is enabled when you create a storage account.

[Require secure transfer to ensure secure connections | Microsoft Learn](
https://learn.microsoft.com/en-us/azure/storage/common/storage-require-secure-transfer?toc=%2Fazure%2Fstorage%2Fblobs%2Ftoc.json&bc=%2Fazure%2Fstorage%2Fblobs%2Fbreadcrumb%2Ftoc.json
)


**Encryption at Rest**

Data in Azure Storage is encrypted and decrypted transparently using 256-bit AES encryption, one of the strongest block ciphers available, and is FIPS 140-2 compliant. Azure Storage encryption is similar to BitLocker encryption on Windows.

Azure Storage encryption is enabled for all storage accounts, including both Resource Manager and classic storage accounts. Azure Storage encryption cannot be disabled. Because your data is secured by default, you don't need to modify your code or applications to take advantage of Azure Storage encryption.

[Azure Storage encryption for data at rest | Microsoft Learn](
https://learn.microsoft.com/en-us/azure/storage/common/storage-service-encryption?toc=%2Fazure%2Fstorage%2Fblobs%2Ftoc.json&bc=%2Fazure%2Fstorage%2Fblobs%2Fbreadcrumb%2Ftoc.json
)

**References**

[Security recommendations for Blob storage | Microsoft Learn](
https://learn.microsoft.com/en-us/azure/storage/blobs/security-recommendations 
)

[Azure security baseline for Storage | Microsoft Learn](
https://learn.microsoft.com/en-us/security/benchmark/azure/baselines/storage-security-baseline 
)


**Identity and Access Management**

Azure Data Lake is built to be part of the Hadoop ecosystem, using HDFS and YARN. 
The Azure Data Lake Store is optimized for Azure, but supports any analytic tool that accesses HDFS

ADLS allows you a hierarchical namespace configuration. 

ADLS Gen2 supports access control models that combine both RBAC's (Role-based access control) and ACL's (POSIX-like access control list to manage access to the data.

**Note:** 

RBAC are the familiar Azure roles such as reader, contributor, or owner. Granting a role on the service allows someone to view or manage the configuration and settings for that particular Azure service (ADLS in this case). 

The ACLs grant read/write/execute permissions on the data itself. Granting permissions here allows someone to create, read, and/or modify files and folders (i.e., the actual data) stored in ADLS. If you come from the Unix or Linux world, the POSIX-style ACLs will be a familiar concept

RBAC permissions are typically used on the ADLS account itself and is used for the purpose of **managing the resource**.

ACL are used to manage permissions to the data stored in ADLS, for the purpose of **managing the data**.

**When to use RBACs and when to use ACLs to manage access to the data.**

File system  (also referred to as container for non-HNS enabled accounts): 
A file system organizes a set of objects (or files).  Properties such as RBAC can be assigned at the file system level.

Folder/Directory: A folder (also referred to as a directory) 
Organizes a set of objects (other folders or files). 
A folder has properties such as access control lists (ACLs) associated with it
there are two types of ACLs associated with a folder – access ACLs and default ACLs

Object/file: A file is an entity that holds data that can be read/written
A file has an ACL associated with it. 
A file only has access to ACLs and not default ACLs. 

RBACs let you assign roles to security principals (user, group, service principal or managed identity in AAD) and these roles are associated with sets of permissions to the data in your file system. 

RBACs can help manage roles related to control plane operations (such as adding other users and assigning roles, manage encryption settings, firewall rules etc) or for data plane operations (such as creating file systems, reading and writing data etc). 

RBACs are essentially scoped to top-level resources – either storage accounts or file systems in ADLS Gen2

You can also apply RBACs across resources at a resource group or subscription level. 

ACLs let you manage a specific set of permissions for a security principal to a much narrower scope – a file or a directory in ADLS Gen2. 

**There are 2 types of ACLs:**

1.)	Access ADLs that control access to a file or a directory

2.)	Default ACLs are templates of ACLs set for directories that are associated with a directory, a snapshot of these ACLs are inherited by any child items that are created under that directory.

Setting permissions for the service + the data stored in ADLS is always two separate processes, with one exception: when an user is assigned owner – this means the user has full access to manage ADLS and full access to data

When you define an owner for the ADLS service in Azure, that owner is automatically granted 'superuser' (full) access to manage the ADLS resource in Azure *AND* full access to the data.

RBAC uses role assignments to effectively apply sets of permissions to security principals.

Any other RBAC role other than owner needs the data access specifically assigned via ACLs 
-	ACLS are only applicable when hierarchical namespaces are turned ON

Use groups whenever you can to grant access, rather than individual accounts. This is a consistent best practice for managing security across many types of systems.

ACL's (access control lists) grants permissions to create, read, and/or modify files and folders stored in the ADLS service.

**How permissions are evaluated**
During security principal-based authorization, permissions are evaluated in the following order.

1️⃣   Azure role assignments are evaluated first and take priority over any ACL assignments.

2️⃣   If the operation is fully authorized based on Azure role assignment, then ACLs are not evaluated at all.

3️⃣   If the operation is not fully authorized, then ACLs are evaluated.


![image](https://user-images.githubusercontent.com/24648322/213682034-b5fffb63-3436-4f7b-8db5-8c327d060065.png)

Because of the way that access permissions are evaluated by the system, you cannot use an ACL to restrict access that has already been granted by a role assignment. That's because the system evaluates Azure role assignments first, and if the assignment grants sufficient access permission, ACLs are ignored.

The following diagram shows the permission flow for three common operations: listing directory contents, reading a file, and writing a file.

![image](https://user-images.githubusercontent.com/24648322/213682181-baab78b3-1dd2-45a5-84a8-d8f869650c1d.png)

**References**

[Access control model in Azure Data Lake Storage Gen2 | Microsoft Learn](
https://learn.microsoft.com/en-us/azure/storage/blobs/data-lake-storage-access-control-model)

[Access control lists (ACLs) in Azure Data Lake Storage Gen2 | Microsoft Learn](
https://learn.microsoft.com/en-us/azure/storage/blobs/data-lake-storage-access-control)
