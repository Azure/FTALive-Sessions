# Open Source Security
Open-source software security is the measure of assurance or guarantee in the freedom from danger and risk inherent to an open-source software system.

## Benefits
- Proprietary software forces the user to accept the level of security that the software vendor is willing to deliver and to accept the rate that patches and updates are released
- It is assumed that any compiler that is used creates code that can be trusted, but it has been demonstrated by Ken Thompson that a compiler can be subverted using a compiler backdoor to create faulty executables that are unwittingly produced by a well-intentioned developer. With access to the source code for the compiler, the developer has at least the ability to discover if there is any mal-intention.
- Kerckhoffs' principle is based on the idea that an enemy can steal a secure military system and not be able to compromise the information. His ideas were the basis for many modern security practices, and followed that security through obscurity is a bad practice.
## Drawbacks
- Simply making source code available does not guarantee review. An example of this occurring is when Marcus Ranum, an expert on security system design and implementation, released his first public firewall toolkit. At one time, there were over 2,000 sites using his toolkit, but only 10 people gave him any feedback or patches.
- Having a large amount of eyes reviewing code can "lull a user into a false sense of security". Having many users look at source code does not guarantee that security flaws will be found and fixed.

Source : [Wikipedia](https://en.wikipedia.org/wiki/Open-source_software_security)

## Facts
- Many organizations today, are developing software with some OSS components.
- OSS relies on its community to update and maintain source code and patch security vulnerability.
- Any security vulnerability detected in OSS will put its dependents at risk.

## Approaching Open Source Security

1. Evaluate open source components regularly.
1. Maintain an 'approved software' list and share it within your organization.
1. Update libraries that have disclosed vulnerabilities.

## Supply Chain Security

It is important to understand your software supply chain. In GitHub, you can use the dependency graph to identify all your project's dependencies. The dependency graph supports a range of popular package ecosystems. You can explore dependencies and review them. The review lets you catch vulnerable dependencies before you introduce them to your environment, and provides information on license, dependents, and age of dependencies. You can also use Dependabot feature in GitHub to auto-update dependencies and even alert you when vulnerable dependencies are detected.

## Useful Links

- [Open Source Security Foundation](https://openssf.org/)
- [Securing your software supply chain](https://docs.github.com/en/code-security/supply-chain-security)

