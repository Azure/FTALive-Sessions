Microsoft Defender for SQL is a Defender plan in Microsoft Defender for Cloud. Microsoft Defender for SQL includes functionality for surfacing and mitigating potential database vulnerabilities, and detecting anomalous activities that could indicate a threat to your database. It provides a single go-to location for enabling and managing these capabilities.





 you can enable it at the resource level as described in [Enable Microsoft Defender for Azure SQL Database at the resource level](https://learn.microsoft.com/en-us/azure/azure-sql/database/azure-defender-for-sql?view=azuresql#enable-microsoft-defender-for-azure-sql-database-at-the-resource-level).

When you enable on the subscription level, all databases in Azure SQL Database and Azure SQL Managed Instance are protected. You can then disable them individually if you choose. If you want to manually manage which databases are protected, disable at the subscription level and enable each database that you want protected.

### Enable Microsoft Defender for Azure SQL Database at the subscription level in Microsoft Defender for Cloud

To enable Microsoft Defender for Azure SQL Database at the subscription level from within Microsoft Defender for Cloud:

1. From the [Azure portal](https://portal.azure.com/), open **Defender for Cloud**.

2. From Defender for Cloud's menu, select **Environment Settings**.

3. Select the relevant subscription.

4. Change the plan setting to **On**.

   ![Enabling Microsoft Defender for Azure SQL Database at the subscription level.](https://learn.microsoft.com/en-us/azure/azure-sql/database/media/azure-defender-for-sql/enable-azure-defender-sql-subscription-level.png?view=azuresql)

5. Select **Save**.

### Enable Microsoft Defender plans programatically

The flexibility of Azure allows for a number of programmatic methods for enabling Microsoft Defender plans.

Use any of the following tools to enable Microsoft Defender for your subscription:

| Method       | Instructions                                                 |
| :----------- | :----------------------------------------------------------- |
| REST API     | [Pricings API](https://learn.microsoft.com/en-us/rest/api/securitycenter/pricings) |
| Azure CLI    | [az security pricing](https://learn.microsoft.com/en-us/cli/azure/security/pricing) |
| PowerShell   | [Set-AzSecurityPricing](https://learn.microsoft.com/en-us/powershell/module/az.security/set-azsecuritypricing) |
| Azure Policy | [Bundle Pricings](https://github.com/Azure/Azure-Security-Center/blob/master/Pricing %26 Settings/ARM Templates/Set-ASC-Bundle-Pricing.json) |

### Enable Microsoft Defender for Azure SQL Database at the resource level

We recommend enabling Microsoft Defender plans at the subscription level so that new resources are automatically protected. However, if you have an organizational reason to enable Microsoft Defender for Cloud at the server level, use the following steps:

1. From the [Azure portal](https://portal.azure.com/), open your server or managed instance.

2. Under the **Security** heading, select **Defender for Cloud**.

3. Select **Enable Microsoft Defender for SQL**.

   ![Enable Microsoft Defender for SQL from within Azure SQL databases.](https://learn.microsoft.com/en-us/azure/azure-sql/database/media/azure-defender-for-sql/enable-azure-defender.png?view=azuresql)

## Manage Microsoft Defender for SQL settings

To view and manage Microsoft Defender for SQL settings:

1. From the **Security** area of your server or managed instance, select **Defender for Cloud**.

   On this page, you'll see the status of Microsoft Defender for SQL:

   ![Checking the status of Microsoft Defender for SQL inside Azure SQL databases.](https://learn.microsoft.com/en-us/azure/azure-sql/database/media/azure-defender-for-sql/status-of-defender-for-sql.png?view=azuresql)

2. If Microsoft Defender for SQL is enabled, you'll see a **Configure** link as shown in the previous graphic. To edit the settings for Microsoft Defender for SQL, select **Configure**.

   ![Settings for Microsoft Defender for SQL.](https://learn.microsoft.com/en-us/azure/azure-sql/database/media/azure-defender-for-sql/security-server-settings.png?view=azuresql)

3. Make the necessary changes and select **Save**.