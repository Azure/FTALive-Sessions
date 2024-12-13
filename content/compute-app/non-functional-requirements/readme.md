# Overview

During architecture reviews and discussions, FTA engineers work with many different types of customers. We can only be of assistance when we really understand what customers' requirements are, and what they're trying to achieve with a solution design or architecture. However, many customers struggle to understand the importance of their non-functional requirements, and either have absolutely no context to provide such requirements or will make up technical requirements that don't really align with business requirements.

In this FTA Live session, we want to help customers to understand some of the key non-functional requirements we pay attention to, and set them up to have the right conversations internally so they can collect their requirements from the right stakeholders.

## Intended audience

- Solution architects, and especially accidental architects (i.e. those who might not have a lot of formal experience with architecture but are responsible for designing/architecting a solution).
- Product owners/product managers and other business stakeholders. Ideally, requirements should be a negoation between business and technical stakeholders, and we want to empower business stakeholders to understand the technical impact of some of their decisions and requirements.
 
## Goals

- Support customers' understanding of the key non-functional requirements they need to focus on.
- Provide customers with sufficient knowledge so they can have informed discussions with **business stakeholders** to identify requirements.
- Help customers to have a productive review with FTA engineers in the 1:1 architecture review.

## Non-goals

- We don't plan to give a decision tree, or tell customers what their NFRs/requirements should be.
- We don't need to cover every NFR or requirement. We want to provide the key requirements, as well as a conceptual understanding of what requirements are, the types of requirements, and tradeoffs.
- We don't want to replace the 1:1 architecture reviews. Instead, this session provides background information that customers can use when they attend those reviews.
- We don't want to shortcut any part of the 1:1 architecture reviews. The most important part of an architecture review is the discussions we have, including side discussions. We don't want to stop or inhibit that.

# Session outline

## Introduction

- **What is an NFR?** Start by explaining what a non-functional requirement is - it's a requirement that doesn't directly relate to the behaviour of the system, but nevertheless is an important consideration in how the system works. Maybe we can give a     few examples of functional requirements versus non-functional requirements.
  - Example functional requirement: A customer can submit an invoice for payment
  - Example non-functional requirement: The system is available and accepts invoices for payment during 99.9% of business hours

- **Types of requirements.** Not all requirements (especially NFRs) are the same.
  - Some requirements are specified contractually or in regulation, compliance standards, or legislation; a violation of those requirements might cause financial or legal problems.
   - Other requirements are implied, but very important - for example, an ISV might not explicitly commit to a certain level of uptime, but if their solution is offline for three hours every day then their customers will lose patience and go across the street.
   - Some other requirements are hidden - for example, if you're an ISV, you might not know until it's too late that one of your customers assumes they will have their own database, and when they discover that you share the database with other      tenants it causes a major problem.
   - And some requirements are made up by the business, and don't really have any direct consequence. For example, you might aim to have your APIs respond within 500ms. If you miss the mark, nobody is going to sue you, but the business cares about this because it's part of their quality and performance goal.
   - Distinguish SLAs (service level agreements) vs. SLOs (service level objectives).
  - For each requirement, it's helpful to have a clear understanding of whether the requirement is an SLA or an SLO, who "owns" the requirement, who is responsible for monitoring compliance with the requirement, who is responsible for rectifying any violations, and what happens if it's violated. A lot of the time these aren't written down or understood systematically, but they should be.

- **Tradeoffs**. An important part of solution architecture is deciding on tradeoffs. For example, imagine you're building an enterprise solution. Your security team wants you to lock down your environment, but your development team is telling you that will cause them major problems and make everything take much longer, which means your timeframes will be at risk. What should you do?

- **WAF pillars.** Talk about the fact that the five WAF pillars are there to help to structure our thinking and conversations about the key areas of NFRs.

  The rest of this session focuses on each of the pillars in turn, and talks about the key NFRs in each, using them both as a way to explain the requirements and also as a way to think systematically about non-functional requirements overall.

