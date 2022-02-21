# Securing the CI/CD workflow

Securing your CI/CD workflow makes a lot of sense, since it gives a point of access to the different environments you deploy to. This implies that you need to take extra care of into defining who has access to your repositories, pipelines and workflows and how each of your automatic processes are governed.

For overall governance of your CI/CD processes, take a look at the [DevOps Governance session](../part-1-ado-governance.md) we host in [FTA Live](https://fasttrack.azure.com/live/category/DevOps).

This session is based upon: [Secure the pipeline and CI/CD workflow](https://docs.microsoft.com/en-us/azure/cloud-adoption-framework/secure/best-practices/secure-devops).

Guidance specifically for [Azure pipelines](https://docs.microsoft.com/en-us/azure/devops/pipelines/security/overview?view=azure-devops), which describes the different components you can secure.

For workflows hosted on GitHub, there is guidance on [Security hardening](https://docs.github.com/en/actions/security-guides/security-hardening-for-github-actions). For authenticating your GitHub workflows against Azure Active Directory, there is a (currently preview!) way of authenticating based on [workload identity](https://docs.microsoft.com/en-us/azure/active-directory/develop/workload-identity-federation). Guidance on how to configure and use this can be found in the [GitHub docs on Configuring OpenID Connect in Azure](https://docs.github.com/en/actions/deployment/security-hardening-your-deployments/configuring-openid-connect-in-azure) and in the [Microsoft docs on Use GitHub Actions to connect to Azure](https://docs.microsoft.com/en-us/azure/developer/github/connect-from-azure?tabs=azure-portal%2Cwindows).
