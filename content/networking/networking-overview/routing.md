# Routing

#### [prev](./connectivity.md) | [home](./readme.md)  | [next](./topology.md)

### Common routing scenarios
- Passing traffic between your Azure VNETs and your external networks
- Directing traffic through a network security or monitoring appliance

### Route types in Azure

* [**System Routes**](https://docs.microsoft.com/azure/virtual-network/virtual-networks-udr-overview#system-routes): created by the system, enable basic connectivity flows from a VNET
* [**Optional System Routes**](https://docs.microsoft.com/azure/virtual-network/virtual-networks-udr-overview#optional-default-routes): added by the system depending on your VNET configuration, such as peering, Virtual Network Gateways, or Service Endpoints
* [**Custom Routes**](https://docs.microsoft.com/azure/virtual-network/virtual-networks-udr-overview#custom-routes): Used to override system routes based on customer requirements
    * [User-defined](https://docs.microsoft.com/azure/virtual-network/virtual-networks-udr-overview#user-defined) routes specified in a Route Table
    * Routes advertized over BGP through a VNET Gateway or a Route Server. BGP will be covered in the [Connectivity section](./connectivity.md)

### Route Selection in Azure

If multiple routes contain the same address prefix, Azure selects the route type, based on the following priority:

1. User-defined route
2. BGP route
3. System route

### User defined routes and next hop types

You can create custom, or user-defined(static), routes in Azure to override Azure's default system routes, or to add additional routes to a subnet's route table. In Azure, you create a route table, then associate the route table to zero or more virtual network subnets.
Following next hop types are available when creating user-defined route:

* Virtual appliance
* Virtual Network Gateway
* None
* Virtual Network
* Internet

#### Detailed routing overview, scenarios, and route selection walkthough: [Virtual Network Traffic Routing](https://docs.microsoft.com/en-us/azure/virtual-network/virtual-networks-udr-overview)
