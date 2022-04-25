# Overview 

| Plan and Develop | Commit the Code | Build and Test | Go to Production | Operate |  
|---|---|---|---|---|
|[Threat Modelling](./ThreatModelling.md)| [Static application security testing](./CodeAnalysis.md)| [Dynamic application security testing](./CodeAnalysis.md) | Security smoke tests | [Continuous monitoring](Operate.md)
|[IDE Security plugins](./CodeAnalysis.md)| Security Unit and Functional tests | _**[Cloud configuration validation](CloudConfigValidation.md)**_ | _**[Configuration checks](CloudConfigValidation.md)**_ | [Threat intelligence](Operate.md)
|[Pre commit hooks](https://git-scm.com/book/en/v2/Customizing-Git-Git-Hooks)| [Dependency management](./CodeAnalysis.md) | _**[Infrastructure scanning](CloudConfigValidation.md)**_ | [Live Site Penetration testing](https://docs.microsoft.com/azure/security/fundamentals/pen-testing) | [Penetration testing](https://docs.microsoft.com/azure/security/fundamentals/pen-testing)
|[Secure coding standards](https://owasp.org/www-project-secure-coding-practices-quick-reference-guide/migrated_content) | [Securing the CI/CD workflow](./securingCICD.md) | Security acceptance testing | Blameless postmortems
|[Peer review](https://docs.github.com/en/pull-requests/collaborating-with-pull-requests/proposing-changes-to-your-work-with-pull-requests/about-pull-requests)||||

# Cloud Configuration Validation

When deploying to a cloud environment like Azure, and especially when applying Infrastructure as Code (IaC), it becomes important to check that any configuration made in your cloud environment complies with overall security and governance principles.

![Typical IaC workflow](media/IaC.png)

When utilizing Infrastructure as Code you can run these checks beforehand by using specific tooling, however, it is more common to have your cloud platform flag any incompliance to you with the tooling that is build into the platform.

## Pre-deployment checks

Depending on which IaC tooling you use, you will have different tools available to you to run checks before deployment happens.

In case you want to learn more about IaC and how to build a secure process, we also advise you to take a look at the [FTA Live sessions on DevOps for infrastructure](https://github.com/Azure/FTALive-Sessions/blob/main/content/devops/part-3-infra.md). You can sign up for these session on the [FTA Live site](https://fasttrack.azure.com/live/category/DevOps).

### ARM and Bicep

For both JSon and Bicep ARM templates, you can add template scanning by using the [arm-ttk](https://github.com/Azure/arm-ttk) toolkit. The [Bicep Linter](https://docs.microsoft.com/azure/azure-resource-manager/bicep/linter) is the more up to date version of arm-ttk for Bicep templates. 

A full run-through of how to test Bicep code can be found in this [learn module for Azure Pipelines](https://docs.microsoft.com/learn/modules/test-bicep-code-using-azure-pipelines/) and this one for [GitHub Actions](https://docs.microsoft.com/learn/modules/test-bicep-code-using-github-actions/). It also covers steps like validating, linting, previewing changes and approving deployment. Both modules are part of a larger set of [learn paths on Bicep](https://docs.microsoft.com/azure/azure-resource-manager/bicep/learn-bicep)

### Terraform

For Terraform, there is [tfsec](https://aquasecurity.github.io/tfsec/v1.4.2/). This [article](https://www.winopsdba.com/blog/azure-cloud-terraform-validate-and-sast.html) describes how you can use tf validate and tfsec in a pipeline for pre-analysis.

Even though testing IaC templates before deployment is an option, a better way of making sure you comply with all governance and security rules, is by utilizing your cloud platforms' built-in governance controls. These will provide you with the most up-to-date set of governance controls.

## Build-in governance controls

The [Cloud Adoption Framework](https://docs.microsoft.com/azure/cloud-adoption-framework/) defines cloud security as a journey where you work towards a [secure end state](https://docs.microsoft.com/azure/cloud-adoption-framework/secure/). 

![Envision a security end state](media/secure-methodology.png)

This end state can be enforced by utilizing [Azure Policies](https://docs.microsoft.com/azure/governance/policy/overview). We provide multiple [build-in Azure Policy initiatives](https://docs.microsoft.com/azure/governance/policy/samples/built-in-initiatives) and [landing zones](https://docs.microsoft.com/azure/cloud-adoption-framework/ready/landing-zone/implementation-options) that utilize these built-in Azure Policy definitions to enforce governance controls. [Enterprise scale landing zone (ESLZ)](https://docs.microsoft.com/azure/cloud-adoption-framework/ready/enterprise-scale/) is one of these predefined landing zone setups.

![enterprise scale hub and spoke](media/es-hubspoke.png)

Depending on how you configure Azure Policy you can opt for a no-deploy of a resource in case it does not comply with the standards you have set. As an alternative you can opt for a flagging of a incompliant state.

We provide an [FTA Live session on Azure Governance](https://github.com/Azure/FTALive-Sessions/tree/main/content/management-governance/governance) for which you can sign up [here](https://fasttrack.azure.com/live/category/Governance)

## Post-deployment checks

You could also utilize checks post-deployment. These are less common, but we mention these for completeness.

In an Azure environment, you can use the [resource graph](https://docs.microsoft.com/azure/governance/resource-graph/samples/advanced?tabs=azure-cli) to test what has been deployed and how.