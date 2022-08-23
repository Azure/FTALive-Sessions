# Remediation

#### [prev](./discoveryandassessment.md) | [home](./readme.md)  | [next](./migrationplanning.md)

## Remediation
The remediation steps consists of activities required to fix your database and application layer before migration
Each of the assessment tools mentioned in the previous modules provide reports which reflect changes in the following 3 categories
* Breaking changes - Which will block the migration
* Behavior changes - Which will impact the functionality in use (Application and Data Layer)
* Deprecated features - Which will not be supported in the latest versions

Diagrams below provide a rough overview of how each of the tools conducts the assessment

### **Reports Overview**
**1. MAP ToolKit Assessments** ->Detection but manual remediation

This tool collects several reports which includes and inventory for server instances and the databases contained. The sample looks as follows under the database section of the toolkit. 

![MAPToolKit Database Section](/images/MAPAssessment1.png#left)

##### Azure VM Readiness Section
The Azure VM Readiness section provides insights on readiness for you to migrate for IAAS offering. The remediation actions however reflect in the below snapshot alone. Most of the sections are self explanatory with excels providing insights on high level overview of the Microsoft SQL Server usage assessment. 

![MAPToolKit VM Section](/images/MAPAssessment2.png#left)![Excel Report](/images/MAPVMSummary1.png#right)