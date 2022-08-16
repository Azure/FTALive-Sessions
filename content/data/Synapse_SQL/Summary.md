## Synapse SQL serverless pool and Dedicated SQL Pool Summary

****[Home](https://github.com/LiliamLeme/FTALive-Sessions_Synapse_SQL/blob/main/content/data/tobedefined.md)\**** 

As **Summary**, Table for comparison (Table 1):

 

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