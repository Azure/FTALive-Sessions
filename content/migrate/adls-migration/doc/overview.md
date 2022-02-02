# Lift & Shift DC Migration Overview

#### [prev](./welcome.md) | [home](./welcome.md)  | [next](./scan.md)

## [**Scan Milestone**](./scan.md)
During this phase discovery tooling is ran in the migratable state. 

## [**Assess & Select Migration Waves Milestone**](./assess.md) 
During this phase, typically lengthy, the scan results are reviewed to decide on lift and shift readiness and understand dependencies which will help build the migration waves.

## [**Design and Build the Landing Zone Milestone**](./landingzone.md) 
During this phase, typically lenghty, a design document for the Landing Zone (networking, governance, and operations) is developed and signed off. Build of the landing zone is 
performed based on this design.

>**Note**: The Assess & Select Workload milestone and the Design and Build the Landing Zone milestone can optionally be ran in parallel. 

## [**Replication of Migration Waves Milestone**](./replication.md) 
During this phase, a subnet of migration waves identified will be enabled for replication using a phased approach to adapt to current available bandwidth and ensure healthy replication. 

## [**End to End Test Migration Wave Milestone**](./testing.md) 
During this phase, typically missed but important, each migration wave identified during the Assess & Select Workload milestone is tested in Azure prior to the final cutover. Various test cases will be discussed during the presentation.

## [**Waves Migration & Post Go-Live Milestone**](./migration.md) 
During this phase, each migration wave is cutover to Azure and validated for expected functionality. For Post Go-live, each migration wave is handed over to Azure operations teams for the defined soak period. 

![Concept Diagram](../png/LiftandShift-dcmigration-workflow.PNG)

