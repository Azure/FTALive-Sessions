## Synapse SQL dedicate pool and SQL serverless pool review

#### What is the difference of SQL dedicate pool and SQL serverless pool options inside of Synapse?



***\*[Home](../tobedefined.md)\**** - [Next >](test.md)

##### Architecture Overview



For dedicated SQL pool, the unit of scale is an abstraction of compute power that is known as a [data warehouse unit](https://docs.microsoft.com/en-us/azure/synapse-analytics/sql/resource-consumption-models).

For serverless SQL pool, being serverless, scaling is done automatically to accommodate query resource requirements. As topology changes over time by adding, removing nodes or failovers, it adapts to changes and makes sure your query has enough resources and finishes successfully. For example, the image below shows serverless SQL pool utilizing 4 compute nodes to execute a query.

With decoupled storage and compute, when using Synapse SQL one can benefit from independent sizing of compute power irrespective of your storage needs. For serverless SQL pool scaling is done automatically, while for dedicated SQL pool one can:

- Grow or shrink compute power, within a dedicated SQL pool, without moving data.
- Pause compute capacity while leaving data intact, so you only pay for storage.
- Resume compute capacity during operational hours.



![image-20220726110815690](C:\Users\lilem\AppData\Roaming\Typora\typora-user-images\image-20220726110815690.png)

###### Reference:

[Synapse SQL architecture - Azure Synapse Analytics | Microsoft Docs](https://docs.microsoft.com/en-us/azure/synapse-analytics/sql/overview-architecture)