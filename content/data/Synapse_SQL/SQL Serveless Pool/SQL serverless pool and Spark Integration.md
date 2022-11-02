## Synapse Serverless SQL pool 

[Back<](https://github.com/LiliamLeme/FTALive-Sessions_Synapse_SQL/blob/main/content/data/Synapse_SQL/SQL%20Serveless%20Pool/FilenameFilepath.md) -[Home](https://github.com/LiliamLeme/FTALive-Sessions_Synapse_SQL/blob/main/content/data/Synapse_SQL/SQL%20Serveless%20Pool/Agenda_serveless.md)\- [>Next](https://github.com/LiliamLeme/FTALive-Sessions_Synapse_SQL/blob/main/content/data/Synapse_SQL/SQL%20Serveless%20Pool/Delta_timetravel_serveless.md)

### Spark Integration overview

Azure Synapse Analytics provides multiple query runtimes that you can use to query in-database or external data. You have the choice to use T-SQL queries using a serverless Synapse SQL pool or notebooks in Apache Spark for Synapse analytics to analyse your data.

For example:

1) Using notebooks you can code with the languages supported in Spark like Phyton. In the following example data is available via the dataframe named **df** and load into a Spark database named **nyctaxi**.

   Add a new code cell to the notebook, and then enter the following code ( Notebook from Synapse Studio):

   ```
   %%pyspark
   spark.sql("CREATE DATABASE IF NOT EXISTS nyctaxi")
   df = spark.read.load('abfss://users@contosolake.dfs.core.windows.net/NYCTripSmall.parquet', format='parquet')
   display(df.limit(10))
   
   df.write.mode("overwrite").saveAsTable("nyctaxi.FTALL")
   ```

   

2. Run this select using Serverless SQL Pool ( SQL Script from Synapse Studio)

```
SELECT TOP (100) [DateID]
                ,[MedallionID]
                ,[HackneyLicenseID]
                ,[PickupTimeID]
                ,[DropoffTimeID]
                ,[PickupGeographyID]
                ,[DropoffGeographyID]
                ,[PickupLatitude]
                ,[PickupLongitude]
                ,[PickupLatLong]
                ,[DropoffLatitude]
                ,[DropoffLongitude]
                ,[DropoffLatLong]
                ,[PassengerCount]
                ,[TripDurationSeconds]
                ,[TripDistanceMiles]
                ,[PaymentType]
                ,[FareAmount]
                ,[SurchargeAmount]
                ,[TaxAmount]
                ,[TipAmount]
                ,[TollsAmount]
                ,[TotalAmount]
 FROM [nyctaxi].[dbo].[ftall]
```

**MetaDatasync**

There is a service inside of the Serverless SQL Pool that ensures the metadata sync with Spark, hence external tables created and managed on the Lake database are also made available as external tables with the same name in the corresponding synchronized database in the Serverless SQL pool. Therefore, Spark and Serverless SQL Pool are integrated and you can use it to create Delta tables and expose them to Analysis Services, Power BI, or any other tool connected to Serverless SQL Pool.



**Delta** 

The serverless SQL pool also enables you to read the data stored in Delta Lake format, and serve it to reporting tools. A serverless SQL pool can read Delta Lake files that are created using Apache Spark, Azure Databricks, or any other producer of the Delta Lake format.

**Example**: https://raw.githubusercontent.com/Azure-Samples/Synapse/main/SQL/Samples/LdwSample/SampleDB.sql



**What is Delta?**

Delta lake is an open-source storage framework that enables building a Lakehouse Architecture. Delta Lake is simple: Information about which objects are part of a Delta table is maintained in an ACID manner, using a write-ahead log that is itself stored in the cloud object store. The objects themselves are encoded in Parquet. Delta lake is becoming increasingly popular and you can use it inside of your Synapse Workspace.



Syntax example: 

```
SELECT TOP 10 *
FROM OPENROWSET(
    BULK 'https://sqlondemandstorage.blob.core.windows.net/delta-lake/folder/',
    FORMAT = 'delta') as rows;
```

The URI in the `OPENROWSET` function must reference the root Delta Lake folder that contains a subfolder called `_delta_log`.

**Creating Delta Tables**

Using the same example that was proposed to create a spark table we can create a Delta table, the difference lies on the fact we are specifying Delta format.

  

```
%%pyspark
#spark.sql("CREATE DATABASE IF NOT EXISTS nyctaxi")
df = spark.read.load('abfss://users@contosolake.dfs.core.windows.net/NYCTripSmall.parquet', format='parquet')

df.write.format("delta").mode("overwrite").saveAsTable("nyctaxi.FTALL_delta")
```





Reference

 [Shared metadata tables - Azure Synapse Analytics | Microsoft Learn](https://learn.microsoft.com/en-us/azure/synapse-analytics/metadata/table)

[Home | Delta Lake](https://delta.io/)
