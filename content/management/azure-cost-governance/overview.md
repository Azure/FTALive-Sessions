# Cost Management Overview

#### [home](./readme.md)  | [next](./understand-forecast.md)


### Motivation
A successful cloud adoption is not only comprised of technical activities but should also align with other business operations, including financial activities and constraints. Learning about the cost optimization pillar of [Microsoft Azure Well-Architected Framework](https://learn.microsoft.com/en-us/azure/architecture/framework/cost/) can help you balance the trade-offs, eliminate blockers and take opportunities to save money and do more with less.

### Cost Optimization Principles

#### Choose the right resources
- Can your workload run with PaaS resources instead of IaaS? Explore this possibility early and re-evaluate periodically as service offerings are always improving.
- Are there consumption-based resources that would fit your workloads performance requirements? 
- Do you need to deploy to a single region or multiple regions to support your service level requirements?

#### Consider cost constraints and set up budgets
- What are the cost constraints set by the business?
- How do your design choices (i.e. performance, scale, redundancy & security) affect your costs?
- What are the budget thresholds at which point you'll need to alert? 

#### Dynamic allocation of resources
- How will you identify idle or underutilized resources?
- Can resources be shut down on a schedule?
- Where can you consolidate resources into a shared service?

#### Optimize workloads
- Start with smaller instance sizes if you have a highly variable workload.
- Scaling out is preferred over scaling up and allows for smaller increments at higher levels.
- Use savings plans, reservations, hybrid use benefits when possible.

#### Continuously monitor
- Conduct regular cost reviews.
- Detect anomalies and identify changes that might contribute to changes in cost.
- Use resource tags to enrich reporting and cost reviews.

### Sustainability