# Overview

| Plan and Develop | Commit the Code | Build and Test | Go to Production | Operate |  
|---|---|---|---|---|
|[Threat Modelling](./ThreatModelling.md)| [Static application security testing](./CodeAnalysis.md)| [Dynamic application security testing](./CodeAnalysis.md) | Security smoke tests | [Continuous monitoring](Operate.md)
|[IDE Security plugins](./CodeAnalysis.md)| Security Unit and Functional tests | [Cloud configuration validation](CloudConfigValidation.md) | [Configuration checks](CloudConfigValidation.md) | [Threat intelligence](Operate.md)
|[Pre commit hooks](https://git-scm.com/book/en/v2/Customizing-Git-Git-Hooks)| [Dependency management](./CodeAnalysis.md) | [Infrastructure scanning](CloudConfigValidation.md) | [Live Site Penetration testing](https://docs.microsoft.com/azure/security/fundamentals/pen-testing) | [Penetration testing](https://docs.microsoft.com/azure/security/fundamentals/pen-testing)
|[Secure coding standards](https://owasp.org/www-project-secure-coding-practices-quick-reference-guide/migrated_content) | _**[Securing the CI/CD workflow](./securingCICD.md)**_ | Security acceptance testing | Blameless postmortems
|[Peer review](https://docs.github.com/en/pull-requests/collaborating-with-pull-requests/proposing-changes-to-your-work-with-pull-requests/about-pull-requests)||||


# Securing the CI/CD workflow

Securing your CI/CD workflow makes a lot of sense, since it gives a point of access to the different environments you deploy to. This implies that you need to take extra care of into defining who has access to your repositories, pipelines and workflows and how each of your automatic processes are governed.

For overall governance of your CI/CD processes, take a look at the [DevOps Governance session](../part-1-ado-governance.md) we host in [FTA Live](https://fasttrack.azure.com/live/category/DevOps).

This session is based upon: [Secure the pipeline and CI/CD workflow](https://docs.microsoft.com/azure/cloud-adoption-framework/secure/best-practices/secure-devops).

Guidance specifically for [Azure pipelines](https://docs.microsoft.com/azure/devops/pipelines/security/overview?view=azure-devops), which describes the different components you can secure.

For workflows hosted on GitHub, there is guidance on [Security hardening](https://docs.github.com/en/actions/security-guides/security-hardening-for-github-actions). For authenticating your GitHub workflows against Azure Active Directory, there is a (currently preview!) way of authenticating based on [workload identity](https://docs.microsoft.com/azure/active-directory/develop/workload-identity-federation). Guidance on how to configure and use this can be found in the [GitHub docs on Configuring OpenID Connect in Azure](https://docs.github.com/en/actions/deployment/security-hardening-your-deployments/configuring-openid-connect-in-azure) and in the [Microsoft docs on Use GitHub Actions to connect to Azure](https://docs.microsoft.com/azure/developer/github/connect-from-azure?tabs=azure-portal%2Cwindows).
