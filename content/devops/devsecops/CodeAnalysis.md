# Overview 

| Plan and Develop | Commit the Code | Build and Test | Go to Production | Operate |  
|---|---|---|---|---|
|[Threat Modelling](./ThreatModelling.md)| _**[Static application security testing](./CodeAnalysis.md)**_| _**[Dynamic application security testing](./CodeAnalysis.md)**_ | Security smoke tests | [Continuous monitoring](Operate.md)
|_**[IDE Security plugins](./CodeAnalysis.md)**_| Security Unit and Functional tests | [Cloud configuration validation](CloudConfigValidation.md) | [Configuration checks](CloudConfigValidation.md) | [Threat intelligence](Operate.md)
|[Pre commit hooks](https://git-scm.com/book/en/v2/Customizing-Git-Git-Hooks)| _**[Dependency management](./CodeAnalysis.md)**_ | [Infrastructure scanning](CloudConfigValidation.md) | [Live Site Penetration testing](https://docs.microsoft.com/azure/security/fundamentals/pen-testing) | [Penetration testing](https://docs.microsoft.com/azure/security/fundamentals/pen-testing)
|[Secure coding standards](https://owasp.org/www-project-secure-coding-practices-quick-reference-guide/migrated_content) | [Securing the CI/CD workflow](./securingCICD.md) | Security acceptance testing | Blameless postmortems
|[Peer review](https://docs.github.com/en/pull-requests/collaborating-with-pull-requests/proposing-changes-to-your-work-with-pull-requests/about-pull-requests)||||


# Code Analysis

So, your team is developing a software and likely your code depends on external libraries or open-source software (dependencies). Any vulnerability in these dependencies can translate to security risk in your solution. Even if you develop software with 100% 1st party components, an insecure software design and implementation can still happen.  By continuously run code/dependency/security analysis in your repository and CI/CD process, you can greatly reduce security risk and prevent bugs from ever appearing in your solution.

## IDE Security plugins

- [DevSkim](https://github.com/Microsoft/DevSkim#devskim) - a framework of IDE extensions and language analyzers that provide inline security analysis in the dev environment as the developer writes code.
- [Tools from Visual Studio marketplace](https://marketplace.visualstudio.com/search?term=tag%3ASecurity&target=VS&category=All%20categories&vsVersion=vs15&sortBy=Relevance)
- [Tools from Visual Studio Code marketplace](https://marketplace.visualstudio.com/search?term=tag%3Asecurity&target=VSCode&category=All%20categories&sortBy=Relevance)

## Static code analysis

The following are tools that you may considered:

- GitHub [code scanning](https://docs.github.com/en/free-pro-team@latest/github/finding-security-vulnerabilities-and-errors-in-your-code/automatically-scanning-your-code-for-vulnerabilities-and-errors) with [CodeQL](https://codeql.github.com/). This allows you to write your own custom query to detect vulnerabilities in your code. [Demo](https://github.com/github/code-scanning-javascript-demo).
- [BinSkim](https://github.com/microsoft/binskim/blob/main/docs/UserGuide.md) - a checker that examines Portable Executable (PE) files and their associated Program Database File Formats (PDB) to identify various security problems.
- [Security Code Scan for .NET](https://security-code-scan.github.io/)
- [SonarQube](https://docs.sonarqube.org/latest/)
- [CredScan](https://secdevtools.azurewebsites.net/helpcredscan.html)
- [Additional tools](https://www.microsoft.com/securityengineering/sdl/resources)

## Dependency management

Checking the security on any dependencies you may use in your project:

- [Dependabot](https://github.com/dependabot/dependabot-core#dependabot) - dependency review and alerts in GitHub.
- [OWASP Dependency-check project](https://owasp.org/www-project-dependency-check/)
- [Securing software supply chain](https://docs.github.com/en/free-pro-team@latest/github/managing-security-vulnerabilities) in GitHub.

## OWASP Scanning

- **What is OWASP Scanning?**
This is a way of scanning your deployed application with an engine which will test the application endpoint effectiveness by launching simulated attacks. A report is generated afterwards which can be assessed.

- **How does this fit into DevOps?**
Usually Penetration Testing (or Pen Testing) is carried out at the latter stages of development against the completed web site (and may continue at a regular cadence thereafter). However it doesn't have to be this way. Scanning/Pen testing can be undertaken during development against the deployed website, during release as an extension of integration testing steps. The advantage is that you learn about any potential new vulnerabilities quickly (shift left). These could be issues created by new code/features or issues introduced by regression.

- **What exists that can help me here?**
Quite a bit of technical effort is required to write a tool that can undertake this kind of synthetic testing/scanning and keep it up to date. For the vast majority of teams writing and maintaining their own tools is not going to be a good use of time and in most cases would not be recommended (mistakes here could lead to a false sense of security).
[OWASP themselves maintain an open source product called Zap](https://owasp.org/www-project-zap/), this tool is regularly maintained and free to use with good online usage instruction and documentation. [An extension of this tool can be obtained from the VS marketplace. The extension can be utilised to run in a Build or Release Pipeline. Full instructions provided in this link.](https://marketplace.visualstudio.com/items?itemName=CSE-DevOps.zap-scanner)

## Container Scanning

When creating containerized workloads, you can be susceptible to additional security threads. There are additional security tools you can use to protect your workloads:

- [Microsoft Defender for Containers](https://docs.microsoft.com/azure/defender-for-cloud/defender-for-containers-introduction?tabs=defender-for-container-arch-aks#architecture-overview)
- [Identify vulnerable container images in your CI/CD workflows](https://docs.microsoft.com/azure/defender-for-cloud/defender-for-container-registries-cicd)
- [Enhance your CI/CD deployment by using Vulnerability Assessments from Microsoft Defender for ACR](https://techcommunity.microsoft.com/t5/microsoft-defender-for-cloud/enhance-your-ci-cd-deployment-by-using-vulnerability-assessments/ba-p/2102516)

Also take a look at the [end to end setups](EndToEnd.md), which contains extra info for AKS workloads. 

## Open Source Security

Open-source software security is the measure of assurance or guarantee in the freedom from danger and risk inherent to an open-source software system.

### Benefits

- Proprietary software forces the user to accept the level of security that the software vendor is willing to deliver and to accept the rate that patches and updates are released
- It is assumed that any compiler that is used creates code that can be trusted, but it has been demonstrated by Ken Thompson that a compiler can be subverted using a compiler backdoor to create faulty executables that are unwittingly produced by a well-intentioned developer. With access to the source code for the compiler, the developer has at least the ability to discover if there is any mal-intention.
- Kerckhoffs' principle is based on the idea that a cryptosystem should be secure, even if everything about the system, except the key, is public knowledge. His ideas were the basis for many modern security practices, and followed that security through obscurity is a bad practice.

### Drawbacks

- Simply making source code available does not guarantee review. An example of this occurring is when Marcus Ranum, an expert on security system design and implementation, released his first public firewall toolkit. At one time, there were over 2,000 sites using his toolkit, but only 10 people gave him any feedback or patches.
- Having a large amount of eyes reviewing code can "lull a user into a false sense of security". Having many users look at source code does not guarantee that security flaws will be found and fixed.

Source : [Wikipedia](https://en.wikipedia.org/wiki/Open-source_software_security)

### Approaching Open Source Security

- Understand your software supply chain.
- Evaluate open source components regularly.
- Maintain an 'approved software' list and share it within your organization.
- Update libraries that have disclosed vulnerabilities.

## A different way of designing your code

Some of the above tools are also targetted at scanning your code for credentials. These should indeed not leak into your source code. By utilizing a different way of designing your applications, you can avoid needing to store credentials in your source code altogether. For Azure workloads, you want to consider: 

- [Azure Key Vault](https://docs.microsoft.com/azure/key-vault/general/overview)
- [Add Key Vault to your web application](https://docs.microsoft.com/azure/key-vault/general/vs-key-vault-add-connected-service)
- [Use Key Vault references for App Service and Azure Functions](https://docs.microsoft.com/azure/app-service/app-service-key-vault-references)
- [Managed Identity](https://docs.microsoft.com/azure/active-directory/managed-identities-azure-resources/overview)
- [How to use managed identities for App Service and Azure Functions](https://docs.microsoft.com/azure/app-service/overview-managed-identity?tabs=portal%2Chttp)

## Useful Links

- [Open Source Security Foundation](https://openssf.org/)
- [Securing your software supply chain](https://docs.github.com/en/code-security/supply-chain-security)
- [SANS Top 25](http://cwe.mitre.org/top25/archive/2021/2021_cwe_top25.html)
