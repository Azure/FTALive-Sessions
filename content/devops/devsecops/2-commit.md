# Commit the code

[< Previous](./1-plan-develop.md) | [Home](./readme.md) | [Next >](./3-build-test.md)

![devsecops-controls](./media/devsecops-controls.png)

Typically, developers create, manage, and share their code in repositories such as GitHub or Azure Repos. This approach provides a central, version-controlled library of code that can be collaborated on easily. However, enabling many collaborators on a single codebase can also introduce the risk of changes being introduced. That risk can lead to vulnerabilities or the unintentional inclusion of credentials or tokens in commits.

To address this risk, development teams should evaluate and implement a repository scanning capability. Repository scanning tools perform static code analysis on source code within repositories and look for vulnerabilities or credentials and flag items found for remediation. This capability acts to protect against human error and is a useful safeguard for distributed teams where many people are collaborating in the same repository.

## Static application security testing

It's essential for developers to focus and improve their written code quality and security. There are multiple ways to improve code quality and security, like using IDE security plug-ins and wiring incremental static analysis pre-commit and commit checks discussed before. It's also possible to do the complete source code scanning using static code analysis inside of continuous integration to catch some mistakes missed by previous steps.

To ensure that the feedback loop is effective, it's crucial to tune the tool to minimize false positives and provide clear, actionable feedback on problems to fix. Additionally, it's good to implement the workflow, which prevents code commit to the default branch if there are findings. For both quality and security findings. In this way, security becomes a part of the unit testing experience.

The following are tools that you may considered:

- [GitHub Advance Security](https://docs.github.com/en/free-pro-team@latest/github/finding-security-vulnerabilities-and-errors-in-your-code/automatically-scanning-your-code-for-vulnerabilities-and-errors) with [CodeQL](https://codeql.github.com/). This allows you to write your own custom query to detect vulnerabilities in your code. [Demo](https://github.com/github/code-scanning-javascript-demo).
- GitHub [secret scanning](https://docs.github.com/en/enterprise-cloud@latest/code-security/secret-scanning/configuring-secret-scanning-for-your-repositories) and [push protection](https://docs.github.com/en/enterprise-cloud@latest/code-security/secret-scanning/protecting-pushes-with-secret-scanning)
- [BinSkim](https://github.com/microsoft/binskim/blob/main/docs/UserGuide.md) - a checker that examines Portable Executable (PE) files and their associated Program Database File Formats (PDB) to identify various security problems.
- [Security Code Scan for .NET](https://security-code-scan.github.io/)
- [SonarQube](https://docs.sonarqube.org/latest/)
- [CredScan](https://secdevtools.azurewebsites.net/helpcredscan.html)
- [Additional tools](https://www.microsoft.com/securityengineering/sdl/resources)

## Dependency management

It's known that up 90 percent of the code in current applications contains and is based on external packages and libraries. With the adoption of dependencies in the source code, it's essential to address potential risks. Many third-party libraries have serious security problems themselves. Additionally, developers not consistently implement the proper lifecycle and keep them up to date.

Developer teams should ensure that they know what components are included in their applications, be sure that secure and up-to-date versions are downloaded from the known sources, and there's a process for keeping them up to date. It's also important to address package feeds security.

To check the security on any dependencies you may use in your project:

- [Dependabot](https://github.com/dependabot/dependabot-core#dependabot) - dependency review and alerts in GitHub. [Demo](https://github.com/dependabot/demo)
- [OWASP Dependency-check project](https://owasp.org/www-project-dependency-check/)
- [Securing software supply chain](https://docs.github.com/en/free-pro-team@latest/github/managing-security-vulnerabilities) in GitHub.

## Securing the CI/CD workflow

Securing your CI/CD workflow makes a lot of sense, since it gives a point of access to the different environments you deploy to. This implies that you need to take extra care of into defining who has access to your repositories, pipelines and workflows and how each of your automatic processes are governed.

For overall governance of your CI/CD processes, take a look at the [DevOps Governance session](../patterns-and-practices/readme.md) we host in [FTA Live](https://aka.ms/ftalive).

<img src="https://raw.githubusercontent.com/Azure/devops-governance/main/images/e2e-governance-overview.svg" width="640" alt="Azure Architect Center - E2E Governance">

This session is based upon: [Secure the pipeline and CI/CD workflow](https://docs.microsoft.com/azure/cloud-adoption-framework/secure/best-practices/secure-devops).

Guidance specifically for [Azure pipelines](https://docs.microsoft.com/azure/devops/pipelines/security/overview?view=azure-devops), which describes the different components you can secure.

For workflows hosted on GitHub, there is guidance on [Security hardening](https://docs.github.com/en/actions/security-guides/security-hardening-for-github-actions). For authenticating your GitHub workflows against Azure Active Directory, there is a (currently preview!) way of authenticating based on [workload identity](https://docs.microsoft.com/azure/active-directory/develop/workload-identity-federation). Guidance on how to configure and use this can be found in the [GitHub docs on Configuring OpenID Connect in Azure](https://docs.github.com/en/actions/deployment/security-hardening-your-deployments/configuring-openid-connect-in-azure) and in the [Microsoft docs on Use GitHub Actions to connect to Azure](https://docs.microsoft.com/azure/developer/github/connect-from-azure?tabs=azure-portal%2Cwindows).

[< Previous](./1-plan-develop.md) | [Home](./readme.md) | [Next >](./3-build-test.md)
