# Milestone: Wave Migration and Post Go-Live

#### [prev](./testing.md) | [home](./welcome.md)  | [next](./faq.md)

The following content can be used as a checklist to incorporate within your migration project plan to ensure best practices.

**CAF Reference:** [Adopt - Release Workloads](https://docs.microsoft.com/en-us/azure/cloud-adoption-framework/migrate/migration-considerations/optimize/)

## **1 Cutover**

### 1.1\. Identify cutover window, recommend for a Friday evening or weekend.

### 1.2\. Ensure the following POCs are present:

- Network Administrators
- Backup Administrators
- Server Administrators
- Identity Administrators
- Application Owners (Frontend and Backend)
- Microsoft Support
- Partner (if available)

### 1.3\. Ensure a backup of the server has been committed prior to cutover.

### 1.4\. Ensure rollback plan is defined and ready for execution if needed.

## **2 Post Go-Live**

### 2.1\. Decommission of the source: Ensure source servers are decommisioned after soak period timeline.

### 2.2\. Migration handover to operations team: Ensure operations teams understands new operations for backup, patching, monitoring, etc.
