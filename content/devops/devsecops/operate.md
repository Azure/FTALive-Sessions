# Overview

| Plan and Develop | Commit the Code | Build and Test | Go to Production | Operate |  
|---|---|---|---|---|
|[Threat Modelling](./ThreatModelling.md)| [Static application security testing](./CodeAnalysis.md)| [Dynamic application security testing](./CodeAnalysis.md) | Security smoke tests | _**[Continuous monitoring](Operate.md)**_
|[IDE Security plugins](./CodeAnalysis.md)| Security Unit and Functional tests | [Cloud configuration validation](CloudConfigValidation.md) | [Configuration checks](CloudConfigValidation.md) | _**[Threat intelligence](Operate.md)**_
|[Pre commit hooks](https://git-scm.com/book/en/v2/Customizing-Git-Git-Hooks)| [Dependency management](./CodeAnalysis.md) | [Infrastructure scanning](CloudConfigValidation.md) | [Live Site Penetration testing](https://docs.microsoft.com/azure/security/fundamentals/pen-testing) | [Penetration testing](https://docs.microsoft.com/azure/security/fundamentals/pen-testing)
|[Secure coding standards](https://owasp.org/www-project-secure-coding-practices-quick-reference-guide/migrated_content) | [Securing the CI/CD workflow](./securingCICD.md) | Security acceptance testing | Blameless postmortems
|[Peer review](https://docs.github.com/en/pull-requests/collaborating-with-pull-requests/proposing-changes-to-your-work-with-pull-requests/about-pull-requests)||||

# Operate

Once you start operating your workloads, you need a means to continuously assess, secure and defend them.

![Defender for Cloud synopsis](media/defender-for-cloud-synopsis.png)

This is where [Microsoft Defender for Cloud](https://docs.microsoft.com/azure/defender-for-cloud/defender-for-cloud-introduction) steps in. Here as well, there is a dedicated [FTA Live session](https://github.com/Azure/FTALive-Sessions/blob/main/content/security/azure-security/AzureSecurityCenter.MD) for which you can sign up [here](https://fasttrack.azure.com/live/category/Security).

Additionaly you can make use of [Azure threat protection](https://docs.microsoft.com/azure/security/fundamentals/threat-detection), which is an additional offering on top of Azure Active Directory and Microsoft Defender for Cloud.