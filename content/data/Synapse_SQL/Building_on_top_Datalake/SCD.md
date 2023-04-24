## Slow Change Dimension

### Slow Change Dimension overview

[Home](https://github.com/LiliamLeme/FTALive-Sessions_Synapse_SQL/blob/main/content/data/ModernDatawarehouse-Security/Agenda.md)\- [Next >](https://github.com/LiliamLeme/FTALive-Sessions_Synapse_SQL/blob/main/content/)

#### Slow Change Dimension 

**Scenario**: Customer wants to implement on top of the Data Lake customer wants to a Slow Change Dimension type 2. For this scenario, I will use Serverless SQL Pool for this example.

Next post I will use the same approach to do this using Spark, only.


**What is Slow Change Dimension Type 2?**

**Slow Change Dimension type 2**: This method tracks historical data by creating multiple records for a given [natural key](https://en.wikipedia.org/wiki/Natural_key) in the dimensional tables with separate [surrogate keys](https://en.wikipedia.org/wiki/Surrogate_key) and/or different version numbers.

Reference: https://en.wikipedia.org/wiki/Slowly_changing_dimension

There are multiple approaches that could be used to create a Slow Change Dimension, those approaches may vary accordingly to how the data has been handled on the source. For instance, if the source has information such as row version or columns using flags as deleted or updated and etc, you could use a completely different approach from the one I am using.  Considering that I will follow with more details that I am considering for this scenario. 

**Considerations for this Scenario:**

- This scenario is managing UPSERT and file versioning.
- The files are not coming from the source with version, or information if the row was updated or deleted. 
- Those files have a key value that is used to filter if they already exist or not on the destination. If you do not have a key column to compare. You will need to compare all the columns that the business considers as key values to determine if the information is new or not. 
- The source will send the information on the file regardless if it is a new row to be inserted or updated. In other words, the process of transformation and cleansing needs to understand if the value on the file refers to an updated row or a new row. So this solution tries to understand that scenario and based on that version it accordingly. If your source can send the rows in an accurate way in which it is clear which row is updated, you can change the steps accordingly. 
Solution:

Consider as in the example below the folder sourcefiles_folder with all files in parquet format which were sent from the source to be compared to a destination. My destination is the external table: SCD_DimDepartmentGroup.

 The file has the following columns:

      

Column

Datatype

 

DepartmentGroupKey

int

Not Null

ParentDepartmentGroupKey

int

NULL

DepartmentGroupName

nvarchar

Not Null

 

Here are the current values for this table - SCD_DimDepartmentGroup as Fig. 1, shows:

The last surrogate key is of the value of 8:

![image](https://user-images.githubusercontent.com/62876278/234089704-c95e4622-1f08-4d81-babf-de869fa91f57.png)


Fig. 1

 

Code - First Load and Dimension Creation:

```sql
CREATE EXTERNAL TABLE SCD_DimDepartmentGroup
  WITH (
    LOCATION = '/SCD_DimDepartmentGroup',
    DATA_SOURCE = SCD_serveless_dim,
    FILE_FORMAT = Parquet_file
      ) 
  AS
  SELECT ROW_NUMBER () OVER (ORDER BY DepartmentGroupKey) ID_Surr
         ,[DepartmentGroupKey]
        ,[ParentDepartmentGroupKey]
        ,[DepartmentGroupName]
        ,1 ID_valid
        ,0 ID_Deleted
        ,Curr_date as From_date
        ,Null as End_date
    FROM
    OPENROWSET(
               BULK 'https://Storage.blob.core.windows.net/Container/SCD/sourcefiles_folder/',
               FORMAT = 'PARQUET'
               ) AS [SCD_DimDepartmentGroup]
   
``` 

 

**1) Step 1 - Create a CETAS for new values**

*TableA_SCD_DimDepartmentGroup_NEW* - In this example, this step will basically insert all the values that exist on the files and **do not exist on the destination** into an External Table.

The column DepartmentGroupKey defines if the row is new or not. You will need a column or columns to understand if this is considered new information or not in your dimension.

 

Please note three columns were added to this example:

- As Curr_date is the date where the row was inserted into the table. So we are using getdate()
- 1 ID_Valid which means this is a new valid row
- 1 ID_Delete which means this row was not deleted Or versioned.

 

Code:

 

First, let's create the data source that will be used across all the external tables 

 

 

 

```sql
  CREATE EXTERNAL DATA SOURCE SCD_serveless_dim
  WITH (
  LOCATION = 'https://Storage.blob.core.windows.net/Container/SCD/transformation_folder/',
  CREDENTIAL = [MSI]
  ) 
```

 

 

 

Now, let's create the external table for Step 1:

 

 

```applescript
CREATE EXTERNAL TABLE TableA_SCD_DimDepartmentGroup_NEW
WITH (
    LOCATION = '/TableA_SCD_DimDepartmentGroup_NEW',
    DATA_SOURCE = SCD_serveless_dim,
    FILE_FORMAT = Parquet_file
      ) 
  AS
  SELECT [DepartmentGroupKey]
        ,[ParentDepartmentGroupKey]
        ,[DepartmentGroupName]
        ,1 ID_valid
        ,0 ID_Deleted
        ,Getdate() as Curr_date

FROM
    OPENROWSET(
        BULK 'https://Storage.blob.core.windows.net/Container/SCD/sourcefiles_folder/',
        FORMAT = 'PARQUET' ---DELTA can be used here 
    ) AS [SCD_DimDepartmentGroup_Silver]

WHERE NOT EXISTS ( 
                SELECT 1
                FROM SCD_DimDepartmentGroup
                WHERE   SCD_DimDepartmentGroup_Silver.[DepartmentGroupKey] =   SCD_DimDepartmentGroup.DepartmentGroupKey        
                   )
```

 

 

 

Results in Fig. 1 - Step 1:

![image](https://user-images.githubusercontent.com/62876278/234083999-458f90be-4796-494d-8cd2-fa36b8abcaad.png)

Fig. 1 - Step 1.

 

 

 

 

**2)** **Step 2 -** **Create a CETAS for values that will be updated/versioned.**

 

*TableB_SCD_DimDepartmentGroup_OLD* will be the next external table to be created by inserting all values that exist on the file exported from the source and do exist on the destination, also those values should not exist on the external table created in Step 1 (A).

So basically here you have the data that will be versioned, it is not a new row(Step 1) it is rows that do exist on the destination but something has changed. 

DepartmentGroupKey is the key that always would be the same in this scenario, so if there is a new key, it means a new row. Hence, the comparison will happen for any other column. I am also considering in this scenario that sometimes the source sends the same information again without any change at all, so the point in comparing it is to be sure the row sent is in fact a row to be versioned. 

 

Please note for the rows to be versioned:

- Flag ID_Valid was changed to 0
- ID_Deleted was invalidated by changing the value to 1. 
- Curr_date here is the date the row was inserted on the table SCD_DimDepartmentGroup, so the From_date column is re-used.
- NULL columns are been handled properly(ISNULL) to find the ones that in fact changed.

 

Please note I using getting the max value+1 of my surrogate key column ID_Surr of the main table SCD_DimDepartmentGroup. Following, I will add the same value for all the rows that still will have a new surrogate value to be created, and if the values repeat that is ok ( at this point), later on in the last step( Step 5) I will reuse this information with Departament Key to create a new Surrogate key, therefore, a new unique value per rows. The fact I am using max+1 is just because I want to be sure I will not mess up the surrogate that already exists. 

 

```sql
DECLARE @ID_Surr AS INT

SELECT @ID_Surr = MAX (ID_Surr)+1 FROM SCD_DimDepartmentGroup

CREATE EXTERNAL TABLE TableA_SCD_DimDepartmentGroup_NEW
WITH (
    LOCATION = '/TableA_SCD_DimDepartmentGroup_NEW',
    DATA_SOURCE = SCD_serveless_dim,
    FILE_FORMAT = Parquet_file
      ) 
  AS
  SELECT @ID_Surr as ID_Surr
        ,[DepartmentGroupKey]
        ,[ParentDepartmentGroupKey]
        ,[DepartmentGroupName]
        ,1 ID_valid
        ,0 ID_Deleted
        ,Getdate() as Curr_date

FROM
    OPENROWSET(
        BULK 'https://Storage.blob.core.windows.net/Container/SCD/sourcefiles_folder/',
        FORMAT = 'PARQUET' ---DELTA can be used here 
    ) AS [SCD_DimDepartmentGroup_Silver]

WHERE NOT EXISTS ( 
                SELECT 1
                FROM SCD_DimDepartmentGroup
                WHERE   SCD_DimDepartmentGroup_Silver.[DepartmentGroupKey] =   SCD_DimDepartmentGroup.DepartmentGroupKey        
                   )
```

 

 

 

 

Results are Fig. 2 - Step 2 :

![image](https://user-images.githubusercontent.com/62876278/234084693-9a576362-f7cc-43bc-9997-386511531b5e.png)

Fig. 2 - Step 2

 

 

**3)** **Step 3 -** **Only updated values are to be versioned**

*TableC_SCD_DimDepartmentGroup_GOLD_OLD_INS-*The next external table will get the new rows from the source file. The filter will be the rows that we already know something changed and needs to be versioned from Step 2.

 

Code:

 
```sql
DECLARE @ID_Surr AS INT

SELECT @ID_Surr = MAX (ID_Surr)+1 FROM SCD_DimDepartmentGroup

CREATE EXTERNAL TABLE TableC_SCD_DimDepartmentGroup_GOLD_OLD_INS
WITH (
       LOCATION = '/TableC_SCD_DimDepartmentGroup_GOLD_OLD_INS',
    DATA_SOURCE = SCD_serveless_dim,
    FILE_FORMAT = Parquet_file
      ) 
  AS
  SELECT  @ID_Surr as ID_Surr
         ,[DepartmentGroupKey]
        ,[ParentDepartmentGroupKey]
        ,[DepartmentGroupName]
        ,1 ID_valid
        ,0 ID_Deleted
        ,getdate() Curr_date
FROM
FROM
    OPENROWSET(
        BULK 'https://Storage.blob.core.windows.net/Container/SCD/sourcefiles_folder/',
        FORMAT = 'PARQUET'
    )  AS [SCD_DimDepartmentGroup_Silver]
WHERE  EXISTS   (SELECT 1 FROM   TableB_SCD_DimDepartmentGroup_OLD  
                  WHERE   SCD_DimDepartmentGroup_Silver.[DepartmentGroupKey] =   TableB_SCD_DimDepartmentGroup_OLD.DepartmentGroupKey)
```

 

 

 

 

The results are in Fig. 3 - Step :

 

![image](https://user-images.githubusercontent.com/62876278/234085808-5877e731-a7c5-4dce-961d-afc6a88b0389.png)

Fig. 3 - Step 3

 

**4**) **Step 4 - Create another external table by Union** for all those external tables that were created on the latest steps.

- EndDatate should be null for new rows or new values versioned. If the value was versioned the respective row will contain until when it was valid.

- ID_valid will be 1 if the row is not versioned, 0 if this row is no longer valid

- ID_Deleted will be 0 if the row is not versioned, 1 if this row is no longer valid

   

 

 

```sql
 CREATE EXTERNAL TABLE UNION_SCD_DimDepartmentGroup
  WITH (
    LOCATION = '/UNION_SCD_DimDepartmentGroup',
    DATA_SOURCE = SCD_serveless_dim,
    FILE_FORMAT = Parquet_file
      ) 
  AS
  SELECT ID_Surr
        ,[DepartmentGroupKey]
        ,[ParentDepartmentGroupKey]
        ,[DepartmentGroupName]
        ,ID_valid
        ,ID_Deleted
        ,getdate() as From_date
        ,Null as End_date
FROM TableA_SCD_DimDepartmentGroup_NEW
UNION ALL
     SELECT ID_Surr 
        ,[DepartmentGroupKey]
        ,[ParentDepartmentGroupKey]
        ,[DepartmentGroupName]
        ,ID_valid
        ,ID_Deleted
        ,From_date as From_date
        ,Getdate() as End_date
FROM TableB_SCD_DimDepartmentGroup_OLD 
UNION ALL
SELECT ID_Surr 
        ,[DepartmentGroupKey]
        ,[ParentDepartmentGroupKey]
        ,[DepartmentGroupName]
        ,ID_valid
        ,ID_Deleted
        ,getdate() as From_date
        ,Null as End_date
FROM TableC_SCD_DimDepartmentGroup_GOLD_OLD_INS 
```

 

 

Results are - Fig. 4 - Union :

![image](https://user-images.githubusercontent.com/62876278/234091264-52e63e50-240d-4604-a0ef-948a2f18aaa8.png)

Fig. 4 Union

 

Here we have the new rows, new versioned rows consolidated on the external table.

**5) Step 5.** Next, we need to transfer this to our main table, by recreating an external table with the new information and dropping the old one.

\1) I need the data from the main table excluding the rows that were versioned on this round

\2) I need the data from the external tables Union.

