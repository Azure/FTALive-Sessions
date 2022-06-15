# Management

[prev](./dns.md) | [home](./readme.md)  | [next](./readme.md)

## Azure Network Watcher

Azure Network Watcher provides tools to monitor, diagnose, view metrics, and enable or disable logs for resources in an Azure virtual network. Network Watcher is designed to monitor and repair the network health of IaaS (Infrastructure-as-a-Service) products which includes Virtual Machines, Virtual Networks, Application Gateways, Load balancers, etc. Note: It is not intended for and will not work for PaaS monitoring or Web analytics.

[What is Azure Network Watcher?](https://docs.microsoft.com/azure/network-watcher/network-watcher-monitoring-overview)

### Packet capture

Network Watcher variable packet capture allows you to create packet capture sessions to track traffic to and from a virtual machine. Packet capture helps to diagnose network anomalies both reactively and proactively. Other uses include gathering network statistics, gaining information on network intrusions, to debug client-server communications and much more.

Portal link: [Network Watcher | Packet capture](https://ms.portal.azure.com/#blade/Microsoft_Azure_Network/NetworkWatcherMenuBlade/packetCapture)

[Introduction to variable packet capture in Azure Network Watcher](https://docs.microsoft.com/azure/network-watcher/network-watcher-packet-capture-overview)


## Azure Monitor Network Insights

Azure Monitor's Network Insights page provides a quick dashboard of network component status and health across your subscriptions. Use it to quickly locate problems in your network.

![Azure Monitor Network Insights](./png/azure-monitor-network-insights.png)

### Traffic Analytics

Traffic Analytics is a cloud-based solution that provides visibility into user and application activity in cloud networks. Traffic analytics analyzes Network Watcher network security group (NSG) flow logs to provide insights into traffic flow in your Azure cloud.

[Why traffic analytics?](https://docs.microsoft.com/azure/network-watcher/traffic-analytics)

![Traffic analytics geo-map](png/traffic-analytics.png)
