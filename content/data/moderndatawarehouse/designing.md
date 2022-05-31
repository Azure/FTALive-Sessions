# Designing

#### [prev](./introduction.md) | [home](./readme.md)  | [next](./building.md)

## Architecture
* **Don't reinvent the wheel!** Visit our [architecture centre](https://docs.microsoft.com/en-us/azure/architecture/) and check out some reference [data architectures](https://docs.microsoft.com/en-us/azure/architecture/data-guide/) such as [MDW for SMB](https://docs.microsoft.com/en-us/azure/architecture/example-scenario/data/small-medium-data-warehouse)
* Review the [Cloud Adoption Framework for Data and Analytics](https://docs.microsoft.com/en-us/azure/cloud-adoption-framework/scenarios/cloud-scale-analytics/)
* Some architectures are applicable across technologies and clouds, such as [Lambda](https://docs.microsoft.com/en-us/azure/architecture/data-guide/big-data/#lambda-architecture)
* Keep it simple to begin with and only include services that are required
* Security! More on this later, but design and build it into the solution from the beginning
* Iterative and modular
* Leverage [Common Data Models or Industry Data Models](https://docs.microsoft.com/en-us/azure/cloud-adoption-framework/scenarios/cloud-scale-analytics/architectures/common-industry-data-models) where possible

## Design
* Produce a 'High Level Design'
* Then produce a 'Physical Design(s)'
   * Specific Azure services
   * Subscription, region, resource groups 
   * Networking
* Does your design address the pillars of [Microsoft Well-Architectured Framework](https://docs.microsoft.com/en-us/azure/architecture/framework/)?
   * Reliability
   * Security
   * Cost Optimization
   * Operational Excellence
   * Performance Efficiency

## Requirements
   * Don't build a 'generic data platform'
   * Business
   * Functional
   * Non-Functional
      * **Networking**
      * **Business Continuity** (HA/DR)
      * **Backups** (But how...)
      * Performance
   * Preferred technologies within your organisation, and skill-set to support them
   * Timelines

## Data Lakes
* MDWs have [Data Lakes](https://azure.microsoft.com/en-us/overview/what-is-a-data-lake/) at their core, so become familiar with [concept](https://docs.microsoft.com/en-us/azure/architecture/data-guide/scenarios/data-lake)
* Understand the difference between the concept of a Data Lake, and actual implementation
* [What is Azure Data Lake Storage Gen2](https://docs.microsoft.com/en-us/azure/storage/blobs/data-lake-storage-introduction)
* Microsoft has some very good guidance on [Zones](https://docs.microsoft.com/en-us/azure/cloud-adoption-framework/scenarios/cloud-scale-analytics/best-practices/data-lake-zones) and [Best Practices](https://docs.microsoft.com/en-us/azure/storage/blobs/data-lake-storage-best-practices)
* A well designed, built and governed Data Lake in an organizational is key to supporting all current and future scenarios

## Additional Resources
- [What is Delta Lake](https://docs.microsoft.com/en-us/azure/synapse-analytics/spark/apache-spark-what-is-delta-lake)
- [What is Lake Database](https://docs.microsoft.com/en-us/azure/synapse-analytics/database-designer/concepts-lake-database)
- [What is Azure Synapse Analytics](https://docs.microsoft.com/en-us/azure/synapse-analytics/overview-what-is)
- [What is the Parquet file format](https://parquet.apache.org/) and [Unpacking the Transaction Log](https://databricks.com/session_eu20/diving-into-delta-lake-unpacking-the-transaction-log)
- Blog: [The Data Lakehouse, the Data Warehouse and a Modern Data platform architecture](https://techcommunity.microsoft.com/t5/azure-synapse-analytics-blog/the-data-lakehouse-the-data-warehouse-and-a-modern-data-platform/ba-p/2792337)

### Questions you should ask yourself & document
* From when a record enters your source system, when do you want to report or take action on in it in your MDW?
* Real-time, near real-time, micro-batch or batch?
   * What is your definition of real-time, near real-time, micro-batch and batch?
* Does your source system support this velocity?
* What format should the data be in to make those reports / take action?
* What transformations do you need to make to support this?
* How much data do you have?
* What variety of data do you have?
* Who are the consumers of the MDW and what data will you expose to them, and where and how?
* What technology & languages does your team have experience with?
* Row level security - is it required and where will it be implemented?
* More!


