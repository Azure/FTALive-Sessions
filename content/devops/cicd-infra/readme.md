# FTA Live - CI/CD for Infrastructure

_This handout was prepared in advance and generic. Actual session content may differ based on discussion. Please refer to your own personal notes._

---

## Getting Started with Infrastructure as Code (IaC) 

- [Azure DevOps Channel on YouTube](https://www.youtube.com/c/AzureDevOps)

### Azure ARM

- [Microsoft Learn Path - Deploy and manage resources in Azure by using JSON ARM templates](https://docs.microsoft.com/learn/paths/deploy-manage-resource-manager-templates/)
- [Microsoft on YouTube – ARM Template Series, 1 of 12](https://www.youtube.com/watch?v=VWe-stknCIM)

### Azure Bicep

- [Microsoft Learn Path - Bicep](https://docs.microsoft.com/learn/paths/bicep-deploy/)
- [Bicep Tutorial on GitHub](https://github.com/Azure/bicep/tree/main/docs/tutorial)

## Infrastructure as Code (IaC) Comparison

Using comparison table below, we'll explain a few important IaC Concepts

- Syntax (Json vs DSL)
- Deployment Preview, e.g. Config Drift Check
  - State Files
- Rollback and Clean Up


| Feature | ARM | Terraform | Pulumi |
|:--|:--:|:--:|:--:|
| **Language** | JSON + [Bicep](https://github.com/Azure/bicep) | HCL/DSL | Code Native, e.g. JavaScript, Python |
| **Languages (in preview)** | [Bicep](https://github.com/Azure/bicep) DSL | [CDK for Terraform](https://www.hashicorp.com/blog/cdk-for-terraform-enabling-python-and-typescript-support), Python and TypeScript Support | - |
| **Azure Integrations** | ARM, AAD via [Tenant Scope](https://docs.microsoft.com/azure/azure-resource-manager/bicep/deploy-to-tenant?tabs=azure-cli) | ARM, AAD, ADO | ARM, AAD, ADO |
| **Clouds** | Azure-only | Agnostic + on-prem | Agnostic + on-prem |
| **Preview Changes** | [`az deployment … what-if`](https://docs.microsoft.com/azure/azure-resource-manager/templates/template-deploy-what-if?tabs=azure-powershell) | [`terraform plan`](https://www.terraform.io/docs/cli/commands/plan.html) | [`pulumi preview`](https://www.pulumi.com/docs/reference/cli/pulumi_preview/) |
| **Rollback Changes** | [Rollback](https://docs.microsoft.com/azure/azure-resource-manager/templates/rollback-on-error) | Revert code & Re-deploy | Revert code & Re-deploy |
| **Infrastructure Clean Up** | Delete Resource Group | [`terraform destroy`](https://www.terraform.io/docs/cli/commands/destroy.html) | [`pulumi destroy`](https://www.pulumi.com/docs/reference/cli/pulumi_destroy/) |
| **Deployment History** | [Deployment History](https://docs.microsoft.com/azure/azure-resource-manager/templates/deployment-history?tabs=azure-portal) |  SCM + [Auditing](https://www.hashicorp.com/blog/hashicorp-terraform-cloud-audit-logging-with-splunk)* | SCM + [Auditing](https://www.pulumi.com/docs/intro/console/collaboration/auditing/)* |
| **Code Re-Use** | [Hosted JSON (ARM)](https://docs.microsoft.com/azure/azure-resource-manager/templates/linked-templates#linked-template) + [Private Registry** (Bicep)](https://docs.microsoft.com/azure/azure-resource-manager/bicep/private-module-registry) | [Modules](https://learn.hashicorp.com/collections/terraform/modules) + [Registry](https://learn.hashicorp.com/tutorials/terraform/module-private-registry)* | Code-Native Packages, e.g. npm or pip |
| **State Files** | No State File | [Plain-text](https://www.terraform.io/docs/language/state/index.html) | [Encrypted](https://www.pulumi.com/docs/intro/concepts/state/) |

_* premium feature_  
_** preview feature as of 10 Nov 2021_

#### Abbreviations

- ARM = Azure Resource Manager
- AAD = Azure Active Directory
- ADO = Azure DevOps
- DSL = Domain Specific Language
- HCL = HashiCorp Language
- SCM = Source Code Management

## Security Considerations for Automating Infrastructure

- Azure Architecture Center: E2E Governance and [what access do security principals need?](https://docs.microsoft.com/azure/architecture/example-scenario/governance/end-to-end-governance-in-azure#2-what-access-do-security-principals-need) 
- Azure Docs: [Principle of Least Privilege](https://docs.microsoft.com/azure/role-based-access-control/best-practices#only-grant-the-access-users-need)
- Azure Docs: [Lock resources to prevent unexpected changes](https://docs.microsoft.com/azure/azure-resource-manager/management/lock-resources?tabs=json)
- Cloud Adoption Framework: [Standard enterprise governance guide](https://docs.microsoft.com/azure/cloud-adoption-framework/govern/guides/standard/)

### Use Custom Roles

Example custom role from [Azure Architecture Center: End-to-end governance in Azure when using CI/CD](https://docs.microsoft.com/azure/architecture/example-scenario/governance/end-to-end-governance-in-azure)

```json
{
  "Name": "Headless Owner",    
  "Description": "Can manage infrastructure.",
  "actions": [
    "*"
  ],
  "notActions": [
    "Microsoft.Authorization/*/Delete"
  ],
  "AssignableScopes": [
    "/subscriptions/{subscriptionId1}",
    "/subscriptions/{subscriptionId2}",
    "/providers/Microsoft.Management/managementGroups/{groupId1}"
  ]
}
```

# Pipeline Walkthroughs

### [Governance on Azure Demo (Terraform)]((https://github.com/azure/devops-governance))

- Azure Integrations: ARM, AAD, ADO
- [`DEPLOY.md`](https://github.com/Azure/devops-governance/blob/main/DEPLOY.md) example of permissions and configurations required for IaC
- Drift Detection in [`stages/pull-request.yaml`](https://github.com/Azure/devops-governance/blob/main/azure-pipelines/stages/pull-request.yaml) and posting results back to Pull Request [(example)](https://github.com/Azure/devops-governance/pull/44#issuecomment-961037578)


### [AKS Secure Baseline (ARM/Bicep)](https://github.com/Azure/Aks-Construction/tree/main/bicep)

Please note both code projects are based on [Secure AKS Baseline Reference Architecture](https://docs.microsoft.com/azure/architecture/reference-architectures/containers/aks/secure-baseline-aks) and complementary.

- [Secure AKS Baseline Reference Implementation (ARM)](https://github.com/mspnp/aks-secure-baseline) 
  - has very good step by step multi-page markdown instructions
  - Infra as Code in real life is complicated
  - JSON is not friendliest to read, example [`cluster-stamp.json`](https://github.com/mspnp/aks-secure-baseline/blob/main/cluster-stamp.json)
- [AKS Bicep Accelerator (Bicep)](https://github.com/Azure/Aks-Construction/tree/main/bicep) 
  - has multiple files, e.g. [`./network.bicep`](https://github.com/Azure/Aks-Construction/blob/main/bicep/network.bicep) with local directory requirement.
  - [`main.bicep`](https://github.com/Azure/Aks-Construction/blob/main/bicep/main.bicep) - note parameters/variables

# Scenario Walkthroughs

### Shared Resources at Scale - Platform vs Workload Teams

This is an example from the API Management PG that is a great example of a real life solution to the complex problem of CI/CD at scale.

The key difference can be summarized in the table below. 

| Environment | # of APIMs | APIM Owner | API Definitions |
|:--|:--|:--|:--|
| Dev | _n_ | Workload Team | Export API definitions config |
| Prod |  1 | Central or Platform Team | Imports API definitions config |

Please read the PG documentation to undestand the nuances:

- [APIM DevOps Resource Kit](https://github.com/Azure/azure-api-management-devops-resource-kit) - the README and diagram are great. Take the time to really digest.
- [PG Video Walkthrough of APIM DevOps Resource Kit](https://www.youtube.com/watch?v=4Sp2Qvmg6j8)

# Resources

Additional resources to bookmark

- [Bicep Examples on GitHub.com](https://github.com/Azure/bicep/tree/main/docs/examples) sorted by level (100, 200, etc.) and great for learning by example. 
- [Azure Policy Samples on GitHub.com](https://github.com/Azure/azure-policy) built-in and reference examples for you to learn, extend and use.
- Bicep Scope deployments: [Resource Group](https://docs.microsoft.com/azure/azure-resource-manager/bicep/deploy-to-resource-group?tabs=azure-cli), [Subscription](https://docs.microsoft.com/azure/azure-resource-manager/bicep/deploy-to-subscription?tabs=azure-cli), [Management Group](https://docs.microsoft.com/azure/azure-resource-manager/bicep/deploy-to-management-group?tabs=azure-cli), [Tenant](https://docs.microsoft.com/azure/azure-resource-manager/bicep/deploy-to-tenant?tabs=azure-cli)

