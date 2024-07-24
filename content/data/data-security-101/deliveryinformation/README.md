# fta-datasecurity

# Data Security 101
Welcome to FTAs Data Security 101 introduction. Goals of this repo:
1. Delivered with in Data & Analytics project within FTA.
1. Contained to 1 hour. Additional sessions can of course be delivered if customer wants to dig deeper, ideally using the Data Security Checklist. Can also share post session info.
1. Service agnostic

Target audience: 
* Any customer building a Data and/or Analytics solution within Azure / Fabric. Specific personas we would expect to have on the call:
* Data Engineer -> **target**
* Application dev / dev dba - > **target**
* Production/platform dba - > **target**
* Security team member/security professional 
* Networking engineer
* Consumers of solution

Assumed Knowledge / Pre-requisites > Want to keep this achievable.

## Delivery guide
It is recommended to deliver this end-to-end. Avoid getting pulled into the weeds, and instead, recommend follow up sessions to discuss specific topics in detail.

Ensure you have the right audience invited.

# Introduction (10mins)
* SECURITY IS A NON-NEGIOABLE IN YOUR PROJECT
* Security is not a 1-and-done activity - it's an ongoing endeavour in your environment & life.
* Do you fall into this mindset? *Security is the responsibility of the Security team. Network security is the responsibility of the Networking team. We dont have to worry about security, the platform is secured & noone will get to our data.*
    * I (Nathan) dont understand how people think like this.
    * From [Microsoft Digital Defense Report 2023 (MDDR)](https://www.microsoft.com/en-us/security/security-insider/microsoft-digital-defense-report-2023) -> 1 hijacked domain is a security event. 100,000+ is a data/big data issue.
    * In most hacks where data is exfiltrated, the data is exfiltrated from a database (of some kind). Isn't that your responsibility as a DBA/Data Engineer to protect? Aren't you the last line of defence (the goal keeper/full back)?
        * When the game starts, sure there are other's on the field & they have jobs. But you are the last line of defence.
        * GK/FB directs > Data engineers know the data platform. They should be directing how to protect the data.
    * Bystander effect in security is real.
        * Is your phone free to unlock? Or do you use a PIN? Or a Password? Or a BIO?
        * Is your Computer free to unlock? 
        * Are you standing around, because other people are standing around?
        * Are you standing around, because you don't think it's your responsibility?
        * Did you go to the cloud thinking someone else would take care of security for you?
    * Have you taken a prod backup & restored it in dev because it was just easier?
    * Have you ever wished you could disable (or actually disabled) MFA on your admin account because your steps would just be easier?
    * Have you ever run reporting script using your admin account?
    * When was the last time you patched your server? 
        * When was the last time you ran a report to ensure your server *HAS* been patched? **You're the last line of defence -> Trust but verify**
    * ?? Does this behaviour seem normal to you? Does this behaviour seem ok to you?
        * Goal for today is for us to collectively figure out whether this is ok.
        * Blissful ignorance is not an excuse.
        * Rectification isnt hard, it's just new to you. But so was your first KQL query - but now they're just things you do.
        * The alternatives are **devastating** [security breach - data exfil, cryptolocker ransomware, human cost, etc].

? **WHAT IS THE HOOK?**
    * Our goal for this talk is for you to want to engage with your security team, to want to learn more and contribute more.
    * I understand for some of you may feel this is too simple -> but I would like you to stick around to help with the others for whom this may be new.
    * reference link for discusion: https://www.darkreading.com/cybersecurity-operations/how-do-we-truly-make-security-everyone-s-responsibility
    
? A data engineer could have saved this:
    * Examples: 
    > Crypto ransomware on db
    > Restoring prod db to dev for development

* [Secure data with Zero Trust | Microsoft Learn](https://learn.microsoft.com/en-us/security/zero-trust/deploy/data)

## Cost of compromise
* September 2022, 9.8 million customers had their names, DOB, phone numbers, passport, drivers license, medical records and government IDs exposed through large Telco hack. ~40% of Australian population.
* December 2022, 9.7 million customers had their medical records stolen and leaked onto the dark web through health insurer Hack.  ~40% of Australian population.
* At least 141 hospitals victim of ransomware attacks in 2023.
* Large password manager breach in 2022, result of stolen credentials from DevOps engineer on Home PC, because he had another service installed that had unpatched vulnerability.
* Midnight Blizzard (group with links to state sponsorhip) attack against Microsoft. Access executive email.
* Recent hack where Government Data center cryptolockered / ransomware. Luckily malicious actors offered to return the keys, as long as they were thanked.
* Credentials work $1 - $50 USD depending on many variables, including perceived value of the target. (from 2021 MS Digital Defence Report).


**Cost is reputation, money, customers and even loss of life.**
**Non-compliance could result in sanctions (GDPR example), or complete removal of licenses or ability to operate in a market - effectively ending your business (NRA/ATF example).**

>> (hook) If you are a data engineer & you havent heard about these -> you might need to go do some reading.

## Defence in Depth 
* **Zero Trust** in practical terms is a transition from implicit trust—assuming that everything inside a corporate network is safe—to the model that *assumes breach* and *explicitly verifies* the security status of identity, endpoint, network, and other resources based on all available signals and data. 
* **Assume Breach Mindset**: Assumes cyber-attacks will happen, are happening and have happened. Legacy "Wall & Moat" mindset no longer applies - "hostile actors already in the keep & can poison the water".
* **Secure By Design**: This is why we are having this session!
* **Principle of least priviliege**
* **Verify Explicitly** -> 1+1=3 : Multilayer security results in greater overall security

## Doesn't Microsoft protect me?

### Shared responsibility
* [Shared responsibility in the cloud - Microsoft Azure | Microsoft Learn](https://learn.microsoft.com/en-us/azure/security/fundamentals/shared-responsibility)
* [Microsoft Incident Response and shared responsibility for cloud computing | Microsoft Azure Blog](https://azure.microsoft.com/en-us/blog/microsoft-incident-response-and-shared-responsibility-for-cloud-computing/)

![sharedresponsibility](./sharedresponsibilitymodel.jpg)

### Cost vs Security vs Complexity (Is this the right triangle?)
* Discuss the Tungsten Triangle - Cost vs Security vs Performance (where performance is CPU/latency and/or administrative overheads/operational latency/operational costs)

![irontungstentriangle](./irontungstentriangle.jpg)

*FUD* is pointless - don't do security because of Fear, Uncertainty or Distrust. You need business buy-in & business direction & drivers, or a business requirement..

"We are not going to jump into all security fundamentals on this call, there's a separate fta live learning series on this, we can share the link later."

"Never enough time to do it right the first time, but always enough time (and budget) to do it again later [After a security breach]."

**<Need Link to share for FTA Security "Zero to Zero Trust" series>**

# Overall flow & important topics

Topics:
1. Protecting your identities (15mins)
2. Network security (15mins)
3. Controlling access to data (15mins)

* ## Protecting your identities (15mins)
* Why it's so important.
    * Bad actors don't "hack in" they "log in"
        * lots of breaches constantly occurring -> see HIBP for example
        * Personal passwords being used the same as work credentials. -> "DONT DO THIS"
        * (spear) phishing targeting large corporate (social engineering) -> sometimes not needed if you haven't done above
        * if using cloud services -> publicly accessible. This is the nature of modern computing (mostly)
        * someone in another country can just as easily use your credential as you can
        * This shows the need for MFA (99%+ reduction in success of Password Spray attacks) + Conditional Access (limit access to only where it's needed).
        * Defence in depth is like an onion - multiple layers. Each of these is a layer
    * Don't write your own identity management solution(s)
        * Entra has a dedicated team focussed on improving the solution & fixing any bugs they find. You can build on thier work instead of trying to do it yourself
    * Defenders think in Lists, Attackers think in Graphs [advanced?] -> basic version of this is: minimise your surface area for attack, give yourself (and your SOC/Defenders) the best chance of defending what you've got.
* Users accounts, Admin accounts and MFA. Give an example of something like Synapse Workspace or Fabric Workspace.
    * Ideal recommendation - we don't want any individual user or account accessing/touching production. you should use IAC + release pipelines to push code/config into production.
    * Real world recommendation - at least split user accounts vs. admin accounts. log access where possible
* Managed identities (system assigned [recommended - default] vs user assigned [advanced])
    * don't use service principals (if possible)
    * definitely don't use SQL auth
* Use Azure Key Vault [use it] -> secure store for credentials. Can be locked down & have monitoring put in place. 
    * At a minimum, use some kind of secure Key store.
    * Secret/Certificate rotation [do it, implementation is advanced topic]
* Understanding the chain of control (NFI if that is the right idea) of who has direct / indirect access. Who can elevate their privileges.

### Decisions: 

* Do I need MFA (Yes)
* Do I need Conditional Access (yes)
* Do I need to separate user vs Admin accounts (ideally, but not must)
* Do I need separate user vs Admin devices (possibly, but hard)

## Network security (15mins)
* [Best practices for secure PaaS deployments - Microsoft Azure | Microsoft Learn](https://learn.microsoft.com/en-us/azure/security/fundamentals/paas-deployments)
* Public vs Private -> continuing on from "public cloud" point from earlier, if all services are publicly accessible you need to consider how to implement multiple security controls to help multiplicatively reduce risk. There are a couple of options to restrict network:
    * Service endpoints (Ben: Does anyone care about these? 😋)
    * Service firewalls
    * Private endpoints
        * be aware that if you lock resources down, there will be both performance implications (spark spin up time increases due to needing private cluster) and some services no longer work (e.g. azure sql database export [to bacpac]).
            * databricks - need to implement multiple controls to secure the infrastructure, then also implement controls to be able to access the control plane
            * DevOps deployments - you now need to run self-hosted agents (VM's with service installed to connect to DevOps) to connect to & deploy to your resource(s)
* Azure backbone vs Internet -> what is the difference between these comms methods
    * Use TLS 1.2+ (it's not just SSL) - Transport Layer Security protocol | Microsoft Learn
    * storage -> msft routing vs internet routing
* Inbound & outbound comms.
    * Not many occurrences of outbound in most data products, but some have (e.g. SQL DB able to call REST API)
    * restricting inbound "protects your services from attack" -> with assume breach, we think an attacker is already in, so we need to restrict outbound on our services to "protect against data exfiltration".
        * discuss application security groups -> only allowing communications north/south to specific services/endpoints/ports that actually need to be communicating. Block all other traffic. -> do similar for PAAS services.
        * custom data factory pipeline that copies data from source system to public S3 bucket would look "normal" to anyone who doesn't specifically know that it _shouldn't_ be happening.
* What controls do you want to put in place. Understanding the impacting of "locking things down."
    * The network-level security controls that we look to implement should be based on the organisation's security, regulatory & compliance requirements. Of specific note here is that we should not just default to implementing controls such as Private Link. Instead we should:
        * Perform an overall evaluation of all requirements in the company which apply to the solution
        * Identify the risks we are trying to mitigate
        * Identify possible controls that could mitigate the risks
        * Consider the cost of each control (e.g. financial cost, complexity, performance, team agility etc)
        * Decide (with the relevant teams) which controls you are going to implement and which ones you are not (this is a perfect example of a situation where you should create some ADR's)
        * Only then, implement controls which you have decided upon
        * DONT just go "RFC1918 ipv4 private IP addresses are more secure"

### Decision: 
* Do you want to go Public, semi-private or private connections?

## Controlling access to data (15mins)
* (Placeholder) GDPR / CCPA / Privacy Principles
* Principal of least privilege
* Zones / layers in environment
    * DEV/Test/Prod 
        * Building a representative dev environment is hard
        * Data obfuscation is hard
        * Building representative datasets is hard
        * JUST BECAUSE THIS IS HARD DOES NOT MEAN YOU CAN JUST RESTORE PROD DATASETS/DATABASES INTO DEV
    * Data Lake Zones as a security boundary (Raw/Conformed/Curated)
        * Raw/Bronze zone should be heavily restricted due to containing sensitive data & PII
        * Separate storage accounts for Raw vs Processed dataset(s)
        * Immutable storage for Raw zone - allows for versioning data where source dataset doesnt have history or you don't own the source dataset
    * Analytics sandbox
    * ML sandbox
    * Restores of Production datasets SHOULD HAVE THE SAME SECURITY CONTROLS APPLIED AS PRODUCTION
* Storage, RBAC and ACLs
    * Different Azure IAM roles for Contributor/Owner vs Storage account Data Reader/writer
        * Data plane vs Control plane operation > Go watch governance call recording to learn more
    * Data lake POSIX permissions - no inheritance so get it right the first time
    * Use automated process(es) to enrol new datasources into your data lake. Automatically set up read/write/owner Entra groups and provision them and grant them access at creation time. > Allows for more granular RBAC
        * More granularity will cause more administrative overhead
    * ABAC is a thing, but not covered here
* Touch on Engine specific controls (e.g. SQL, Power BI) - be aware that there are controls that exist outside the data layer. You dont have to do everything yourself.
    * RLS
    * Data Masking
    * Encryption
        * Column
        * Always Encrypted
        * app-layer encryption
* Dev, Test & Prod. Simplest approach(es) to manage this in analytics.
* Backups are part of your security protection. Get them off the same platform/service 
    * 7 tao of backup
    * while bc/dr isn't strictly a security item, thinking about bc/dr will help improve your overall security posture.
    * Protecting against accidental (update without where clause, connected to wrong datasource) or malicious modification (i.e. ransomware) or deletion.
* Purview Data Access Policies [advanced - [Microsoft Purview Self-service access concepts | Microsoft Learn](https://learn.microsoft.com/en-us/purview/concept-self-service-data-access-policy)]
* Technology vs process to control access (i.e. You don't need to lean on technology for everything. Consider human level processes such as security clearance, auditing, and disciplinary access). If you make it too hard, they will workaround it and build shadow IT.. 
    * People vs Process vs Technology. Controls should be applied in each relevant pillar. Be aware that with enough time, people can work around controls.
        * ~ >= 75% of failures are going to be People and Process related
        * Maybe have auditing in place for normal actions, allowing users to do things but we can track it. But then for highly privileged actions, implement locks.
    * Everyone has a smart phone, if I can see the data on the screen, I can take a photo of the data, then rebuild it in excel and join it with other deidentified datasets, allowing me to reidentify a dataset


### Decision
* Define Personas, then align permissions and design based on those use-cases
    * At what granularity will you go (consider Tungsten Triangle)
    * Consider implications around People vs Process vs Technology
* How and where to do your development, including how do you manage "dev" datasets
* How do you want to handle data source registration & lifecycle management, including PII management/obfuscation

## Advanced topics (won't cover, but be aware they exist) (<5 minutes)
* Encryption options across the azure platform
    * Encryption at rest
    * Encryption in transit
    * BYOK
        * lots of administrative overhead goes along with BYOK including cert backup, rotation, etc
* Advanced topics (for future conversations and reference)
    * Purview
    * Information protection
    * Data loss prevention
    * Data classification
    * Data retention 
    * Data governance 
    * Responsibilities of chief data officer vs chief security officer
    * database lifecycle management
    * data lifecycle management
    * data access monitoring and auditing
    * security monitoring
    * data archiving for recent vs old data
    * server and database level auditing
    * row level security
    * tokenisation, and tracing these tokens

## End Summary (5 minutes)
* Give an overview of what we covered
* Give an overview of why it was important
* Give an image of the 3/4 core pillars of Data Security 101
* Give a list of 3-5 key take aways / go-do's
    * Email your security team to find out how you can contribute to improving the overall security posture of the org.

* Decisions summary:

Post Delivery Email To Share With Customer





## References
[Secure data with Zero Trust | Microsoft Learn](https://learn.microsoft.com/en-us/security/zero-trust/deploy/data)
[fta-deliveryhowto/articles/security/Data/data-security-checklist.md at nwiddup-updatesPostFirstDelivery · NWiddup/fta-deliveryhowto (github.com)](https://github.com/NWiddup/fta-deliveryhowto/blob/nwiddup-updatesPostFirstDelivery/articles/security/Data/data-security-checklist.md)
[fta-deliveryhowto/articles/security/Data/data-security-readiness-wip.md at nwiddup-updatesPostFirstDelivery · NWiddup/fta-deliveryhowto (github.com)](https://github.com/NWiddup/fta-deliveryhowto/blob/nwiddup-updatesPostFirstDelivery/articles/security/Data/data-security-readiness-wip.md)
[fta-deliveryhowto/articles/security/Data/data-security-work-in-progress.md at nwiddup-updatesPostFirstDelivery · NWiddup/fta-deliveryhowto (github.com)](https://github.com/NWiddup/fta-deliveryhowto/blob/nwiddup-updatesPostFirstDelivery/articles/security/Data/data-security-work-in-progress.md)

