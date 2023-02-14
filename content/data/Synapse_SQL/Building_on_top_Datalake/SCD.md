**Scenario**: Customer wants to implement on top of the Data Lake customer wants to a Slow Change Dimension type 2. For this scenario, I will use code examples with Serverless SQL Pool and Spark.


**What is a Slow Change Dimension type 2?**

**Slow Change Dimension type 2**: This method tracks historical data by creating multiple records for a given [natural key](https://en.wikipedia.org/wiki/Natural_key) in the dimensional tables with separate [surrogate keys](https://en.wikipedia.org/wiki/Surrogate_key) and/or different version numbers. Unlimited history is preserved for each insert.

Reference: https://en.wikipedia.org/wiki/Slowly_changing_dimension

 

There are multiple approaches that could be used to create a Slow Change Dimension, those approaches may vary accordingly to how the data has been handled on the source. For instance, if the source has information such as row version or columns using flags as deleted or updated and etc, you could use a completely different approach from the one I am using.  Considering that I will follow with more details that I am considering for this scenario.

 

**Considerations for this Scenario:**

- This scenario is managing UPSERT and file versioning.
- The files are not coming from the source with version, or information if the row was updated or deleted. 
- Those files have a key value that is used to filter if they already exist or not on the destination. If you do not have a key column to compare. You will need to compare all the columns that the business considers as key values to determine if the information is new or not. 
- The source will send the information on the file regardless if it is a new row to be inserted or updated. In other words, the process of transformation and cleansing needs to understand if the value on the file refers to an updated row or a new row. So this solution tries to understand that scenario and based on that version it accordingly. If your source can send the rows in an accurate way in which it is clear which row is updated, it will be easier to implement the version control.

 

**Solution:**

Consider as in the example below the folder SCD_DimDepartmentGroup_silver with all files in parquet format which were sent from the source to be compared to a destination. My destination is the external table: SCD_DimDepartmentGroup.

 

The file has the following columns:

   

| Column                   | Datatype |          |
| ------------------------ | -------- | -------- |
| DepartmentGroupKey       | int      | Not Null |
| ParentDepartmentGroupKey | int      | NULL     |
| DepartmentGroupName      | nvarchar | Not Null |

 

The same approach on Serverless SQL Pool can be used on Spark. I will show examples of the code for both.

 

**Slow Change Dimension in 4 steps:**

The implementation of the SCD is quite simple is basically filtering, persisting the data filtered, and comparing.

 

 

Current values on the table:



 

- ID_Valid column will show if the row was versioned or not. 1 for a new row, 0 for a versioned row.
- ID_Delete column will show if the row is still valid or not. 0 for a new not, 1 for an invalid
- Curr_date is the date where the row was inserted into the table. 
- ID_Surr is a surrogate key created for this table. 

Values coming from the file - Blue are the new ones, yellow the ones to be version:

EXPLAIN BETTER sPARK EXAMPLES

AT THE END ADD THE SURROGATE TO MAIN TABLE.

 

\1) **Create a CETAS for new values**

 

 able A - In this example, this step will basically insert all the values that exist on the files and **do not exist on the destination** into an External Table (SCD_DimDepartmentGroup_NEW).

 

Please note three columns were added to this example:

- As Curr_date is the date where the row was inserted into the table. So we are using getdate()

 

Code:

 

 

 

 

 

--Storage path where the result set will be materialized CREATE EXTERNAL DATA SOURCE SCD_serveless_dim WITH ( LOCATION = 'https://Storage.blob.core.windows.net/Container/SCD/SCD_DimDepartmentGroup', CREDENTIAL = [MSI]  )    CREATE EXTERNAL TABLE SCD_DimDepartmentGroup_NEW   WITH (     LOCATION = '/A_TABLE,     DATA_SOURCE = SCD_serveless_dim,     FILE_FORMAT = Parquet_file       )    AS   SELECT [DepartmentGroupKey]         ,[ParentDepartmentGroupKey]         ,[DepartmentGroupName]         ,1 ID_valid         ,0 ID_Deleted         ,Getdate() as Curr_date FROM     OPENROWSET(         BULK 'https://Storage.blob.core.windows.net/Container/SCD /SCD_DimDepartmentGroup_Silver/',         FORMAT = 'PARQUET' ---DELTA can be used here      ) AS [SCD_DimDepartmentGroup_Silver] WHERE NOT EXISTS (                  SELECT 1                 FROM                     OPENROWSET(                         BULK 'https://Storage.blob.core.windows.net/Container/SCD/SCD_DimDepartmentGroup/*.parquet',                         FORMAT = 'PARQUET'                     ) AS [SCD_DimDepartmentGroup]                 WHERE   SCD_DimDepartmentGroup_Silver.[DepartmentGroupKey] =   SCD_DimDepartmentGroup.DepartmentGroupKey                                                    )

 

 

 

 

Results:

 



 

 

**Spark**:

Same step using Spark instead of serverless

 

Step 1 - PySpark:

 

Note to add the new columns on Spark you could use the following:

scala:

 

 

import org.apache.spark.sql.SparkSession import org.apache.spark.sql.functions.{col, lit, typedLit, when} import org.apache.spark.sql.types.IntegerType val df_ids = df.withColumn("ID_valid",lit("1").cast(IntegerType)).withColumn("ID_Deleted",lit("0").cast(IntegerType))

 

 

Pyspark:

 

 

%%pyspark ##reading the view created on the previous step with pyspark ##using the function window to create a sequential value for the columns Surrogate_ID ##adding the column current_date to manage when the data was inserted on the silver  from pyspark.sql.window import Window from pyspark.sql.functions import col, row_number, concat from pyspark.sql import functions as F w = Window().orderBy("CurrencyKey") Reading_df_col = Reading_df.withColumn("surrogate_ID", concat(row_number().over(w) + 1)).withColumn("Curr_date", F.current_date())

 

 

 

Pyspark - Inserting new values using data frame joins

 

 

 

%%pyspark   #REad the data df_silver = spark.read\   .format('delta')\   .load("/SCD/SCD_DimDepartmentGroup_Silver")  df_main = spark.read\   .format('delta')\   .load("/SCD/SCD_DimDepartmentGroup ")  ##Insert - Returns only columns from the left dataset for non-matched records. df_left_forIns= df_silver.join(df_main,df_silver.DepartmentGroupKey == df_main.DepartmentGroupKey, "leftanti") df_left_forIns.show()

 

 

 

 

 

 

\2) **Create a CETAS for values that will be updated/versioned.**

 

