# FTA Live: Non-Functional Requirements

This document provides some key links to help you to understand non-functional requirements (NFRs), as well as a summary of the key NFRs you typically need to consider for a solution.

## Well-Architected Framework

The [Microsoft Azure Well-Architected Framework](https://learn.microsoft.com/azure/architecture/framework/) is a set of guiding tenets that can be used to improve the quality of a workload.

It includes a discussion of the key pillars of a well-architected solution, as well as guidance for specific types of workloads, including [mission-critical workloads](https://learn.microsoft.com/azure/architecture/framework/mission-critical/mission-critical-overview).

## Hot Paths

It's important to identify **hot paths** in your solution, which represent the key data flows and components that are essential for your business. You might have different requirements for hot paths compared to other parts of your solution.

## Key Non-Functional Requirements

### Reliability

- Distinguish SLOs from SLAs. See the video [SLIs, SLOs, SLAs, oh my!](https://www.youtube.com/watch?v=tEylFyxbDLE).
- Availability
  - Uptime, which is usually measured a percentage. [Website: uptime.is](https://uptime.is) 
  - Decide how you define "up" and "down".
- Recoverability
  - Recovery time objective (RTO)
  - Recovery point objective (RPO)
  - Mean time to recovery (MTTR)
  - Mean time between failures (MTBF)
- Topology
  - What systems do you depend on?
  - What other systems depend on you?

### Performance

- Target transaction latency
  - End-to-end
  - Component-based
  - Consider how you measure and summarise
- Expected transaction throughput
- Expected user base
  - Total users
  - Concurrent users
  - Geographical locations of users
- Usage patterns (e.g. seasonal changes)
- Expected growth in users and transactions
- Performance baselines from other systems
- Downstream systems' constraints
- Consequences of bad performance

### Security

- Compliance standards and regulatory requirements
- Contractual requirements
- Data residency or sovereignty requirements
- Key security stakeholders
- Specific threats to mitigate
- Previous security issues that you need to avoid repeating

### Operations

- Team characteristics
  - Workload
  - Size
  - Skill set
  - Longevity
- Deployment frequency
- Monitoring requirements
  - How will you monitor your compliance with all of the other requirements listed in this document?

### Cost

- Understand whether the solution is a cost centre or a profit centre.
- Budget
- Total cost of ownership
  - Include staff costs, managed providers, ongoing maintenance
- Azure resource cost estimate
