## Serveless SQL pool 

### Security 

[<Back](https://github.com/LiliamLeme/FTALive-Sessions_Synapse_SQL/blob/main/content/data/ModernDatawarehouse-Security/Dedicated%20SQL%20Pool_data.md)\- [Next >](https://github.com/LiliamLeme/FTALive-Sessions_Synapse_SQL/blob/main/content/data/ModernDatawarehouse-Security/Data%20factoryandSpark.md)


#### Serverless Security overview
Serverless SQL pool enables you to centrally manage identities of database user and other Microsoft services with [Azure Active Directory integration](https://learn.microsoft.com/en-us/azure/azure-sql/database/authentication-aad-configure). . Azure Active Directory (Azure AD) supports [multi-factor authentication](https://learn.microsoft.com/en-us/azure/azure-sql/database/authentication-mfa-ssms-configure) (MFA).

**Authentication**

Serverless SQL pool authentication refers to how users prove their identity when connecting to the endpoint. Two types of authentication are supported:

•    **SQL Authentication**

•    This authentication method uses a username and password.

•    **Azure Active Directory Authentication**:

•    This authentication method uses identities managed by Azure Active Directory. 

**Authorization**

If SQL Authentication is used, the SQL user exists only in serverless SQL pool and permissions are scoped to the objects in serverless SQL pool. The SQL user needs to use one of the [supported authorization types](https://learn.microsoft.com/en-us/azure/synapse-analytics/sql/develop-storage-files-storage-access-control#supported-storage-authorization-types) to access the files on teh storage as give permission to a SQl user would not be possible.

If Azure AD authentication is used, a user can sign in to serverless SQL pool and other services, like Azure Storage, and can grant permissions to the Azure AD user.

#### **Access to storage accounts**

 serverless SQL pool supports the following authorization types:

•    [**Shared access signature (SAS)**](https://learn.microsoft.com/en-us/azure/synapse-analytics/sql/develop-storage-files-storage-access-control?tabs=shared-access-signature) A SAS gives you granular control over the type of access you grant to clients who have the SAS: validity interval, granted permissions, acceptable IP address range, acceptable protocol (https/http).

•    [**User Identity**](https://learn.microsoft.com/en-us/azure/synapse-analytics/sql/develop-storage-files-storage-access-control?tabs=user-identity) (also known as "pass-through") This authorization type uses the Azure AD user that logged into serverless SQL pool, therefore it's not supported for SQL user types.

•    [**Workspace Identity**](https://learn.microsoft.com/en-us/azure/synapse-analytics/sql/develop-storage-files-storage-access-control?tabs=managed-identity) is an authorization type where the identity of the Synapse workspace is used to authorize access to the data. Before accessing the data, Azure Storage administrator must grant permissions to workspace identity for accessing the data.

#### Data security

 As Serveless SQL Pool does not support data masking or row level security there are some workarounds possible. You manually create the data masking function and applied it to a view as the same for the row level security.


#### Reference

[Row-level security in serverless Synapse SQL pools (microsoft.com)](https://techcommunity.microsoft.com/t5/azure-synapse-analytics-blog/how-to-implement-row-level-security-in-serverless-sql-pools/ba-p/2354759#:~:text=Row-level)

[Serverless SQL pool - Azure Synapse Analytics | Microsoft Learn](https://learn.microsoft.com/en-us/azure/synapse-analytics/sql/on-demand-workspace-overview)
