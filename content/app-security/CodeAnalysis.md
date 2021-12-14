# Code Analysis

So, your team is developing a software and likely your code depends on external libraries or open-source software (dependencies). Any vulnerability in these dependencies can translate to security risk in your solution. Even if you develop software with 100% 1st party components, an insecure software design and implementation can still happen.  By continuously run code/dependency/security analysis in your repository and CI/CD process, you can greatly reduce security risk and prevent bugs from ever appearing in your solution.

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

## Static code analysis

The following are tools that you may considered:

- [CodeQL](https://codeql.github.com/) - You can write your own custom query to detect vulnerabilities in your code.
- GitHub build-in [code scanning](https://docs.github.com/en/free-pro-team@latest/github/finding-security-vulnerabilities-and-errors-in-your-code/automatically-scanning-your-code-for-vulnerabilities-and-errors) features.
- [Dependabot](https://github.com/dependabot/dependabot-core#dependabot) - dependency review and alerts in GitHub.
- [Securing software supply chain](https://docs.github.com/en/free-pro-team@latest/github/managing-security-vulnerabilities) in GitHub.
- [DevSkim](https://github.com/Microsoft/DevSkim#devskim) - a framework of IDE extensions and language analyzers that provide inline security analysis in the dev environment as the developer writes code.
- [BinSkim](https://github.com/microsoft/binskim/blob/main/docs/UserGuide.md) - a checker that examines Portable Executable (PE) files and their associated Program Database File Formats (PDB) to identify various security problems.
- [Security Code Scan for .NET](https://security-code-scan.github.io/)
- [SonarQube](https://docs.sonarqube.org/latest/)
- [Additional tools](https://www.microsoft.com/en-us/securityengineering/sdl/resources)

## OWASP Scanning

- **What is OWASP Scanning?**
This is a way of scanning your deployed application with an engine which will test the application endpoint effectiveness by launching simulated attacks. A report is generated afterwards which can be assessed.

- **How does this fit into DevOps?**
Usually Penetration Testing (or Pen Testing) is carried out at the latter stages of development against the completed web site (and may continue at a regular cadence thereafter). However it doesn't have to be this way. Scanning/Pen testing can be undertaken during development against the deployed website, during release as an extension of integration testing steps. The advantage is that you learn about any potential new vulnerabilities quickly (shift left). These could be issues created by new code/features or issues introduced by regression.

- **What exists that can help me here?**
Quite a bit of technical effort is required to write a tool that can undertake this kind of synthetic testing/scanning and keep it up to date. For the vast majority of teams writing and maintaining their own tools is not going to be a good use of time and in most cases would not be recommended (mistakes here could lead to a false sense of security).
[OWASP themselves maintain an open source product called Zap](https://owasp.org/www-project-zap/), this tool is regularly maintained and free to use with good online usage instruction and documentation. [An extension of this tool can be obtained from the VS marketplace. The extension can be utilised to run in a Build or Release Pipeline. Full instructions provided in this link.](https://marketplace.visualstudio.com/items?itemName=CSE-DevOps.zap-scanner)

## Container Scanning

- Code scanning in a container using [CodeQL](https://docs.github.com/en/free-pro-team@latest/github/finding-security-vulnerabilities-and-errors-in-your-code/running-codeql-code-scanning-in-a-container)
- [Azure Defender for container registries](https://docs.microsoft.com/en-us/azure/security-center/defender-for-container-registries-introduction)

## Useful Links

- [Open Source Security Foundation](https://openssf.org/)
- [Securing your software supply chain](https://docs.github.com/en/code-security/supply-chain-security)
- [SANS Top 25](http://cwe.mitre.org/top25/archive/2021/2021_cwe_top25.html)
