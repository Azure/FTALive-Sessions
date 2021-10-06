# Azure Security Center

We spoke about [Azure Security Center and Azure Defender](https://docs.microsoft.com/en-gb/azure/security-center/security-center-intro).

*   Azure Security Center provides capabilities around managing your Cloud Security posture, leveraging off policies to detect potential vulnerabilities and areas of improvement. It also provides some capabilities around workload protection.
*   Azure Security Center relies on [Azure Policies](https://docs.microsoft.com/en-gb/azure/governance/policy/overview), which allows you to create rules and effects for your resources in Azure and report on compliance to those rules. We have a gallery of [sample policy definitions](https://docs.microsoft.com/en-gb/azure/governance/policy/samples/). Recommended reading:
    *   [Understanding Azure Policy Effects](https://docs.microsoft.com/en-gb/azure/governance/policy/concepts/effects)
    *   [Azure Policy definition structure](https://docs.microsoft.com/en-gb/azure/governance/policy/concepts/definition-structure)
    *   [Determine causes of non-compliance](https://docs.microsoft.com/en-gb/azure/governance/policy/how-to/determine-non-compliance)
    *   Tutorial: [Create and manage policies to enforce compliance](https://docs.microsoft.com/en-gb/azure/governance/policy/tutorials/create-and-manage)
    *   Tutorial: [Working with Security Policies](https://docs.microsoft.com/en-gb/azure/security-center/tutorial-security-policy)
    *   [Azure security policies monitored by Security Center](https://docs.microsoft.com/en-gb/azure/security-center/security-center-policy-definitions)
    * [Excepting your resources and recommendations from your secure score](https://docs.microsoft.com/en-us/azure/security-center/exempt-resource)
*   We spoke about your [Secure Score and how to improve it](https://docs.microsoft.com/en-us/azure/security-center/security-center-secure-score).
    * [Security Recommendations Reference Guide](https://docs.microsoft.com/en-us/azure/security-center/recommendations-reference)
*   We mentioned the capabilities of [Azure Defender for Servers](https://docs.microsoft.com/en-us/azure/security-center/defender-for-servers-introduction), you can read more about them here:
    *   [Just in Time Access](https://docs.microsoft.com/en-us/azure/security-center/security-center-just-in-time)
    *   [Adaptive Application Controls](https://docs.microsoft.com/en-us/azure/security-center/security-center-adaptive-application)
    *   [File Integrity Monitoring](https://docs.microsoft.com/en-us/azure/security-center/security-center-file-integrity-monitoring)
    *   [Adaptive Network Hardening](https://docs.microsoft.com/en-us/azure/security-center/security-center-adaptive-network-hardening)
*   We also looked at [Azure Defender for SQL](https://docs.microsoft.com/en-us/azure/azure-sql/database/azure-defender-for-sql)
*   We also mentioned that you can integrate ASC with [Defender for Endpoint](https://docs.microsoft.com/en-us/azure/security-center/security-center-wdatp)  for advanced threat protection detection and response capabilities.
*   For downstream integration into other tools, you can use [the continuous export capability](https://docs.microsoft.com/en-us/azure/security-center/continuous-export?tabs=azure-portal) in Security Center, and stream the events, alerts and recommendations to an Event Hub or to a Log Analytics workspace.

## Additional Learning resources:

*   [Identify security threats with Azure Security Center](https://docs.microsoft.com/en-us/learn/modules/identify-threats-with-azure-security-center/)
*   [Protect your servers and VMs from brute-force and malware attacks with Azure Security Center](https://docs.microsoft.com/en-us/learn/modules/secure-vms-with-azure-security-center/)
*   Video: [Azure Power Lunch: Azure Security Center](https://www.youtube.com/watch?v=0-DV3DFeHWc)
*   Video: [Securing the hybrid cloud | Azure Security Center Part 1](https://www.youtube.com/watch?v=3Ddli1q3CcQ)