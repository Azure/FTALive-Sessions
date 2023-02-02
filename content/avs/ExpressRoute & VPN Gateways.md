# Cost Management Overview

#### [home](./readme.md)  | [next](./understand-forecast.md)


### Motivation
A successful cloud adoption is not only comprised of technical activities but should also align with other business operations, including financial activities and constraints. Learning about the cost optimization pillar of [Microsoft Azure Well-Architected Framework](https://learn.microsoft.com/en-us/azure/architecture/framework/cost/) can help you balance the trade-offs, eliminate blockers and take opportunities to save money and do more with less.

### Cost Optimization Principles

#### Choose the right resources
- Can your workload run with [PaaS resources instead of IaaS](https://learn.microsoft.com/en-us/azure/architecture/guide/technology-choices/compute-decision-tree)? Explore this possibility early and re-evaluate periodically as service offerings are always improving.
- Are there [consumption-based resources](https://learn.microsoft.com/en-us/azure/architecture/framework/cost/design-price) that would fit your workloads performance requirements? 
- Do you need to deploy to a [single region or multiple regions](https://learn.microsoft.com/en-us/azure/architecture/framework/cost/design-regions) to support your service level requirements?

#### Consider cost constraints and set up budgets
- What are the [cost constraints](https://learn.microsoft.com/en-us/azure/architecture/framework/cost/design-model#cost-constraints) set by the business?
- How do your [design choices](https://learn.microsoft.com/en-us/azure/architecture/framework/cost/tradeoffs) (i.e. performance, scale, redundancy & security) affect your costs?
- What are the budget thresholds at which point you'll need to alert? 

#### Dynamic allocation of resources
- How will you identify idle or [underutilized resources](https://learn.microsoft.com/en-us/azure/advisor/advisor-cost-recommendations)?
- Can resources be [shut down on a schedule](https://learn.microsoft.com/en-us/azure/azure-functions/start-stop-vms/overview)?
- Where can you [consolidate resources](https://learn.microsoft.com/en-us/azure/architecture/patterns/compute-resource-consolidation) into a shared service?

#### Optimize workloads
- Start with smaller instance sizes if you have a highly variable workload.
- [Scaling out](https://learn.microsoft.com/en-us/azure/architecture/guide/design-principles/scale-out) is preferred over scaling up and allows for smaller increments at higher levels.
- Use [savings plans, reservations](https://learn.microsoft.com/en-us/azure/cost-management-billing/savings-plan/decide-between-savings-plan-reservation), [hybrid use benefits](https://azure.microsoft.com/en-us/pricing/hybrid-benefit/) when possible.

#### Continuously monitor
- Conduct regular [cost reviews](https://learn.microsoft.com/en-us/azure/architecture/framework/cost/monitor-reviews).
- Detect anomalies and identify changes that might contribute to changes in cost.
- Use resource tags to enrich reporting and cost reviews.

### Sustainability


#### Microsoft Sustainability Manager - [Overview](https://learn.microsoft.com/en-us/industry/sustainability/sustainability-manager-overview)
- Records emissions data from disparate sources into a common data model.
- Uses dashboards to visualize energy consumption and emissions. 

#### Emissions Impact Dashboard - [Overview](https://learn.microsoft.com/en-us/power-bi/connect-data/service-connect-to-emissions-impact-dashboard)
- Measure your Microsoft Cloud-based emissions and estimate emissions avoided by using the cloud.
- Access Azure emissions data with the Microsoft Cloud for Sustainability API
