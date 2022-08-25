# DR Planning

#### [prev](./siterecovery.md) | [home](./readme.md)  | [next](./drtesting.md)

## Define Requirements
Each workload may have different requirements for availability and DR. Workloads can be grouped together if they have similar requirements or as dictated by business needs.

  - What are the usage patterns? How is this expressed in terms of "uptime"? 
  - Recovery Metrics - RTO & RPO are typically the outcome of a business impact analysis. 
      - Recovery Time Objective (RTO) aka "downtime" - the target duration of time and a service level within which a business process must be restored after a disaster (or disruption) in order to avoid unacceptable consequences associated with a break in business continuity. 
      - Recovery Point Objective (RPO) aka "data loss" - the maximum targeted period during which transactional data is lost from an IT service due to a major incident.

## Build the DR Plan

Review the workload resources to identify what solutions you will need employ in your DR plan. Azure Backup service can be used as an effective default solution for many Azure resources and on-premises sources.

  - Individual DR plans must include detailed procedures (steps) required to recover the workload when a disaster occurs. 
  - Include space on the plan to record completion, brief comments and timing of steps.
  - Consider use of native PaaS DR capabilities and any steps they may require during a failure mode.
  - Identify when and where references should be updated during a failure mode (i.e. updating connection strings, resource URIs, network addresses, etc).

## Build the Test Plan
  - Information Gathering 
    - Who will need to participate? 
    - What is the failure mode that will be simulated?
  - Dependencies - Are there internal or external dependencies that must be coordinated during the test?
  - Schedule - For full tests it is important to consider potential for business impact.
  - Communication - Ensure you are including any communications with appropriate heading during your tests.
  - Conditions of acceptance - DR tests should be documented with actual recovery metrics that were observed and sign-off from business stakeholders. This is often a compliance requirement for  regulatory standards.

### Additional learning resources

[MS Learn - Describe HADR Strategies | RTO and RPO](https://docs.microsoft.com/en-us/learn/modules/describe-high-availability-disaster-recovery-strategies/2-describe-recovery-time-objective-recovery-point-objective)