Create another external SCD_DimDepartmentGroup_OLD - table(B) by inserting all values that exist on the file exported from the source and do exist on the destination, also those values should not exist on the external table created in step1 (A).

So basically here you have the data that will be versioned, it is not a new row it is rows that do exist on the destination but something changed. 

My business rule said the DepartmentGroupKey would always be the same, so the comparison will happen for the other columns. Also, sometimes the source sends the same information over again without any change, so the point in comparing is to be sure the row in fact needs to be versioned.

 

Please note, the flag ID_Valid was changed to 0, and ID_Deleted was invalidated by changing the value to 1. 

Curr_date here is the date the row was inserted on the table SCD_DimDepartmentGroup, so the From_date column is used.

 

Code:

 

 

 

 

CREATE EXTERNAL TABLE SCD_DimDepartmentGroup_OLD   WITH (          LOCATION = '/B_TABLE',     DATA_SOURCE = SCD_serveless_dim,     FILE_FORMAT = Parquet_file       )    AS   SELECT [DepartmentGroupKey]         ,[ParentDepartmentGroupKey]         ,[DepartmentGroupName]         ,0 ID_valid         ,1 ID_Deleted         , From_date as Curr_date FROM     OPENROWSET(         BULK 'https://Storage.blob.core.windows.net/Container/SCD/SCD_DimDepartmentGroup/',         FORMAT = 'PARQUET' ---DELTA can be used here      ) AS [SCD_DimDepartmentGroup] WHERE NOT   EXISTS ( SELECT 1                 FROM                     OPENROWSET(                         BULK 'https://Storage.blob.core.windows.net/Container/SCD/SCD_DimDepartmentGroup_Silver/',                         FORMAT = 'PARQUET'                     ) AS [SCD_DimDepartmentGroup_Silver]                  WHERE   SCD_DimDepartmentGroup_Silver.[DepartmentGroupKey] =   SCD_DimDepartmentGroup.DepartmentGroupKey                         AND  (ISNULL(SCD_DimDepartmentGroup_Silver.[ParentDepartmentGroupKey], 1) =   ISNULL(SCD_DimDepartmentGroup.[ParentDepartmentGroupKey], 1)                         AND  SCD_DimDepartmentGroup_Silver.[DepartmentGroupName] = SCD_DimDepartmentGroup.[DepartmentGroupName])                      )                   AND NOT EXISTS                        (SELECT 1 FROM SCD_DimDepartmentGroup_GOLD_NEW                       WHERE   SCD_DimDepartmentGroup_NEW.[DepartmentGroupKey] =   SCD_DimDepartmentGroup.DepartmentGroupKey)

 

 

 

 

Results are:



 

 

 

 

**Spark**:

 

Same step using Spark instead of serverless

 

Step 2 – PySpark with Spark SQL:

 

 

 

 

 

 

\#Everything that exist as the same in both dataframes #first steps for the update #using Spark SQL df_main.createOrReplaceTempView("df_main_view") df_silver.createOrReplaceTempView("df_silver_view") df_left_forIns.createOrReplaceTempView("df_left_forIns_view")  df_join_forUpd=spark.sql("select Main.DepartmentGroupKey,Main.ParentDepartmentGroupKey, Main.DepartmentGroupName, Main.ID_valid, Main.ID_Deleted, Main.surrogate_ID, Main.Curr_date  from df_main_view Main inner join df_silver_view SILVER on SILVER.DepartmentGroupKey = Main.DepartmentGroupKey and ISNULL(SILVER.ParentDepartmentGroupKey) = ISNULL( Main.ParentDepartmentGroupKey) and SILVER.DepartmentGroupName = Main.DepartmentGroupName  where not exists (select 1 from df_left_forIns_view Ins where Ins.DepartmentGroupKey == Main.DepartmentGroupKey)")

 

 

 

 

 

 

