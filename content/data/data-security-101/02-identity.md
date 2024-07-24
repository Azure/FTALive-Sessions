# Identity & Devices

#### [Previous (Introduction)](./01-introduction.md) | [Home](./readme.md)  | [Next (Network)](./03-network.md)

## Your Identity
* "Microsoft Entra ID is a **cloud-based** identity & access management service"
  * Anyone anywhere can attempt to use your credential** 
* Bad actors don't "hack in" they "log in".
  * Cloud/PaaS is public by default so Identity *almost* completely supersedes network based controls.
* Phishing and Spear Phishing attacks are a common attack.
* Question: Does anyone on this call have access to the 'crown jewels' of your organisation? What would happen if your identity was stolen?
* Personal passwords being used the same as work credentials. -> **DO NOT DO THIS**
* [Spear] phishing targeting large corporates (social engineering)
  * This shows the need for MFA (99%+ reduction in success of Password Spray attacks) + Conditional Access (limit access to only where it's needed).
* Users accounts vs admin accounts and MFA. Give an example of something like Synapse Workspace or Fabric Workspace.
  * Aspirational - We don't have access to production directly, so if your account get's compromised, blast radius is small. All production work done through low priveledge accounts and use of IAC + release pipelines to push code/config into production.
  * Real world - Consider separate User accounts and Admin accounts. Additionally, enabling auditing.
* Recommendation: Enable Multi-Factor Authentication (MFA) on accounts with privileged access.

## Your Device
* Question: Would you login to your internet banking account from a public library or internet cafe? Why not?
* How can I trust a device?
  * Domain / Entra joined
  * Microsoft in-tune
  * Conditional Access
* The combination of identity + device 
* What is a Privledged Access Workstation (PAW) and Secure Admin Workstation (SAW)?
  * A device used only for admininstratative purposes.
  * No email or custom client tools.
  * Client side network restrictions, allowing connectivity to specific sites and IPs
  * Server side network restrictions, device is 'allowed listed' to make a connection.
* Why a PAW or SAW?

## Identities connecting to data sources
* Managed identities (system assigned [recommended - default] vs user assigned [advanced])
    * Don't use service principals (if possible)
    * Don't use Basic Authentication (i.e. Username + Password (e.g. SQL Authentication))
* Azure Key Vault
  * Azure cloud service for securely storing and accessing secrets
  * Recommendation: Use it
  * Recommendation: Use it at the beginning of your project (usually costs more time + money to remediate later)
  * Can be locked down & have monitoring put in place.
* Secret/Certificate rotation [do it, implementation is advanced topic]

## Decisions: 
* Do I need MFA? (Answer: Yes!)
* Do I need Conditional Access?
* Do I need to separate User vs Admin accounts?
* Do I need separate User vs Admin devices?
* Do I need to rotate any secrets or keys? If so, how will I do it?
* Do I need a PAW or SAW?

#### [Previous (Introduction)](./01-introduction.md) | [Home](./readme.md)  | [Next (Network)](./03-network.md)