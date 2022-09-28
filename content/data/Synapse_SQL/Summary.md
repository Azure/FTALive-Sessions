## Synapse SQL serverless pool and Dedicated SQL Pool Summary

[Back <](SynapseCETAS.md) [Home](https://github.com/LiliamLeme/FTALive-Sessions_Synapse_SQL/blob/main/content/data/Synapse_SQL/Agenda.md) 

### Summary

Follow a table for comparison (Table 1):

 

| Features                                                     | Serverless SQL Pool | Dedicated SQL Pool                                           |
| ------------------------------------------------------------ | ------------------- | ------------------------------------------------------------ |
| Select Surface Supported                                     | Yes                 | Yes                                                          |
| External Tables                                              | Yes                 | Yes                                                          |
| Delta File Support                                           | Yes                 | No                                                           |
| Query Spark Tables                                           | Yes                 | No                                                           |
| Concurrency                                                  | Not limited         | Limited according to Service Level ([check docs](https://docs.microsoft.com/en-us/azure/synapse-analytics/sql-data-warehouse/memory-concurrency-limits)) |
| Concurrency managed ( resource governor)                     | No                  | Yes                                                          |
| Create Table                                                 | No                  | Yes                                                          |
| Insert, Update and Delete commands                           | No                  | Yes                                                          |
| View                                                         | Yes                 | Yes                                                          |
| Materialized View                                            | No                  | Yes                                                          |
| Index creation                                               | No                  | Yes                                                          |
| Custom management of table distribution like Hash, Round Robin, and Replicated. | No                  | Yes                                                          |
| Works with ADF                                               | Yes                 | Yes                                                          |
| Works with Power BI                                          | Yes                 | Yes                                                          |
| CETAS                                                        | Yes                 | Yes                                                          |
| Pay per use ( *Data processed by query*)                     | Yes                 | No                                                           |
| Pay by minutes online ( manage by a pause and resume operations) | No                  | Yes                                                          |

Table 1

**Note:**
In terms of Servelss SQL Pool - The select surface is fully supported, as this option will be used to query and organize files from the storage but it will not store them in a database structure. Hence, DMLs operations such as Insert, Update, and Delete are not supported. 

Table creation is also not supported, only external tables are supported in this context. Follow the link for more information on how to use CETAS: [How to use CETAS on serverless SQL pool to improve performance and automatically recreate it - Microsoft Tech Community](https://techcommunity.microsoft.com/t5/azure-synapse-analytics-blog/how-to-use-cetas-on-serverless-sql-pool-to-improve-performance/ba-p/3548040)

For more information about T-SQL feature support, please review this doc.

[T-SQL feature in Synapse SQL pool - Azure Synapse Analytics | Microsoft Docs](https://docs.microsoft.com/en-us/azure/synapse-analytics/sql/overview-features)

Table reference: [Understand Synapse dedicated SQL pool (formerly SQL DW) and Serverless SQL pool - Microsoft Tech Community](https://techcommunity.microsoft.com/t5/azure-synapse-analytics-blog/understand-synapse-dedicated-sql-pool-formerly-sql-dw-and/ba-p/3594628)
