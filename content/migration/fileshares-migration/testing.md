
# Milestone: Migration Testing

#### [prev](./replication.md) | [home](./readme.md)  | [next](./migration.md)

The following content can be used as a checklist to incorporate within your migration project plan to ensure best practices.

## **Pre & Post  Migration Activities Defined**

### Business
In order to prepare the business and its stakeholders for the migration activities, Contoso defines the below items:

- A maintenance window for each of the applications to migrate.
- Communications on application downtime and impact to business.
- Points of Contacts (POCs) which can provide support for the below key areas during migration testing and cutover:
    - Network Administrators
    - Backup Administrators
    - Server Administrators
    - Identity Administrators
    - Application Owners (Frontend and Backend)
    - Microsoft Support
    - Partner (if available)
- Soak Period after the cutover. During the Soak Period after application cutover to Azure, if any issues arise the rollback plan must be executed. After the Soak Period has expired, rollback of the application cannot be committed.

### Technical
- **Pre-Migration Tasks:**
    - Define Rollback Plan.
    - Take backup of servers on-premises.
    - Open Firewall Ports.
    - Get local admins accounts for login purposes.


- **Post-Migration Tasks:**
    - Update any existing CMDB
    - Validate file share monitoring via new or existing service.
    - Validate file share backup via new or existing service.
    - Tag Azure resources.
    - Postmortem and Learnings

## **Migration Plan Definition**
Consider key activities such as resync and final switchover as described in the suggested [Migration Phase activities](https://docs.microsoft.com/en-us/azure/storage/common/storage-migration-overview?toc=/azure/storage/blobs/toc.json#migration-phase) for each migration group in the migration wave.
