
[Home](https://github.com/LiliamLeme/FTALive-Sessions_Synapse_SQL/edit/main/content/data/ModernDatawarehouse-Security/Agenda.md)\- [>Next](https://github.com/LiliamLeme/FTALive-Sessions_Synapse_SQL/blob/main/content/data/ModernDatawarehouse-Security/MDW.md)


# Modern Data warehouse end to end security


**Presenters - FTA engineers**

      Kathryn Varral
      Liliam Leme
      Matteo T


## Agenda

Welcome and introductions

What is a Modern Datawarehouse?

Security overview and considerations

Storage - Securing Azure Data Lake

Security  Overview

Synapse security configuration

Synapse Analytics

      Workspace  
      
            Synapse Workspace - VNET, DEP and Private Endpoints, RBACs
            
            Least Privilege Rule
            
      Dedicated SQL Pools
      
            Data Masking
            
            Row level Security
            
            Columns Level Security
            
            Defender
            
      Serveless SQL Pools
      
            Permissions: Scoped or SQL user
            
      Spark
      
            MSI\AAD Passthrough
      

 Securing Azure Data Factory

 Securing Power BI

 Summary - Putting it all together 
 
 Q&A

**Audience**

IT Pros or architects that want to understand the options to enforce the security in a Modern Datwarehouse

**References:**

[Securing your Synapse environment](https://techcommunity.microsoft.com/t5/azure-synapse-analytics-blog/securing-your-synapse-environment/ba-p/3725524)

[Row-level security in serverless Synapse SQL pools (microsoft.com)](https://techcommunity.microsoft.com/t5/azure-synapse-analytics-blog/how-to-implement-row-level-security-in-serverless-sql-pools/ba-p/2354759#:~:text=Row-level)

[Serverless SQL pool - Azure Synapse Analytics | Microsoft Learn](https://learn.microsoft.com/en-us/azure/synapse-analytics/sql/on-demand-workspace-overview)

[Permissions (Database Engine) - SQL Server | Microsoft Learn](https://learn.microsoft.com/en-us/sql/relational-databases/security/permissions-database-engine?view=sql-server-ver16)

[Control storage account access for serverless SQL pool - Azure Synapse Analytics | Microsoft Learn](https://learn.microsoft.com/en-us/azure/synapse-analytics/sql/develop-storage-files-storage-access-control?tabs=user-identity)

[Security considerations - Azure Data Factory | Microsoft Learn](https://learn.microsoft.com/en-us/azure/data-factory/data-movement-security-considerations)

[Azure Synapse Analytics security white paper: Network security - Azure Synapse Analytics | Microsoft Learn](https://learn.microsoft.com/en-us/azure/synapse-analytics/guidance/security-white-paper-network-security)

[Azure Integration Runtime IP addresses - Azure Data Factory | Microsoft Learn](https://learn.microsoft.com/en-us/azure/data-factory/azure-integration-runtime-ip-addresses)

[Data Factory is now a 'Trusted Service' in Azure Storage and Azure Key Vault firewall - Microsoft Community Hub](https://techcommunity.microsoft.com/t5/azure-data-factory-blog/data-factory-is-now-a-trusted-service-in-azure-storage-and-azure/ba-p/964993)

[Secure access credentials with Linked Services in Apache Spark for Azure Synapse Analytics - Azure Synapse Analytics | Microsoft Learn](https://learn.microsoft.com/en-us/azure/synapse-analytics/spark/apache-spark-secure-credentials-with-tokenlibrary?pivots=programming-language-python)

[Synapse Spark - Encryption, Decryption and Data Masking - Microsoft Community Hub](https://techcommunity.microsoft.com/t5/azure-synapse-analytics-blog/synapse-spark-encryption-decryption-and-data-masking/ba-p/3615094)

[Using the workspace MSI to authenticate a Synapse notebook when accessing an Azure Storage account - Microsoft Community Hub](https://techcommunity.microsoft.com/t5/azure-synapse-analytics-blog/using-the-workspace-msi-to-authenticate-a-synapse-notebook-when/ba-p/2330029)

[Secure access credentials with Linked Services in Apache Spark for Azure Synapse Analytics - Azure Synapse Analytics | Microsoft Learn](https://learn.microsoft.com/en-us/azure/synapse-analytics/spark/apache-spark-secure-credentials-with-tokenlibrary?pivots=programming-language-scala#adls-gen2-storage-with-linked-services)

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

[Transparent data encryption (T-SQL)](https://learn.microsoft.com/en-us/sql/relational-databases/security/encryption/transparent-data-encryption?toc=%2Fazure%2Fsynapse-analytics%2Fsql-data-warehouse%2Ftoc.json&bc=%2Fazure%2Fsynapse-analytics%2Fsql-data-warehouse%2Fbreadcrumb%2Ftoc.json&view=azure-sqldw-latest&preserve-view=true)

[Inconsistent permissions or ownership chaining - Microsoft Community Hub](https://techcommunity.microsoft.com/t5/azure-synapse-analytics-blog/inconsistent-permissions-or-ownership-chaining/ba-p/1552690)

[Dynamic Data Masking - SQL Server | Microsoft Learn](https://learn.microsoft.com/en-us/sql/relational-databases/security/dynamic-data-masking?view=sql-server-ver16)

[Dynamic data masking - Azure SQL Database | Microsoft Learn](https://learn.microsoft.com/en-us/azure/azure-sql/database/dynamic-data-masking-overview?view=azuresql)

[Azure Synapse Analytics security white paper: Access control - Azure Synapse Analytics | Microsoft Learn](https://learn.microsoft.com/en-us/azure/synapse-analytics/guidance/security-white-paper-access-control)

[Column-level security for dedicated SQL pool - Azure Synapse Analytics | Microsoft Learn](https://learn.microsoft.com/en-us/azure/synapse-analytics/sql-data-warehouse/column-level-security)

[Row-Level Security - SQL Server | Microsoft Learn](https://learn.microsoft.com/en-us/sql/relational-databases/security/row-level-security?view=azure-sqldw-latest&preserve-view=true)

[Managed virtual network - Azure Synapse Analytics | Microsoft Learn](https://learn.microsoft.com/en-us/azure/synapse-analytics/security/synapse-workspace-managed-vnet)

[What is a private endpoint? - Azure Private Link | Microsoft Learn](https://learn.microsoft.com/en-us/azure/private-link/private-endpoint-overview)

[Configure IP firewall rules - Azure Synapse Analytics | Microsoft Learn](https://learn.microsoft.com/en-us/azure/synapse-analytics/security/synapse-workspace-ip-firewall)


[Connect to a secure storage account from your Azure Synapse workspace - Azure Synapse Analytics | Microsoft Learn](https://learn.microsoft.com/en-us/azure/synapse-analytics/security/connect-to-a-secure-storage-account)

[(428) Synapse Security Deep Dive: Outbound Network Security - YouTube](https://www.youtube.com/watch?v=vwScocYyeyk)

[Create a workspace with data exfiltration protection enabled - Azure Synapse Analytics | Microsoft Learn](https://learn.microsoft.com/en-us/azure/synapse-analytics/security/how-to-create-a-workspace-with-data-exfiltration-protection)


[How Data Exfiltration Protection (DEP) impacts Azure Synapse Analytics Pipelines - Microsoft Community Hub](https://techcommunity.microsoft.com/t5/azure-synapse-analytics-blog/how-data-exfiltration-protection-dep-impacts-azure-synapse/ba-p/3676146)

[Grant permissions to managed identity in Synapse workspace - Azure Synapse Analytics | Microsoft Learn](https://learn.microsoft.com/en-us/azure/synapse-analytics/security/how-to-grant-workspace-managed-identity-permissions)

[Managed identities for Azure resources - Microsoft Entra | Microsoft Learn](https://learn.microsoft.com/en-us/azure/active-directory/managed-identities-azure-resources/overview)

[Gateway Region](https://learn.microsoft.com/en-us/azure/azure-sql/database/connectivity-architecture?view=azuresql#gateway-ip-addresses)

[Synapse Connectivity Series Part #1 - Inbound SQL DW connections on Public Endpoints - Microsoft Community Hub](https://techcommunity.microsoft.com/t5/azure-synapse-analytics-blog/synapse-connectivity-series-part-1-inbound-sql-dw-connections-on/ba-p/3589170)
        
[Connect to workspace resources in Azure Synapse Analytics Studio from a restricted network - Azure Synapse Analytics | Microsoft Learn](https://learn.microsoft.com/en-us/azure/synapse-analytics/security/how-to-connect-to-workspace-from-restricted-network)
        

[Connect to a Synapse Studio using private links - Azure Synapse Analytics | Microsoft Learn](https://learn.microsoft.com/en-us/azure/synapse-analytics/security/synapse-private-link-hubs)



### Let's start:

 [Next >](https://github.com/LiliamLeme/FTALive-Sessions_Synapse_SQL/blob/main/content/data/ModernDatawarehouse-Security/MDW.md)


