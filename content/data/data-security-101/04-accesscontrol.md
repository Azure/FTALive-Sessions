#### [Previous (Network)](./03-network.md) | [Home](./readme.md)  | [Next (Summary)](./05-summary.md)

# Access Control
## Controlling access to data
* Compliance requirements: GDPR / CCPA / Privacy Principles.
* Principal of least privilege.
* DEV/Test/Prod 
  * Building a representative dataset in dev environment is hard
  * Question: How will / do you refesh dev/test environments?
* Data Lake Layers/Zones
  * Recommendation: Your landing/Raw zone should be *restricted* due to potential for ingesting sensitive data
  * Separate storage accounts for Raw vs Processed dataset(s)
    * Immutable storage for Raw zone - allows for versioning data where source dataset doesnt have history or you don't own the source dataset
    * Analytics sandbox
    * ML sandbox
    * Restores of Production datasets SHOULD HAVE THE SAME SECURITY CONTROLS APPLIED AS PRODUCTION
* Storage, RBAC and ACLs
  * Different Azure IAM roles for Contributor/Owner vs Storage account Data Reader/writer
    * Data plane vs Control plane operation > Go watch governance call recording to learn more
    * Data lake POSIX permissions - no inheritance so get it right the first time
    * Use automated process(es) to enrol new datasources into your data lake. Automatically set up read/write/owner Entra groups and provision them and grant them access at creation time. > Allows for more granular RBAC
      * More granularity will cause more administrative overhead
* Engine Specific controls. Note that in Modern Data Warehouses, these occur only in the engine (not on the data directly).
  * RLS
  * Data Masking
  * Encryption (e.g. Column and Always Encrypted)
* Understand the heirachy of security within Azure, and who could elevant their permissions within the control plane, to gain access within the data plane.

## Recovery of Data
* Backups are part of your security protection strategy. Get them off the same service/platform.
  * Protecting against accidental (update without where clause, connected to wrong datasource) or malicious modification (i.e. ransomware) or deletion.

## Other controls
* Building a complex Access Control strategy? Think of the Tungsten Triangle..
* Technology vs process to control access (i.e. You don't need to lean on technology for everything. Consider human level processes such as security clearance, auditing, and disciplinary action). 
* If you make it too hard, users will workaround controls (and build shadow IT). 
  * ~ >= 75% of failures are going to be People and Process related
  * Consider auditing as a method of control. Users have access to do more, but we can track it. But then for highly privileged actions, implement locks.
* Everyone has a smart phone, if I can see the data on the screen, I can take a photo of the data, then rebuild it in excel and join it with other deidentified datasets, allowing me to reidentify a dataset.

### Decision
* Define Personas, then align permissions and design based on those use-cases
    * At what granularity will you go (consider Tungsten Triangle)
    * Consider implications around People vs Process vs Technology
* How and where to do your development, including how do you manage "dev" datasets
* How do you want to handle data source registration & lifecycle management, including PII management/obfuscation
* Understanding the chain of control of who has direct and indirect access. Who can elevate their privileges to gain control.

#### [Previous (Network)](./03-network.md) | [Home](./readme.md)  | [Next (Summary)](./05-summary.md)