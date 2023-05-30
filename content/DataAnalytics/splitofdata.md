# Split of Data

This module focusses on certain database scenarios which should help you narrow down your options for storing data. Often neglected these are few important concepts one must consider before creating pipelines

## Transactional Data

This is the day to day data that gets generated through transactions. 
Common scenarios here are

1) **OLTP systems** :
These systems are optimized for dealing with discrete system or user requests immediately and responding as quickly as possible

## Historical Data

This is data you don't generate every day. Its accumulated over a period of time and mostly used for reports that involve aggregation of various subsets of this data for meaningful insights.
Common scenarios here are

1) **OLAP systems** :
These are optimized for the analytical processing, ingesting, synthesizing, and managing large sets of historical data. The data processed by OLAP systems largely originates from OLTP systems and needs to be loaded into the OLAP systems by **ETL (Extract, Transform, and Load)** batch processes.

2) **Modern Data Warehouse** :
A conventional data warehousing (OLAP systems) solution typically involves copying data from transactional data stores into a relational database with a schema that's optimized for querying and building multidimensional models. A modern data warehouse also lets you ingest data from multiple sources of different types, including structured, semi-structured, unstructured and/or streaming data with capabilities like scalability and in-built dashboards. Before storing data is cleansed **(ETL)** to reduce the overhead of space and compute for processing this data when called.This can handle more than 24TB to 1PB of data. 

3) **Data Mart**:
This is a specialized subset of data warehouse, designed to handle business and reporting needs to a specific unit or department within an organization. For example if you are in the retail industry you have a data warehouse that stores records of all your stores, inventory, sales, marketing, online transactions, etc. For specifically catering to the needs of marketing unit you may choose to have a data mart instead. Given its nature of specialization it may have fewer sources of data ingestion and likewise lesser volume of data than a data warehouse. This helps with faster aggregation on data and more structural focus on summarizing data. Majority of the time they are project-focused with limited or oriented and focussed usage.

Datamarts provide a simple and optionally no-code experience to ingest data from different data sources, **extract transform and load (ETL)** the data using Power Query, then load it into an Azure SQL database that's fully managed and requires no tuning or optimization. They can handle up to 100GB of data


## Analytical Data

This is vast volumes of historical data or transactional data. As more businesses move to digital processes, they increasingly recognize the value of being able to respond to opportunities by making faster and well-informed decisions. HTAP (Hybrid Transactional/Analytical processing) enables business to run advanced analytics in near-real-time on data stored and processed by OLTP systems

A data lake is a centralized repository that ingests and stores large volumes of data in its original form.

Delta Lake is an open-source storage layer that brings ACID (atomicity, consistency, isolation, and durability) transactions to Apache Spark and big data workloads.

Large-scale data warehousing solutions combine conventional data warehousing used to support business intelligence (BI) with techniques used for so-called "big data" analytics.

## Additional Information

- [Important data engineering concepts](https://learn.microsoft.com/en-us/training/modules/introduction-to-data-engineering-azure/4-common-patterns-azure-data-engineering)
