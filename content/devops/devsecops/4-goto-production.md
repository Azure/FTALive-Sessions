# Go to production

[< Previous](./3-build-test.md) | [Home](./readme.md) | [Next >](./5-operate.md)

![devsecops-controls](./media/devsecops-controls.png)

## Configuration check
To obtain visibility for cloud subscriptions and resource configuration across multiple subscriptions, the [Azure tenant security solution](https://github.com/azsk/AzTS-docs) from the AzSK team can be used.

Azure includes monitoring and security capabilities that are designed to detect and alert anomalous events or configurations that require investigation and potential remediation. Technologies such as [Microsoft Defender for Cloud](https://docs.microsoft.com/en-us/azure/defender-for-cloud/defender-for-cloud-introduction) and [Microsoft Sentinel](https://docs.microsoft.com/en-us/azure/sentinel/overview) are first-party tools that natively integrate into the Azure environments. These tools complement the environment and code security tools to provide a broad-reaching set of security monitoring to enable organizations to experiment and innovate at a pace in a secure way.

For Sentinel you can also take a look at the [dedicated learn collection for Azure Sentinel](https://learn.microsoft.com/en-us/users/kimberlm/collections/eegrh51oqe3np5).

## Penetration testing
Penetration testing is a recommended practice for environments to check for any vulnerabilities in the infrastructure or application configuration that might create weaknesses that attackers could exploit.

There are many products and partners that provide penetration testing services. Microsoft provides guidance for [penetration testing in Azure](https://docs.microsoft.com/en-us/azure/security/fundamentals/pen-testing).

Testing typical covers the following test types:

- Tests on your endpoints to uncover vulnerabilities.
- Fuzz testing (finding program errors by supplying malformed input data) of your endpoints.
- Port scanning of your endpoints.

## Cryptography Strategy

Encryption is the most common mechanism to protect data from unintended disclosure or alteration,whether the data is being stored or transmitted. While it is possible to retroactively build encryption into a feature, it is easier, more efficient and more cost-effective to consider encryption during the design process. 

### Key Decisions
1. What to protect - The entity to protect - data in motion, data at rest, etc.
1. The goal of protection - To encrypt it or to hash it?
1. Mechanism of encryption - The algorithm to use and key length.
1. Key and Certificate management solution to use. - Windows Credential Manager, HSM, Azure Key Vault.

### Testing SSL:

#### Server side tools

* [Comodo SSL analyzer](https://comodosslstore.com/ssltools/ssl-checker.php)
* [Globalsign SSL checker](https://globalsign.ssllabs.com/)
* [SSLLabs](https://www.ssllabs.com/ssltest/)
### Client side tools
* [How's my SSL](https://www.howsmyssl.com/)

SSLLabs assessment tools - https://github.com/ssllabs/research/wiki/Assessment-Tools

#### Further Reading
[OWASP cryptographic cheat sheet](https://cheatsheetseries.owasp.org/cheatsheets/Cryptographic_Storage_Cheat_Sheet.html)

[< Previous](./3-build-test.md) | [Home](./readme.md) | [Next >](./5-operate.md)
