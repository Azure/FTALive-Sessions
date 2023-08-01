# Split of Data (Part 1)

[prev](./dataoperations.md) | [home](./introduction.md)  | [next](./splitofdata2.md)

This module focuses on scenarios which will help narrow down options for storing data. Often neglected, these are a few important concepts one must consider before creating building an analytics solution.

## Transactional Data
This is the day to day data that gets generated through transactions. Common scenarios here are:

### OLTP
The management of transactional data using computer systems is referred to as Online Transaction Processing (OLTP). These systems record business interactions as they occur in the day-to-day operation of the organization and support querying of this data. These systems are optimized for dealing with discrete system or user requests immediately and responding as quickly as possible. OLTP databases vary in size from a few megabytes to hundreds terabytes. </br>

#### When to use an OLTP solution
* Choose OLTP when you need to efficiently process and store business transactions, immediately make those transactions available and when you must adhere to ACID (Atomic, Consistent, Isolated and Durable) properties. Use this architecture when any tangible delay in processing would have a negative impact on the day-to-day operations of the business.

![OLTP](/images/OLTP.png)

## Historical Data
Historical data refers to data that is not being actively updated and queried for day-to-day business purposes. Its accumulated over time and mostly used for reports that involve aggregation for business insights. 

### Data Warehouse
A conventional data warehousing solution typically involves copying data from transactional data stores into a relational database with a schema that's optimized for querying and building multidimensional models. A Modern Data Warehouse (MDW) not only allows the ingestion of structured data, it also lets you ingest semi-structured, unstructured and/or streaming data at vast  scales. 
Before storing historical data it must be cleansed (transformed) to reduce the overhead of space and compute for processing this data when called. 

#### When to use a Data Warehouse solution
* Choose a data warehouse when you need to turn massive amounts of data from operational systems into a format that is easy to understand. 
* Preferred when you need to keep historical data separate from the source transaction systems for performance reasons.
* Data warehouses don't need to follow the same terse data structure you may be using in your OLTP databases. You can use column names that make sense to business users and analysts, restructure the schema to simplify relationships, and consolidate several tables into one.

![Data Warehouse](/images/DataWarehouse.png)

### OLAP systems
Online Analytical Processing (OLAP) systems are optimized for the analytical processing, ingesting, synthesizing, and managing large sets of historical data. The data brought into OLAP systems usually originates from OLTP systems and needs to be loaded into the OLAP systems by **ETL (Extract, Transform, and Load)** batch processes.</br>

#### When to use OLAP solution
* Consider OLAP when there is a need to execute complex analytical and adhoc queries rapidly over large amount of data, without negatively affecting your OLTP systems.
* OLAP systems are optimized for read-heavy scenarios, such as analytics and business intelligence where users are required to segment multi-dimensional data into slices that can be viewed in multiple dimensions (such as a pivot table) or filter the data by specific values.

### Data Mart
This is a specialized subset of a data warehouse, designed to handle business and reporting needs to a specific unit or department within an organization. For example, in the retail industry you might have a data warehouse that stores records of all your stores inventory, sales, marketing, online transactions, etc. If the marketing team were to have specific requirements of their data, you could build a dedicated data mart, which contained a specific subset of the data from the data warehouse. Given its nature of specialization it may have fewer sources of data ingestion and likewise lesser volume of data than a data warehouse. This helps with faster aggregation on data and more structural focus on summarizing data. 
Power BI Data Marts provide an out-of-the-box no-code option for building Data Marts utilizing Power Query to ingest data from multiple sources, then load it into an Azure SQL database that's fully managed and requires no tuning or optimization. 

#### When to use Data Mart solution
* Choose a data mart when you need to turn moderate volume of data from operational systems into a format that is easy to understand for a particular business unit or department.
* Data marts are a good option where auto generated datasets are viable for generating reports. It works well for relational database analytics with Power BI.

![Data Mart](/images/DataMarts.png)

The heirarchy of the above data storage options is summarized as follows:

![Data Hierarchy](/images/DataHeirarchyOLTPtoOLAP.png)

The next section will cover the change in trend from **ETL** to **ELT** with the advent of Big Data.

## Additional Information

* [Important data engineering concepts](https://learn.microsoft.com/training/modules/introduction-to-data-engineering-azure/4-common-patterns-azure-data-engineering)
* [OLTP](https://learn.microsoft.com/azure/architecture/data-guide/relational-data/online-transaction-processing)
* [OLAP](https://learn.microsoft.com/azure/architecture/data-guide/relational-data/online-analytical-processing)
* [Data Warehousing](https://learn.microsoft.com/azure/architecture/data-guide/relational-data/data-warehousing)
* [Data Marts](https://learn.microsoft.com/power-bi/transform-model/datamarts/datamarts-overview)
* [Big Data Characteristics](https://www.teradata.com/Glossary/What-are-the-5-V-s-of-Big-Data#:~:text=Big%20data%20is%20a%20collection,variety%2C%20velocity%2C%20and%20veracity)
