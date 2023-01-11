# Hub and Spoke with Azure VWAN

**[prev](./basics.md) | [home](./readme.md)  | [next](./readme.md)**

## Virtual WAN Overview

![Azure Virtual WAN overview diagram](https://docs.microsoft.com/azure/virtual-wan/media/virtual-wan-about/virtualwan1.png)

You can use an Azure Virtual WAN and regional Virtual Hubs instead of a Virtual Network for managing your hub layer.

Once you deploy a Virtual WAN, you will then deploy multiple Virtual Hubs.  These can have the same sizing as your Virtual Network Hub, and so shouldn't impact your IPAM plan.  One exception is if you need to shift other resources outside of the hub, so keep that in mind.

You will then create connections from the hub to the spoke networks from within the Virtual WAN itself.

Deployment of Gateways and Firewalls will occur from within the Virtual WAN/Virtual Hub interface, and you can also manage items as well.

Also, you should make sure your [routing scenario is one of the supported patterns](https://docs.microsoft.com/azure/virtual-wan/scenario-any-to-any).

## Use Case for Azure VWAN

Azure Virtual WAN is a service that allows for improved throughput and management of virtual networks, but are managed very differently.  The advantages are:

* Azure Virtual WAN provides more tunnels to on-prem networks (called branches).
* Provides greater network throughput through the hub from these tunnels (but does not increase the throughput of each tunnel).
* Provides a way to define routes and configure auto-learning of routes, and "push" them to spoke virtual networks.

It can be a powerful tool, but it comes with some limitations

* Because the Virtual WAN hubs are software defined, you cannot put your own resources in them; only Azure Firewalls, Virtual Network Gateways, ExpressRoute Gateways, and specific third party NVAs can be deployed in.
* Route Tables have interactions with the Azure VWAN published routes, which can add complexity if an environment has unique routing concerns.
* While VWAN allows for Any-to-Any between branches and spokes, this is disabled if you use the Secure Hub format and deploy an Azure Firewall in the hub.

With this in mind, you should consider carefully if you wish to use Azure Virtual WAN, and what it means for your environment.

## Routing with Virtual Hubs

Routing with spoke networks connected to VWAN Hubs works differently than normal routing.  A virtual hub has route tables associated with it by default:

* **Default** - Which is the standard route and assumed to be the one in use
* **None** - Which is intended to be empty, and used for when a virtual network should not have additional routes assigned to it.

You can add your own to match different patterns.  Route tables in the Virtual Hub are assigned labels, so they can be managed in groups.

In addition to static routes inputted in to the route tables, when you go to connect spokes to the virtual hub, you will select what route tables to associate and which to propagate to.

The route table that you select for **Associated Route Table** will be used by the network; it becomes the default route definitions for all subnets in the virtual network.  UDRs can still be used to overwrite these routes.

The route table(s) that you select for **Propagate to Route Tables** will be the route tables that learn the routes associated with this Virtual Network.  **Propagate to labels** applies to all route tables with that labels.

You can also specify static routes in this connection.

Imagine if you had two network segments, Red and Blue.  You could use route tables to control traffic from Red and Blue networks in different ways.

![Red and Blue VNets with Virtual Hub](https://docs.microsoft.com/azure/virtual-wan/media/routing-scenarios/custom-branch-vnet/custom-branch.png)
