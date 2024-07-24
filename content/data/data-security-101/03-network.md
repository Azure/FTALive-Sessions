#### [Previous (Identity)](./02-identity.md) | [Home](./readme.md)  | [Next (Access Control)](./04-accesscontrol.md)

# Network security
## PaaS and SaaS Services
* Zero Trust Networking. Each service is an island and doesn't trust the network communication path.
* Shared responsibility model. Services are as secure as you configure them.
* All inter-service communication utilizes Transport Layer Security (TLS) protocol v1.2+
* When it's an option to manually enable network encryption (i.e. when clients want to connect), enforce TLS 1.2+
* Control Plane vs Data Plane within network security.

## Azure Networking
* Public vs Private
  * Private endpoints
  * Service endpoints
  * Service firewalls
* The Azure Backbone vs Internet -> what is the difference between these comms methods
* Inbound vs outbound.
  * Common example of outbound communication is your ETL tool (e.g. Azure Data Factory) connecting to data sources.
    * With an assume breach mindset, we think an attacker is already in, so we need to restrict outbound on our services to "protect against data exfiltration".
    * Example: Azure Data Factory pipeline that co.mdpies data from source system to public S3 bucket would look "normal" to anyone who doesn't specifically know that it _shouldn't_ be happening.
  * Inbound communication is client tools (i.e. Azure Data Explorer on a PC), or, data sources that 'push'.
    * Restricting inbound reduces the surface area of attack.
* Understanding the impact of "locking things down."
  * Enabling tight network controls can make operating within the environment less convienent (think Tungsten triangle).
    * Example: If you block outbound connection for a Spark cluster, how will you import common libraries?
  * Impact of Private communication can be greater complexity, and in same cases reduced capability (e.g. Azure SQL Export feature) and performance (Fabric Spark cluster spinup time) 
  * The network-level security controls that we look to implement should be based on the organisation's security, regulatory & compliance requirements. Of specific note here is that we should not just default to implementing controls such as Private Link. Instead we should:
    * Perform an overall evaluation of all requirements in the company which apply to the solution
      * Identify the risks we are trying to mitigate.
      * Identify possible controls that could mitigate the risks.
      * Consider the cost of each control (e.g. financial cost, complexity, performance, team agility etc).
      * Decide (with the relevant teams) which controls you are going to implement and which ones you are not (this is a perfect example of a situation where you should create some ADR's).
      * Only then, implement controls which you have decided upon.
      * DON'T just go "RFC1918 ipv4 private IP addresses are more secure".

## Hybrid Network (i.e. Connect to on-premises)
* Connecting to on-prem requires planning (common example is avoiding IP address overlap between Azure and On-Prem).
* Point-to-site (P2S) connectivity can appear simple to setup, but in almost all cases, it requires a landing zone and Hub + Spoke topology. Which takes time.
* If you are the first project requiring Azure <-> On-Premises connectivity, start this work NOW.

## Decision: 
* Do you want to go Public, semi-private or private connections?

#### [Previous (Identity)](./02-identity.md) | [Home](./readme.md)  | [Next (Access Control)](./04-accesscontrol.md)