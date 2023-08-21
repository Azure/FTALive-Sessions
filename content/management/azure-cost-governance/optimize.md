# Optimize Workloads

#### [prev](./understand-forecast.md) | [home](./readme.md)  | [next](./control.md)

### Using Azure Advisor
Azure Advisor can be thought of as a personalized cloud consultant that helps you follow not only best practices, but also gives you the ability to optimize workloads by giving you insight into underutilized instances.
- Advisor uses machine-learning algorithms to identify low utilization and to identify the ideal recommendation to ensure optimal usage of virtual machines and virtual machine scale sets. The recommended actions are shut down or resize, specific to the resource being evaluated.
- Advisor will look at CPU, Memory and Outbound Network utilization.
  - Advisor will make resize or burstable recommendations.
    - Resize can be thought of as a permanent change to a long running workload.
    - Burstable means that your workload is variable and that workload is varied. This suggestion is made so a user can take advantage of lower cost and also the fact that the workload has low average utilization but high spikes in cases, which can be best served by Burstable machines.
- You can make decisions based on the recommendations and then adopt those, or decide against them by dismissing them.

Advisor cost documentation can be found here: [Reduce service costs using Azure Advisor - Azure Advisor | Microsoft Learn](https://learn.microsoft.com/en-us/azure/advisor/advisor-cost-recommendations)

#### Azure Advisor - Cost Optimization workbook

The [Azure Cost Optimization workbook](https://learn.microsoft.com/en-us/azure/advisor/advisor-cost-optimization-workbook) is a centralized hub for some of the most commonly used tools that can help you drive utilization and efficiency goals. It offers a range of recommendations, including Azure Advisor cost recommendations, identification of idle resources, and management of improperly deallocated Virtual Machines. Additionally, it provides insights into using Azure Hybrid benefit options for Windows, Linux, and SQL databases.

### Right sizing your infrastructure
It’s possible that in order to migrate, you did so quickly and used existing virtual machine sizes. While this is typically a fast approach, not all machines are probably sized correctly. Leading to lots of machines that are oversized and underutilized.
- Once again, Azure Advisor can be used to help us right size an environment.
  - You can identify underutilized machines by adjusting the CPU utilization rule on each subscription.
    - When you do decide to resize to a smaller machine, it does require the machine to be shut down and restarted. So be aware of the potential impact to business.

**Important:** When using tools like Azure Advisor, understand that they can only give a snapshot of usage during their discovery period. If your organization experiences large seasonal fluctuations, you can save on provisioning your base workloads, typically your line-of-business applications, by reserving virtual machine instances and capacity with a discount.
### Using Auto Scaling for dynamic workloads
[Azure autoscale](https://learn.microsoft.com/azure/azure-monitor/autoscale/autoscale-overview) is a service that allows you to automatically add and remove resources according to the load on your application.

When your application experiences higher load, autoscale adds resources to handle the increased load. When load is low, autoscale reduces the number of resources, lowering your costs. You can scale your application based on metrics like CPU usage, queue length, and available memory, or based on a schedule.

Scaling in and out is called horizontal scaling, which means adding more machines to absorb the workload.

Scaling up and down is called vertical scaling, keeps the same number of resources, but gives the resources more capacity in terms of CPU, memory, disk and network. Vertical scaling may require a restart of machines and the hardware varies by region.
### Locating Orphaned Resources
Often a workload is built, used for a short period and then forgotten about. It’s a good idea to locate these orphaned resources and remove them if they are not being used. 

Use the [Azure Orphan Resources Workbook](https://github.com/dolevshor/azure-orphan-resources) to scan for the following orphaned resource types:
- Disks
- Network Interfaces
- Public IPs
- Resource Groups
- Network Security Groups (NSGs)
- Availability Set
- Route Tables
- Load Balancers
- App Service Plans
- Front Door WAF Policy
- Traffic Manager Profiles

### Using Spot Instances
It’s possible that you might have short lived temporary workloads that need to run occasionally. In this case Spot Instances are a great way to save. They are ideal for workloads that can be interrupted, like batch processing jobs, etc.

Spot Instances save money by using surplus capacity in Azure at a much lower cost.

- Remember that Spot VMs have no SLAs after they’ve been created.
  - See [How to build workloads on spot virtual machines - Azure Architecture Center | Microsoft Learn](https://learn.microsoft.com/en-us/azure/architecture/guide/spot/spot-eviction) for additional information about eviction.
