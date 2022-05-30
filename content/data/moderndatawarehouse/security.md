# Security

#### [prev](./operating.md) | [home](./readme.md)  | [next](./microsoftlearn.md)
</br>

## [Defence in Depth](https://docs.microsoft.com/en-us/shows/azure-videos/defense-in-depth-security-in-azure)
* [Zero trust](https://docs.microsoft.com/en-us/security/zero-trust/deploy/networks) ([Link 2](https://docs.microsoft.com/en-us/security/zero-trust/zero-trust-overview)) with multi-layer defence
* [Audit, detect and alert](https://docs.microsoft.com/en-us/azure/architecture/framework/security/monitor-logs-alerts) with [Azure Monitor](https://docs.microsoft.com/en-us/azure/azure-monitor/overview), [Microsoft Defender for Cloud](https://docs.microsoft.com/en-us/azure/defender-for-cloud/defender-for-cloud-introduction) and [Sentinel](https://docs.microsoft.com/en-us/azure/sentinel/overview)
* Enable [Advanced Threat Protection](https://docs.microsoft.com/en-us/azure/azure-sql/database/threat-detection-overview?view=azuresql) where available
* Protect against [Data exfiltration](https://docs.microsoft.com/en-us/azure/synapse-analytics/security/workspace-data-exfiltration-protection)
* Utilise [Encryption](https://docs.microsoft.com/en-us/azure/security/fundamentals/encryption-overview) at Rest across services
* Best practices [Link 1](https://docs.microsoft.com/en-us/azure/security/fundamentals/best-practices-and-patterns) | [Link 2](https://docs.microsoft.com/en-us/azure/cloud-adoption-framework/secure/security-top-10) | [Link 3](https://docs.microsoft.com/en-us/azure/security/fundamentals/operational-best-practices) | [Link 4](https://docs.microsoft.com/en-us/azure/security/fundamentals/identity-management-best-practices) 

## Credential Management
* [Identity Protection and Management](https://docs.microsoft.com/en-us/azure/security/fundamentals/steps-secure-identity) (with [Azure KeyVault](https://docs.microsoft.com/en-us/azure/key-vault/general/overview))
* Azure AD (AAD) and [System & User Assigned Managed Identities](https://docs.microsoft.com/en-us/azure/active-directory/managed-identities-azure-resources/overview)

## [Network Security](https://docs.microsoft.com/en-us/azure/architecture/framework/security/design-network)
* Don't leave discussion of [Private](https://docs.microsoft.com/en-us/azure/private-link/private-endpoint-overview) vs Public Endpoints to late. The choice can potentially change the architecture
* Encryption in transit (Transport Layer Security (TLS) with RSA-based 2048-bit)

## Control plane
* EA and Subscription ownership
* [Break glass accounts](https://docs.microsoft.com/en-us/azure/active-directory/roles/security-emergency-access)
* [Lock Resources](https://docs.microsoft.com/en-us/azure/storage/common/lock-account-resource?tabs=portal)
* Define business roles that can be translated to AAD groups ([Personas](https://docs.microsoft.com/en-us/azure/architecture/guide/security/conditional-access-architecture)) (which can be used at the Data plane level also).

## Data plane
* [ADLSv2 RBAC]((https://docs.microsoft.com/en-us/azure/cloud-adoption-framework/scenarios/cloud-scale-analytics/best-practices/data-lake-access)) & [POSIX ACLs](https://docs.microsoft.com/en-us/azure/storage/blobs/data-lake-storage-access-control) (Acronym city! Azure Data Lake Storage Gen 2 Role Based Access Control & Portable Operating System Interface Access Control Lists)
* [Row-level Security (RLS) in Azure SQL, Synapse Pools](https://docs.microsoft.com/en-us/sql/relational-databases/security/row-level-security?view=sql-server-ver16) and [Power BI](https://docs.microsoft.com/en-us/power-bi/enterprise/service-admin-rls)
* [Dynamic Data Masking](https://docs.microsoft.com/en-us/azure/azure-sql/database/dynamic-data-masking-overview?view=azuresql)
* [The power of SQL permissions](https://docs.microsoft.com/en-us/azure/azure-sql/database/security-overview?view=azuresql)

## Microsoft Defender for Cloud
* Get familiar with Microsoft Defender for Cloud (Formerly Azure Security Center (ASC)) by reviewing your [Security Posture](https://docs.microsoft.com/en-us/azure/defender-for-cloud/secure-score-security-controls) and regularly checking your [Secure score](https://docs.microsoft.com/en-us/azure/defender-for-cloud/secure-score-access-and-track)
