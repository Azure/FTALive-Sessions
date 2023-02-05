# Five Example architectures for Azure VMWare Solutions

#### [prev](./understand-forecast.md) | [home](./readme.md)  | [next](./control.md)

### 1. Secured Virtual WAN hub with default route propagation
| Scenario | Traffic inspection requirements | Recommended solution design | Considerations |
|---|----|---|---|
| 1 |  - Internet ingress <br> - Internet egress | Use a Virtual WAN secured hub with default gateway propagation. </br></br> For HTTP/S traffic, use Azure Application Gateway. For non-HTTP/S traffic, use Azure Firewall.</br></br> Deploy a secured Virtual WAN hub and enable public IP in Azure VMware Solution. | This solution doesn't work for on-premises filtering. Global Reach bypasses Virtual WAN hubs. |
  
![eslz-net-scenario-1](https://user-images.githubusercontent.com/97964083/216805269-ccdc8006-1202-4ab1-863a-f5d9b296863d.png)


### 2. Network Virtual Appliance in Azure Virtual Network to inspect all network traffic
| Scenario | Traffic inspection requirements | Recommended solution design | Considerations |
|---|----|---|---|
| 2 |  - Internet ingress <br> - Internet egress <br> - To on-premises datacenter <br> - To Azure Virtual Network| Use third-party firewall NVA solutions in your hub virtual network with Azure Route Server. </br></br> Disable Global Reach. </br></br> For HTTP/S traffic, use Azure Application Gateway. For non-HTTP/S traffic, use a third-party firewall NVA on Azure.| Choose this option if you want to use your existing NVA and centralize all traffic inspection in your hub virtual network. |


### 3. Egress from Azure VMware Solution with or without NSX-T or NVA
| Scenario | Traffic inspection requirements | Recommended solution design | Considerations |
|---|----|---|---|
| 3 | - Internet ingress <br> - Internet egress <br> - To on-premises datacenter <br> - To Azure Virtual Network <br> Within Azure VMware Solution <br>|   Use NSX-T or a third-party NVA firewall in Azure VMware Solution. </br></br>  Use Application Gateway for HTTPs, or Azure Firewall for non-HTTPs traffic. </br></br> Deploy the secured Virtual WAN hub and enable public IP in Azure VMware Solution.| Choose this option if you need to inspect traffic from two or more Azure VMware Solution private clouds. </br></br> This option lets you use NSX-T native features. You can also combine this option with NVAs running on Azure VMware Solution between L1 and L0. |

### 4. Egress from Azure VMware Solution through 0.0.0.0/0 advertisement from on-premises
| Scenario | Traffic inspection requirements | Recommended solution design | Considerations |
|---|----|---|---|
| 4 | - Internet ingress <br> - To Azure Virtual Network| Use Virtual WAN secured hub. </br></br>  For HTTP/S traffic, use Azure Application Gateway. For non-HTTP/S traffic, use Azure Firewall.</br></br> Deploy a secured Virtual WAN hub and enable public IP in Azure VMware Solution. | Choose this option to advertise the `0.0.0.0/0` route from on-premises datacenters. |

### 5. A third-party NVA in the hub VNet inspects traffic between AVS and the internet and between AVS and Azure VNets
| Scenario | Traffic inspection requirements | Recommended solution design | Considerations |
|---|----|---|---|
| 5 | - Internet ingress <br> - Internet egress </br> - To on-premises datacenter </br> - To Azure Virtual Network   | </br>  Use third-party firewall solutions in a hub virtual network with Azure Route Server. </br></br> For HTTP/S traffic, use Azure Application Gateway. For non-HTTP/S traffic, use a third-party firewall NVA on Azure. </br></br> Use an on-premises third-party firewall NVA. </br></br> Deploy third-party firewall solutions in a hub virtual network with Azure Route Server. | Choose this option to advertise the `0.0.0.0/0` route from an NVA in your Azure hub virtual network to an Azure VMware Solution.|

Azure Advisor can be thought of as a personalized cloud consultant that helps you follow not only best practices, but also gives you the ability to optimize workloads by giving you insight into underutilized instances.
- Advisor uses machine-learning algorithms to identify low utilization and to identify the ideal recommendation to ensure optimal usage of virtual machines and virtual machine scale sets. The recommended actions are shut down or resize, specific to the resource being evaluated.
- Advisor will look at CPU, Memory and Outbound Network utilization.
  - Advisor will make resize or burstable recommendations.
    - Resize can be thought of as a permanent change to a long running workload.
    - Burstable means that your workload is variable and that workload is varied. This suggestion is made so a user can take advantage of lower cost and also the fact that the workload has low average utilization but high spikes in cases, which can be best served by Burstable machines.
- You can make decisions based on the recommendations and then adopt those, or decide against them by dismissing them.

Advisor cost documentation can be found here: [Reduce service costs using Azure Advisor - Azure Advisor | Microsoft Learn](https://learn.microsoft.com/en-us/azure/advisor/advisor-cost-recommendations)
### Right sizing your infrastructure
It’s possible that in order to migrate, you did so quickly and used existing virtual machine sizes. While this is typically a fast approach, not all machines are probably sized correctly. Leading to lots of machines that are oversized and underutilized.
- Once again, Azure Advisor can be used to help us right size an environment.
  - You can identify underutilized machines by adjusting the CPU utilization rule on each subscription.
    - When you do decide to resize to a smaller machine, it does require the machine to be shut down and restarted. So be aware of the potential impact to business.

**Important:** When using tools like Azure Advisor, understand that they can only give a snapshot of usage during their discovery period. If your organization experiences large seasonal fluctuations, you can save on provisioning your base workloads, typically your line-of-business applications, by reserving virtual machine instances and capacity with a discount.
### Using Auto Scaling for dynamic workloads
Azure autoscale is a service that allows you to automatically add and remove resources according to the load on your application.

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
