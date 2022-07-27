# Agenda

Presenters - FTA engineers
	Liliam Leme
	Luca Ferrari

Synapse SQL dedicate pool and SQL serverless pool review

[What is the difference of those 2 options inside of Synapse?]

[SQL DW Architecture overview]
	1.1 - Distribution keys consideration basics
	1.2 - Concurrency consideration basics
[SQL Serveless Architecture overview]
	2.1 Query to beginners: OpenRowset, Credentials, External tables
	2.2 Spark\Delta Integration overview

### Audience

IT Pros or architects that are considering those options for a datawarehouse solution and  they want to understand
when use them, how to use them. THis is an overview session of both sessions that aim to introduce the concepts
and how to work with them.

### Goals:

Attended be able to differentiate both options and choose the one that best suits their business goals.

Architecture: [Synapse SQL architecture - Azure Synapse Analytics | Microsoft Docs](https://docs.microsoft.com/en-us/azure/synapse-analytics/sql/overview-architecture)

DW examples: [What The Hack - Synapse Dedicated SQL Pool - Performance Best Practices | What The Hack (microsoft.github.io)](https://microsoft.github.io/WhatTheHack/049-SQLDedicatedPoolPerf/)

SQL serveless pool  examples and docs:

https://raw.githubusercontent.com/Azure-Samples/Synapse/main/SQL/Samples/LdwSample/SampleDB.sqlhttps://docs.microsoft.com/en-us/azure/synapse-analytics/sql/query-delta-lake-format#query-partitioned-data

[Control storage account access for serverless SQL pool - Azure Synapse Analytics | Microsoft Docs](https://docs.microsoft.com/en-us/azure/synapse-analytics/sql/develop-storage-files-storage-access-control?tabs=user-identity)

[Use external tables with Synapse SQL - Azure Synapse Analytics | Microsoft Docs](https://docs.microsoft.com/en-us/azure/synapse-analytics/sql/develop-tables-external-tables?tabs=hadoop)

