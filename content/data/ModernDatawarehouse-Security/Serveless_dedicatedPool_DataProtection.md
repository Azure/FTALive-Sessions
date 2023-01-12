
## Synapse SQL dedicate pool 

#### Security


[<Back](https://github.com/LiliamLeme/FTALive-Sessions_Synapse_SQL/blob/main/content/data/ModernDatawarehouse-Security/Agenda.md)\- [Next >](https://github.com/LiliamLeme/FTALive-Sessions_Synapse_SQL/blob/main/content/data/ModernDatawarehouse-Security/Dedicated%20SQL%20Pool_data.md)


#### Authentication

Authentication refers to how you prove your identity when connecting to the database. Dedicated SQL pool (formerly SQL DW) currently supports SQL Server Authentication with a username and password, and with Azure Active Directory.

When you created the server for your database, you specified a "server admin" login with a username and password. Using these credentials, you can authenticate to any database on that server as the database owner, or "dbo" through SQL Server Authentication.

You can see this configuration on the portal -> properties:

![image](https://user-images.githubusercontent.com/62876278/208087739-9831c5c1-56b2-49a6-8364-a61ce269ca40.png)


However, as a best practice, your organization's users should use a different account to authenticate. This way you can limit the permissions granted to the application and reduce the risks of malicious activity in case your application code is vulnerable to a SQL injection attack.

For example, you could reate an Azure Active Directory administrator account with full administrative permission and  one Azure Active Directory account could be configured as an administrator of the Azure SQL deployment with full administrative permissions. This account could be either an individual or security group account. An Azure AD administrator must be configured if you want to use Azure AD accounts to connect to the Database.
In SQL Database, you can create SQL logins with limited administrative permissions using the fixed roles to help you manage that.

To create a SQL Server Authenticated user, connect to the master database on your server with your server admin login and create a new server login. It's a good idea to also create a user in the master database. Creating a user in master allows a user to log in using tools like SSMS without specifying a database name. It also allows them to use the object explorer to view all databases on a server.
SQLCopy

```sql
-- Connect to master database and create a login
CREATE LOGIN ApplicationLogin WITH PASSWORD = 'Str0ng_password';
CREATE USER ApplicationUser FOR LOGIN ApplicationLogin;
```

Then, connect to your **dedicated SQL pool (formerly SQL DW)** with your server admin login and create a database user based on the server login you created.

SQLCopy

```sql
-- Connect to the database and create a database user
CREATE USER ApplicationUser FOR LOGIN ApplicationLogin;
```

#### Authorization

Authorization refers to what you can do within a database once you are authenticated and connected. Authorization privileges are determined by role memberships and permissions. As a best practice, you should grant users the least privileges necessary. To manage roles, you can use the following stored procedures:

SQLCopy

```sql
EXEC sp_addrolemember 'db_datareader', 'ApplicationUser'; -- allows ApplicationUser to read data
EXEC sp_addrolemember 'db_datawriter', 'ApplicationUser'; -- allows ApplicationUser to write data
```

The server admin account you are connecting with is a member of db_owner, which has authority to do anything within the database. Save this account for deploying schema upgrades and other management operations. Use the "ApplicationUser" account with more limited permissions to connect from your application to the database with the least privileges needed by your application.

There are ways to further limit what a user can do within the database:

The following example grants read access to a user-defined schema.

SQLCopy

```sql
--CREATE SCHEMA Test
GRANT SELECT ON SCHEMA::Test to ApplicationUser
```

Managing databases and servers from the Azure portal or using the Azure Resource Manager API is controlled by your portal user account's role assignments. For more information, see [Assign Azure roles using the Azure portal](https://learn.microsoft.com/en-us/azure/role-based-access-control/role-assignments-portal?toc=/azure/synapse-analytics/sql-data-warehouse/toc.json&bc=/azure/synapse-analytics/sql-data-warehouse/breadcrumb/toc.json).

#### Encryption

Transparent Data Encryption (TDE) helps protect against the threat of malicious activity by encrypting and decrypting your data at rest. When you encrypt your database, associated backups and transaction log files are encrypted without requiring any changes to your applications. TDE encrypts the storage of an entire database by using a symmetric key called the database encryption key.

In SQL Database, the database encryption key is protected by a built-in server certificate. The built-in server certificate is unique for each server. Microsoft automatically rotates these certificates at least every 90 days. The encryption algorithm used is AES-256. For a general description of TDE, see [Transparent Data Encryption](https://learn.microsoft.com/en-us/sql/relational-databases/security/encryption/transparent-data-encryption?toc=/azure/synapse-analytics/sql-data-warehouse/toc.json&bc=/azure/synapse-analytics/sql-data-warehouse/breadcrumb/toc.json&view=azure-sqldw-latest&preserve-view=true).

You can encrypt your database using the [Azure portal](https://learn.microsoft.com/en-us/azure/synapse-analytics/sql-data-warehouse/sql-data-warehouse-encryption-tde) or [T-SQL](https://learn.microsoft.com/en-us/azure/synapse-analytics/sql-data-warehouse/sql-data-warehouse-encryption-tde-tsql).

Follow these steps to enable TDE:

1. Connect to the *master* database on the server hosting the database using a login that is an administrator or a member of the **dbmanager** role in the master database
2. Execute the following statement to encrypt the database.

SQLCopy

```sql
ALTER DATABASE [AdventureWorks] SET ENCRYPTION ON;
```


### References
[IP firewall rules - Azure SQL Database and Azure Synapse Analytics | Microsoft Learn](https://learn.microsoft.com/en-us/azure/azure-sql/database/firewall-configure?toc=%2Fazure%2Fsynapse-analytics%2Fsql-data-warehouse%2Ftoc.json&bc=%2Fazure%2Fsynapse-analytics%2Fsql-data-warehouse%2Fbreadcrumb%2Ftoc.json&view=azuresql)

[Azure Synapse connectivity settings - Azure Synapse Analytics | Microsoft Learn](https://learn.microsoft.com/en-us/azure/synapse-analytics/security/connectivity-settings)

[Azure SQL Database connectivity architecture - Azure SQL Database and Azure Synapse Analytics | Microsoft Learn](https://learn.microsoft.com/en-us/azure/azure-sql/database/connectivity-architecture?view=azuresql#connection-policy)

[Managing databases and logins in Azure SQL Database](https://learn.microsoft.com/en-us/azure/azure-sql/database/logins-create-manage?toc=/azure/synapse-analytics/sql-data-warehouse/toc.json&bc=/azure/synapse-analytics/sql-data-warehouse/breadcrumb/toc.json). 

[Connecting by using Azure Active Directory Authentication](https://learn.microsoft.com/en-us/azure/synapse-analytics/sql-data-warehouse/sql-data-warehouse-authentication).

[sp_addrolemember (Transact-SQL) - SQL Server | Microsoft Learn](https://learn.microsoft.com/en-us/sql/relational-databases/system-stored-procedures/sp-addrolemember-transact-sql?view=sql-server-ver16#examples)

[Azure Active Directory authentication - Azure SQL Database | Microsoft Learn](https://learn.microsoft.com/en-us/azure/azure-sql/database/authentication-aad-overview?view=azuresql)

[Granular Permissions](https://learn.microsoft.com/en-us/sql/relational-databases/security/permissions-database-engine?toc=/azure/synapse-analytics/sql-data-warehouse/toc.json&bc=/azure/synapse-analytics/sql-data-warehouse/breadcrumb/toc.json&view=azure-sqldw-latest&preserve-view=true) 

[Database roles](https://learn.microsoft.com/en-us/sql/relational-databases/security/authentication-access/database-level-roles?toc=/azure/synapse-analytics/sql-data-warehouse/toc.json&bc=/azure/synapse-analytics/sql-data-warehouse/breadcrumb/toc.json&view=azure-sqldw-latest&preserve-view=true) 

[Stored procedures](https://learn.microsoft.com/en-us/sql/relational-databases/stored-procedures/stored-procedures-database-engine?toc=/azure/synapse-analytics/sql-data-warehouse/toc.json&bc=/azure/synapse-analytics/sql-data-warehouse/breadcrumb/toc.json&view=azure-sqldw-latest&preserve-view=true) 

[Transparent data encryption (T-SQL) - Azure Synapse Analytics | Microsoft Learn](https://learn.microsoft.com/en-us/azure/synapse-analytics/sql-data-warehouse/sql-data-warehouse-encryption-tde-tsql)

 [Connectivity](https://techcommunity.microsoft.com/t5/azure-synapse-analytics-blog/synapse-connectivity-series-part-1-inbound-sql-dw-connections-on/ba-p/3589170)
 
 [Gateway Region](https://learn.microsoft.com/en-us/azure/azure-sql/database/connectivity-architecture?view=azuresql#gateway-ip-addresses)
