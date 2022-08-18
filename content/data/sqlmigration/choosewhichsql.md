# Understanding Azure SQL and choosing a target

#### [prev](./introduction.md) | [home](./readme.md)  | [next](./discoveryandassessment.md)

## Understanding SQL on Azure
Azure SQL is a family of managed, secure, and intelligent products that use the SQL Server database engine in the Azure cloud.

![](/images/SQLFamily.png)

</br></br>
	**1. Azure SQL Database:** Support modern cloud applications on an intelligent, managed database service, that includes serverless compute.</br>
	**2. Azure SQL Managed Instance:** Modernize your existing SQL Server applications at scale with an intelligent fully managed instance as a service, with almost 100% feature parity with the SQL Server database engine. Best for most migrations to the cloud.</br>
	**3. SQL Server on Azure VMs:** Lift-and-shift your SQL Server workloads with ease and maintain 100% SQL Server compatibility and operating system-level access.</br>
	**4. Azure SQL Edge :** Run IoT edge compute with a SQL database optimized with data streaming, time series, and AI capabilities built-in</br>
   
   SQL Server on Azure VMs and SQL Managed Instance are also now Azure Arc enabled, allowing you to run these services on the infrastructure of your choice, when a hybrid approach is required.</br>
	
## Choosing a target
Consider Vendor Support, Compatibility, Features, Performance and many, many other factors.) 
One of the important factor to consider is manageability control that is required
![](/images/SQLFamily_IAAS_PAAS.png)
  * [Azure SQL DB](https://docs.microsoft.com/en-us/azure/azure-sql/database/)
  * [SQL Managed Instance](https://docs.microsoft.com/en-us/azure/azure-sql/managed-instance/)
  * [SQL Server on Azure VMs](https://docs.microsoft.com/en-us/azure/azure-sql/virtual-machines/)
  * [Comparison](https://techcommunity.microsoft.com/t5/fasttrack-for-azure/feature-comparison-of-azure-sql-database-azure-sql-managed/ba-p/3154789)
