## Storage

[<Back](https://github.com/LiliamLeme/FTALive-Sessions_Synapse_SQL/blob/main/content/data/Synapse_SQL/Building_on_top_Datalake/Data%20Lake%2C%20Delta%20and%20Lakehouse.md)\- [Next >](https://github.com/LiliamLeme/FTALive-Sessions_Synapse_SQL/blob/main/content/data/Synapse_SQL/Building_on_top_Datalake/Workspace.md)

#### Security overview

This session is an overview of some security recommendations for Blob storage. Implementing these recommendations will help you fulfill your security obligations , you can find more information on Microsoft Docs on the references at the end of this file.


| Recommendation                                             | Comments                                                     | Defender for Cloud                                           |
| :--------------------------------------------------------- | :----------------------------------------------------------- | :----------------------------------------------------------- |
| Use the Azure Resource Manager deployment model            | Create new storage accounts using the Azure Resource Manager deployment model for important security enhancements, including superior Azure role-based access control (Azure RBAC) and auditing, Resource Manager-based deployment and governance, access to managed identities, access to Azure Key Vault for secrets, and Azure AD-based authentication and authorization for access to Azure Storage data and resources. If possible, migrate existing storage accounts that use the classic deployment model to use Azure Resource Manager. For more information about Azure Resource Manager, see [Azure Resource Manager overview](https://learn.microsoft.com/en-us/azure/azure-resource-manager/management/overview). | -                                                            |
| Enable Microsoft Defender for all of your storage accounts | Microsoft Defender for Storage provides an additional layer of security intelligence that detects unusual and potentially harmful attempts to access or exploit storage accounts. Security alerts are triggered in Microsoft Defender for Cloud when anomalies in activity occur and are also sent via email to subscription administrators, with details of suspicious activity and recommendations on how to investigate and remediate threats. For more information, see [Configure Microsoft Defender for Storage](https://learn.microsoft.com/en-us/azure/storage/common/azure-defender-storage-configure). | [Yes](https://learn.microsoft.com/en-us/azure/defender-for-cloud/implement-security-recommendations) |
| Turn on soft delete for blobs                              | Soft delete for blobs enables you to recover blob data after it has been deleted. For more information on soft delete for blobs, see [Soft delete for Azure Storage blobs](https://learn.microsoft.com/en-us/azure/storage/blobs/soft-delete-blob-overview). | -                                                            |
| Turn on soft delete for containers                         | Soft delete for containers enables you to recover a container after it has been deleted. For more information on soft delete for containers, see [Soft delete for containers](https://learn.microsoft.com/en-us/azure/storage/blobs/soft-delete-container-overview). |      
| Configure the minimum required version of Transport Layer Security (TLS) for a storage account. | Require that clients use a more secure version of TLS to make requests against an Azure Storage account by configuring the minimum version of TLS for that account. For more information, see [Configure minimum required version of Transport Layer Security (TLS) for a storage account](https://learn.microsoft.com/en-us/azure/storage/common/transport-layer-security-configure-minimum-version?toc=/azure/storage/blobs/toc.json) | -                                                            |
| Enable the **Secure transfer required** option on all of your storage accounts | When you enable the **Secure transfer required** option, all requests made against the storage account must take place over secure connections. Any requests made over HTTP will fail. For more information, see [Require secure transfer in Azure Storage](https://learn.microsoft.com/en-us/azure/storage/common/storage-require-secure-transfer?toc=/azure/storage/blobs/toc.json). | [Yes](https://learn.microsoft.com/en-us/azure/defender-for-cloud/implement-security-recommendations) |
| Enable firewall rules                                        | Configure firewall rules to limit access to your storage account to requests that originate from specified IP addresses or ranges, or from a list of subnets in an Azure Virtual Network (VNet). For more information about configuring firewall rules, see [Configure Azure Storage firewalls and virtual networks](https://learn.microsoft.com/en-us/azure/storage/common/storage-network-security?toc=/azure/storage/blobs/toc.json). | -                                                            |
| Allow trusted Microsoft services to access the storage account | Turning on firewall rules for your storage account blocks incoming requests for data by default, unless the requests originate from a service operating within an Azure Virtual Network (VNet) or from allowed public IP addresses. Requests that are blocked include those from other Azure services, from the Azure portal, from logging and metrics services, and so on. You can permit requests from other Azure services by adding an exception to allow trusted Microsoft services to access the storage account. For more information about adding an exception for trusted Microsoft services, see [Configure Azure Storage firewalls and virtual networks](https://learn.microsoft.com/en-us/azure/storage/common/storage-network-security?toc=/azure/storage/blobs/toc.json). | -                                                            |

**Note**:

> Storage accounts have a public endpoint that is accessible through the internet. You can also create [Private Endpoints for your storage account](https://docs.microsoft.com/en-us/azure/storage/common/storage-private-endpoints), which assigns a private IP address from your VNet to the storage account, and secures all traffic between your VNet and the storage account over a private link.
>
> if managed VNET is not in use on the workspace and the connection through spark goes to the storage that has firewall it will fail with 403 unless the storage is configured to use public internet.



#### **Considerations to the design of the Storage Account**

1. What am I storing in my data lake?
2. How much data am I storing in the data lake?
3. What portion of your data do you run your analytics workloads on?
4. Who needs access to what parts of my data lake?
5. What are the various analytics workloads that I’m going to run on my data lake?
6. What are the various transaction patterns on the analytics workloads?
7. Which team will manage the     data security?
8. Why your design approach with one storage     account and think about reasons why you need multiple storage accounts?
9. Considerations for lifecycle?     [Optimize costs by      automatically managing the data lifecycle - Azure Storage | Microsoft      Learn](https://learn.microsoft.com/en-us/azure/storage/blobs/lifecycle-management-overview?tabs=azure-portal)



​     ref: [adlsguidancedoc/Hitchhikers_Guide_to_the_Datalake.md at master · rukmani-msft/adlsguidancedoc (github.com)](https://github.com/rukmani-msft/adlsguidancedoc/blob/master/Hitchhikers_Guide_to_the_Datalake.md)





#### Data standardization

Data arrives in data lake accounts in various formats. These formats include human readable formats, such as JSON, .CSV, or XML files, and compressed binary formats, such as .tar or .gz. Arriving data also comes in many sizes, from a few edited files to an export of an entire SQL table. Data can also come as a large number of small files that are a few kbs apiece, such as real-time events from an IoT solution.

While Azure Data Lake Storage Gen2 does support storage for all kinds of data without restrictions, you should carefully consider your data formats to ensure processing pipeline efficiency and optimize costs.

Many organizations now standardize their ingest format and separate compute from storage. Because of this, the Delta Lake format has become the preferred standard for data ingestion through to the enrichment layer. From the enrichment layer, your data application team can serve data into a format that reflects their use case.

##### Delta Lake

Delta Lake is an open-source storage layer that brings ACID (atomicity, consistency, isolation, and durability) transactions to big data workloads and Apache Spark. Both Azure Synapse Analytics and Azure Databricks are compatible with Linux Foundation Delta Lake.



#### Number of Storage accounts

When deciding the number of storage accounts you want to create, the following considerations are helpful in deciding the number of storage accounts you want to provision.

- A single storage account gives you the ability to manage a single set of control plane management operations such as RBACs, firewall settings, data lifecycle management policies for all the data in your storage account, while allowing you to organize your data using containers, files and folders on the storage account. If you want to optimize for ease of management, specially if you adopt a centralized data lake strategy, this would be a good model to consider.



- Multiple storage accounts provide you the ability to isolate data across different accounts so different management policies can be applied to them or manage their billing/cost logic separately. If you are considering a federated data lake strategy with each organization or business unit having their own set of manageability requirements, then this model might work best for you.

in Summary consider the following key aspects, as an example:

**Key aspect:**
- Isolate security Storage configuration and permission. 
- Data isolate per Domain requiring data governance per team
- Permissions for only people that require access to that domains on Storage Account Level
- Storage account in different subscriptions per domain
- Different network settings per Storage account if there are different requirements.( data lake external and internal for example)
- If the data has a requirement to be isolated per region and data can't leave that region

#### Design

| Cloud-scale analytics | Delta Lake | Other terms             | Description                                                  |
| :-------------------- | :--------- | :---------------------- | :----------------------------------------------------------- |
| Raw                   | Bronze     | Landing and Conformance | Ingestion Tables                                             |
| Enriched              | Silver     | Standardization Zone    | Refined Tables. Stored full entity, consumption-ready recordsets from systems of record. |
| Curated               | Gold       | Product Zone            | Feature or aggregated tables. Primary zone for applications, teams, and users to consume data products. |
| Development           | --         | Development Zone        | Location for data engineers and scientists, comprising both an analytics sandbox and a product development zone. |
  


#### Raw layer or data lake one

Think of the raw layer as a reservoir that stores data in its natural and original state. It's unfiltered and unpurified. You might choose to store the data in its original format, such as JSON or CSV, but you might also encounter scenarios where it's more cost effective to store the file contents as a column in a compressed file format like Avro, Parquet, or Databricks Delta Lake.



When you load data from source systems into the raw zone, you can choose to do either:

- **Full loads**, where you extract a full data set
- **Delta loads**, where you load only changed data



We define full loads and delta loads as:

- Full load:
  - Complete data from source can be onboarded in the following scenarios.
    - Data volume at source is small.
    - The source system doesn't maintain any timestamp field that identifies if data has been added, updated or deleted.
    - The source system overwrites the complete data each time.
- Delta load:
  - Incremental data from source can be onboarded in the following scenarios.
    - Data volume at source is large.
    - The source system maintains a timestamp field that identifies if data has been added/updated or deleted
    - The source system creates and updates files on data changes.

#### Enriched layer or data lake two

Think of the enriched layer as a filtration layer. It removes impurities and can also involve enrichment.

Your standardization container holds systems of record and masters. Folders are segmented first by subject area, then by entity. Data is available in merged, partitioned tables optimized for analytics consumption.

This data layer is considered the silver layer or read data source. Data within it has had no transformations applied other than data quality, delta lake conversion, and data type alignment.

The following diagram shows the flow of data lakes and containers from source data to a standardized container.

[![High level data flow](https://learn.microsoft.com/en-us/azure/cloud-adoption-framework/scenarios/cloud-scale-analytics/media/data-flow-high-level.png)](https://learn.microsoft.com/en-us/azure/cloud-adoption-framework/scenarios/cloud-scale-analytics/media/data-flow-high-level.png#lightbox)



#### Curated layer or data lake two

Your curated layer is your consumption layer. It's optimized for analytics, rather than data ingestion or processing. The curated layer might store data in de-normalized data marts or star schemas.

Data is taken from your standardized container and transformed into high-value data products that are served to your data consumers. This data has structure, and can be served to the consumers either as-is (such as data science notebooks) or through another read data store (such as Azure SQL Database).

Use tools like Spark or Data Factory to do dimensional modeling instead of doing it inside your database engine. This use of tools becomes a key point if you want to make your lake the single source of truth.

If you do dimensional modeling outside of your lake, you might want to publish models back to your lake for consistency. Don't view this layer as a replacement for a data warehouse. Its performance typically isn't adequate for responsive dashboards or end-user and consumer interactive analytics. This layer is best suited for internal analysts and data scientists who run large-scale improvised queries, analysis, or for advanced analysts who don't have strict time-sensitive reporting needs. Since storage costs are lower in your data lake than your data warehouse, it can be more cost effective to keep granular, low-level data in your lake and store only aggregated data in your warehouse. You can generate these aggregations using Spark or Azure Data Factory, and persist them to your data lake before loading them into your data warehouse.



#### Development layer or data lake three

Your data consumers can bring other useful data products along with the data ingested into your standardized container.

In this scenario, your data platform should allocate an analytics sandbox area for these consumers. There, they can generate valuable insights using the curated data and data products they bring. For example, if a data science team wants to determine the best product placement strategy for a new region, they can bring other data products like customer demographics and usage data from similar products from that region. They team can use the high-value sales insights from this data to analyze the product market fit and offering strategy.





#### Reference

[Configure Azure Storage firewalls and virtual networks | Microsoft Learn](https://learn.microsoft.com/en-us/azure/storage/common/storage-network-security?tabs=azure-portal)

[Key considerations for Azure Data Lake Storage - Cloud Adoption Framework | Microsoft Learn](https://learn.microsoft.com/en-us/azure/cloud-adoption-framework/scenarios/cloud-scale-analytics/best-practices/data-lake-key-considerations?source=recommendations)

[Best practices for using Azure Data Lake Storage Gen2 - Azure Storage | Microsoft Learn](https://learn.microsoft.com/en-us/azure/storage/blobs/data-lake-storage-best-practices#directory-layout-considerations)

[Data landing zones - Cloud Adoption Framework | Microsoft Learn](https://learn.microsoft.com/en-us/azure/cloud-adoption-framework/scenarios/cloud-scale-analytics/architectures/data-landing-zone#data-lake-services)

[Data standardization - Cloud Adoption Framework | Microsoft Learn](https://learn.microsoft.com/en-us/azure/cloud-adoption-framework/scenarios/cloud-scale-analytics/architectures/data-standardization)

[Data lake zones and containers - Cloud Adoption Framework | Microsoft Learn](https://learn.microsoft.com/en-us/azure/cloud-adoption-framework/scenarios/cloud-scale-analytics/best-practices/data-lake-zones)

[Data lake zones and containers - Cloud Adoption Framework | Microsoft Learn](https://learn.microsoft.com/en-us/azure/cloud-adoption-framework/scenarios/cloud-scale-analytics/best-practices/data-lake-zones)

[Security recommendations for Blob storage - Azure Storage | Microsoft Learn](https://learn.microsoft.com/en-us/azure/storage/blobs/security-recommendations)

[adlsguidancedoc/Hitchhikers_Guide_to_the_Datalake.md at master · rukmani-msft/adlsguidancedoc (github.com)](https://github.com/rukmani-msft/adlsguidancedoc/blob/master/Hitchhikers_Guide_to_the_Datalake.md)

[Data governance overview - Cloud Adoption Framework | Microsoft Learn](https://learn.microsoft.com/en-us/azure/cloud-adoption-framework/scenarios/cloud-scale-analytics/govern)

https://docs.microsoft.com/en-us/azure/synapse-analytics/spark/apache-spark-delta-lake-overview?pivots=programming-language-python#read-older-versions-of-data-using-time-travel


[Data, Delta and Lakehouse](https://techcommunity.microsoft.com/t5/azure-synapse-analytics-blog/synapse-data-lake-vs-delta-lake-vs-data-lakehouse/ba-p/3673653)

[Essential tips for exporting and cleaning data with Spark](https://techcommunity.microsoft.com/t5/azure-synapse-analytics-blog/essential-tips-for-exporting-and-cleaning-data-with-spark/ba-p/3779583)