## Reliability

- **Pillar Concept** - HA/BC/DR - scenarios, availability and recoverability

- **Uptime** is the amount of time that your solution is available and responsive, usually measured as a percentage of time (e.g. 99.9%).
  - In general, the higher the uptime, the more resiliency you need, and often the more expensive the solution is to run.
  - We calculate composite SLAs to tell you what Azure is guaranteeing for your solution, although there's more to it than just a single number.

- Recovery from various types of problems is another key element of resiliency.
- Imagine you've got a solution that you decide to spread across multiple regions in a primary/secondary or hot/cold architecture.
- Now, a disaster hits your primary region. How long does it take to recover?
   - In a hot-cold architecture, you might need to stand up some more infrastructure and wait for it to be deployed and configured.
   - In a warm-standby architecture, you might need to trigger a failover and then wait for DNS records to be updated.
   - This is your recovery time.
- **RTO** is the amount of time that you can tolerate being offline in the event of a failure.

- But, suppose your solution deals with a lot of data. During the failover, you might have lost some of this data.
   - In a hot-cold architecture, you might have last replicated or backed up your data the previous night.
   - In a warm-standby architecture, you might have asynchronous replication of your data across regions, and maybe it's ~15 minutes out of date.
   - This is your recovery point.
- **RPO** is the amount of data that you can tolerate losing in the event of a failure.

- Think about the business continuity in a wider context - e.g. can you switch to manual operations?

- Azure services provide several options for how you architect for different levels of uptime, RTO, and RPO. But these have tradeoffs.
   - Single-region, single-zone architectures tend to be cheapest, but have the least resiliency. You likely can't support low RTO or RPO.
   - Multi-region designs are often expensive because you need to deploy multiple separate instances. They can also introduce complexity. And data replication is usually asynchronous, which means you don't automatically get low RPO. But your risk is spread across multiple regions, so they can be resilient and performant, especially when you have customers in multiple regions.
   - Disasters come in different types and have different risk levels. For example, a data centre HVAC/power outage might impact one zone, while a severe weather event (like a flood) might impact multiple zones in one region. You need to decide on your risk tolerance for different forms of disaster.
   - Single-region, multi-zone architectures tend to be the sweet spot for most customers. There is still some cost involved in the redundancy, but you can often support low RPO and RTO requirements.
  - Also, you might choose to have different controls in different parts of your system. For example, if you ingest invoices and then process them:
    - You might decide to synchronously replicate the incoming invoice data - it's hard to replace this, and even though there's a perf hit on the synchronous replication, it's worth it.
    - But then the other data (e.g. everything derived in processing the invoice) isn't synchronously replicated, because you can re-process that if you really have to, and so you can prioritize cost and performance for this set of data.
    - So you need to understand your business and business requirements to sensibly decide on these approaches - which is why these requirements and decisions should be led by informed business stakeholders, not by the technology teams. 

- Some other things we want to touch on around tradeoffs of resiliency vs. other requirements:
  - What happens when customer tells they need 100% availability?
  - Design complexity comparison wrt SLAs (three 9's vs 4 9's for example)
  - What happens when customer tells they need 100% recoverability (RPO & RTO as zero)
  - Impact of recoverability metrics in BCDR design

## Performance

- **Pillar Concept** - performance baseline

- Need to think about overall performance as well as performance of individual components.

- For example, imagine you're building a solution that handles processing of invoices. You might care about both:
   - End-to-end transaction latency
   - The response time of individual APIs
