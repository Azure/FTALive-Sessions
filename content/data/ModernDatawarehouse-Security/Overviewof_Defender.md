## Defender Overview

#### Security

[<Back]()\- [Next >]()

Microsoft Defender for SQL is a Defender plan in Microsoft Defender for Cloud. Microsoft Defender for SQL includes functionality for surfacing and mitigating potential database vulnerabilities, and detecting anomalous activities that could indicate a threat to your database. It provides a single go-to location for enabling and managing these capabilities. you can enable it at the resource level as described in [Enable Microsoft Defender for Azure SQL Database at the resource level](https://learn.microsoft.com/en-us/azure/azure-sql/database/azure-defender-for-sql?view=azuresql#enable-microsoft-defender-for-azure-sql-database-at-the-resource-level).

When you enable on the subscription level, all databases in Azure SQL Database and Azure SQL Managed Instance are protected. You can then disable them individually if you choose. If you want to manually manage which databases are protected, disable at the subscription level and enable each database that you want protected.

| Aspect                  | Details                                                      |
| :---------------------- | :----------------------------------------------------------- |
| Release state:          | Generally available (GA)                                     |
| Pricing:                | **Microsoft Defender for Azure SQL** is billed as shown on the [pricing page](https://azure.microsoft.com/pricing/details/defender-for-cloud/) |
| Protected SQL versions: | Read-write replicas of: - Azure SQL [single databases](https://learn.microsoft.com/en-us/azure/azure-sql/database/single-database-overview) and [elastic pools](https://learn.microsoft.com/en-us/azure/azure-sql/database/elastic-pool-overview) - [Azure SQL Managed Instance](https://learn.microsoft.com/en-us/azure/azure-sql/managed-instance/sql-managed-instance-paas-overview) - [Azure Synapse Analytics (formerly SQL DW) dedicated SQL pool](https://learn.microsoft.com/en-us/azure/synapse-analytics/sql-data-warehouse/sql-data-warehouse-overview-what-is) |

Threat intelligence enriched security alerts are triggered when there's:

- **Potential SQL injection attacks** - including vulnerabilities detected when applications generate a faulty SQL statement in the database
- **Anomalous database access and query patterns** - for example, an abnormally high number of failed sign-in attempts with different credentials (a brute force attempt)
- **Suspicious database activity** - for example, a legitimate user accessing an SQL Server from a breached computer which communicated with a crypto-mining C&C server
- 

### Enable Microsoft Defender for Azure SQL Database at the subscription level in Microsoft Defender for Cloud

To enable Microsoft Defender for Azure SQL Database at the subscription level from within Microsoft Defender for Cloud:

1. From the [Azure portal](https://portal.azure.com/), open **Defender for Cloud**.

2. From Defender for Cloud's menu, select **Environment Settings**.

3. Select the relevant subscription.

4. Change the plan setting to **On**.

   

   




https://learn.microsoft.com/en-us/azure/defender-for-cloud/defender-for-sql-introduction

https://learn.microsoft.com/en-us/azure/azure-sql/database/threat-detection-overview?view=azuresql