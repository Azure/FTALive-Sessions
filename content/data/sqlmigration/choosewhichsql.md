# Understanding Azure SQL and choosing a target

#### [prev](./introduction.md) | [home](./readme.md)  | [next](./discoveryandassessment.md)

## What is Azure SQL?
Azure SQL is a family of managed, secure, and intelligent products that use the SQL Server database engine in the Azure cloud. It is an umbrella term that covers the below services: </br></br>
![](/images/SQLFamily.png) </br></br>
1. **Azure SQL Database:** Support modern cloud applications on an intelligent, managed database service, that includes Hyperscale as well as serverless compute.
1. **Azure SQL Managed Instance:** Modernize your existing SQL Server applications at scale with an intelligent fully managed instance as a service, with almost 100% feature parity with the SQL Server database engine. **Best for most migrations to the cloud.**
1. **SQL Server on Azure VMs:** Lift-and-shift your SQL Server workloads with ease and maintain 100% SQL Server compatibility and operating system-level access whilst benefitting from Azure enabled patching and backups.
1. **Azure SQL Edge:** Run IoT edge compute with a SQL database optimized with data streaming, time series, and AI capabilities built-in.
1. **Azure Arc:** SQL Server on Azure VMs and SQL Managed Instance are also now Azure Arc enabled, allowing you to run these services on the infrastructure of your choice, when a hybrid approach is required.
	
## Choosing a target
When picking a target, it's critical to consider vendor support, compatibility, features, performance and many other factors. To compare Azure SQL versions please see this [comparison table](https://techcommunity.microsoft.com/t5/fasttrack-for-azure/feature-comparison-of-azure-sql-database-azure-sql-managed/ba-p/3154789).</br>
One of the important factors to consider is Total Cost of Ownership (TCO) and what level of control is required or desired. The below table illustrates the shared responsibility model for Azure SQL.

![](/images/SQLFamily_IAAS_PAAS.png)

---
## Additional Information 
  * [Azure SQL DB](https://docs.microsoft.com/en-us/azure/azure-sql/database/)
  * [SQL Managed Instance](https://docs.microsoft.com/en-us/azure/azure-sql/managed-instance/)
  * [SQL Server on Azure VMs](https://docs.microsoft.com/en-us/azure/azure-sql/virtual-machines/)