\3) I need to keep the historical changes of the old/main table

\4) On top of that I will recreate the surrogate key.

 

```sql
SELECT ROW_NUMBER () OVER (ORDER BY ID_Surr, DepartmentGroupKey) ID_Surr
       ,[DepartmentGroupKey]
        ,[ParentDepartmentGroupKey]
        ,[DepartmentGroupName]
        ,ID_valid
        ,ID_Deleted
        ,From_date
        ,End_date
FROM (
      SELECT   ID_Surr
              ,[DepartmentGroupKey]
              ,[ParentDepartmentGroupKey]
              ,[DepartmentGroupName]
              ,ID_valid
              ,ID_Deleted
              ,From_date
              ,End_date
      FROM SCD_DimDepartmentGroup
      WHERE NOT EXISTS
          ( SELECT 1 FROM TableB_SCD_DimDepartmentGroup_OLD
            WHERE SCD_DimDepartmentGroup.DepartmentGroupKey = TableB_SCD_DimDepartmentGroup_OLD.DepartmentGroupKey
              )
      UNION 
      SELECT   ID_Surr
               ,[DepartmentGroupKey]
              ,[ParentDepartmentGroupKey]
              ,[DepartmentGroupName]
              , ID_valid
              ,ID_Deleted
              ,From_date
              ,End_date
      FROM UNION_SCD_DimDepartmentGroup
      UNION 
      SELECT   ID_Surr
              ,[DepartmentGroupKey]
              ,[ParentDepartmentGroupKey]
              ,[DepartmentGroupName]
              ,ID_valid
              ,ID_Deleted
              ,From_date
              ,End_date
      FROM SCD_DimDepartmentGroup
      WHERE  SCD_DimDepartmentGroup.ID_valid = 0
)NEW_SCD
```

  

 

Results are in Fig. 5 - New Table. Please note in green there are the rows that are versioned, and in blue are the new rows:

![image](https://user-images.githubusercontent.com/62876278/234087597-34cd44dc-6b24-414f-bdf0-32df3a77c19b.png)

Fig. 5 - New Table

 

This new table should replace the current SCD_DimDepartmentGroup, by recreating a new external table and dropping this old one. 

 

**Summary**:

Please review the scenario considerations to understand what was relevant for this implementation as I mentioned before, those approaches may vary accordingly to how the data has been handled on the source. Here I show in examples of how to read new data, version old data that has changed, and recreate new external tables with the old information plus the new version for a Slow Change Dimension type 2. 
