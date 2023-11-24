# FTA Live for AKS -  Networking Handout

> [!NOTE]
> This handout was prepared in advance and intentionally generic. Actual session content may differ based on discussion. Please also refer to your own personal notes.


## Networking Models

See also [Networking concepts for AKS](https://docs.microsoft.com/azure/aks/concepts-network#azure-virtual-networks)

### Kubenet

Nodes get an IP address from the Azure virtual network subnet. Pods receive IP from logically different space from VNet.

- [Overview of Kubenet on AKS](https://learn.microsoft.com/en-us/azure/aks/configure-kubenet)
- [IP address availability for kubenet](https://docs.microsoft.com/azure/aks/configure-kubenet#ip-address-availability-and-exhaustion)
- [Limitations and considerations for kubenet](https://docs.microsoft.com/azure/aks/configure-kubenet#limitations--considerations-for-kubenet)
- [Dual-stack kubenet networking](https://learn.microsoft.com/en-us/azure/aks/configure-kubenet-dual-stack?tabs=azure-cli%2Ckubectl)

### Azure CNI

Assigns VNet IP address to every pod, thus requiring additional planning while designing the IP address space.

- [Overivew of Azure CNI (advanced) networking](https://learn.microsoft.com/en-us/azure/aks/concepts-network#azure-cni-advanced-networking)
- [Configure Azure CNI in Azure Kubernetes Service](https://docs.microsoft.com/azure/aks/configure-azure-cni)
- [Dynamic IP allocation for enhanced subnet support](https://learn.microsoft.com/en-us/azure/aks/configure-azure-cni-dynamic-ip-allocation) 

### Azure CNI Overlay

Pods are assigned IP addresses from a private CIDR logically different from the VNet hosting the nodes allowing for larger cluster scales.

- [Overview of Azure CNI Overlay](https://learn.microsoft.com/en-us/azure/aks/azure-cni-overlay?tabs=kubectl)
	- [Comparison to Kubenet](https://learn.microsoft.com/en-us/azure/aks/azure-cni-overlay?tabs=kubectl#differences-between-kubenet-and-azure-cni-overlay)
	- [IP Address Planning](https://learn.microsoft.com/en-us/azure/aks/azure-cni-overlay?tabs=kubectl#ip-address-planning)
	- [Limitations of Azure CNI Overlay](https://learn.microsoft.com/en-us/azure/aks/azure-cni-overlay?tabs=kubectl#limitations-with-azure-cni-overlay)

## Private AKS cluster

A private AKS cluster ensures that the control plane has a private IP address and thus only accessible from within the private network.

- [Create a private Azure Kubernetes Service cluster](https://docs.microsoft.com/azure/aks/private-clusters)
- [Configure Private DNS zone](https://docs.microsoft.com/azure/aks/private-clusters#configure-private-dns-zone) to connect via private endpoint without VNet peering
- Considerations for [Hub & Spoke with custom DNS](https://docs.microsoft.com/azure/aks/private-clusters#hub-and-spoke-with-custom-dns)
- [Options for connecting to API server for private clusters](https://docs.microsoft.com/azure/aks/private-clusters#options-for-connecting-to-the-private-cluster)
- [Limitations of private clusters](https://docs.microsoft.com/azure/aks/private-clusters#limitations)

## Egress Traffic

- [Control egress traffic using Azure Firewall in Azure Kubernetes Service (AKS)](https://docs.microsoft.com/azure/aks/limit-egress-traffic), which has two outbound types:
  - [loadbalancer](https://docs.microsoft.com/azure/aks/egress-outboundtype#outbound-type-of-loadbalancer)
  - [userDefinedRouting](https://docs.microsoft.com/azure/aks/egress-outboundtype#outbound-type-of-userdefinedrouting)
- Azure Firewall integration
  - [Restrict egress traffic with Azure Firewall](https://docs.microsoft.com/azure/aks/limit-egress-traffic#restrict-egress-traffic-using-azure-firewall)
  - [Create Azure Firewall with multiple public IP address](https://docs.microsoft.com/azure/firewall/quick-create-multiple-ip-template)
- [Use SNAT for outbound connections](https://docs.microsoft.com/azure/load-balancer/load-balancer-outbound-connections)
- [Cluster egress with Managed NAT Gateway](https://docs.microsoft.com/en-us/azure/aks/nat-gateway)

---

## Ingress Traffic

### Azure Load Balancers for Services

Considerations for using `LoadBalancer` 
[Kubernetes services type](https://kubernetes.io/docs/concepts/services-networking/service/):

- [Create an Internal LoadBalancer](https://docs.microsoft.com/azure/aks/internal-lb) for a private IP.
- [Create a Standard LoadBalancer](https://docs.microsoft.com/azure/aks/load-balancer-standard) for a public IP.
- [Use a static public IP address](https://docs.microsoft.com/azure/aks/static-ip) for use with DNS.

### Kubernetes Ingress 

[Ingress controllers](https://kubernetes.io/docs/concepts/services-networking/ingress/) are reverse proxies used to expose http(s) services for external access from outside the cluster.

#### Azure managed 

- [Application routing add-on](https://learn.microsoft.com/en-us/azure/aks/app-routing?tabs=default%2Cdeploy-app-default) - a managed nginx ingress option
- [Application Gateway Ingress Controller (AGIC)](https://learn.microsoft.com/en-us/azure/application-gateway/ingress-controller-overview) - scroll all the way down for add-on and helm installation options both for brown field and green field scenarios.
- [Application Gateway for Containers](https://learn.microsoft.com/en-us/azure/application-gateway/for-containers/overview)

#### Self-managed 

Customers can install any ingress controller of their choice and manage everything themselves, including TLS. Popular open source options include:

- [NGINX ingress controller](https://learn.microsoft.com/en-us/azure/aks/ingress-basic?tabs=azure-cli) (Kubernetes community version)
- [Traefik proxy](https://doc.traefik.io/traefik/providers/kubernetes-ingress/)



## Network Policies

Control intra-cluster traffic with [Kubernetes Network Policies](https://kubernetes.io/docs/concepts/services-networking/network-policies/).

- [Azure Network Policies for AKS](https://learn.microsoft.com/en-us/azure/aks/use-network-policies)
- [Calico](https://docs.tigera.io/calico/latest/about/) - the most popular open source option 
- [Comparison - Azure vs. Calico](https://learn.microsoft.com/en-us/azure/aks/use-network-policies#differences-between-azure-network-policy-manager-and-calico-network-policy-and-their-capabilities)