- Make sure you're clear about whether performance requirements are hard or soft (SLAs or SLOs).
- Consider both average performance and also percentiles and ranges, so that you can consider outliers and monitor for unusual situations or problems.
- The exact performance targets will vary depending on the solution, but when you're thinking about what is reasonable, consider these questions:
   - What's the system all about? Is it a business-critical or low-priority system? Is it used a lot or infrequently?
   - What will the users generally notice? When would they start to complain?
   - Are you over-optimising a single part of a wider end-to-end system?
   - What's reasonable given your constraints? e.g. if you rely on a database or a downstream third-party system, you might not have much ability to influence performance.
   - If you're migrating or replacing an existing system, have you got a baseline measurement of performance? Is this acceptable or too slow?
 - For example:
   - Suppose you're building an internally facing web application that will be used a few times a day by a small number of employees in your company. That probably doesn't need to have low latency requirements - if it takes a few seconds to respond then that might be fine.
   - Suppose you're building a public API. Your customers might notice if their requests don't receive a response within (say) 100-200ms.
   - Suppose you're building a high-frequency trading system. Every millisecond counts.

## Security

- **Pillar Concept** - secure first, cyber security, network security, app security, identity, threat protection, zero trust, Industry compliance requirements

- What are your security requirements?
- If you have a security team, get them involved early and often. Bringing them in late can often lead to a lot of rework (and stress + cost).
- Ensure you understand whether you're subject to any compliance, regulatory, or contractual requirements.

- One big area that often trips customers up is private networking. Azure historically hasn't emphasized this, but customers used to an on-prem environment expected controls to look like what they were used to.
- But security isn't just about networking. Don't fall in to the trap of thinking either "private networking is inherently secure" or equally "public networking is inherently insecure".

- Identity, zero trust, governance, etc. all play a big part.
- Paradigm shift from network to identity as security boundary in cloud.

## Operational excellence

- **Pillar Concept** - monitoring, supportability requirements, DevOps and automation, serviceability, SLA monitoring, problem and incident management.

- Solution complexity is an underrated consideration.
  - Consider your team's size, workload, and level of skill. Will they actually be able to design, build/implement, monitor, and maintain this solution in practice? Or are you throwing them a very complex solution using a suite of technologies that they aren't used to?
  - Example: How many ops teams have recently been expected to run a production Kubernetes cluster, even though they might be predominantly experienced with running Windows workloads?
  - Or, how many dev teams have been told to run private endpoints when they have no networking experience?
  - Consider the tradeoffs between IaaS, PaaS, and serverless - often the service cost is higher for managed services, but the complexity and your staff cost is lower.

- Consider DevOps requirements. Remember DevOps = Dev + Ops. Don't restrict DevOps to just deployment. For example, consider monitoring.

- Monitoring should also be driven by your requirements. If you have performance requirements to say "end to end transaction latency should be X", how will you actually monitor this? Who will look at the dashboards, and how frequently?

## Cost

- **Pillar Concept** - solution budget, scalable architectures, training/upskilling, cost management

- You need to consider what cost you're prepared to bear.
- Understand how scalable your architecture should be - e.g. business workload peak times, expected growth.
- Is this solution a cost center or profit center? ( important for trade-offs)

- Cost includes:
   - Your Azure costs 
   - Networking - Egress scenarios. Vnet peering, zone transfer 
   - Staff costs.
   - And all of the ancillary costs - e.g. if you have a managed provider, how much are they charging?
- When you're considering wildly different architectures, consider the total cost. For example, IaaS vs. PaaS architectures have totally different cost profiles.

- Trade offs
  - Cost vs Uptime
  - Cost in relation to complexity and operations 

## Wrap-up

- Don't make assumptions about requirements. Get as explicit requirements as possible.
- We (FTA) can only help you if we understand your requirements. If you don't have them, or if you just make them up on the spot, we can't be as much use to you.
  - If you don't understand something, ask - we'll spend as much time as we need to help you understand what you need to decide.
- Remember there are tradeoffs. Don't automatically dial everything up to 11 ("most secure", "most resilient") without thinking through the consequences.
- **NFRs should come from a negotiation between the product owners/business stakeholders and the technology stakeholders.** Bring in the right people to help you determine your requirements and look at all of the tradeoffs involved.

## Tools to mention

- WAF self-assessment
- Azure Advisor
- Azure Monitor
