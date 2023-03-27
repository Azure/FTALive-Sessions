## Data Cleaning

[<Back](https://github.com/LiliamLeme/FTALive-Sessions_Synapse_SQL/blob/main/content/data/ModernDatawarehouse-Security/Overviewof_Defender.md)\- [Next >](https://github.com/LiliamLeme/FTALive-Sessions_Synapse_SQL/blob/main/content/data/ModernDatawarehouse-Security/Data%20factoryandSpark.md)

#### Spark



*Please note: All my examples are using pyspark*

 

In my scenario, I am exporting multiple tables from SQLDB to a folder using a notebook and running the requests in parallel.

This post here: [MSSparkUtils is the Swiss Army knife inside Synapse Spark - Microsoft Community Hub](https://techcommunity.microsoft.com/t5/azure-synapse-analytics-blog/mssparkutils-is-the-swiss-army-knife-inside-synapse-spark/bc-p/3699228#M716) mentioned the logic of reusing the same session. Comments of my colleague martinB on that post will be shown in more detail in the next example to export the data from SQLDB into the Data Lake:

 

**Exporting the data and building the lab**

  

```applescript
from concurrent.futures import ThreadPoolExecutor

timeout = 3600 # 3600 seconds = 1 hour

notebooks = [
    {"path": "notebook1", "params": {"param1": "value1"}},
    {"path": "notebook2", "params": {"param2": "value2"}},
    {"path": "notebook3", "params": {"param3": "value3"}},
]

with ThreadPoolExecutor() as ec:
    for notebook in notebooks:
        ec.submit(mssparkutils.notebook.run, notebook["path"], timeout, notebook["params"])
```

 

This is the doc for reference on how to use the thread pool [concurrent.futures — Launching parallel tasks — Python 3.11.1 documentation.](https://docs.python.org/3/library/concurrent.futures.html)

Colleagues from Microsoft build this nice framework [Synapse Spark pool optimization via Genie through multiple notebooks on same cluster instance (microsoft.com)](https://techcommunity.microsoft.com/t5/azure-synapse-analytics-blog/improve-spark-pool-utilization-with-synapse-genie/ba-p/3690428) you could also improve your logical execution on Spark.

 

Back to the script I just mentioned. I will basically create a notebook connecting to the Adventureworks2017 database hosted on the SQLDB server. I will use SQL Server user through the JDBC connector. The notebook will be called: Notebook_interactive

Tables names will be parameters that will be input into this notebook through another one that will trigger the parallel execution.

Data will be exported to my storage connected to synapse on the following path: "/SQLDB_intrc/Tables/"

 

Notebook_interactive code:

 

```applescript
from concurrent.futures import ThreadPoolExecutor

timeout = 3600 # 3600 seconds = 1 hour

notebooks = [
    {"path": "notebook1", "params": {"param1": "value1"}},
    {"path": "notebook2", "params": {"param2": "value2"}},
    {"path": "notebook3", "params": {"param3": "value3"}},
]

with ThreadPoolExecutor() as ec:
    for notebook in notebooks:
        ec.submit(mssparkutils.notebook.run, notebook["path"], timeout, notebook["params"])
```

 



Using thread pool I will show a small example with the table names: Production.Product and Production.Workorder hardcoded into the notebook that will trigger the parallel execution:

 

```applescript
from concurrent.futures import ThreadPoolExecutor

timeout = 3600 # 3600 seconds = 1 hour

notebooks = [
    {"path": "notebook1", "params": {"param1": "value1"}},
    {"path": "notebook2", "params": {"param2": "value2"}},
    {"path": "notebook3", "params": {"param3": "value3"}},
]

with ThreadPoolExecutor() as ec:
    for notebook in notebooks:
        ec.submit(mssparkutils.notebook.run, notebook["path"], timeout, notebook["params"])
```

 

 

As you can see in Fig 1 - execution, it shows both notebooks were called and executed in parallel:

 

![image-20230327192852936](C:\Users\lilem\AppData\Roaming\Typora\typora-user-images\image-20230327192852936.png)

Fig 1 - execution

 

Ok. Data exported, now let's work on it!

 

**Organizing the data**

 

If you are not familiar with Data lake, Lakehouse, Bronze, Silver, and Gold. It will be good to get to know more about it. 

 

Following some great references for a start:

[Data landing zones - Cloud Adoption Framework | Microsoft Learn](https://learn.microsoft.com/en-us/azure/cloud-adoption-framework/scenarios/cloud-scale-analytics/architectures/data-landing-zone#data-lake-services)

[adlsguidancedoc/Hitchhikers_Guide_to_the_Datalake.md at master · rukmani-msft/adlsguidancedoc (github.com)](https://github.com/rukmani-msft/adlsguidancedoc/blob/master/Hitchhikers_Guide_to_the_Datalake.md)

https://techcommunity.microsoft.com/t5/azure-synapse-analytics-blog/synapse-data-lake-vs-delta-lake-vs-data-lakehouse/ba-p/3673653

 

Considering you already read the content above or you already know about it. Let's start with how to handle the data that was exported.

The data landed on the Bronze or Raw zone. While going through my Silver zone I will clean and organize the data to be fit for the purpose of my Analytics project that will connect to my Gold zone.

*Please note: All my examples are using pyspark*

 

**Cleaning the Data**

 

So, from this point on I will follow with some tips that can be done to clean your data. What you will use and if you will use any of the information I am sharing will really depend on your business requirements.

 

I will start my example with Production.Product file. The examples below use **pandas**, hence to visualize the data I am using the **head()** method.

 

**First lets open and review the file using different formats:**

 

1) 
   \1) CSV with pandas

    

   ```applescript
   import pandas as pd
   
   ##CSV
   df = pd.read_csv(r'https://StorageAccount.blob.core.windows.net/Container/FILENAME.csv')
   #shows the data
   df.head()
   ```

    

   \2) Excel - For this one, I needed to install the xlrd. Just run this alone in a notebook cell

    

    

    

   ```applescript
   !pip install xlrd
   ```

    

    

   Reading the excel file:

    

    

   ```applescript
   import pandas as pd
   file =('https://StorageAccount.blob.core.windows.net/Container/filename.xlsx')
   excel_panda = pd.read_excel(file)
   
   ##show the data read from the excel spreadsheet
   excel_panda.head()
   ```

    

    

   \3) Parquet - For parquet, we will use a slightest different approach. 

    

   One way to do it could be as mentioned by the docs: [Tutorial: Use Pandas to read/write ADLS data in serverless Apache Spark pool in Synapse Analytics - ...](https://learn.microsoft.com/en-us/azure/synapse-analytics/spark/tutorial-use-pandas-spark-pool#readwrite-data-using-secondary-adls-account)

    

   Another way is basically copying the file with the mssparkutils locally and reading it from there. 

    

    

   ```applescript
   import pandas as pd
   
   mssparkutils.fs.cp('/SQLDB_intrc/Tables_introc/Production.Product/FILENAME.snappy.parquet', 'file:/tmp/temp/FILENAME.parquet')
   
   pf = pd.read_parquet('file:/tmp/temp/FILENAME.parquet')
   pf.head()
   ```

    

    

   Also, if you need to use *"with open"* the solution above would work as well. For example, here I am reading a CSV ( any CSV) and using *"with open"* to create a dictionary:

    

    

   ```applescript
   import csv
   #mssparkutils.fs.cp('/folderonthestorage/filename.csv', 'file:/tmp/temp/filename.csv')
   
   with open ("/tmp/temp/filename.csv") as csvfile :
       file_dict_csv = list (csv.DictReader(csvfile)) 
   #showing first 5 
   file_dict_csv[:5]
   ```

    

    

Fig 2 - Dictionary, shows what I just mentioned.

 

The dictionary will *"create an object that operates like a regular reader but maps the information in each row to a dict  whose keys are given by the optional fieldnames parameter." ref: [csv — CSV File Reading and Writing — Python 3.11.2 documentation](https://docs.python.org/3/library/csv.html#csv.DictReader)*

 ![image-20230327192930159](C:\Users\lilem\AppData\Roaming\Typora\typora-user-images\image-20230327192930159.png)



Fig 2 - Dictionary

 

This is the File that was just read for the dictionary creation. Refer to Fig 3 - File, for the results:

![image-20230327192942364](C:\Users\lilem\AppData\Roaming\Typora\typora-user-images\image-20230327192942364.png)Fig 3 - File.

 

Ok. Now you have the data, you can open and read it if you need. 

Let's filter it and measure the time of it.

 

**Filtering**

 

Back to my Product file exported from AdventureWorks.

Let's suppose I want to filter the SafetyStockLevel columns from the data frame. I want values that are greater than 700 and smaller than 1100. How can I do that? Well, there are some different approaches. Generally, the best is the one that gives me accurate results as fastest as possible.

Hence, another question comes into our scenario: How can we measure the fastest one?

 

For the filter, I will show you 2 different approaches, for the measure question I will be using timeit.


\1) Filtering approach 1 - It will create a boolean mask that will return true or false(log_val). That mask will be used to filter the data frame (pf) that contains data for Product. 

 

 

```applescript
##logical validation returning true and false
##pf stands for the dataframe that was used to read the data from the parquet file. 
#so pf here is jsut a dataframe name
log_val= (pf['SafetyStockLevel']>700) & (pf['SafetyStockLevel']<1100)

##using my logical validation to get the data
pf.where(log_val).head()
```

 

 

\2) Filtering approach 2 - Directly filter the data frame using the predicate. 

 

```applescript
pf[(pf['SafetyStockLevel']>700) & (pf['SafetyStockLevel']<1100)].head()
```

 

 

The second approach seems to me faster as it is more straightforward. However, I want to prove, hence I will use timeit. 

 

First, create a notebook cell and run the following:

 

```applescript
import timeit
```

 

Now, let's use timeit by referencing it with %%timeit and loop it 2 times. Fig 4 - timeit, will show the results:

 



 ![image-20230327193016054](C:\Users\lilem\AppData\Roaming\Typora\typora-user-images\image-20230327193016054.png)

Fig 4 - timeit

 

Ok. it was proved the second approach is faster!

 

**NaN, NA and null values**

NaN stands for not a number, as NA represents a missing value. Null represents an empty object. There are different ways to handle this, using pandas NaN, NA and Null values would sometimes be handled with the same methods.

Following are some examples:

**
isna**

*"Return a boolean same-sized object indicating if the values are NA. NA values, such as None or `numpy.NaN`, gets mapped to True values. "*

Note: pf on the example is a data frame with Production data.

 

 

```applescript
import pandas as pd
pd.isna(pf)
```

 

ref:[pandas.DataFrame.isna — pandas 1.5.3 documentation (pydata.org)](https://pandas.pydata.org/pandas-docs/stable/reference/api/pandas.DataFrame.isna.html)

 

Fig 5 - isna, shows the results for isna execution. As you can see a boolean mask was created returning true or false:

 

![image-20230327193028253](C:\Users\lilem\AppData\Roaming\Typora\typora-user-images\image-20230327193028253.png)

Fig 5 - isna

**
Fillna** can be used to replace the values and handle NA, NaN . In this example, I am replacing it with zero.

Per documentation *"Fill NA/NaN values using the specified method."*

Note: pf on the example is a data frame with Production data.

 

 

```applescript
import pandas
pf=pf.fillna(0,inplace=True)
pf.head()
```

 

ref: [pandas.DataFrame.fillna — pandas 1.5.3 documentation (pydata.org)](https://pandas.pydata.org/pandas-docs/stable/reference/api/pandas.DataFrame.fillna.html)

 

Fig 6 - fillna, shows the results. So as you can see values that were returned as true by isna are now replaced by zero using fillna:

 

![image-20230327193039881](C:\Users\lilem\AppData\Roaming\Typora\typora-user-images\image-20230327193039881.png)

Fig 6 - fillna

 

**Null**

"*Detect missing values.*

*Return a boolean same-sized object indicating if the values are NA. NA values, such as None or `numpy.NaN`, gets mapped to True values. Everything else gets mapped to False values. "*

Note: pf on the example is a data frame with Production data

 
 

```applescript
import pandas 
Log_val = pf.isnull()
Log_val.head()
```

 

ref: [pandas.DataFrame.isnull — pandas 1.5.3 documentation (pydata.org)](https://pandas.pydata.org/pandas-docs/stable/reference/api/pandas.DataFrame.isnull.html)

Results on Fig 7 - isnull, shows a boolean mask:

![image-20230327193051423](C:\Users\lilem\AppData\Roaming\Typora\typora-user-images\image-20230327193051423.png)

*Fig 7 isnull*

 

**Not Null**

It is possible also to do the opposite, instead of using isnull() use notnull(). Not null will return true for not null values. So, also returns a boolean mask for Not Null values.

 


 

```applescript
Log_val = pf.notnull()
Log_val.head()
```

 

 

**Replacing values**

Now, null, NaN values were handled. My requirements for cleaning this data should cover replacing values. There are different ways to replace values inside the data frame. I will show a few examples of replacing numbers and strings with pandas and regex.

 

**Replace string**

The next examples will cover how to search for a string and replace it.

As mentioned before, pf represents the data frame in the example below. The word "h*eadset*" will be searched on the **column Name** of the data frame(pf) and if the exact string match, this is **case-sensitive.** So it will be replaced by "*HeadSt*".

 

 

```applescript
import pandas as pd

#Replace "headset" with "HeadSt"
pf['Name'] = pf['Name'].str.replace(r"headset", "HeadSt")
```

 

 

If you need to change the text of a column to lowercase. In this case, let's use as an example the column **Name**, you could use the following code.

 

 

```applescript
pf['Name'] = pf['Name'].str.lower()
```

 

 

Follow another example using regex to replace the value in a **case-insensitive** way.

 

```applescript
import pandas as pd
import re

# Use regex to replace "headset" with "HeadSt" 
pf['Name'] = pf['Name'].str.replace(re.compile(r"headset", re.IGNORECASE), "HeadSt")
```

 

 

**Replace numbers**

This very simple will show how to replace values in a column.

The following will replace the values that are equal to **750 by 800** on the column *Reorderpoint* for the dataframe pf.

 

 

```applescript
pf['ReorderPoint']= pf['ReorderPoint'].replace([750],800)
```

 

 

**New column**

 

Ok. So let's now create a new column, one of my requirements is to create a column as a result of a calculation. Hence, I will import the data of the file *"Production.WorkOrder"* into data frame **df** and *subtract* *EndDate from StartDate.* My new column will be named Order_days.

 

 

```applescript
import pandas as pd

mssparkutils.fs.cp('/SQLDB/Tables/Production.WorkOrder/file.parquet', 'file:/tmp/temp/file.parquet')


df = pd.read_parquet('/tmp/temp/file.parquet')
df.head()



##new column was created by subtracting the end date from the End date and start date
df['Order_days'] = df['EndDate'] - df['StartDate'] 
```

 

 

**Merge**

My next an final requirement is to merge Dataframes. So I will merge the pf - product, and df - workorders by doing a left join using productid as the key and create a new data frame from it.

 

 

```applescript
import pandas as pd
#on =  the columns name
newpf= pd.merge (pf,df, how='left',on ='ProductID')

newpf.head()
```

 

 

**Summary**:

My plan here was to share some tips that could be used while you are doing the data cleaning of your environment in the Silver Zone before going to the Gold Zone. Here I shared examples using python/pandas that would cover how to open files with different formats, create a dictionary from a CSV file as an example, handle NaN, NA, and Null values, filter the data, create new columns, and merge data frames. 

 

#### Reference



 