# FTA Live - Azure DevOps - Patterns and Practices

_This handout was prepared in advance and generic. Actual session content may differ based on discussion. Please refer to your own personal notes._

---

Some documentation links are highlighted with icons

| Icon | Description |
|:--|:--|
| 📖 | Bookmark-worthy references, tables, etc. |
| 🤔 | Guidance to help you plan and design your ADO organization and operating model |

### Microsoft Learn - Learning Paths

Resources for absolute beginners.

- [Part 1: Get started with Azure DevOps](https://learn.microsoft.com/training/paths/evolve-your-devops-practices/)
- [Part 2: Build applications with Azure DevOps](https://learn.microsoft.com/en-us/training/paths/build-applications-with-azure-devops/)
- [Part 3: Deploy applications with Azure DevOps](https://learn.microsoft.com/en-us/training/paths/deploy-applications-with-azure-devops/)


### Azure Architecture Center

- [Azure-Architecture Center: End-to-end governance in Azure when using CI/CD](https://docs.microsoft.com/azure/architecture/example-scenario/governance/end-to-end-governance-in-azure) 🤔 - _preview diagram below_
- [GitHub.com - Governance on Azure Demo - from DevOps to ARM](https://github.com/azure/devops-governance) - _repo that accompanies that Architecture Center article_

<img src="https://raw.githubusercontent.com/Azure/devops-governance/main/images/e2e-governance-overview.svg" width="640" alt="Azure Architect Center - E2E Governance">

### Cloud Adoption Framework

- [Cloud Adoption Framework – End-to-end governance from DevOps to Azure](https://docs.microsoft.com/azure/cloud-adoption-framework/secure/best-practices/end-to-end-governance) 
- [Cloud Adoption Framework – Azure role-based access control](https://docs.microsoft.com/azure/cloud-adoption-framework/ready/considerations/roles)

### Azure DevOps Docs

- [Azure DevOps: Connect your organization to Azure Active Directory](https://docs.microsoft.com/azure/devops/organizations/accounts/connect-organization-to-azure-ad?view=azure-devops)
- [Azure DevOps: Default permissions and access for Azure DevOps](https://docs.microsoft.com/azure/devops/organizations/security/permissions-access?toc=%2Fazure%2Fdevops%2Fget-started%2Ftoc.json&bc=%2Fazure%2Fdevops%2Fget-started%2Fbreadcrumb%2Ftoc.json&view=azure-devops#azure-repos) 📖

#### Azure DevOps Organizations

- [Manage your organizations](https://docs.microsoft.com/azure/devops/organizations/accounts/organization-management?view=azure-devops)
- [Plan your organizational structure](https://docs.microsoft.com/azure/devops/user-guide/plan-your-azure-devops-org-structure?toc=%2Fazure%2Fdevops%2Forganizations%2Ftoc.json&bc=%2Fazure%2Fdevops%2Forganizations%2Fbreadcrumb%2Ftoc.json&view=azure-devops) 🤔
- [Restrict organization creation via Azure AD tenant policy](https://docs.microsoft.com/azure/devops/organizations/accounts/azure-ad-tenant-policy-restrict-org-creation?view=azure-devops)

#### Azure DevOps Projects

- [How many projects do you need?](https://docs.microsoft.com/azure/devops/user-guide/plan-your-azure-devops-org-structure?view=azure-devops#how-many-projects-do-you-need) 🤔
- [Default permissions quick reference for Azure DevOps](https://docs.microsoft.com/azure/devops/organizations/security/permissions-access?toc=%2Fazure%2Fdevops%2Fget-started%2Ftoc.json&bc=%2Fazure%2Fdevops%2Fget-started%2Fbreadcrumb%2Ftoc.json&view=azure-devops) 📖

#### Azure DevOps Repositories

- [Set Git repository permissions](https://docs.microsoft.com/azure/devops/repos/git/set-git-repository-permissions?view=azure-devops)

#### Azure DevOps Pipelines

- [Verify permissions for contributors](https://docs.microsoft.com/azure/devops/pipelines/policies/set-permissions?view=azure-devops#verify-permissions-for-contributors) - _For CD pipelines you want to limit triggering by Contributors!_
- [Define approvals and checks](https://docs.microsoft.com/azure/devops/pipelines/process/approvals?view=azure-devops&tabs=check-pass)
- [Add & use variable groups](https://docs.microsoft.com/azure/devops/pipelines/library/variable-groups?view=azure-devops&tabs=yaml)
- [Set different levels of pipeline permissions](https://docs.microsoft.com/azure/devops/pipelines/policies/permissions?view=azure-devops#set-service-connection-permissions)
- [Securing Azure Pipelines](https://docs.microsoft.com/azure/devops/pipelines/security/overview?view=azure-devops) 