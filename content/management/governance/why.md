# Why should we talk about governance?

#### [prev](./readme.md) | [home](./readme.md)  | <!--[next](./concepts.md)-->

## Good governance is key for cloud adoption

Many organizations adopt Azure in order to improve resilience and workload agility by decoupling from a heritage data center model.

However, it is very difficult to gain those returns without proper governance of the Azure environment.  Lost or mismanaged resources, spiking costs, and unclear access can create very challenging situations.

By implementing management groups and subscription guidance, having proper tagging and naming structures, and organizing billing considerations appropriately, you can head off these challenges and greatly ease your Azure management.

## The role of cloud governance

Cloud governance, and its supporting funtions such as a cloud center of excellence functions, cloud strategy functions, and cloud governance functions should be architected to allow for the enablement of teams by giving them a safe and resilient platform and operating model.  This is often illustrated by a "traffic circle" analogy, which can be helpful in thinking about the goals and roles of cloud governance teams.

![Image of stop lights vs. tarffic circles](https://docs.microsoft.com/en-us/azure/cloud-adoption-framework/_images/ready/ccoe-paradigm-shift.png)

## Common traps and wrong assumptions

Management groups and subscriptions need to match our organizational structure
- Management groups and subscriptions are used for permissions and policies.
- Tagging provides better structures for most organizational structure needs (cost/charge back).

Any team should be able to create a subscription and use it using their own corporate expense structures
- Subscription creation should follow organizational practices to ensure that proper segmentation and management is possible.
- Business driven subscription creation creates Shadow IT practices that can erode security and resiliency.

We can turn loose developers/workload leaders with their subscription with no worries
- This often leads to rapid cost increase if financial practices aren't followed.
- This can lead to untracked and unmanaged resources being deployed and then not cleaned up.
- This can lead to secuirty issues if security policies and baselines are not implemented correctly.

A central cloud team needs to be involved in deploying all resources to ensure proper behavior.
- Using policies can provide automation for enforcing behavior, allowing much more self-service.
- Requiring a central team to deploy all resources can create delays and reduce agility.