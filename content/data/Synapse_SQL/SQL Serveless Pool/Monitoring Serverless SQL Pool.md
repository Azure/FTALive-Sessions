## Synapse Serverless SQL pool 

[Back<](https://github.com/LiliamLeme/FTALive-Sessions_Synapse_SQL/blob/main/content/data/Synapse_SQL/SQL%20Serveless%20Pool/Delta_timetravel_serveless.md) -[Home](https://github.com/LiliamLeme/FTALive-Sessions_Synapse_SQL/blob/main/content/data/Synapse_SQL/SQL%20Serveless%20Pool/Agenda_serveless.md)

#### **Monitoring Serveless SQL Pool:**

##### **Log analytics**

Natively speaking you can use log analytics to monitor the following on Serverless SQL Pool:



| Metric Name                      | Desc                                      |       |               | Desc                                                         |
| -------------------------------- | ----------------------------------------- | ----- | ------------- | ------------------------------------------------------------ |
| BuiltinSqlPoolDataProcessedBytes | Built-in SQL pool, Data processed (bytes) | Byte  | Sum (default) | Amount of data processed by the built-in serverless SQL pool. |
| BuiltinSqlPoolLoginAttempts      | Built-in SQL pool, Login attempts         | Count | Sum (default) | Number of login attempts for the built-in serverless SQL pool. |
| BuiltinSqlPoolDataRequestsEnded  | Built-in SQL pool, Requests ended (bytes) | Count | Sum (default) | Number of ended SQL requests for the built-in serverless SQL pool.  Use the Result dimension of this metric to filter by final state. |
| SynapseBuiltinSqlReqsEnded       | BuiltinSqlReqsEnded                       |       |               | Azure Synapse built-in serverless SQL pool ended requests.   |

Using those metrics you can measure the bytes processed per query and even manage the costs.



**Reference**

[Monitoring serverless SQL ended requests by using Log Analytics. - Microsoft Community Hub](https://techcommunity.microsoft.com/t5/azure-synapse-analytics-blog/monitoring-serverless-sql-ended-requests-by-using-log-analytics/ba-p/3650383)

[How to monitor Synapse Analytics using Azure Monitor - Azure Synapse Analytics | Microsoft Learn](https://learn.microsoft.com/en-us/azure/synapse-analytics/monitoring/how-to-monitor-using-azure-monitor#metrics)

[Azure Monitor Logs reference - SynapseBuiltinSqlPoolRequestsEnded | Microsoft Learn](https://learn.microsoft.com/en-us/azure/azure-monitor/reference/tables/synapsebuiltinsqlpoolrequestsended)

##### **DMVs**

In terms of overall performance you can use SQL DMVs to monitor the environment:

For example, you can monitor the requests using  : 

```sql
SELECT * FROM sys.dm_exec_requests
```

Monitor the sessions:

```sql
 SELECT * FROM sys.dm_exec_sessions 
```



Open sessions per program, database:

```sql
SELECT

  DB_NAME(database_id) as DBName, 

  nt_user_name as username, 

  login_name as LoginName,

  program_name as ApplicationName,

  host_name,

  program_name,

  COUNT(*) AS NB_Connections

FROM sys.dm_exec_sessions

GROUP BY DB_NAME(database_id) , 

  nt_user_name , 

  login_name ,

  program_name ,

  host_name,

  program_name
```



Cross the requests with sessions and SQl text:

```sql
SELECT * FROM 
    sys.dm_exec_requests req 
CROSS APPLY sys.dm_exec_sql_text(sql_handle) sqltext
JOIN sys.dm_exec_sessions s 
ON req.session_id = s.session_id
```



Check the history of the executions:

```sql
SELECT  * 
FROM sys.dm_exec_requests_history req 
WHERE transaction_ID = 23022567
Order by data_processed_mb desc


```

**References:** 

[Monitoring Synapse serverless SQL open connections - Microsoft Community Hub](https://techcommunity.microsoft.com/t5/azure-synapse-analytics-blog/monitoring-synapse-serverless-sql-open-connections/ba-p/3298577)

[Troubleshooting SQL On-demand or Serverless DMVs - Microsoft Community Hub](https://techcommunity.microsoft.com/t5/azure-synapse-analytics-blog/troubleshooting-sql-on-demand-or-serverless-dmvs/ba-p/1955869)

[(3) Troubleshooting performance on serverless Synapse SQL pool using QPI library | LinkedIn](https://www.linkedin.com/pulse/troubleshooting-performance-serverless-synapse-sql-pool-jovan-popovic/)

https://github.com/JocaPC/qpi/blob/master/src/qpi.sql 
