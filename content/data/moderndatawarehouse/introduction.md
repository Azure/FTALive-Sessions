# Introduction

#### [prev](./readme.md) | [home](./readme.md)  | [next](./designing.md)

## Definitions
**Data Warehouse** </br>“DWs are central repositories of integrated data from one or more disparate sources. They store current and historical data in one single place that are used for creating analytical reports for workers throughout the enterprise.” - Wikipedia

**Modern Data Warehouse**</br>
"A modern data warehouse lets you bring together all your data at any scale easily, and to get insights through analytical dashboards, operational reports, or advanced analytics for all your users." – Azure Docs

## Why build a Modern Data Warehouse
* Support data-driven decision making within organisations (Business Intelligence)
* Advanced Analytics workloads (AI/ML)
* Data exploration and discovery

## What makes a Data Warehouse *Modern*
DW | MDW
---|---
Built to ingest data from multiple data sources, usually structured (relational) | Ingest data from multiple sources of different types, including structured, unstructured and/or streaming data 
Usually Based on Kimball, Inmon and DataVault methodologies | Support for ‘Big Data’
Usually batch loaded | Supports event driven architectures
Stored in a relational engine | Usually faster time to gain insights from project inception.
OLAP models built on top for reporting | Built on modern technologies such as ADLS, Hadoop & Spark
Scale up | Scale out


</br>
</br>

### Presenter Notes
1. Industry & individuals definitions are not the same!
1. Purposely used vague terms in the above table
1. DW and MDW attempting to solve similar business challenges, but more modern challenges. e.g. Don't want to wait to end of the month reports anymore.
1. MDW is far broader in scope than DW. Supports more great variety, volume & velocity of data
1. MDW does not need a traditional 'database' (but it can have)
