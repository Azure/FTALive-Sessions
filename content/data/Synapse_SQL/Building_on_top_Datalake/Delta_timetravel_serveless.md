## Synapse Serverless SQL pool 

[Back<](https://github.com/LiliamLeme/FTALive-Sessions_Synapse_SQL/blob/main/content/data/Synapse_SQL/SQL%20Serveless%20Pool/SQL%20serverless%20pool%20and%20Spark%20Integration.md) -[Home](https://github.com/LiliamLeme/FTALive-Sessions_Synapse_SQL/blob/main/content/data/Synapse_SQL/SQL%20Serveless%20Pool/Agenda_serveless.md)\- [>Next](https://github.com/LiliamLeme/FTALive-Sessions_Synapse_SQL/blob/main/content/data/Synapse_SQL/SQL%20Serveless%20Pool/Monitoring%20Serverless%20SQL%20Pool.md)



**What is Time travel using Delta?**

Use time travel to let users query point-in-time snapshots or roll back erroneous updates to their data. 

 

**Actually, using Delta Time travel**

 

For example. The plan here is to export a point in time to recover a change in a transaction. The steps are to be executed in an environment you already set up the Delta files.

Following the steps.

Ref: [Overview of how to use Linux Foundation Delta Lake in Apache Spark for Azure Synapse Analytics - Azure Synapse Analytics | Microsoft Docs](https://docs.microsoft.com/en-us/azure/synapse-analytics/spark/apache-spark-delta-lake-overview?pivots=programming-language-python#read-older-versions-of-data-using-time-travel)

 

For example, here I have a FactCurrencyRate_join folder that contains parquet files using Delta format and it is stored as: */sqlserverlessanalitics/FactCurrencyRate_join:*

  

```
%%pyspark 

df = spark.read\   

.format('delta')\   

.load("/sqlserverlessanalitics/FactCurrencyRate_join")
```

 Checking the metadata:

  

```
df.printSchema()
```

 

Suppose I increased by "mistake" a few times the *AverageRate* values and now I need to travel back in time to bring back the last valid value before I changed. Following the code to travel in time based on the checkpoint where the information was in the state before the changes, which in my example is **"2022-09-16 08:41:00".** If you want to list the last checkpoint and versions, follow the code example. Fig 2 shows the results, and Fig 3 checkpoints illustration: 

```
from delta.tables 
import * deltaTable = DeltaTable.forPath(spark, "/sqlserverlessanalitics/FactCurrencyRate_join/") 

latestHistory = deltaTable.history(); 

latestHistory.show(10)    
```



Here I am using the timestamp, you can also use the version number if you prefer. Anyway, I want to travel back to **"2022-09-16 at 08:41:00":**

 

```
//timetravel.  

val df_read = spark.read.format("delta").option("timestampAsOf", "2022-09-16 08:41:00").load("/sqlserverlessanalitics/FactCurrencyRate_join")
```

 Now, I want to send it to a different/new folder to confirm the information:

  

```
df_read.write.mode("overwrite").format("delta").save("/sqlserverlessanalitics/FactCurrencyRate_join/Timetravel")
```

 I am working here with files, you can also do the same with Spark Delta tables if you prefer.

 **How can I make Delta Lake accessible for BI tools?**

 Using **SQL Serverless Pool** as it does support Delta files or tables inside of Spark you can easily query it or create views on top of it. You could even build your logical Datawarehouse or just explore the data, Fig 4 results:

  

```sql
SELECT     TOP 100 * 

FROM OPENROWSET(  BULK 'https://Storage.blob.core.windows.net/Container/sqlserverlessanalitics/FactCurrencyRate_join/Timetravel',         
FORMAT = 'Delta'     ) AS [result]
```

 **Conclusion:**

Delta time travel can be used inside Synapse Spark as an option to do a point-in-time recovery while building a Lakehouse architecture. That is very useful as you can also use it to roll back changes, create snapshot scenarios, and manage the file versions and changes on top of your Data lake architecture. As Serverless SQL pools support Delta format and it is integrated with Spark you can use it to explore further as an end-to-end solution.

  **Ref:**

 [How to Query Delta Lake Tables in Lake Databases Using Serverless SQL? - YouTube](https://www.youtube.com/watch?v=LSIVX0XxVfc&t=184s)

 [Synapse Espresso: Introduction to Delta Tables - YouTube](https://www.youtube.com/watch?v=B_wyRXlLKok&t=9s)

 [Synapse Spark Delta Time Travel - Microsoft Community Hub](https://techcommunity.microsoft.com/t5/azure-synapse-analytics-blog/synapse-spark-delta-time-travel/ba-p/3646789)

 

 

 

 

 

 

 