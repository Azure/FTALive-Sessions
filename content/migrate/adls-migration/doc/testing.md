
# Milestone: End to End Test Migration Wave

#### [prev](./replication.md) | [home](./welcome.md)  | [next](./migration.md)

The following content can be used as a checklist to incorporate within your migration project plan to ensure best practices.

**CAF Reference:** [Adopt - Business Testing](https://docs.microsoft.com/en-us/azure/cloud-adoption-framework/migrate/migration-considerations/optimize/business-test)

## **1 Pre & Post  Migration Activities Defined**

### 1.1\. Business
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

### 1.2\. Technical
- **Pre-Migration Tasks:**
    - Define Rollback Plan.
    - Take backup of servers on-premises.
    - Open Firewall Ports.
    - Get local admins accounts for login purposes.
    - [Verify manual changes needed for Windows and Linux](https://docs.microsoft.com/en-us/azure/migrate/prepare-for-migration#verify-required-changes-before-migrating).
        +  For older Linux distros, instructions to install Hyper-V drivers can be found [here](https://docs.microsoft.com/en-us/windows-server/virtualization/hyper-v/supported-linux-and-freebsd-virtual-machines-for-hyper-v-on-windows).
        +  For older Windows versions (E.G. WS2003 or WS2008), instructions to install Hyper-V drivers can be found [here](https://docs.microsoft.com/en-us/azure/migrate/prepare-windows-server-2003-migration).
    - Prepare isolated virtual networks for test migrations.
        - Plan for secure management access (e.g. RDP, SSH) into this environment leveraging services like [Azure Bastion](https://docs.microsoft.com/en-us/azure/bastion/bastion-overview).
        - Plan for an isolated virtual network in each subscription containing migrated VMs. The Test Migration functionality in Azure Migrate must use a virtual network in the same subscription where the migrated VM will exist.

- **Post-Migration Tasks:**
    - The following are the documented post-migration activities best practices:
        +  [VMware Agentless](https://docs.microsoft.com/en-us/azure/migrate/tutorial-migrate-vmware#complete-the-migration)
        +  [VMware Agent-based](https://docs.microsoft.com/en-us/azure/migrate/tutorial-migrate-vmware-agent#complete-the-migration)
        +  [Hyper-V](https://docs.microsoft.com/en-us/azure/migrate/tutorial-migrate-hyper-v#complete-the-migration)
        +  [Physical](https://docs.microsoft.com/en-us/azure/migrate/tutorial-migrate-physical-virtual-machines#complete-the-migration), [AWS](https://docs.microsoft.com/en-us/azure/migrate/tutorial-migrate-aws-virtual-machines#complete-the-migration), [GCP](https://docs.microsoft.com/en-us/azure/migrate/tutorial-migrate-gcp-virtual-machines#complete-the-migration)
    - The following are additional best practices to consider:
        +  Validate login with local account for SSH or RDP.
        +  Validate DNS resolves and DNS servers are configured in network settings (E.G. TCP/IP settings) for the OS.
        +  Validate IP address has been assigned to server in network settings (E.G. TCP/IP settings) for the OS.
        +  Validate access to OS licensing is activated and there is access to cloud-based licensing endpoints (E.G. Azure KMS endpoints).
        +  Validate login with domain accounts.
        +  Validate application URLs dependencies.
        +  Update any existing CMDB
        +  Validate Install or Update necessary Azure agents:
        - Windows and/or WALinux VM agent.
        - Windows and/or Linux Log Analytics agent/extension.
        - Windows and/or Linux Dependency Map agent/extension.
        - Windows SQL Extension.
        +  Validate VM monitoring via new or existing service.
        +  Validate VM patching via new or existing service.
        +  Validate VM backup via new or existing service.
        +  Validate VM Antivirus/endpoint protection via new or existing service.
        +  Tag Azure resources.
        +  Postmortem and Learnings

## **2 Migration Plan Definition**

### 2.1\. Define Smoke Test
A smoke test is intended to validate that servers identified to migrate will successfully boot in Azure. It is recommended to perform this smoke test in an isolated vnet for all servers to be migrated.

Select which post-migration tasks need will be executed. This is usually led by server admins or migration partners. Here are a few examples of common smoke test activites:
- The server boots in Azure.
- The administrator is able to login to the server using local credentials.
- TCP/IP settings for DNS, IPv4 and default gateways assignment are updated to the values provided by the Azure vnet via DHCP.
- OS licensing is activated.

### 2.2\. Define UAT
Perform UAT (User Acceptance Testing) to ensure that the applications are functional and accessible by expected users. UAT will help surface missed configuration changes necessary for a successful migration (e.g. hardcoded IP addresses).

This is usually led by application owners. For example, UAT may include:

- Validate login with domain credentials.
- Validate application has access to dependencies (E.G. accessing target URLs or connection strings).
- Validate application functionality with test users
-  Select which post-migration tasks need will be executed: (E.G. Validate application URL dependencies and access with domain accounts).

### 2.3\. Identify target vnets, tests and migration workflow:

The below diagram aims to provide a workflow for testing and migration based on common scenarios. Timelines for different aspects of the workflow, such as testing vs. migration, may be targeted on different dates depending on your scenario.

![Concept Diagram](../png/migration-workflow.PNG)

## **3 Migration Plan Execution**

### 3.1\. Execute the migration workflow for each migration wave.
