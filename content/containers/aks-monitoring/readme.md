# AKS Monitoring 

This section presents a common strategy that is a bottoms-up approach starting from infrastructure up through applications. Each layer has distinct monitoring requirements.

These layers are illustrated in [Monitor AKS with Azure Monitor for container insight](https://learn.microsoft.com/en-us/azure/architecture/aws-professional/eks-to-aks/monitoring)  
- Cluster level components
- Managed AKS components
- Kubernetes objects and workloads
- Applications / hosted workloads
- Resources external to AKS

### Tools

- Azure Monitor
- Alerting
- Querying Logs with Container Insights
- Azure Managed Prometheus
- Azure Managed Grafana
  
### Enable Azure Monitor for Containers
```bash
# Set subscription context
az account set --subscription <subscriptionId>

# Enable monitoring on existing cluster
az aks enable-addons -a monitoring -n <clustername> -g <resourcegroupname>

# Enable monitoring on existing cluster with existing workspace
az aks enable-addons -a monitoring -n <clustername> -g <resourcegroupname> --workspace-resource-id "/subscriptions/<subscriptionId>/resourcegroups/<resourcegroupname>/providers/microsoft.operationalinsights/workspaces/<workspacename>"

# Verify the status and the agent version
kubectl get ds omsagent --namespace kube-system

# To verify the agent version running on Windows nodepool.
kubectl get ds omsagent-win --namespace kube-system

# Check the connected workspace details for an existing cluster
az aks show -g <resourcegroupname> -n <clustername> | grep -i "logAnalyticsWorkspaceResourceID"

# To disable the addon Azure monitor for containers
az aks disable-addons -a monitoring -g <resourcegroupname> -n <clustername>

````
## Metric alerts and Data reference
Metric alerts are a way to proactively identify issues related to system resources of your Azure Kubernetes Service (AKS) clusters. There are two types of metric alerts that you can use to monitor your AKS clusters: Prometheus alert rules and metric alert rules.

Prometheus alert rules use metrics stored in Azure Monitor managed service for Prometheus, which collects metrics from your Kubernetes cluster using a Prometheus agent. You can enable two sets of Prometheus alert rules: community alerts and recommended alerts. Community alerts are handpicked alert rules from the Prometheus community, while recommended alerts are the equivalent of the custom metric alert rules.

- [Recommended metric alerts (preview) from Container insights](https://docs.microsoft.com/azure/azure-monitor/containers/container-insights-metric-alerts)

- [Monitoring AKS data reference](https://docs.microsoft.com/azure/aks/monitor-aks-reference)

## Query the Logs with Container Insights and create alert out of them
Querying logs with Container Insights is a way to analyze and troubleshoot the performance and health of your Azure Kubernetes Service (AKS) clusters and containers. Container Insights collects various types of data from your AKS clusters, such as metrics, inventory, and events, and stores them in a Log Analytics workspace in Azure Monitor. You can use Log Analytics to run queries on this data and get insights into your cluster’s behavior and performance.
- [How to query logs from Container insights](https://docs.microsoft.com/azure/azure-monitor/containers/container-insights-log-query)

- [Create log alert rules](https://docs.microsoft.com/en-us/azure/azure-monitor/containers/container-insights-log-alerts)

## Azure Managed Prometheus

Azure managed Prometheus is a service that allows you to collect and analyze Prometheus metrics at scale using a Prometheus-compatible monitoring solution. Prometheus is an open-source project that is widely used for monitoring containerized workloads. Azure managed Prometheus provides the following benefits:
- It is fully managed by Azure and integrated with Azure Monitor, which means you don’t need to install, configure, or maintain the underlying infrastructure.
- It supports both Azure Kubernetes Service (AKS) and self-managed Kubernetes clusters as data sources. You can also use Azure Arc-enabled Kubernetes to collect Prometheus metrics from any Kubernetes cluster.
- It leverages the same platform as Azure Monitor Metrics, which offers high performance, availability, scalability, global reach, compliance, and capacity.
-	It supports Prometheus alert rules and recording rules based on PromQL queries. You can also use Azure action groups to trigger actions or notifications when an alert is fired.
-	It integrates with Azure Managed Grafana, which is a fully managed and secure Grafana service that allows you to visualize and analyze your Prometheus metrics using prebuilt or custom dashboards.
- If you want to learn more about Azure managed Prometheus, you can check out the following resources:
    - [Overview of Azure Monitor Managed Service for Prometheus](https://learn.microsoft.com/en-Us/azure/azure-monitor/essentials/prometheus-metrics-overview)
    - [Introduction Blog About Azure Monitor Managed Service for Prometheus](https://techcommunity.microsoft.com/t5/azure-observability-blog/introducing-azure-monitor-managed-service-for-prometheus/ba-p/3600185)

## Azure Managed Grafana

Azure managed Grafana is a fully managed service for analytics and monitoring solutions. It’s supported by Grafana Enterprise, which provides extensible data visualizations. You can quickly and easily deploy Grafana dashboards with built-in high availability and control access with Azure security. Azure managed Grafana is optimized for the Azure environment. It works seamlessly with many Azure services and provides the following integration features:
- Built-in support for Azure Monitor and Azure Data Explorer
- User authentication and access control using Microsoft Entra identities
-	Direct import of existing charts from the Azure portal
-[Overview of Azure Managed Grafana](https://learn.microsoft.com/en-us/azure/managed-grafana/overview)
-[Monitoring with Azure Managed Prometheus and Grafana](https://learn.microsoft.com/en-us/azure/hdinsight-aks/monitor-with-prometheus-grafana)


# Now, what should be monitored in each layer?

## Monitor cluster infrastructure & Cluster level components:
- Nodes and Node pools.

Kubernetes uses node pools (nodes that are identical as they use same VM SKU), and most production environments uses node pools with auto scaling, monitoring the nodes and node pools are important.

If you use Azure monitor for containers, you can view node performance directly from [the portal](https://docs.microsoft.com/azure/azure-monitor/containers/container-insights-analyze#view-performance-directly-from-a-cluster).

[Monitor Kubernetes cluster performance with Container Insights](https://docs.microsoft.com/azure/azure-monitor/containers/container-insights-analyze)

Enable alerting with right monitor and threshold to act proactively.

| Name | Objective / Description | Metrics & Resource logs |
|:-----|:------------------------|:------------------------|
| Monitor Node conditions - [Not ready status](https://docs.microsoft.com/azure/azure-monitor/containers/container-insights-metric-alerts)| Monitor the node conditions for health status. Not Ready or Unknown| Metric and resource logs |
| Nodes under resource pressure - [Node conditions](https://kubernetes.io/docs/concepts/architecture/nodes/#condition) | Monitor the nodes under resource pressure like CPU, memory, PID and disk pressures.| Resource logs |
| Node level CPU utilization - [CPU Utilization](https://docs.microsoft.com/azure/azure-monitor/containers/container-insights-metric-alerts)| CPU utilization for individual nodes and aggregated at node pools.| Metric |
| Node level memory utilization - [Memory Utilization](https://docs.microsoft.com/azure/azure-monitor/containers/container-insights-metric-alerts)	| Monitor memory utilization for individual nodes and aggregated at node pools.| Metric |
| Active nodes and scale out %	| Monitor the scale out % of node pools	| Resource log |

## Monitor Managed AKS components:

To assist with troubleshooting AKS cluster problems and gain deeper insights enable the collection of AKS master node logs. Enable “Diagnostic” settings for the control plane to stream logs to a log aggregation solution such as Azure Storage or Log Analytics, or to a third party via EventHubs.

[List of supported platform metrics](https://docs.microsoft.com/azure/azure-monitor/essentials/metrics-supported#microsoftcontainerservicemanagedclusters), if Azure Monitor for container is used.

| Name | Objective/Description	| Metrics & Resource logs|
|:-----|:----------------------|:------------------------|
| API Server | Monitor the API server logs	| Resource logs |
| Allocatable resources availability | Monitor how much resources are available for scheduling the pods/containers. Allocatable memory and CPU|   Metric and resource logs |
| Pods pending for schedule	| Monitor the long pending schedule status. This may be due to resource unavailability.	| Resource logs |
| Auto-scaler – scaling events	| Monitor the scaling events to determine is it expected (scale out or scale in events). | Metric |
| Kubelet status - [Get kubelet logs from AKS cluster nodes](https://docs.microsoft.com/azure/aks/kubelet-logs) | Monitor the kubelet status for pod eviction and OOM kill.	| Metric |
| Cluster health |		| Metric |
| Unschedulable pods | Monitor the unschedulable pods. | Metric |

## Monitor the cluster availability (Kubernetes pods, replicasets, and daemonsets):

Kubernetes requires its system services pods to run in desired state for stable cluster operation. Monitoring the system services critical pods is a minimum requirement.

| Name | Objective/Description	| Metrics & Resource logs |
|:------|:---------------------|:-------------------------|
| System pods & Container restarts | Continuous restart on critical system services could cause instability in cluster operations. Monitor the pods/containers under kube-system namespace. Some of them are like, coredns, metric-server	| Metric and Resource logs |
| Replicasets specific to system pods ** | Most of the system services are 2 Replicas as desired state, set the right threshold to alert if one becomes unavailable or in non-stable state (any state other than running/ready). | Metric and resource logs |
| Daemonsets specific to system pods | Running below desired state may not always cause an issue. However, this could cause an intermittent behavior as some of the nodes may not be running with the required daemonsets. Monitor pods under kube-system namespace. | Metric and resource logs |

** *The rolling update strategy generally set the PDB as 1 as unavailable with 25% max surge. This could result in false positive during the rolling updates if the monitoring frequency and duration is too aggressive.*

## Monitor workloads / hosted applications:

| Name | Objective/Description	| Metrics & Resource logs |
|:------|:---------------------|:-------------------------|
|Pods & containers availability** |	Monitor the availability of application pods.|Metric and resource logs|
|Deployment scale out % - [HPA metrics with Container Insight](https://docs.microsoft.com/azure/azure-monitor/containers/container-insights-deployment-hpa-metrics)| Number of current replicas versus the maximum number of scales out limit. Help detect if deployment reaches scale limits.	|Resource logs
|Pod & Deployment status -  [HPA metrics with Container Insight](https://docs.microsoft.com/azure/azure-monitor/containers/container-insights-deployment-hpa-metrics)| Monitor the number of ready pods vs target by the deployment.|	Metric
| Pods resource requests and limits	|Monitor resource (CPU & Memory) requests and limits configuration on each deployment. Helps to determine the overcommitted nodes. |Metric
CPU and memory usage at controller level|	Monitor the applications CPU and memory usage at controller level.|	Resource log

** *The availability can be monitored based on pod/container status, restart counts. If replicasets, individual pod unavailability may not impact the service, having correct threshold will help monitor the availability and give enough time to address issue before it becomes completely down. Monitor the number of replicas vs desired state.*

# Monitor resources additional to AKS
## Monitor Azure Application gateway

- [Recommended alert rules for Application Gateway](https://docs.microsoft.com/azure/application-gateway/monitor-application-gateway#alerts)

- [List of metrics that Application Gateway supports](https://docs.microsoft.com/azure/application-gateway/monitor-application-gateway-reference)

| Name | Objective/Description	| Metrics & Resource logs |
|:------|:---------------------|:-------------------------|
|Compute unit utilization	|Compute unit is the measure of compute utilization of your Application Gateway. 	|Resource logs
|Capacity unit utilization | Capacity units represent overall gateway utilization in terms of throughput, compute, and connection count.| Resource logs
|Unhealthy host count	|Indicates number of backend servers that application gateway is unable to probe successfully	|Metric and resource logs
|Backend response time	|Monitor the backend response latency.|Metric
|http status 4xx, 5xx	|Monitor the http status code 4xx, and 5xx for bad gateways.|Resource logs

## Monitor Azure load balancer

- [Azure Standard load balancers diagnostics with metrics, alerts and resource health](https://docs.microsoft.com/azure/load-balancer/load-balancer-standard-diagnostics)

- [Common and recommended alert rules for Load Balancer](https://docs.microsoft.com/azure/load-balancer/monitor-load-balancer#alerts)

| Name | Objective/Description	| Metrics & Resource logs |
|:------|:---------------------|:-------------------------|
| Monitor SNAT port exhaustion|This alerts when used SNAT ports is greater than the allocated number of ports (or greater the threshold).| Metric
| Monitor failed outbound connections.|If SNAT Connection Count filtered to Connection State = Failed is greater than zero, then fire alert| Metric

## Monitor Azure Firewall
- [Monitor Firewall health state](https://docs.microsoft.com/en-us/azure/firewall/logs-and-metrics#metrics)

- Possible status are "Healthy", "Degraded" & "Unhealthy"

- SNAT port utilization - The percentage of SNAT port that has been utilized

## Network observability
Network observability in AKS is a preview feature that allows you to monitor and troubleshoot the network traffic in your Kubernetes cluster. It collects and converts useful metrics into Prometheus format, which can then be visualized in Grafana. You can use either Azure managed Prometheus and Grafana or your own instances of these tools. Network observability supports both Cilium and non-Cilium data planes. For more information, you can check out the following resources:
- [What is Azure Kubernetes Service (AKS) Network Observability? (Preview)](https://learn.microsoft.com/en-us/azure/aks/network-observability-overview)
-	[Setup of Network Observability with Azure managed Prometheus and Grafana](https://learn.microsoft.com/en-us/azure/aks/network-observability-managed-cli?tabs=non-cilium)
-	[Setup of Network Observability with BYO Prometheus and Grafana](https://learn.microsoft.com/en-us/azure/aks/network-observability-byo-cli?tabs=non-cilium)
-	[Public Preview: Network Observability add-on on AKS](https://azure.microsoft.com/cs-cz/updates/network-observability-add-on/)


