## Power BI 

### Securing Power BI  

This section covers securing Power BI, Data and Data Transfer in Power BI 

[<Back](https://github.com/LiliamLeme/FTALive-Sessions_Synapse_SQL/blob/main/content/data/ModernDatawarehouse-Security/DataFactory.md)\- [Next >](https://github.com/LiliamLeme/FTALive-Sessions_Synapse_SQL/blob/main/content/data/ModernDatawarehouse-Security/Putting_it_all_together.md)

#### Overview

Power BI is an online software service (SaaS, or Software as a Service) offering from Microsoft that lets you easily and quickly create self-service Business Intelligence dashboards, reports, datasets, and visualizations. With Power BI, you can connect to many different data sources, combine and shape data from those connections, then create reports and dashboards that can be shared with others.

User authentication to the Power BI service consists of a series of requests, responses, and redirects between the user's browser and the Power BI service or the Azure services used by Power BI. 

Power BI has robust encryption for both data at rest and data in transit. Data at rest is encrypted in Azure BIob Storage and Azure SQL DB. Data in transit is encrypted with HTTPs, while data in use is cached, encrypted, and stored in the Azure SQL database.

The SaaS solution uses the Azure Active Directory (AAD) for customer authentication and management. It also leverages the Azure Traffic Manager (ATM) for directing traffic to the proximate data centers, based on the DNS record of the client.

The authentication process in Power Bi is governed by Azure Active Directory (AAD). The SaaS uses the customer’s login credentials to grant access to the resource. Logging into Power BI is then by email address used to create the Power BI account.

Power BI then uses the login email as a username, passing it to resources whenever an attempt is made by the user to connect to data sources. The username is mapped to the UPN and resolved with a windows domain account for authentication.

![image](https://user-images.githubusercontent.com/24648322/214106037-51be1375-8836-4762-b489-5da0574b1629.png)

**Data Residency**

Unless otherwise indicated in documentation, Power BI stores customer data in an Azure geography that is assigned when an Azure AD tenant signs up for Power BI services for the first time. An Azure AD tenant houses the user and application identities, groups, and other relevant information that pertain to an organization and its security.

The assignment of an Azure geography for tenant data storage is done by mapping the country or region selected as part of the Azure AD tenant setup to the most suitable Azure geography where a Power BI deployment exists. Once this determination is made, all Power BI customer data will be stored in this selected Azure geography (also known as the home geo), except in cases where organizations utilize multi-geo deployments.

**Data at rest**

Power BI uses two primary data storage resource types:

•     Azure Storage

•     Azure SQL Databases

In the majority of scenarios, Azure Storage is utilized to persist the data of Power BI artifacts, while Azure SQL Databases are used to persist artifact metadata.

All data persisted by Power BI is encrypted by default using Microsoft-managed keys. Customer data stored in Azure SQL Databases is fully encrypted using Azure SQL's Transparent Data Encryption (TDE) technology. Customer data stored in Azure Blob storage is encrypted using Azure Storage Encryption.

**Data in processing**

Data is in processing when it is either actively being used by one or more users as part of an interactive scenario, or when a background process, such as refresh, touches this data. Power BI loads actively processed data into the memory space of one or more service workloads. To facilitate the functionality required by the workload, the processed data in memory is not encrypted.

**Data Transfer**

All data requested and transmitted by Power BI is encrypted in transit using HTTPS (except when the data source chosen by the customer does not support HTTPS) to connect from the data source to the Power BI service. A secure connection is established with the data provider, and only once that connection is established will data traverse the network.

**Authentication to data sources**

When connecting to a data source, a user can choose to import a copy of the data into Power BI or to connect directly to the data source.

In the case of import, a user establishes a connection based on the user's login and accesses the data with the credential. After the dataset is published to the Power BI service, Power BI always uses this user's credential to import data. Once data is imported, viewing the data in reports and dashboards does not access the underlying data source. Power BI supports single sign-on authentication for selected data sources. If the connection is configured to use single sign-on, the dataset owner's credentials are used to connect to the data source.

If a data source is connected directly using pre-configured credentials, the pre-configured credentials are used to connect to the data source when any user views the data.

If a data source is connected directly using single sign-on, the current user's credentials are used to connect to the data source when a user views the data. When used with single sign-on, Row Level Security (RLS) and/or object-level security (OLS) can be implemented on the data source. This allows users to view only data they have privileges to access. When the connection is to data sources in the cloud, Azure AD authentication is used for single sign-on; for on-premises data sources, Kerberos, Security Assertion Markup Language (SAML), and Azure AD are supported.

**Data source permissions**
When a data creator starts a new project, permissions required to access external data sources are one of their first security-related considerations. They may also need guidance on other data source related matters, including privacy levels, native database queries, and custom connectors.

**Access to the data source**
When a data creator creates a dataset, dataflow, or datamart, they must authenticate with data sources to retrieve data. Usually, authentication involves user credentials (account and password), which could be for a service account.

Sometimes it's useful to create specific service accounts for accessing data sources. Check with your IT department for guidance on how service accounts should be used in your organization. When they're permitted, the use of service accounts can:

•     Centralize permissions needed for data sources.

•     Reduce the number of individual users that need permissions to a data source.

•     Avoid data refresh failures when a user leaves the organization.

If you choose to use service accounts, we recommend that you tightly control who has access to the credentials. Rotate passwords on a regular basis (such as every three months) or when someone that has access leaves the organization.

When accessing data sources, apply the principle of least privilege to ensure that users (or service accounts) have permission to read only the data they need. They should never have permission to perform data modifications. 

Database administrators who create these service accounts should inquire about expected queries and workloads and take steps to ensure adequate optimizations (like indexes) and resources are in place.



The credentials (account and password) can be applied in one of two ways.

•     Power BI Desktop: Credentials are encrypted and stored locally on the user machine.

•     Power BI service: Credentials are encrypted and securely stored for either:

The dataset (when a data gateway isn't in use to reach the data source).

The gateway data source (when a standard gateway or a virtual network gateway service is in use to reach the data source).



Credentials are encrypted and stored separately from the data model in both Power BI Desktop and the Power BI service

When you've already entered credentials for a dataset data source, the Power BI service will automatically bind those credentials to other dataset data sources when there's an exact match of connection string and database name. Both the Power BI service and Power BI Desktop make it look like you're entering credentials for each data source. However, it can apply the same credentials to matching data sources that have the same owner. In that respect, dataset credentials are scoped to the owner.

Some data sources support single-sign on (SSO), which can be set when entering credentials in the Power BI service (for dataset or gateway data sources). When you enable SSO, Power BI sends the authenticated user's credentials to the data source. This option enables Power BI to honor the security settings that are set up in the data source, such as row-level security. SSO is especially useful when tables in the data model use DirectQuery storage mode.



**Network isolation**

A service tag represents a group of IP address prefixes from a given Azure service. It helps minimize the complexity of frequent updates to network security rules. Customers can use service tags to define network access controls on Network Security Groups or Azure Firewall. Customers can use service tags in place of specific IP addresses when creating security rules. By specifying the service tag name (such as PowerBI) in the appropriate source or destination (for APIs) field of a rule, customers can allow or deny the traffic for the corresponding service. Microsoft manages the address prefixes encompassed by the service tag and automatically updates the service tag as addresses change.

**Private Link integration**

Azure networking provides the Azure Private Link feature that enables Power BI to provide secure access via Azure Networking private endpoints. With Azure Private Link and private endpoints, data traffic is sent privately using Microsoft's backbone network infrastructure, and thus the data doesn't traverse the Internet.

Private Link ensures that Power BI users use the Microsoft private network backbone when going to resources in the Power BI service.

Using Private Link with Power BI provides the following benefits:

•     Private Link ensures that traffic will flow over the Azure backbone to a private endpoint for Azure cloud-based resources.

•     Network traffic isolation from non-Azure-based infrastructure, such as on-premises access, would require customers to have ExpressRoute or a Virtual Private Network (VPN) configured.


**On Premise Data Gateway**

The on-premises data gateway acts as a bridge to provide quick and secure data transfer between on-premises data (data that isn't in the cloud) and several Microsoft cloud services. 

By using a gateway, organizations can keep databases and other data sources on their on-premises networks, yet securely use that on-premises data in cloud services.

Power Query services execute in back-end nodes. Data may be pulled directly from the cloud sources or through a gateway installed on premises. When pulled directly from a cloud source to the service or to the gateway, the transport uses protection methodology specific to the client technology, if applicable. When data is transferred from the gateway to the cloud service, it is encrypted.

An On Premise Data Gateway running in a virtual machine is required for connecting to data sources associated with a VNet whether in the cloud or on premise. 

The on-premises data gateway is configured to use NT SERVICE\PBIEgwService for the Windows service sign-in credential. In the context of the machine on which you install the gateway, the account by default has the right of Log on as a service.

This service account isn't the account used to connect to on-premises data sources. It also isn't the work or school account that you sign in to cloud services with.

After the gateway is installed and registered, the only required ports and IP addresses are those needed by Azure Relay.

The gateway supports and secures the following two communications protocols:

•     AMQP 1.0 – TCP + TLS: This protocol requires ports 443, 5671-5672, and 9350-9354 to be open for outgoing communication. This protocol is preferred, since it has lower communication overhead. The gateway doesn't require inbound ports.

•     HTTPS – WebSockets over HTTPS + TLS: This protocol uses port 443 only. The WebSocket is initiated by a single HTTP CONNECT message. Once the channel is established, the communication is essentially TCP+TLS. 

By default, the gateway uses Transport Layer Security (TLS) 1.2 to communicate with the Power BI service. To ensure all gateway traffic uses TLS 1.2, you might need to add or modify registry keys on the machine that runs the gateway service.

We recommend that you allow the "*.servicebus.windows.net" Domain Name System (DNS). 


**VNet connectivity (preview - coming soon)**

While the Private Link integration feature provides secure inbound connections to Power BI, the VNet connectivity feature enables secure outbound connectivity from Power BI to data sources within a VNet.

VNet gateways (Microsoft-managed) will eliminate the overhead of installing and monitoring on-premises data gateways for connecting to data sources associated with a VNet. They will, however, still follow the familiar process of managing security and data sources, as with an on-premises data gateway.

The following is an overview of what happens when you interact with a Power BI report that is connected to a data source within a VNet using VNet gateways:

The Power BI cloud service (or one of the other supported cloud services) kicks off a query and sends the query, data source details, and credentials to the Power Platform VNet service (PP VNet).

The PP VNet service then securely injects a container running a VNet gateway into the subnet. This container can now connect to data services accessible from within this subnet.

The PP VNet service then sends the query, data source details, and credentials to the VNet gateway.

The VNet gateway gets the query and connects to the data sources with those credentials.

The query is then sent to the data source for execution.

After execution, the results are sent to the VNet gateway, and the PP VNet service securely pushes the data from the container to the Power BI cloud service.

**This feature will be available in public preview soon.*

**Power BI Service** 

Security concerns within the Power BI service can arise from the following questions:

•     Who has access to my data? 

•     Who can create workspaces?

•     Who can export data?

•     Who is sharing data and is it being shared externally?


**NOTE: The organisation / customer is responsible for the data that is shared.*

Remember: Users can access data sources that they have permissions to using their credentials and they can share reports with a non-authenticated person. 

**Best practice and key considerations**

Azure Active Directory (AD) governs authentication to the Power BI service. Sync your AD to Azure using Azure AD connect to provide single sign-on for on-premises and cloud. 

Disabling the ‘Share content with external users’ setting in the Admin Portal.

Disabling the ‘Publish to web’ setting - the publish to web setting will allow users to will publish your reports to the internet. Consider disabling publishing for the whole organization.

Monitor or disable the exported data if printed or used in a softcopy by employees

Turning off the ‘export data’ feature unless it’s critically necessary

Multi-factor authentication (MFA)— turn this ON on Azure AD Conditional Access

Blocking access from certain Operating Systems

Restricting user accesses from untrusted locations

Restricting access from individual clients using mobile

**Service principals**

Power BI supports the use of service principals. Store any service principal credentials used for encrypting or accessing Power BI in a Key Vault, assign proper access policies to the vault, and regularly review access permissions.

To restrict service principal access to specific tenant settings, you can allow access to specific security groups. Alternatively, you can create a dedicated security group for service principals, and exclude it from the desired tenant setting

**Multi layered approach to security in the Power BI Service**

**This topic excludes Dataflows and DataMarts*

![image](https://user-images.githubusercontent.com/24648322/213696207-c03c766f-93b7-472c-a2c8-767f44ada8fc.png)

Here are a few examples of high-level security strategies. You might choose to make decisions that impact the entire organization.

Requirements for row-level security: You can use row-level security (RLS) to restrict data access for specific users. That means different users will see different data when accessing the same report. A Power BI dataset or a data source (when using single sign-on) can enforce RLS. F

Data discoverability: Determine the extent to which data discoverability should be encouraged in Power BI. Discoverability affects who can find datasets or datamarts in the data hub, and whether content authors are allowed to request access to those items (by using the Request access workflow). 

Data that's permitted to be stored in Power BI: Determine whether there are certain types of data that shouldn't be stored in Power BI. For example, you might specify that certain sensitive information types, like bank account numbers or social security numbers, aren't allowed to be stored in a dataset. 

Inbound private networking: Determine whether there are requirements for network isolation by using private endpoints to access Power BI. When you use Azure Private Link, data traffic is sent by using the Microsoft private network backbone instead of going across the internet.

Outbound private networking: Determine whether more security is required when connecting to data sources. The Virtual Network (VNet) data gateway enables secure outbound connectivity from Power BI to data sources within a VNet. You can use an Azure VNet data gateway when content is stored in a Premium workspace.

When considering network isolation, work with your IT infrastructure and networking teams before you change any of the Power BI tenant settings. Azure Private Link allows for enhanced inbound security through private endpoints, while an Azure VNet gateway allows for enhanced outbound security when connecting to data sources. Azure VNet gateway is Microsoft-managed rather than customer-managed, so it eliminates the overhead of installing and monitoring on-premises gateways.


When reviewing security in the Power BI Service, it must be take into consideration that security is implemented in layers.

These layers include:
Workspaces
Apps
Datasets
Dataset data 

At a planning level, these layers include:

•     Tenant-Level

•     Report consumer Level

•     Content creator level

The Power BI administrator is a high-privilege role that has significant control over Power BI. We recommend that you carefully consider who's assigned to this role because a Power BI administrator can perform many high-level functions, including:

•     Tenant settings management

•     Workspace role management

•     Access to tenant metadata

A Power BI administrator belongs to at least one of these built-in roles:

•     Power BI admin (Microsoft 365)

•     Power Platform admin (Microsoft 365)

•     Global administrator (Azure Active Directory)


As a best practice, you should assign between two and four users to the Power BI administrator role. That way, you can reduce risk while ensuring there's adequate coverage and cross-training.


**Workspaces**

Fundamentally, a Power BI workspace is a container in the Power BI service for storing and securing Power BI content. However, workspaces have many other capabilities and functionality that includes content distribution and collaboration.

You grant workspace access by adding users or groups (including security groups, Microsoft 365 groups, and distribution lists) to workspace roles. Assigning users to workspace roles allows you to specify what they can do with the workspace and its content.

**Viewer** - This role provides read only access to workspace items. Read access does provide report / dashboard consumers the ability to not only view, but also interact with visuals. Interaction does not mean changing a visual. 

Users assigned to the Viewer role can view and interact with all workspace content.

The Viewer role is relevant to read-only consumers for small teams and informal scenarios.

**Contributor** - This role can access and interact with reports and dashboards. Additionally, this role can create, edit, copy, and delete items in a workspace, publish reports, schedule refreshes, and modify gateways.

**Member** - This role can access and interact with reports and dashboards. Additionally, this role can create, edit, copy, and delete items in a workspace, publish reports, schedule refreshes, and modify gateways. Finally, members of this role can also feature dashboards on the service, share items, allow others to reshare items, publish or republish and APP. This role is also able to add other users to the viewer or contributor role.
Users assigned to the Member role can add other workspace users (but not administrators). They can also manage permissions for all content in the workspace.

Workspace members can publish or unpublish the app for the workspace, share a workspace item or the app, and allow other users to share workspace items of the app.

Workspace members should be limited to the users who need to manage the workspace content creation and publish the app. 

**Admin** - This role can do all the functions above plus add and remove all users including other Admins.

Users assigned to the Admin role become the workspace administrators. They can manage all settings and perform all actions, including adding or removing users (including other workspace administrators).

Workspace administrators can update or delete the Power BI app (if one exists). They can, optionally, allow contributors to update the app for the workspace. For more information, see Variations to workspace roles later in this article.

Users assigned to the Admin role become the workspace administrators. They can manage all settings and perform all actions, including adding or removing users (including other workspace administrators).

Take care to ensure that only trusted and reliable individuals are workspace administrators. A workspace administrator has high privileges.

**Consumers and Apps**

Generally, it's a best practice to use a Power BI app for most consumers. Occasionally the workspace Viewer role may also be appropriate. Both Power BI apps and the workspace Viewer role allow managing permissions for many items, and should be used whenever possible. Managing permissions for individual items can be tedious, time consuming, and error prone. In contrast, managing a set of items reduces maintenance and improves accuracy.

We recommend that you use app permissions whenever possible. Next, consider using workspace roles to enable direct workspace access. Lastly, use per-item permissions when they meet the above criteria. App permissions and workspace roles both specify security for a collection of content (rather than individual items), which is a better security practice.


In the Power BI service, consumers can view a report or dashboard when they have permission to both:

View the Power BI item that contains the visualizations (such as a report or dashboard).
Read the underlying data (dataset or other source).


You can provide read-only access to consumers by using different techniques. The common techniques used by self-service content creators include:

•     Granting users and groups access to a Power BI app.

•     Adding users and groups to a Power BI workspace Viewer role.

•     Providing users and groups per-item permissions by using a sharing link.

•     Providing users and groups per-item permissions by using direct access.


**Datasets**

You can assign the following dataset permissions.

**Read**: Targeted primarily at report consumers, this permission allows a report to query data in the dataset. 

**Build**: Targeted at report creators, this permission allows users to create new reports based on the shared dataset. 

**Write**: Targeted at dataset creators who create, publish, and manage datasets, this permission allows users to edit the dataset. 

**Reshare**: Targeted at anyone with existing permission to the dataset, this permission allows users to share the dataset with another user. 

A workspace administrator or member can edit the permissions for a dataset.

The best practice here would be to implement a least-privilege administrative model. 

**Dataset data security**

You can plan to create fewer datasets and reports by enforcing data security. The objective is to enforce data security based on the identity of the user who's viewing the content.

A dataset creator can enforce data security in two ways.

Row-level security (RLS) allows a data modeler to restrict access to a subset of data.
Object-level security (OLS) allows a data modeler to restrict access to specific tables and columns, and their metadata.

The implementation of RLS and OLS is mostly targeted at report consumers. 

Row-level security (RLS) can be implemented in Power BI desktop. It grants the ability to publish a single report to your user base but exposes the data differently to each person. RLS helps to secure data and streamline administration. Consider implementing RLS either in Analysis Services or in the Power BI data model.

**Report creation**

Report creators need workspace access to create reports in the Power BI service or publish them from Power BI Desktop. They must be either an administrator, member, or contributor in the target workspace.

Whenever possible, report creators should use an existing shared dataset (via a live connection or DirectQuery). That way, the report creation process is decoupled from the dataset creation process. This type of separation provides many benefits for security and team development scenarios.

A report creator needs to be a workspace administrator, member, or contributor.

Report creators must have Read and Build permissions on the datasets that their reports will use, which includes chained datasets. That permission can be granted explicitly on the individual datasets, or it can be granted implicitly for workspace datasets when the report creator is a workspace administrator, member, or contributor.

The steps in the process include:

•     Defining Power BI roles and rules and apply a DAX expression

•     Validating roles and defining what users can see

•     Managing security of the data model

•     Sharing Within your Organization, Guest Users and Sharing ‘Outside the Walls


For stronger data protection, consider limiting Guest User creation on Power BI Tenant settings, Azure Active Directory settings, and Office 365 Security settings.

Power BI also enables the sharing of content by email, including personal email addresses. If you enable users to share content this way, by default, you will be enabling them to create guest accounts in Azure Directory. These guest users could then add content to workspaces or serve as admins.

**Auditing**

Admins and other users with the necessary privileges can access the Office 365 Admin Center. Here you can view exhaustive logs of all Power BI activities. Viewing these logs helps to monitor and evaluate access, users, and group activities, including the sharing/exportation of reports on Power BI.

It would be wise to regularly access your audit logs so you can see who is doing what. That’s a critical step in helping your organization comply with regulatory requirements on record preservation.


#### Reference
[Power BI security white paper | Microsoft Learn](
https://learn.microsoft.com/en-us/power-bi/guidance/whitepaper-powerbi-security )

[Power BI implementation planning: Security | Microsoft Learn](
https://learn.microsoft.com/en-us/power-bi/guidance/powerbi-implementation-planning-security-overview)

[VNet connectivity (preview - coming soon) | Microsoft Learn](
https://learn.microsoft.com/en-us/power-bi/guidance/whitepaper-powerbi-security#vnet-connectivity-preview---coming-soon)


[What is an on-premises data gateway? | Microsoft Learn](
https://learn.microsoft.com/en-us/power-bi/connect-data/service-gateway-onprem)

[On-premises data gateway in-depth | Microsoft Learn](
https://learn.microsoft.com/en-us/power-bi/connect-data/service-gateway-onprem-indepth)


[Private endpoints for accessing Power BI | Microsoft Learn](
https://learn.microsoft.com/en-us/power-bi/enterprise/service-security-private-links)


[Automate Premium workspace and dataset tasks with service principals | Microsoft Learn](
https://learn.microsoft.com/en-us/power-bi/enterprise/service-premium-service-principal)
