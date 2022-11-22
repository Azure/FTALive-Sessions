# Network

 

## Manage VNet

 

Ref: [Managed virtual network - Azure Synapse Analytics | Microsoft Learn](https://learn.microsoft.com/en-us/azure/synapse-analytics/security/synapse-workspace-managed-vnet)

​     [What is a private endpoint? - Azure Private Link | Microsoft Learn](https://learn.microsoft.com/en-us/azure/private-link/private-endpoint-overview)

When you create your Azure Synapse workspace, you can choose to associate it to a Microsoft Azure Virtual Network. The Virtual Network associated with your workspace is managed by Azure Synapse. This Virtual Network is called a *Managed workspace Virtual Network*. Creating a workspace with a Managed workspace Virtual Network associated with it ensures that your workspace is network isolated from other workspaces. 

If your workspace has a Managed workspace Virtual Network, Data integration and Spark resources are deployed in it. A Managed workspace Virtual Network also provides user-level isolation for Spark activities because each Spark cluster is in its own subnet.

Dedicated SQL pool and serverless SQL pool are multi-tenant capabilities and therefore reside outside of the Managed workspace Virtual Network. Intra-workspace communication to dedicated SQL pool and serverless SQL pool use Azure private links. These private links are automatically created for you when you create a workspace with a Managed workspace Virtual Network associated to it.

![Timeline  Description automatically generated](file:///C:/Users/lilem/AppData/Local/Temp/msohtmlclip1/01/clip_image002.gif)

 

Private endpoints can be accessed from only within the same virtual network and from other virtual networks that are globally or regionally peered to the VNET that contains these private endpoints and from customer on prem network using express route or VPN gateway

Private endpoints are mapped to an instance of PaaS resource instead of the entire service. In the event of a security incident within a network, only mapped resource instance is exposed, minimizing the exposure and data leakage from other instances

## Firewall

 

Ref: [Configure IP firewall rules - Azure Synapse Analytics | Microsoft Learn](https://learn.microsoft.com/en-us/azure/synapse-analytics/security/synapse-workspace-ip-firewall)

Every synapse workspace has a firewall by default to be configured on the portal, access from internet goes to a Firewall before reaching the Endpoints. IP firewall rules grant or deny access to your Azure Synapse workspace based on the originating IP address of each request. You can configure IP firewall rules for your workspace. IP firewall rules configured at the workspace level apply to all public endpoints of the workspace (dedicated SQL pools, serverless SQL pool, and development). That is an important against attacks from external networks, including distributed denial of service (DDoS) attacks, application-specific attacks, and unsolicited and potentially malicious internet traffic. 

 

![Graphical user interface, application, Teams  Description automatically generated](file:///C:/Users/lilem/AppData/Local/Temp/msohtmlclip1/01/clip_image004.gif)

 

## Connecting to the Storage

[Connect to a secure storage account from your Azure Synapse workspace - Azure Synapse Analytics | Microsoft Learn](https://learn.microsoft.com/en-us/azure/synapse-analytics/security/connect-to-a-secure-storage-account)

Azure storage provides a layered security model that enables you to secure and control access to your storage accounts. You can configure IP firewall rules to grant traffic from selected public IP address ranges access to your storage account. You can also configure network rules to grant traffic from selected virtual networks access to your storage account.

If you enabled **Managed virtual network** when you created the workspace, then your workspace is associated with a dedicated virtual network managed by Azure Synapse. These virtual networks are not created in your customer subscription. Therefore, you will not be able to grant traffic from these virtual networks access to your secured storage account using network rules. Analytic capabilities such as **Dedicated SQL pool and Serverless SQL pool use multi-tenant infrastructure that is not deployed into the managed virtual network**. In order for traffic from these capabilities to access the secured storage account, you must configure access to your storage account based on the workspace's system-assigned managed identity

![Graphical user interface, text, application  Description automatically generated](file:///C:/Users/lilem/AppData/Local/Temp/msohtmlclip1/01/clip_image006.gif)

## Data Extra filtration (DEP)

 

Ref: [(428) Synapse Security Deep Dive: Outbound Network Security - YouTube](https://www.youtube.com/watch?v=vwScocYyeyk)

[Create a workspace with data exfiltration protection enabled - Azure Synapse Analytics | Microsoft Learn](https://learn.microsoft.com/en-us/azure/synapse-analytics/security/how-to-create-a-workspace-with-data-exfiltration-protection)

Azure Synapse Analytics workspaces support enabling data exfiltration protection for workspaces. With exfiltration protection, you can guard against malicious insiders accessing your Azure resources and exfiltrating sensitive data to locations outside of your organization’s scope. At the time of workspace creation, you can choose to configure the workspace with a managed virtual network and additional protection against data exfiltration. Workspaces with data exfiltration protection, resources within the managed virtual network always communicate over [managed private endpoints](https://learn.microsoft.com/en-us/azure/synapse-analytics/security/synapse-workspace-managed-private-endpoints) and the Synapse SQL resources can only connect to authorized Azure resources (targets of approved managed private endpoint connections from the workspace). The main ideas is to prevent malicious users with high permission such as Contributor RBAC role from using SQL or Spark pools to write data out to remote servers, Azure-based or not.

 

![Graphical user interface, text, application, email  Description automatically generated](file:///C:/Users/lilem/AppData/Local/Temp/msohtmlclip1/01/clip_image008.gif)

 

**Limitations:**

Users can provide an environment configuration file to install Python packages from public repositories like PyPI. In data exfiltration protected workspaces, connections to outbound repositories are blocked. 

Ingesting data [from an Event Hub into Data Explorer pools](https://learn.microsoft.com/en-us/azure/synapse-analytics/data-explorer/ingest-data/data-explorer-ingest-event-hub-one-click) will not work if your Synapse workspace uses a managed virtual network with data exfiltration protection enabled.

## Manage application identities securely and automatically


 Ref: [Grant permissions to managed identity in Synapse workspace - Azure Synapse Analytics | Microsoft Learn](https://learn.microsoft.com/en-us/azure/synapse-analytics/security/how-to-grant-workspace-managed-identity-permissions)

[Managed identities for Azure resources - Microsoft Entra | Microsoft Learn](https://learn.microsoft.com/en-us/azure/active-directory/managed-identities-azure-resources/overview)

Azure Synapse Workspace supports managed identities for its Azure resources. Use managed identities with Azure Synapse Workspace instead of creating service principals to access other resources. Azure Synapse Workspace can natively authenticate to the Azure services/resources that supports Azure AD authentication through a pre-defined access grant rule without using credentials hard coded in source code or configuration files.

### What are Managed identities?

·    **System-assigned**. Some Azure services allow you to enable a managed identity directly on a service instance. When you enable a system-assigned managed identity, an identity is created in Azure AD. The identity is tied to the lifecycle of that service instance.

·    **User-assigned**. You may also create a managed identity as a standalone Azure resource. You can [create a user-assigned managed identity](https://learn.microsoft.com/en-us/azure/active-directory/managed-identities-azure-resources/how-to-manage-ua-identity-portal) and assign it to one or more instances of an Azure service. For user-assigned managed identities, the identity is managed separately from the resources that use it.

·    .................

# Least Privilege user 

 

Azure Synapse Workspace is integrated with Azure role-based access control (Azure RBAC) to manage its resources. Azure RBAC allows you to manage Azure resource access through role assignments. You can assign these roles to users, groups service principals, and managed identities. Use built-in roles to allocate permissions and only create custom roles when required.

Azure Synapse Analytics requires users in Azure Owner or Azure Contributor roles at the resource-group to control management of its dedicated SQL pools, Spark pools, and Integration runtimes. In addition to this, users and the workspace system-identity must be granted Storage Blob Data Contributor access to the ADLS Gen2 storage container associated with the Synapse workspace.

When you first create an Azure Synapse workspace, you may specify an admin login and password for SQL pools within the Synapse workspace. This administrative account is called Server admin. You can identify the Server admin account for Synapse by opening the Azure portal and navigating to the overview tab of your Synapse workspace. You can also configure an Azure AD admin account with full administrative permissions, this is required if you want to enable Azure Active Directory authentication.

Portal

![img](file:///C:/Users/lilem/AppData/Local/Temp/msohtmlclip1/01/clip_image010.gif)

 

Synapse Studio:

![img](file:///C:/Users/lilem/AppData/Local/Temp/msohtmlclip1/01/clip_image012.gif)