# Split of Data
This module focusses on certain database scenarios which should help you narrow down your options for storing data. Often neglected these are few important concepts one must consider before creating pipelines

## Transactional Data
This is the day to day data that gets generated through transactions. 

Common scenarios here are 
1) **OLTP systems** : These systems are optimized for dealing with discrete system or user requests immediately and responding as quickly as possible

## Historical Data
This is data you don't generate every day. Its accumulated over a period of time and mostly used for reports that involve aggregation of various subsets of this data for meaningful insights.
Common scenarios here are 
1) **OLAP systems** : These are optimized for the analytical processing, ingesting, synthesizing, and managing large sets of historical data. The data processed by OLAP systems largely originates from OLTP systems and needs to be loaded into the OLAP systems by ETL (Extract, Transform, and Load) batch processes.
2) **Modern Data Warehouse** : A conventional data warehousing solution typically involves copying data from transactional data stores into a relational database with a schema that's optimized for querying and building multidimensional models.
## Analytical Data
This is vast volumes of historical data or 
As more businesses move to digital processes, they increasingly recognize the value of being able to respond to opportunities by making faster and well-informed decisions. HTAP (Hybrid Transactional/Analytical processing) enables business to run advanced analytics in near-real-time on data stored and processed by OLTP systems

A data lake is a centralized repository that ingests and stores large volumes of data in its original form.

Delta Lake is an open-source storage layer that brings ACID (atomicity, consistency, isolation, and durability) transactions to Apache Spark and big data workloads.

Large-scale data warehousing solutions combine conventional data warehousing used to support business intelligence (BI) with techniques used for so-called "big data" analytics. 
 
## Additional Information
- [Important data engineering concepts](https://learn.microsoft.com/en-us/training/modules/introduction-to-data-engineering-azure/4-common-patterns-azure-data-engineering)