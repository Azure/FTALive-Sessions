## Data Lake, Delta and Lakehouse

### Security overview

[Home](https://github.com/LiliamLeme/FTALive-Sessions_Synapse_SQL/blob/main/content/data/ModernDatawarehouse-Security/Agenda.md)- [Next >](https://github.com/LiliamLeme/FTALive-Sessions_Synapse_SQL/blob/main/cont)



#### Background on Data Warehouses

Data warehouses have a long history in decision support and business intelligence applications, though were not suited or were expensive for handling unstructured data, semi-structured data, and data with high variety, velocity, and volume.

#### Emergence of Data Lakes

Data lakes then emerged to handle raw data in a variety of formats on cheap storage for data science and machine learning, though lacked critical features from the world of data warehouses: they do not support transactions, they do not enforce data quality, and their lack of consistency/isolation makes it almost impossible to mix appends and reads, and batch and streaming jobs.

#### Data Lake

A Data Lake is storage layer or centralized repository for all structured and unstructured data at any scale. In Synapse, a default or primary data lake is provisioned when you create a Synapse workspace. Additionally, you can mount secondary storage accounts, manage, and access them from the Data pane, directly within Synapse Studio.

 

It is possible to freely navigate through the Data Lake via the File explorer GUI experience for Data lakes. This includes the uploading and downloading of folders and files, copying and pasting across folders or data Lake accounts, and CRUD (Create, Read, Update & Delete) operations for folders and files.

 

![thumbnail image 2 of blog post titled  	 	 	  	 	 	 				 		 			 				 						 							Synapse – Data Lake vs. Delta Lake vs. Data Lakehouse 							 						 					 			 		 	 			 	 	 	 	 	 ](https://techcommunity.microsoft.com/t5/image/serverpage/image-id/418219i980C5735E9C4E503/image-size/large?v=v2&px=999)

  

#### Delta Lake

[Delta lake](https://docs.delta.io/latest/index.html) is an open-source storage layer (a sub project of The Linux foundation) that sits in Data Lake when you are using it within Spark pool of Azure Synapse Analytics.

 

A key part of Delta Lake is the transaction log. This is the common thread that runs through several of the top features within Delta Lake, to include ACID transactions, scalable metadata handling and time travel amongst others.

 

The Delta Lake transaction log is an ordered record of every transaction, ever performed on a Delta Lake table since its creation, stored in a JSON file for each commit. It serves as a single source of truth and acts as a central repository to track all changes that users may make to the table. Check out [Delta Transaction Log Protocol ](https://github.com/delta-io/delta/blob/master/PROTOCOL.md)to learn more.

 

#### Data Lakehouse

Traditionally, organizations have been using a data warehouse for their analytical needs. As the business requirements evolve and data scale increases, they started adopting a modern data warehouse architecture, which can process massive amounts of data in a relational format, and in parallel across multiple compute nodes. At the same time, they start collecting and managing their non-relational big data that was in semi-structured or unstructured format with a data lake.

 

These two disparate yet related systems run in silos, increasing development time, operational overhead, and overall total cost of ownership. It causes an inconvenience to end users to integrate data if they needed access to the data from both systems to meet their business requirements.

 


Data Lakehouse platform architecture combines the best of both worlds in a single data platform, offering and combining capabilities from both these earlier data platform architectures into a single unified data platform – sometimes also called as medallion architecture. It means, the data lakehouse is the one platform to unify all your data, analytics, and Artificial Intelligence/Machine Learning (AI/ML) workloads.

 

 

#### References

https://www.databricks.com/blog/2020/01/30/what-is-a-data-lakehouse.html 



https://www.databricks.com/glossary/medallion-architecture 



https://techcommunity.microsoft.com/t5/azure-synapse-analytics-blog/synapse-data-lake-vs-delta-lake-vs-data-lakehouse/ba-p/3673653



[Building the Lakehouse - Implementing a Data Lake Strategy with Azure Synapse](https://techcommunity.microsoft.com/t5/azure-synapse-analytics-blog/building-the-lakehouse-implementing-a-data-lake-strategy-with/ba-p/3612291)



https://www.databricks.com/glossary/data-lakehouse

