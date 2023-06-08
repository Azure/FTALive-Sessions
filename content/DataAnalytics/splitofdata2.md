# Split of Data (Cont)

[prev](./splitofdata1.md.md) | [home](./introduction.md)  | [next](./splitofdata3.md)

This is in continuation for database scenarios which help you narrow down your storage options

## Analytical Data

As more businesses move to digital processes, they increasingly recognize the value of being able to respond to opportunities by making faster and well-informed decisions. The above models present the following challenges:

* Ability to run advanced analytics on near-real-time data (streaming data,,social media data, IOT data, etc)
* Need to cleanse the data before using it for aggregation

With the boom of Big Data (Data arriving in varied Variety with high Velocity in large volumes) there was a transition from Extracting, Transforming and Loading data (ETL) to **Extracting,Loading and then Transforming data(ELT)** for meaningful insights. This was primarily to address 3 V's Variety,Velocity & Volume. Following patterns evolved which focussed on prioritizing storage volume and cost over performance.

### 5) Data Lakes

A data lake captures anything the organization deems valuable for future use.Essentially  it serves as a central repository that holds a large amount of data in its native, raw format. This approach differs from a traditional data warehouse, which transforms and processes the data at the time of ingestion.Its optimized to for scaling from gigabytes to terabytes and petabytes of data. They are built to handle high volumes of small writes at low latency, and are optimized for massive throughput.

Typically this transformation uses an **ELT (extract-load-transform)** pipeline, where the data is ingested and transformed in place. Source data that is already relational may go directly into the data warehouse, using an ETL process, skipping the data lake.
![Data Lake Architecture](/images/DataLake.png)

[This](https://learn.microsoft.com/eazure/architecture/data-guide/scenarios/data-lake#when-to-use-a-data-lake) table will help to make your use case clearer

#### When to use Data Lake solutions

* Data lake stores are often used in event streaming or IoT scenarios, because they can persist large amounts of relational and nonrelational data without transformation or schema definition.
* Consider **Data Lakes** to be a **heirarchical storage layer where ACID properties are not supported**

### 6) Data Lakehouse

Data Lake does not enforce schema and there can be multiple layers of same data stored which could cause inconsistencies, orphan data or isolated data. Purging becomes an essential component which you should plan when going for a Data Lake Architecture. A data lakehouse is a new, open data management architecture that combines the flexibility, cost-efficiency, and scale of data lakes with the data management and ACID transactions of data warehouses. Data passes through multiple layers of validations and transformations before being stored in a layout optimized for efficient analytics.

![LakeToLakehouse](/images/DataLaketoLakehouse.png)

> Note-Instead of raw, enriched and curated layers, some people call the layers differently, such as:
>
>1. Bronze, Silver, Gold
>1. Raw, Processed, Enhanced
>1. Raw, Staged, Analytics
>1. Transient, Trusted, Refined
>1. Landing, Standardized, Curated
> 
> Essentially it is 3 layers where naming conventions may vary from organization to organization or business to business.

When deciding the number of storage accounts you want to create, the following considerations are helpful in deciding the number of storage accounts you want to provision.

* **A single storage account** gives you the ability to manage a single set of control plane management operations such as RBACs, firewall settings, data lifecycle management policies for all the data in your storage account, while allowing you to organize your data using containers, files and folders on the storage account. If you want to optimize for ease of management, specially if you adopt a centralized data lake strategy, this would be a good model to consider.
* **Multiple storage accounts** provide you the ability to isolate data across different accounts so different management policies can be applied to them or manage their billing/cost logic separately. If you are considering a federated data lake strategy with each organization or business unit having their own set of manageability requirements, then this model might work best for you.

![DataLakehouse](/images/DataLakehouse.png)

## Additional Information

* [Big Data Characteristics](https://www.teradata.com/Glossary/What-are-the-5-V-s-of-Big-Data#:~:text=Big%20data%20is%20a%20collection,variety%2C%20velocity%2C%20and%20veracity)
* [Data Lakes](https://learn.microsoft.com/azure/architecture/data-guide/scenarios/data-lake)
* [Hitchhikers Guide to Data Lake](https://azure.github.io/Storage/docs/analytics/hitchhikers-guide-to-the-datalake/)
* [Data Lake Zones](https://learn.microsoft.com/azure/cloud-adoption-framework/scenarios/cloud-scale-analytics/best-practices/data-lake-zones)
* [Data Lake Planning](https://www.sqlchick.com/entries/2016/7/31/data-lake-use-cases-and-planning)
* [Data Lake Organization](https://www.sqlchick.com/entries/2019/1/20/faqs-about-organizing-a-data-lake)
* [How to Organize your Data Lake](https://techcommunity.microsoft.com/t5/data-architecture-blog/how-to-organize-your-data-lake/ba-p/1182562)

## GitHub Repos to Get started

* [Modern Data Warehouse](https://github.com/Azure-Samples/modern-data-warehouse-dataops)
* [Analytics Toolbox](https://github.com/Azure/AnalyticsinaBox)
