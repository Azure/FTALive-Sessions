# ARM FAQ
## Can I export a template from existing resources?
Yes, you can export a template form existing resources through the Azure portal, see [Export template in Azure portal](https://docs.microsoft.com/en-us/azure/azure-resource-manager/templates/export-template-portal).

## Can I reuse templates?
Yes, the ARM template is designed to be reusable. You may deploy ARM templates through [portal](https://docs.microsoft.com/en-us/azure/azure-resource-manager/templates/deploy-portal), [CLI](https://docs.microsoft.com/en-us/azure/azure-resource-manager/templates/deploy-cli), [PowerShell](https://docs.microsoft.com/en-us/azure/azure-resource-manager/templates/deploy-powershell), [REST API](https://docs.microsoft.com/en-us/azure/azure-resource-manager/templates/deploy-rest) or [from GitHub](https://docs.microsoft.com/en-us/azure/azure-resource-manager/templates/deploy-to-azure-button).

## Is it good practice to deploy multiple different templates to the same resource group?
Good practice is to have a single template or a set of main and [linked templates](https://docs.microsoft.com/en-us/azure/azure-resource-manager/templates/linked-templates) to deploy resources into a resource group. This allows for change tracking and single source of truth.

## Which API Version should I use?
It depends on features of the resource that you want to use. Each resource provider has its own set of API versions. The latest version will have latest features available.

## If Microsoft makes changes to resources will it break my template?
Microsoft keeps previous versions of resource providers and makes available via versioning of REST API.

## Do you recommend complete or incremental mode?
For most situations incremental mode is recommended. It is important to understand differences between two [deployment modes](https://docs.microsoft.com/en-us/azure/azure-resource-manager/templates/deployment-modes).

## How do I manage secrets in a template?
We recommend [integrate Azure Key Vault](https://docs.microsoft.com/en-us/azure/azure-resource-manager/templates/template-tutorial-use-key-vault) in your ARM template deployment. You can store secrets in Azure Key Vault and retrieve them as deployment template parameters.

## How can I run non ARM actions as part of my ARM deployment e.g run a powershell or upload a blob?
Yes, there is a feature, [deployment scripts in template](https://docs.microsoft.com/en-us/azure/azure-resource-manager/templates/deployment-script-template?tabs=CLI) (preview), which allows execution of PowerShell or CLI scripts in template deployments and reviewing of execution results.

## Should I build using kudu or my pipeline?
Generally building in a pipeline makes more sense. This allows you to adopt a Build once deploy many approach and the only change between environments is some configuration. Building using kudu can be very useful for demo templates where you want to enable others to use your template in a one click deployment.

## Should I handle complex logic in my template using nested templates and logic operator or should i move it up to powershell or an orchestrator?
It depends on your preference. ARM template is capable of complex logic and operations.

## What the best tool for authoring templates?
This really comes down to personal preference, We commonly use Visual Studio or VSCode as they both have great extensions for navigating, generating and validating templates.

## Where should I start? Create in the portal and export, QuickStart templates and modify, or using snippets
Everyone learns in different ways but we find starting with a combination of QuickStart templates and exporting resources from the portal until you become familiar is a good way to go

## How do I manage dependencies against existing resources that are not defined in my template?
You can refer to existing resource(s) by Resource Id. You may use build-in [resourceId](https://docs.microsoft.com/en-us/azure/azure-resource-manager/templates/template-functions-resource#resourceid) function for ARM template. You will need subscription id and resource group name of dependent resource.

## Can I create resource groups with an ARM template?
Yes, But there requires a deployment to the subscription and not to the resource group. This approach is used in blueprints for example. For less complex deployments you would typically deploy all your resources into one resource group which would be pre provisioned using PowerShell, CLI or Azure Pipelines

## Can I assign permissions in an arm template
No. However, by using [deployment scripts in template](https://docs.microsoft.com/en-us/azure/azure-resource-manager/templates/deployment-script-template?tabs=CLI) (preview). You can manage users and create objects in Azure AD.

## How do I share common templates with my team or end users
There are several options. The portal has a builtin template gallery to share templates across your tenant. You could manage deployments entirely thorough Azure DevOps or another orchestrator. You could build you custom deployment solution using a private repository. Alternatively, Github is a great way for sharing templates with external users.

## When should I use Azure Blueprints vs standalone ARM templates?
You should start with the standalone ARM templates and once you feel comfortable with them, investigate to Azure Blueprints. Azure Blueprints combine role and policy assignments together with ARM templates and Resource Groups to define a repeatable set of Azure resources that implements and adheres to an organization's standards, patterns, and requirements.

## Any Anti-Patterns I should be aware of?
DO NOT right click to deploy.
Ensure traceability.

# IaC FAQ
## Should I automate everything including resources I only provision once?
You need to evaluate effort required to create deployment template. If the resource(s) are meant to be provisioned once, the portal can be the quickest way to deploy.

## How do I manage changes that cant be automated?
By utilizing appropriate tooling, most changes can be automated. Otherwise, limit number of staff who can manage these changes.

## How do I choose my tooling? ARM, TerraForm, Ansible, Puppet, Chef, DSC, git etc
It depends. By using pipelines tool such as Azure Pipelines, many of these tools can work together where its purpose fits.

## How do I manage shared resources when working with teams of teams, e.g Application Gateway or API Management
Typically, these shared resources should be managed with a single template/script by an appropriate team.

## How do I encourage my team to start using declarative methods, source control and be test driven?
Show your team the benefit of this approach and build DevOps culture among team's members.

