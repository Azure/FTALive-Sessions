## Spark and Data factory


### Overview

[<Back](https://github.com/LiliamLeme/FTALive-Sessions_Synapse_SQL/blob/main/content/data/ModernDatawarehouse-Security/Serveless%20SQL%20Pool.md)\- [Next >](https://github.com/LiliamLeme/FTALive-Sessions_Synapse_SQL/blob/main/content/data/ModernDatawarehouse-Security/ADLS%20Security)
### Spark

Spark inside of Synapse can only be access for the users that have permission for that configured on the Synapse Studio.

Spark pools operate as a job cluster. It means each user gets their own Spark cluster when interacting with the workspace. Creating an Spark pool within the workspace is metadata information for what will be assigned to the user when executing Spark workloads. It means each user will get their own Spark cluster *in a dedicated subnet inside the Managed VNet* to execute workloads. Spark pool sessions from the same user execute on the same compute resources. By providing this functionality, there are three main benefits:

- Greater security due to workload isolation based on the user.
- Reduction of noisy neighbors.
- Greater performance.

**Note:** if managed VNET  is not in use on the workspace and the connection through spark goes to the storage that has firewall it will fail with 403 unless the storage is configured to use public internet.

Accessing data from external sources is a common pattern. Unless the external data source allows anonymous access, chances are you need to secure your connection with a credential, secret, or connection string. Synapse uses Azure Active Directory (Azure AD) passthrough by default for authentication between resources on Spark. The TokenLibrary simplifies the process of retrieving SAS tokens, Azure AD tokens, connection strings, and secrets stored in a linked service or from an Azure Key Vault.

Synapse allows users to set the linked service for a particular storage account. This makes it possible to read/write data from **multiple storage accounts** in a single spark application/query. Once we set **spark.storage.synapse.{source_full_storage_account_name}.linkedServiceName** for each storage account that will be used, Synapse figures out which linked service to use for a particular read/write operation. However if our spark job only deals with a single storage account, we can simply omit the storage account name and use **spark.storage.synapse.linkedServiceName**

PythonCopy

```python
%%pyspark
# Python code
source_full_storage_account_name = "teststorage.dfs.core.windows.net"
spark.conf.set(f"spark.storage.synapse.{source_full_storage_account_name}.linkedServiceName", "<lINKED SERVICE NAME>")
spark.conf.set(f"fs.azure.account.auth.type.{source_full_storage_account_name}", "SAS")
spark.conf.set(f"fs.azure.sas.token.provider.type.{source_full_storage_account_name}", "com.microsoft.azure.synapse.tokenlibrary.LinkedServiceBasedSASProvider")

df = spark.read.csv('abfss://<CONTAINER>@<ACCOUNT>.dfs.core.windows.net/<DIRECTORY PATH>')

df.show()
```
### Data Factory

Data Factory management resources are built on Azure security infrastructure and use all possible security measures offered by Azure.

In a Data Factory solution, you create one or more data [pipelines](https://learn.microsoft.com/en-us/azure/data-factory/concepts-pipelines-activities). A pipeline is a logical grouping of activities that together perform a task. These pipelines reside in the region where the data factory was created.

Azure Data Factory including Azure Integration Runtime and Self-hosted Integration Runtime does not store any temporary data, cache data or logs except for linked service credentials for cloud data stores, which are encrypted by using certificates.

Data Factory has been certified for:

| **[CSA STAR Certification](https://www.microsoft.com/trustcenter/compliance/csa-star-certification)** |
| :----------------------------------------------------------- |
| **[ISO 20000-1:2011](https://www.microsoft.com/trustcenter/Compliance/ISO-20000-1)** |
| **[ISO 22301:2012](https://learn.microsoft.com/en-us/compliance/regulatory/offering-iso-22301)** |
| **[ISO 27001:2013](https://www.microsoft.com/trustcenter/compliance/iso-iec-27001)** |
| **[ISO 27017:2015](https://www.microsoft.com/trustcenter/compliance/iso-iec-27017)** |
| **[ISO 27018:2014](https://www.microsoft.com/trustcenter/compliance/iso-iec-27018)** |
| **[ISO 9001:2015](https://www.microsoft.com/trustcenter/compliance/iso-9001)** |
| **[SOC 1, 2, 3](https://www.microsoft.com/trustcenter/compliance/soc)** |
| **[HIPAA BAA](https://learn.microsoft.com/en-us/compliance/regulatory/offering-hipaa-hitech)** |
| **[HITRUST](https://learn.microsoft.com/en-us/compliance/regulatory/offering-hitrust)** |

**Store encrypted credentials in an Azure Data Factory managed store**. Data Factory helps protect your data store credentials by encrypting them with certificates managed by Microsoft. These certificates are rotated every two years (which includes certificate renewal and the migration of credentials). For more information about Azure Storage security, see [Azure Storage security overview](https://learn.microsoft.com/en-us/azure/storage/blobs/security-recommendations).

**Store credentials in Azure Key Vault**. You can also store the data store's credential in [Azure Key Vault](https://azure.microsoft.com/services/key-vault/). Data Factory retrieves the credential during the execution of an activity. For more information, see [Store credential in Azure Key Vault](https://learn.microsoft.com/en-us/azure/data-factory/store-credentials-in-key-vault).

**If the cloud data store supports HTTPS or TLS**, all data transfers between data movement services in Data Factory and a cloud data store are via secure channel HTTPS or TLS.

**The self-hosted integration runtime makes HTTP-based connections to access the internet**. The outbound ports 443 must be opened for the self-hosted integration runtime to make this connection. Open inbound port 8060 only at the machine level (not the corporate firewall level) for credential manager application. If Azure SQL Database or Azure Synapse Analytics is used as the source or the destination, you need to open port 1433 as well.

Note: By default, when remote access from intranet is enabled, PowerShell uses port 8060 on the machine with self-hosted integration runtime for secure communication. If necessary, this port can be changed from the Integration Runtime Configuration Manager.



#### Reference

[Security considerations - Azure Data Factory | Microsoft Learn](https://learn.microsoft.com/en-us/azure/data-factory/data-movement-security-considerations)

[Azure Synapse Analytics security white paper: Network security - Azure Synapse Analytics | Microsoft Learn](https://learn.microsoft.com/en-us/azure/synapse-analytics/guidance/security-white-paper-network-security)

[Azure Integration Runtime IP addresses - Azure Data Factory | Microsoft Learn](https://learn.microsoft.com/en-us/azure/data-factory/azure-integration-runtime-ip-addresses)

[Data Factory is now a 'Trusted Service' in Azure Storage and Azure Key Vault firewall - Microsoft Community Hub](https://techcommunity.microsoft.com/t5/azure-data-factory-blog/data-factory-is-now-a-trusted-service-in-azure-storage-and-azure/ba-p/964993)

[Secure access credentials with Linked Services in Apache Spark for Azure Synapse Analytics - Azure Synapse Analytics | Microsoft Learn](https://learn.microsoft.com/en-us/azure/synapse-analytics/spark/apache-spark-secure-credentials-with-tokenlibrary?pivots=programming-language-python)

[Synapse Spark - Encryption, Decryption and Data Masking - Microsoft Community Hub](https://techcommunity.microsoft.com/t5/azure-synapse-analytics-blog/synapse-spark-encryption-decryption-and-data-masking/ba-p/3615094)


[Using the workspace MSI to authenticate a Synapse notebook when accessing an Azure Storage account - Microsoft Community Hub](https://techcommunity.microsoft.com/t5/azure-synapse-analytics-blog/using-the-workspace-msi-to-authenticate-a-synapse-notebook-when/ba-p/2330029)

[Secure access credentials with Linked Services in Apache Spark for Azure Synapse Analytics - Azure Synapse Analytics | Microsoft Learn](https://learn.microsoft.com/en-us/azure/synapse-analytics/spark/apache-spark-secure-credentials-with-tokenlibrary?pivots=programming-language-scala#adls-gen2-storage-with-linked-services)
