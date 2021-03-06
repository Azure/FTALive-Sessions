# ARM/bicep templates for FTA Live - Azure Networking

The following templates can be used to illustrate basic concepts of Azure Networking

## Basic Hub and Spoke

This template will deploy two peered VNets (hub and spoke), with one VM in each, and the VM in the hub acting as NVA:

[![Deploy to Azure](https://aka.ms/deploytoazurebutton)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2FAzure%2FFTALive-Sessions%main%2Fcontent%2Fnetworking%2Fnetworking-overview%2Farm%2Fhubandspoke_simple.json)

This environment can be easily explored starting from Network Watcher Topology:

![Hub and Spoke basic topology](basic_hns_topology.png)
