# Resource Management

## How resource management works in Kubernetes

- When a pod needs to be scheduled, Kubernetes scheduler doesn't look at the actual resource usage at that moment on each node. Rather, it uses the `node allocatable` and the sum of the `resource requests` of all pods running on the node to make the decision.

  |![The Scheduler only cares about resource requests](../assets/scheduler-requests.jpg) |
  |:--:|
  |*The Scheduler only cares about resource requests* [^1] |

- With the `resource limits` defined, if a container attempts to use more resources than its limits:
  - If it attempts to use more CPU which is compressible, its CPU time will be throttled;
  - If it attempts to use more memory which is incompressible, it will be terminated.
- Since the scheduler only uses the `resource requests` when scheduling pods, a node could be overcommitted, the sum of the `resource limits` of all pods on the node could be more than the `node allocatable` of the node.

  |![Node is overcommitted](../assets/overcommitting.jpg) |
  |:--:|
  |*Node is overcommitted* [^1] |

[^1]: Marko Luksa. 2018. *[Kubernetes In Action](https://www.amazon.com/Kubernetes-Action-Marko-Luksa/dp/1617293725/)*. Manning Publications Co.

- When a node is under resource pressure, it could evict the pods running on it to reclaim resources. When it has to do it, it uses the following order to identify which pod should be evicted first:
  1. Whether the pod's resource usage exceeds its `resource requests`
  2. Pod priority
  3. The pod's resource usage relative to its `resource requests`

Read further:

- [Managing Resources for Containers](https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/)
- [Node-pressure Eviction](https://kubernetes.io/docs/concepts/scheduling-eviction/node-pressure-eviction/)
- [Resource reservations of AKS](https://docs.microsoft.com/azure/aks/concepts-clusters-workloads#resource-reservations)

## Recommendations for resource management

- Define **resource requests and limits** on all containers in your pods. For critical pods in production, set the resource requests and limits to equal numbers so that the [QoS class](https://kubernetes.io/docs/tasks/configure-pod-container/quality-service-pod/) of the pods will be set to **Guaranteed**.
- Use **resource quotas** on namespaces to reduce the side effects of different applications running on the same cluster. Use **LimitRange** to apply the default requests and limits to pods on which the resource requests and limits are not defined.
- Enable [Azure Policy](https://docs.microsoft.com/azure/aks/policy-reference) to enforce the CPU and memory limit on pods.
- Enable [Container Insights](https://docs.microsoft.com/azure/azure-monitor/containers/container-insights-overview) to monitor the resource usage of pods and nodes. Adjust the resource requests and limits accordingly.
- Monitor the OOMKilled errors by enabling the recommended metric alerts of Container Insights such as `OOM Killed Containers`, `Pods ready %` etc.
- Use system node pool and user node pool to separate the system pods and application pods.
- On Kubernetes nodes, don't install any software outside of the Kubernetes. If you have to install some software on nodes, use the native Kubernetes way to do it, such as using DaemonSet.

  > [!NOTE]
  > According to the [AKS support policy](https://docs.microsoft.com/azure/aks/support-policies#shared-responsibility), any modification done directly to the agent nodes using any of the IaaS APIs renders the cluster unsupportable.

Read further:

- [AKS Operator Best Practices](https://docs.microsoft.com/azure/aks/operator-best-practices-scheduler)
- [Recommended metric alerts from Container insights](https://docs.microsoft.com/azure/azure-monitor/containers/container-insights-metric-alerts)

## Other Tools

- Use autoscaling with Horizontal Pod Autoscaler (HPA) and Cluster Autoscaler to autoscale the pods and nodes.

  > [!NOTE]
  > For AKS clusters, only use the Cluster Autoscaler to auto scale the nodes. Don't manually enable or configure the autoscale for the underlying VMSS.

- For workloads that cannot scale out, consider using [Vertical Pod Autoscaler](https://github.com/kubernetes/autoscaler/tree/master/vertical-pod-autoscaler) (VPA). With the `Off` update mode, VPA can also be used to understand the resource limits of pods.

  > [!NOTE]
  > Be cautious when you use VPA in production. Due to how Kubernetes works, when you create VPA in `Auto` or `Recreate` update mode, it evicts the pod if it needs to change its resource requests, which may cause downtime. Make sure you understand its [limitations](https://github.com/kubernetes/autoscaler/tree/master/vertical-pod-autoscaler#known-limitations) before using it.

- [Kubecost](https://www.kubecost.com/) can be used to get the insights of the cost and resource usage pattern.
