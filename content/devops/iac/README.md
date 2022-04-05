---
services: ARM and Azure Pipeline 
author: wviriya
level: 300
---

# FastTrack for Azure Live - How to deploy Azure services and infrastructure. Leverage Azure Pipeline for CI/CD.  

## Synopsis:
"Zero to Hero with ARM and IaC" How to create a Bicep template and deploy using Azure Pipelines.

## Who should attend:
- I want to do Infrastructure as Code but don't know where to start.
- My team keeps asking me to deploy infrastructure and various environments to Azure, and I do it manually.
- I want to automate my infrastructure.

## At the end of the session you should:
- Understand the basic of Bicep.
- Be aware of the tools available to create Bicep template.
- Understand basic how to create and use simple Azure Pipelines.

## What are prerequisites:
- Azure Subscription
- Azure DevOps account
- JSON (JavaScript Object Notation)
- YAML Syntax
- Git repository
- Desire to learn

## Where are your team
![Automation Maturity](media/automation_maturity.png)

## About this sample
This sample is a guide for learning basic Bicep. The links in this document can you help better understand these services and tools.

## [What is Infrastructure as Code?](https://docs.microsoft.com/en-us/azure/devops/learn/what-is-infrastructure-as-code)

## [Why I should adopt Infrastructure as Code Practice? (Read John Downs' Blog)](https://techcommunity.microsoft.com/t5/fasttrack-for-azure/the-benefits-of-infrastructure-as-code/ba-p/2069350)

## Bicep
A language for declaratively deploying Azure resources. You can use Bicep instead of JSON for developing your Azure Resource Manager templates (ARM templates). Bicep simplifies the authoring experience by providing concise syntax, better support for code reuse, and improved type safety. Bicep is a domain-specific language (DSL), which means it's designed for a particular scenario or domain. It isn't intended as a general programming language for writing applications.

## Azure Resource Manager (ARM) Template
A native infra-as-code solution for managing Azure resources using a declarative programming paradigm.

### Concepts
- [Bicep](https://docs.microsoft.com/en-us/azure/azure-resource-manager/templates/bicep-overview)

### Authoring tools and helps
- [Bicep](https://docs.microsoft.com/en-us/azure/azure-resource-manager/bicep/overview)
- [Azure Portal](https://docs.microsoft.com/en-us/azure/azure-resource-manager/templates/quickstart-create-templates-use-the-portal)
- [VS Code](https://docs.microsoft.com/en-us/azure/azure-resource-manager/templates/quickstart-create-templates-use-visual-studio-code?tabs=CLI)
- [Bicep Visual Studio Code extension](https://marketplace.visualstudio.com/items?itemName=ms-azuretools.vscode-bicep)
- [Azure CLI](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli)
- [Azure PowerShell](https://docs.microsoft.com/en-us/powershell/azure/install-az-ps?view=azps-6.0.0)

### CI/CD
- [Deploy with Azure Pipelines](https://docs.microsoft.com/en-us/azure/azure-resource-manager/templates/add-template-to-azure-pipelines)
- [Deploy with GitHub Actions](https://docs.microsoft.com/en-us/azure/azure-resource-manager/templates/deploy-github-actions)

### Learning resources
- [Microsoft Learn path - Deploy and manage resources in Azure by using Bicep](https://docs.microsoft.com/en-us/learn/paths/bicep-deploy/)

## Other orchestrators
### Terraform with Azure
- [Overview](https://docs.microsoft.com/en-us/azure/developer/terraform/overview)
- [Terraform QuickStart](https://docs.microsoft.com/en-us/azure/developer/terraform/install-configure)
- [Terraform Configuration Language](https://www.terraform.io/docs/configuration/syntax.html)
- [Store Terraform state in Azure Storage](https://docs.microsoft.com/en-us/azure/developer/terraform/store-state-in-azure-storage)
- [Automating infrastructure deployments in the Cloud with Terraform and Azure Pipelines](https://www.azuredevopslabs.com/labs/vstsextend/terraform/)

### Ansible wiht Azure
- [Overview](https://docs.microsoft.com/en-us/azure/developer/ansible/overview)
- [Ansible QuickStart](https://docs.microsoft.com/en-us/azure/developer/ansible/install-on-linux-vm)  
- [Ansible Playbooks](https://docs.ansible.com/ansible/latest/user_guide/playbooks_intro.html)
- [Automating infrastructure deployments in the Cloud with Ansible and Azure Pipelines](https://www.azuredevopslabs.com/labs/vstsextend/ansible/)

## [FAQ](./faq.md)