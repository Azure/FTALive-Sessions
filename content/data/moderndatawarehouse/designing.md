# Designing

#### [prev](./introduction.md) | [home](./readme.md)  | [next](./building.md)


## Architecture
* **Don't reinvent the wheel!** Visit our [architecture centre](https://docs.microsoft.com/en-us/azure/architecture/) and check out some reference [data architectures](https://docs.microsoft.com/en-us/azure/architecture/data-guide/) such as [MDW for SMB](https://docs.microsoft.com/en-us/azure/architecture/example-scenario/data/small-medium-data-warehouse)
* Some architectures are applicable across technologies and cloud, such as Lambda
* Keep it simple to begin with. Only include services that are required
* Iterative and modular
* Produce a 'High Level Design'
* Then produce a 'Physical Design'
   * Specific Azure services
   * Subscription, region, resource groups 
   * Networking
* Pillars
   * Reliability
   * Security
   * Cost Optimization
   * Operational Excellence
   * Performance Efficiency

## Requirements
   * Business
   * Functional
   * Non-Functional
      * **Networking**
      * **Business Continuity** (HA/DR)
      * **Backups** (But how...)
   * Timelines

## Find new home..
* What experience and skills does your team have? SQL, Spark, something else? This should be a consideration.
* CDM https://docs.microsoft.com/en-us/azure/cloud-adoption-framework/scenarios/cloud-scale-analytics/architectures/common-industry-data-models

## Data Lakes
* MDWs have [Data Lakes](https://azure.microsoft.com/en-us/overview/what-is-a-data-lake/) at their core, so become familiar with [concept](https://docs.microsoft.com/en-us/azure/architecture/data-guide/scenarios/data-lake)
* Difference between the logical concept for a Data Lake and actual implementation.
* Azure Data Lake Storage gen2
* Microsoft has some very good guidance on [Zones](https://docs.microsoft.com/en-us/azure/cloud-adoption-framework/scenarios/cloud-scale-analytics/best-practices/data-lake-zones) and [Best Practices](https://docs.microsoft.com/en-us/azure/storage/blobs/data-lake-storage-best-practices)
* 

## Questions you should ask yourself & document
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
* more more more !

## Additional Resources
- CDM https://docs.microsoft.com/en-us/azure/cloud-adoption-framework/scenarios/cloud-scale-analytics/architectures/common-industry-data-models
- DATA LAKES!
- DELTA TABLES
- Lake databases
- Synapse
- https://techcommunity.microsoft.com/t5/azure-synapse-analytics-blog/the-data-lakehouse-the-data-warehouse-and-a-modern-data-platform/ba-p/2792337
- https://docs.microsoft.com/en-us/azure/architecture/example-scenario/data-warehouse/dataops-mdw


