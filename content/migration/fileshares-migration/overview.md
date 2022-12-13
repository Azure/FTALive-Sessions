# Azure Files Migration Overview

#### [prev](./readme.md) | [home](./readme.md)  | [next](./assess.md)

## [**Assess and Select Target File Share Service Milestone**](./assess.md) 
During this phase, the target File Share Service options are reviewed and one or more target File share services are chosen to host the migrated file shares.
## [**Scan File Shares Milestone**](./scan.md)
During this phase discovery tooling is ran to inventory file shares and its clients. The scan results are reviewed to decide on migration readiness and understand dependencies which will help build the migration groups.
## [**Design and Build the Landing Zone Milestone**](./landingzone.md) 
During this phase, typically lenghty, a design document for the Landing Zone (networking, governance, and operations) is developed and signed off. Build of the landing zone is performed based on this design.

>**Note**: The Scan File Shares milestone and the Design and Build the Landing Zone milestone can optionally be ran in parallel. 

## [**Assess and Select Migration Tooling Milestone**](./replication.md) 
During this phase, available migration tools will be analyzed to migrate the file shares and its dependencies. 

## [**Migration Testing Milestone**](./testing.md) 
During this phase, typically missed but important, each migration group identified during the Scan File Shares milestone is tested in Azure prior to the final cutover. Various test cases will be discussed during the presentation.

## [**Migration Execution and Post Go-Live Milestone**](./migration.md) 
During this phase, each migration group is cutover through migration waves to Azure and validated for expected functionality. For Post Go-live, each migration group in the migration wave is handed over to Azure operations teams for the defined soak period. 



