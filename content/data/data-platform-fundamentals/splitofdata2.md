# Split of Data (Part 2)

[prev](./splitofdata1.md.md) | [home](./introduction.md)  | [next](./splitofdata3.md)

This is in continuation for database scenarios which help narrow down storage options for data solutions.

## Analytical Data
As more businesses move to digital processes, they increasingly recognize the value of being able to respond to opportunities by making faster and well-informed decisions. Models discussed in Part 1 still have architectural challenges, including:

* Difficult to run advanced analytics on near-real-time data (streaming, social media data, IOT data, etc).
* Need to cleanse the data before using it for aggregation.

With the boom of Big Data, often defined by the "three V's" (Data arriving in **V**olume, **V**aried Types and with high **V**elocity) there was a need to  transition from "Extract, Transform, Load" (ETL) to **"Extract, Load, Transform (ELT)"** as performing transformations in-flight became resource intensive. With ELT, data is transferred to the chosen storage location, *before* it is transformed. By storing the data first, it opens the data up to additional Massively Parallel Processing (MPP) engines to process & analyse the data at the same time. 

The following patterns evolved to handle Big Data, which focus on prioritizing scalable volumes, performance and cost.

### Data Lakes
A data lake captures anything the organization deems valuable for future use. Essentially it serves as a central repository that holds a large amount of data in its native, raw format. This approach differs from a traditional data warehouse, which transforms and processes the data at the time of ingestion. Its optimized to for scaling from gigabytes to terabytes and petabytes of data. They are built to handle high volumes of small writes at low latency, and are optimized for massive throughput.

Typically this transformation uses an ELT pipeline, where the data is ingested and transformed in place. Source data that is already relational may go directly into the data warehouse, using an ETL process, skipping the data lake.
![Data Lake Architecture](/images/DataLake.png)

[This](https://learn.microsoft.com/azure/architecture/data-guide/scenarios/data-lake#when-to-use-a-data-lake) table will help to make your use case clearer.

#### When to use Data Lake solutions
* Data lake stores are often used in event streaming or IoT scenarios, because they can persist large amounts of relational and non-relational data without transformation or schema definition.
* Consider **Data Lakes** to be a **heirarchical storage layer where ACID properties are not supported**

### Data Lakehouse
Data storage within a Data Lake does not enforce schema and there can be multiple layers of same data stored which could cause inconsistencies or orphan data. A Data Lakehouse is a new, open data management architecture that combines the flexibility, cost-efficiency, and scale of data lakes with the data management and ACID transactions of data warehouses through the use of Delta Tables. 

![LakeToLakehouse](/images/DataLaketoLakehouse.png)

#### Data Lake and Lakehouse Zones
It is important to define Zones within a Lake to help organize, secure, manage and access the data. The most common approach is the Medallion pattern where the zones are defined as Bronze, Silver and Gold. Additional patterns include:

1. Raw, Processed, Enhanced
1. Raw, Staged, Analytics
1. Transient, Trusted, Refined
1. Landing, Standardized, Curated

Although all the above examples have three zones, it is possible and encouraged to create additional zones (or sub-zones) to suit needs.
The naming and definiton of each zone may vary from organization to organization.

When deciding on the number of storage accounts to host your Lake, the consider the following: 

* **A single storage account** gives you the ability to manage a single set of control plane management operations such as RBACs, firewall settings, data lifecycle management policies for all the data in your storage account, while allowing you to organize your data using containers, files and folders on the storage account. If you want to optimize for ease of management, especially if you adopt a centralized data lake strategy, this would be a good model to consider.
* **Multiple storage accounts** provide you the ability to isolate data across different accounts so different management policies can be applied to them or manage their billing/cost logic separately. Each storage account can have different global settings (such as Geo-Redundant Storage (GRS)). If you are considering a federated data lake strategy with each organization or business unit having their own set of manageability requirements, then this model might work best for you.

![DataLakehouse](/images/DataLakehouse.png)

## Additional Information
* [Big Data Characteristics](https://www.teradata.com/Glossary/What-are-the-5-V-s-of-Big-Data#:~:text=Big%20data%20is%20a%20collection,variety%2C%20velocity%2C%20and%20veracity)
* [Data Lakes](https://learn.microsoft.com/azure/architecture/data-guide/scenarios/data-lake)
* [Hitchhikers Guide to Data Lake](https://azure.github.io/Storage/docs/analytics/hitchhikers-guide-to-the-datalake/)
* [Data Lake Zones](https://learn.microsoft.com/azure/cloud-adoption-framework/scenarios/cloud-scale-analytics/best-practices/data-lake-zones)
* [Data Lake Planning](https://www.sqlchick.com/entries/2016/7/31/data-lake-use-cases-and-planning)
* [Data Lake Organization](https://www.sqlchick.com/entries/2019/1/20/faqs-about-organizing-a-data-lake)
* [How to Organize your Data Lake](https://techcommunity.microsoft.com/t5/data-architecture-blog/how-to-organize-your-data-lake/ba-p/1182562)
* [Hybrid Transactional/Analytical Processing](https://learn.microsoft.com/training/modules/design-hybrid-transactional-analytical-processing-using-azure-synapse-analytics/2-understand-patterns)

## Tutorials
* [Data warehousing with dedicated SQL pool in Azure Synapse Analytics](https://learn.microsoft.com/azure/synapse-analytics/guidance/proof-of-concept-playbook-dedicated-sql-pool)

## GitHub Repos

* [Modern Data Warehouse DataOps Demo](https://github.com/Azure-Samples/modern-data-warehouse-dataops)
