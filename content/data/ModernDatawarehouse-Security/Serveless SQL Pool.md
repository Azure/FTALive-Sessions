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

MSI Example:

```sql
CREATE MASTER KEY ENCRYPTION BY PASSWORD= '...';

-- Create a database scoped credential.
CREATE DATABASE SCOPED CREDENTIAL Nameapp WITH IDENTITY = 'Managed Identity'

CREATE EXTERNAL DATA SOURCE [LLive_sqlserverlessanalitics] 
WITH (LOCATION = N'https://STORAGE.dfs.core.windows.net/Container/Folder/'
    , CREDENTIAL = [Nameapp]
)
GO

---****Remove storage permissions, leaving only the owner which is inherited and test.---****
SELECT  *
FROM OPENROWSET(
        BULK 'Folder/',
        DATA_SOURCE = 'LLive_sqlserverlessanalitics',
        FORMAT = 'Delta'
) as X
```

- **[Role based access control (RBAC)](https://learn.microsoft.com/en-us/azure/role-based-access-control/overview)** enables you to assign a role to some Azure AD user in the tenant where your storage is placed. A reader must have `Storage Blob Data Reader`, `Storage Blob Data Contributor`, or `Storage Blob Data Owner` RBAC role on storage account. A user who writes data in the Azure storage must have `Storage Blob Data Contributor` or `Storage Blob Data Owner` role. Note that `Storage Owner` role does not imply that a user is also `Storage Data Owner`.
- **Access Control Lists (ACL)** enable you to define a fine grained [Read(R), Write(W), and Execute(X) permissions](https://learn.microsoft.com/en-us/azure/storage/blobs/data-lake-storage-access-control#levels-of-permission) on the files and directories in Azure storage. ACL can be assigned to Azure AD users. If readers want to read a file on a path in Azure Storage, they must have Execute(X) ACL on every folder in the file path, and Read(R) ACL on the file. [Learn more how to set ACL permissions in storage layer](https://learn.microsoft.com/en-us/azure/storage/blobs/data-lake-storage-access-control#how-to-set-acls).
- **Shared access signature (SAS)** enables a reader to access the files on the Azure Data Lake storage using the time-limited token. The reader doesn’t even need to be authenticated as Azure AD user. SAS token contains the permissions granted to the reader as well as the period when the token is valid. SAS token is good choice for time-constrained access to any user that doesn't even need to be in the same Azure AD tenant. SAS token can be defined on the storage account or on specific directories. Learn more about [granting limited access to Azure Storage resources using shared access signatures](https://learn.microsoft.com/en-us/azure/storage/common/storage-sas-overview).



SQL user example:

```sql
--master
CREATE LOGIN testUser
	WITH PASSWORD = 'xxxx' 
GO

--YOURDATABASE
-- Creates a database user for the login created above.  
CREATE USER testUser FOR LOGIN testUser;  
GO


-- Create a database scoped credential.
--CREATE DATABASE SCOPED CREDENTIAL Nameapp WITH IDENTITY = 'Managed Identity'

--CREATE EXTERNAL DATA SOURCE [LLive_sqlserverlessanalitics] 
--WITH (LOCATION = N'https://Storage.dfs.core.windows.net/Container/Folder/'
  --  , CREDENTIAL = [Nameapp]
--)
--GO

---Permissions to the SQL User
GRANT CONNECT TO testUser
GRANT REFERENCES ON DATABASE SCOPED CREDENTIAL::LLive_sqlserverlessanalitics TO testUser;
GRANT REFERENCES ON DATABASE SCOPED CREDENTIAL::Nameapp TO testUser;


--Blocking the user to user Openrowset
DENY ADMINISTER DATABASE BULK OPERATIONS TO testUser;

--Creating an external table 
CREATE EXTERNAL TABLE LLive_CETAS_DimSalesReason
  WITH (
    LOCATION = 'DimSalesReason_Delta_LLive_CETAS/',
    DATA_SOURCE = LLive_sqlserverlessanalitics,
    FILE_FORMAT = Parquet_file
      ) 
  AS
SELECT  *
FROM OPENROWSET(
        BULK 'DimSalesReason_Delta/',
        DATA_SOURCE = 'LLive_sqlserverlessanalitics',
        FORMAT = 'Delta'
) as X



--Granting permission to SQl user use that external table.
GRANT SELECT ON OBJECT::LLive_CETAS_DimSalesReason TO testUser;

---open on the SSMS with the User and permission
SELECT * FROM LLive_CETAS_DimSalesReason

```



#### Data security

 As Serverless SQL Pool does not support data masking or row level security there are some workarounds possible. You manually create the data masking function and applied it to a view as the same for the row level security.


#### Reference

[Row-level security in serverless Synapse SQL pools (microsoft.com)](https://techcommunity.microsoft.com/t5/azure-synapse-analytics-blog/how-to-implement-row-level-security-in-serverless-sql-pools/ba-p/2354759#:~:text=Row-level)

[Serverless SQL pool - Azure Synapse Analytics | Microsoft Learn](https://learn.microsoft.com/en-us/azure/synapse-analytics/sql/on-demand-workspace-overview)

[Permissions (Database Engine) - SQL Server | Microsoft Learn](https://learn.microsoft.com/en-us/sql/relational-databases/security/permissions-database-engine?view=sql-server-ver16)

[Control storage account access for serverless SQL pool - Azure Synapse Analytics | Microsoft Learn](https://learn.microsoft.com/en-us/azure/synapse-analytics/sql/develop-storage-files-storage-access-control?tabs=user-identity)

[Securing access to ADLS files using Synapse SQL permission model - Microsoft Community Hub](https://techcommunity.microsoft.com/t5/azure-synapse-analytics-blog/securing-access-to-adls-files-using-synapse-sql-permission-model/ba-p/1796282#:~:text=Once%20we%20create%20DATABASE%20SCOPED%20CREDENTIAL%2C%20we%20need,function%20to%20access%20any%20file%20on%20that%20storage)



