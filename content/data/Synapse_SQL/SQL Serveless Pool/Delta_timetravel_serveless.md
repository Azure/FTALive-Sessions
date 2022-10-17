## Serverless SQL Pool and Delta time travel

***\*[Home](../tobedefined.md)\**** - [Next >](TBD.md)

**What is Delta?**

Delta lake is an open-source storage framework that enables building a Lakehouse Architecture. Delta Lake is simple: Information about which objects are part of a Delta table is maintained in an ACID manner, using a write-ahead log that is itself stored in the cloud object store. The objects themselves are encoded in Parquet. Delta lake is becoming increasingly popular and you can use it inside of your Synapse Workspace.

Ref: [Home | Delta Lake](https://delta.io/)

 

**What is Time travel using Delta?**

Use time travel to let users query point-in-time snapshots or roll back erroneous updates to their data. 

 

**Actually, using Delta Time travel**

 

The solution is very simple. The plan is to export a point in time to recover a change in a transaction. The steps are to be executed in an environment you already set up the Delta files.

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
from delta.tables import * deltaTable = DeltaTable.forPath(spark, "/sqlserverlessanalitics/FactCurrencyRate_join/") 

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

  

```
SELECT     TOP 100 * 

FROM OPENROWSET(  BULK 'https://Storage.blob.core.windows.net/Container/sqlserverlessanalitics/FactCurrencyRate_join/Timetravel',         
FORMAT = 'Delta'     ) AS [result]
```

 **Creating Delta Tables**

There is a service inside of the Serverless SQL Pool that ensures the metadata sync with Spark, hence external tables created and managed on the Lake database are also made available as external tables with the same name in the corresponding synchronized database in the Serverless SQL pool. Therefore, Spark and Serverless SQL Pool are integrated and you can use it to create Delta tables and expose them to Analysis Services, Power BI, or any other tool connected to Serverless SQL Pool.

Ref: [Shared metadata tables - Azure Synapse Analytics | Microsoft Learn](https://learn.microsoft.com/en-us/azure/synapse-analytics/metadata/table)

 

For Example, I am reading the files from my folder which contains a set parquet with information of FactCurrencyRate - called FactCurrencyRate_Parquet, and then I save them as Delta Table on the Lake Database Default:

  

```
df = spark.read\ 

.format('delta')\ 

 .load("/sqlserverlessanalitics/FactCurrencyRate_Parquet") 

df.write.format("delta").mode("overwrite").saveAsTable("default.FactCurrencyRate_join")
```

 **Conclusion:**

Delta time travel can be used inside Synapse Spark as an option to do a point-in-time recovery while building a Lakehouse architecture. That is very useful as you can also use it to roll back changes, create snapshot scenarios, and manage the file versions and changes on top of your Data lake architecture. As Serverless SQL pools support Delta format and it is integrated with Spark you can use it to explore further as an end-to-end solution.

 

 

 

 

 

 

 

 