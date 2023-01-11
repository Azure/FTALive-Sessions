# Introduction

#### [prev](./readme.md) | [home](./readme.md)  | [next](./designing.md)

## Definitions
**Data Warehouse** </br>“DWs are central repositories of integrated data from one or more disparate sources. They store current and historical data in one single place that are used for creating analytical reports for workers throughout the enterprise.” - Wikipedia

**Modern Data Warehouse**</br>
"A modern data warehouse lets you bring together all your data at any scale easily, and to get insights through analytical dashboards, operational reports, or advanced analytics for all your users." – Azure Docs

## Why build a Modern Data Warehouse
* Support modern business requirements and scenarios!
* Support data-driven decision making within organisations
* Advanced Analytics workloads (AI/ML)
* Data exploration and discovery (Data Democratization)
* Cost efficiency

## What makes a Data Warehouse *Modern*
DW | MDW
---|---
Ingest data from multiple data sources, usually structured (relational) | Ingest data from multiple sources of *different types*, including structured, semi-structured, unstructured and/or streaming data 
Usually Based on Kimball, Inmon or DataVault methodologies storing data within a relational database | Support for ‘Big Data’ with data stored in a Data Lake
Usually batch loaded | Often batch, micro-batch, near-realtime and realtime ETL/ELT
The 'model' must be built before business can gain insights | Gain business insights quickly
Often built on Enterprise Relational Database engines | Built on modern technologies such as Highly scalable Cloud Storage (Azure Data Lake Storage Gen2) & Spark
Usually Scale up | Scale out
On-prem and Cloud | Cloud Only

<!-- Often have OLAP models built on top of DW for reporting | Data can be accessed directly from the Data Lake (or pushed into any system including OLAP model, Data Mart or a Traditional Data Warehouse) -->