\3) **Only updated values are to be versioned**

 

Create another external SCD_DimDepartmentGroup_OLD_INS - table(C) by inserting all rows from the source that do not exist on the external tables created by other steps (B) into the third external table. So here is only the data that has changed, and it is not the new data.

 

SCD_DimDepartmentGroup_GOLD_OLD -> this table has the old data from SCD_DimDepartmentGroup that has changed.

SCD_DimDepartmentGroup_OLD_INS -> this table has the new rows with the data that has changed to be versioned

 

Code:

 

 

 

 

CREATE EXTERNAL TABLE SCD_DimDepartmentGroup_OLD_INS   WITH (        LOCATION = '/C_TABLE',     DATA_SOURCE = SCD_serveless_dim,     FILE_FORMAT = Parquet_file       )    AS   SELECT [DepartmentGroupKey]         ,[ParentDepartmentGroupKey]         ,[DepartmentGroupName]         ,1 ID_valid         ,0 ID_Deleted         ,getdate() Curr_date FROM     OPENROWSET(         BULK 'https://Storage.blob.core.windows.net/Container/SCD/SCD_DimDepartmentGroup_Silver/*.parquet',         FORMAT = 'PARQUET'     )  AS [SCD_DimDepartmentGroup_Silver] WHERE  EXISTS   (SELECT 1 FROM SCD_DimDepartmentGroup_OLD                   WHERE   SCD_DimDepartmentGroup_GOLD_OLD.[DepartmentGroupKey] =   SCD_DimDepartmentGroup_Silver.DepartmentGroupKey)

 

 

 

 

Results are:



 

 

 

**Spark**

 

Step 3 - Same step using Spark instead of serverless - PySpark

 

 

 

 

 

 

\#everyhing from the df_main that do not exist on df_join_forUpd and df_left_forIns df_anti_forUpd = df_main.join(df_join_forUpd,df_main.DepartmentGroupKey == df_join_forUpd.DepartmentGroupKey, "leftanti")

 

 

 

 

 

 

\4) Create another external table by Union all those tables before.

Union all those 3 external tables into a 4th one with the version control established.

 

Code:

 

 

 

 

 

CREATE EXTERNAL TABLE SCD_DimDepartmentGroup_VERSION   WITH (     LOCATION = '/SCD_DimDepartmentGroup_VERSION',     DATA_SOURCE = SCD_serveless_dim,     FILE_FORMAT = Parquet_file       )    AS   SELECT [DepartmentGroupKey]         ,[ParentDepartmentGroupKey]         ,[DepartmentGroupName]         ,ID_valid         ,ID_Deleted         ,Curr_date as From_date         ,Null as End_date FROM SCD_DimDepartmentGroup_OLD_INS UNION ALL      SELECT [DepartmentGroupKey]         ,[ParentDepartmentGroupKey]         ,[DepartmentGroupName]         ,ID_valid         ,ID_Deleted         ,Curr_date as From_date         ,getdate() as End_date FROM SCD_DimDepartmentGroup_OLD  UNION ALL      SELECT [DepartmentGroupKey]         ,[ParentDepartmentGroupKey]         ,[DepartmentGroupName]         ,ID_valid         ,ID_Deleted         ,Curr_date as From_date         ,Null as End_date FROM SCD_DimDepartmentGroup_new 

 

 

 

 

 

 

 

 

Results are:

 



Results are:

 



 

**Spark**

Step 4 - Same step using Spark instead of serverless - PySpark

 

 

 

 

 

\##Union the data frames. Now we can merge and manage  the versions unionDF = df_anti_forUpd.union(df_left_forIns)  ##and add the version with merge: from pyspark.sql.functions import * from delta.tables import *  deltaTableNew = DeltaTable.forPath(spark, '/sqlserverlessanalitics/SCD/SCD_DimDepartmentGroup_spark')  deltaTableNew.alias('SCD_DimDepartmentGroup_spark') \   .merge(     unionDF.alias('updates'),     'SCD_DimDepartmentGroup_spark.DepartmentGroupKey = updates.DepartmentGroupKey'    ) \   .whenMatchedUpdate(set =     {         "ID_valid": "0",         "ID_Deleted" : "1"     }   ) \   .whenNotMatchedInsert(values =     {       "DepartmentGroupKey" :"updates.DepartmentGroupKey",       "ParentDepartmentGroupKey" :"updates.ParentDepartmentGroupKey",       "DepartmentGroupName" :"updates.DepartmentGroupName",       "ID_valid" : "1",       "ID_Deleted":"0",       "Curr_date" : current_date()     }   ) \   .execute()

 

 

 

 

 

 

 

 

 

 