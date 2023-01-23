## Overview - MDW

### What is a Modern Data Warehouse

[<Back](https://github.com/LiliamLeme/FTALive-Sessions_Synapse_SQL/blob/main/content/data/ModernDatawarehouse-Security/Agenda.md)\- [Next >](https://github.com/LiliamLeme/FTALive-Sessions_Synapse_SQL/blob/main/content/data/ModernDatawarehouse-Security/Overall_security_considerations.md)


A data warehouse - a large store of data accumulated from a wide range of sources within a company and used to guide management decisions.

When businesses started realizing the value of analyzing and reporting on their data,  there wasn’t the type of technology there is today.  Reports were generally limited to a 24 hour interval.  Data went through a very sequential and structured flow.  It was loaded, and then transformed and then stored in a relational format. 

Most organisations pretty much had a one box solution. Tools were used for ETL like SSIS to get data from somewhere and land it into a staging database. Data was usually landed in the format it was originally in, some transformations were applied, maybe some data typing, maybe a column was added or an aggregate.  And then it was put into a into a a nice format of dimensions and facts.

It was a type of conveyor belt of data going through for many years there was very little flexibility. and this became the ingrained thinking of developers. There were also added limitations like hardware and the type of technology available to execute advanced use cases furthermore, for example if you wanted an Apache Spark cluster or a Hadoop cluster on premise for big data analytics, it was very costly, it required skills to configure and maintain it and usually was only a luxury big organisations could afford. 

Adding any additional source was cumbersome and time consuming, data had to be analyzed before loading into relational structures and because data needed to be in a relational structure, analyzing or working with structured or non structured data was almost impossible. Near real time was expensive and mostly something that was just dreamed of. 

This kind of approach doesn’t always make sense when analytic requirements and use cases are changing all the time and when things are getting competitive
Today there are many technology choices to choose from and hardware that is required to run these use cases is right at your finger tips 
These DW systems as they were known are being replaced by the modern data warehouse - database equivalent of a Swiss Army knife - where one can integrate multiple fit-for-purpose analytics engines. 

As scenarios evolve with multiple data types and different types of analytics that needs to be performed over big data structures,  it becomes common that customers inevitably spawn many types of data workloads and because no single platform runs all workloads equally well most data warehouse and analytics systems trend toward a multiplatform environment. 

The design focus has changed the scenarios that involve exploring data, analysing data to generating new insights and new analytics application and for this to be successful, we need to get data from where it is, to where it is needed and when it is needed.

Instead of the relational data store being the centre of the data warehouse, the data lake becomes the centre of any modern DW solution. 
The data lake is the storage repository, which will holds the vast amount of raw data in its native format until it is needed.

If we look at a modern DW architecture in Azure, it typically consists of the following services:
Pipelines using either Azure Data Factory or Azure Synapse pipelines, Azure Data Lake Storage, Azure Synapse Dedicated and Serverless Pools and Power BI. 

As we move into more use cases,  the architecture expands to include other services and even technologies such as Machine Learning, Streaming etc.

![image](https://user-images.githubusercontent.com/24648322/213684800-447f4713-0b48-4128-9ac8-d7ee81d0563a.png)


#### Reference

[Enterprise data warehouse - Azure Solution Ideas (microsoft.com)](https://learn.microsoft.com/en-us/azure/architecture/solution-ideas/articles/enterprise-data-warehouse#architecture)

[Analytics end-to-end with Azure Synapse - Azure Example Scenarios (microsoft.com)](https://docs.microsoft.com/en-us/azure/architecture/example-scenario/dataplate2e/data-platform-end-to-end?tabs=portal)

**Synapse Analytics**

What is Synapse Analytics and why the focus?

Azure Synapse is an enterprise analytics service that accelerates time to insight across data warehouses and big data systems. It brings together the best of SQL technologies used in enterprise data warehousing, Spark technologies used for big data, data Explorer for log and time series analytics and pipelines for data integration and ETL/ELT.

Synapse SQL offers both serverless and dedicated resource models. 
For predictable performance and cost, there are dedicated SQL pools to reserve processing power for data stored in SQL tables and for unplanned or bursty workloads, the always-available, serverless SQL endpoint.

Apache Spark for Azure Synapse deeply and seamlessly integrates Apache Spark--the most popular open source big data engine used for data preparation, data engineering, ETL, and machine learning.

Azure Synapse Data Explorer provides customers with an interactive query experience to unlock insights from log and telemetry data

Underpinning all of this is the ability to monitor and manage the jobs and environment and provides all up security in a single user experience. 
Synapse Studio provides a single way for enterprises to build solutions, maintain, and secure all in a single user experience

As we move into adding more and more components, we need to ensure that we secure and give access only as required.
In this Learn Live session, we will cover discussing the security of the modern data warehouse specifically Azure Data Lake,  Azure Data Factory, Azure Synapse Analytics and Power BI as the core components of a Modern Datawarehouse.

#### Reference

[What is Azure Synapse Analytics? - Azure Synapse Analytics (microsoft.com)](https://learn.microsoft.com/en-us/azure/synapse-analytics/overview-what-is)

[<Back](https://github.com/LiliamLeme/FTALive-Sessions_Synapse_SQL/blob/main/content/data/ModernDatawarehouse-Security/Agenda.md)\- [Next >](https://github.com/LiliamLeme/FTALive-Sessions_Synapse_SQL/blob/main/content/data/ModernDatawarehouse-Security/Overall_security_considerations.md)
