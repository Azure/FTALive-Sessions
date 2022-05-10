# Demos

#### [prev](./postmigration.md) | [home](./readme.md)  | [next](./faq.md)

# Demo 1a - Assess Source Environment
## Objective
### Assess source SQL Server instance migrating to Azure SQL Managed Instance by using [Database Migration Assistant (DMA)](https://docs.microsoft.com/en-us/sql/dma/dma-overview?view=sql-server-ver15#supported-source-and-target-versions). This helps you to detect the issues below which can affect Azure SQL Mnaged Instace migration and provides detailed guidance on how to resolve them.
#### - Migration blocking issues:
Discovers the compatibility issues that block migrating SQL Server database(s) to Azure SQL Managed Instance.
#### - Partially supported or unsupported features:
Detects partially supported or unsupported features that are currently in use on the source SQL Server instance. 
DMA provides a comprehensive set of recommendations, alternative approaches available in Azure, and mitigating steps so that you can incorporate them into your migration projects.


## Migration Environment
### Migration Source
#### SQL Server 201x 
##### - AlwaysOn Availability Group
#####   - Primary Replica
#####   - Secondary Replica for read-scale out
 
### Migration Target
#### Azure SQL Managet Instance
##### - Business Critical Tier

