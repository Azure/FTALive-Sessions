# Welcome to the FastTrack for Azure Governance Call
## We will start 3-4 minutes after the scheduled time to accommodate those still connecting

> This call will not be recorded due to the wide audience and to encourage questions.

**Questions?** Feel free to type them in the chat window at any time. Note that questions you post will be public. 

**Slideless** No PowerPoint, we promise! As we update this content you will get the changes straight away.

**Feeback** We would like to hear your thoughts, please provide us your feedback [https://aka.ms/ftalive-feedback](https://aka.ms/ftalive-feedback).

### Agenda
1. [Why talk about governance?](./why.md)
1. [Setup guide overview](https://portal.azure.com/#blade/Microsoft_Azure_Resources/QuickstartPlaybookBlade/guideId/intro-azure-setup)
1. Organize resources
    1. [Azure Resource Manager Overview](https://docs.microsoft.com/en-us/azure/azure-resource-manager/management/overview)
    1. [Management Groups Overview](https://docs.microsoft.com/en-us/azure/governance/management-groups/overview)
    1. [Define Naming Conventions](https://docs.microsoft.com/en-us/azure/cloud-adoption-framework/ready/azure-best-practices/resource-naming)
    1. [Developing Naming and Tagging Strategy](https://docs.microsoft.com/en-us/azure/cloud-adoption-framework/ready/azure-best-practices/naming-and-tagging)
    1. [Lock resources](https://docs.microsoft.com/en-us/azure/azure-resource-manager/management/lock-resources)
1. Manage policy and compliance
    1. [Azure Policy](https://docs.microsoft.com/en-us/azure/governance/policy/overview)
    1. [Policy Effects](https://docs.microsoft.com/en-us/azure/governance/policy/concepts/effects)
1. Manage access
    1. [Role Based Access Control](https://docs.microsoft.com/en-us/azure/cloud-adoption-framework/ready/considerations/roles)
1. Manage costs and billing
    1. [Cost Management + Billing Overview](https://docs.microsoft.com/en-us/azure/cost-management-billing/cost-management-billing-overview)
    1. [Start Analyzing Costs](https://docs.microsoft.com/en-us/azure/cost-management-billing/costs/quick-acm-cost-analysis?tabs=azure-portal)
    1. [Create and Manage Budgets](https://docs.microsoft.com/en-us/azure/cost-management-billing/costs/tutorial-acm-create-budgets)

#### Additional Resources
* [Microsoft Cloud Adoption Framework](https://aka.ms/caf) - collection of documentation, implementation guidance, best practices, and tools that are proven guidance from Microsoft designed to accelerate your cloud adoption journey
* [Azure Governance DevOps Generator](http://aka.ms/azgovernancereadiness) - implement governance practices following best practices using Azure DevOps boards.
* [Azure Advisor](https://docs.microsoft.com/en-us/azure/advisor/advisor-overview) - Advisor is a personalized cloud consultant that helps you follow best practices to optimize your Azure deployments. It gives you recommendations on five categories: reliability, security, performance, cost and operational excellence.
* [Azure Arc](https://docs.microsoft.com/en-us/azure/azure-arc/overview) - it simplifies governance and management by delivering a consistent multi-cloud and on-premises management platform.
* [Microsoft Defender for Cloud policies](https://docs.microsoft.com/en-us/azure/defender-for-cloud/security-policy-concept) - MDfC is a Cloud Security Posture Management (CSPM) and Cloud Workload Protection Platform (CWPP) for all of your Azure, on-premises, and multi-cloud resources. 

#### Call to Action
1. Organize resources
    1. Define a resource group design for resource organization and management
    1. Define a subscription and management group design and how you plan to scale
    1. Define naming standards and a tagging design
    1. Setup resource locks 
1. Manage policy and compliance
    1. Define your compliance requirements regarding cost management (for example, don't use premium and expensive SKUs in lab environments), resource consistency (for example, enforce naming conventions, tags and deployment locations) and security (all subscriptions come already with a group of security audit policies assigned by Defender for Cloud, but you may have other requirements. 
    1. Translate those requirements into Azure Policies/Initiatives with different effects: audit, deny, deployifnotexists, etc.
    1. Define processes to regularly check policy compliance.
1. Manage access
    1. Define an identity structure (e.g. who/what needs access, what scope, what permissions, etc.)
    1. Define an auditing strategy to validate usage of identities to identify and remove unnecessary access
    1. Enable MFA for all users accessing Azure to manage resources through the portal, REST APIs, PowerShell, CLI, etc.
    1. Setup emergency administrative accounts (i.e. break glass accounts)
1. Manage costs and billing
    1. Review your costs and determine how to best monitor costs
    1. Setup applicable budgets and alerts
    1. Regularly review cost recommendations in Azure Advisor
