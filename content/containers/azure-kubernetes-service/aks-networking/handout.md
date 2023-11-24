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


Additional resources about controlling traffic

* [Create an AKS cluster with network policies](https://docs.microsoft.com/azure/aks/use-network-policies#network-policy-options-in-aks)
* Route Tables:
  - Bring your [own subnet with route table](https://docs.microsoft.com/azure/aks/configure-kubenet#bring-your-own-subnet-and-route-table-with-kubenet)
  - Create custom [route table](https://docs.microsoft.com/azure/virtual-network/manage-route-table)



---

## Ingress Traffic

### Azure Load Balancers for Services

Considerations for using `LoadBalancer` 
[Kubernetes services type](https://kubernetes.io/docs/concepts/services-networking/service/):

- [Create an Internal LoadBalancer](https://docs.microsoft.com/azure/aks/internal-lb) for a private IP.
- [Create a Standard LoadBalancer](https://docs.microsoft.com/azure/aks/load-balancer-standard) for a public IP.
- [Use a static public IP address](https://docs.microsoft.com/azure/aks/static-ip) for use with DNS.

### Kubernetes Ingress 

[Ingress](https://kubernetes.io/docs/concepts/services-networking/ingress/) is to expose HTTP and HTTPS routes from outside of the cluster to the services within the cluster.


- [Ingress resources](https://docs.microsoft.com/azure/aks/operator-best-practices-network#ingress-resource)
- [Ingress Controllers](https://kubernetes.io/docs/concepts/services-networking/ingress-controllers/)
  - [How to create an ingress controller in Azure Kubernetes Service](https://docs.microsoft.com/azure/aks/ingress-basic?tabs=azure-cli)
  - [How to enable HTTP application routing](https://docs.microsoft.com/azure/aks/http-application-routing)
  - [How to create an ingress controller to an internal virtual network in AKS](https://docs.microsoft.com/azure/aks/ingress-internal-ip?tabs=azure-cli)
  - [How client source IP preservation works for loadbalancer services in AKS](https://techcommunity.microsoft.com/t5/fasttrack-for-azure/how-client-source-ip-preservation-works-for-loadbalancer/ba-p/3033722)
  - [How to restrict application access to AKS cluster within VNET](https://techcommunity.microsoft.com/t5/fasttrack-for-azure/restrict-application-access-in-aks-cluster/ba-p/3017826#)

Best practice is to use ingress resources and controllers to distribute HTTP or HTTPS traffic to your application as it is a layer 7 loadbalancer.



### Application Routing add-on

The application routing add-on with nginx delivers the following:


[Application Routing add-on](https://learn.microsoft.com/en-us/azure/aks/app-routing?tabs=default%2Cdeploy-app-default#application-routing-add-on-with-nginx-features)

[Application Routing add-on advanced configs](https://learn.microsoft.com/en-us/azure/aks/app-routing-configuration)

[Migrate from HTTP Application routing to the application routing add-on](https://learn.microsoft.com/en-us/azure/aks/app-routing-migration)

### NGINX Ingress controllers

- [How to create an ingress controller in Azure Kubernetes Service](https://docs.microsoft.com/azure/aks/ingress-basic?tabs=azure-cli)
- [How to create an ingress controller to an internal virtual network in AKS](https://docs.microsoft.com/azure/aks/ingress-internal-ip?tabs=azure-cli)
      - [How client source IP preservation works for loadbalancer services in AKS](https://techcommunity.microsoft.com/t5/fasttrack-for-azure/how-client-source-ip-preservation-works-for-loadbalancer/ba-p/3033722)
      - [How to restrict application access to AKS cluster within VNET](https://techcommunity.microsoft.com/t5/fasttrack-for-azure/restrict-application-access-in-aks-cluster/ba-p/3017826#)
- [How to create an HTTPS ingress controller and use your own TLS certificates on AKS](https://docs.microsoft.com/azure/aks/ingress-own-tls?tabs=azure-cli)
- [How to create an ingress controller that uses Let's Encrypt to automatically generate TLS certificates with a static public IP address in AKS](https://docs.microsoft.com/azure/aks/ingress-static-ip?tabs=azure-cli)
- [How to create an ingress controller that uses Let's Encrypt to automatically generate TLS certificates with a dynamic public IP address in AKS](https://docs.microsoft.com/azure/aks/ingress-tls?tabs=azure-cli)

### Application Gateway Ingress Controller(AGIC)

[Application Gateway Ingress Controller (AGIC)](https://docs.microsoft.com/azure/application-gateway/ingress-controller-overview) allows Azure Application Gateway to be used as the ingress for an Azure Kubernetes Service. It runs in its own pod on the customer’s AKS.


- [Benefits of Application Gateway Ingress Controller](https://docs.microsoft.com/azure/azure-monitor/containers/container-insights-log-query)

- [Application Gateway Ingress Controller Github Repo](https://github.com/Azure/application-gateway-kubernetes-ingress?WT.mc_id=docs-azuredevtips-azureappsdev)

- [Use private IP for internal routing for an Ingress endpoint](https://docs.microsoft.com/azure/application-gateway/ingress-controller-private-ip)

- [Enable multiple Namespace support in an AKS cluster with Application Gateway Ingress Controller](https://docs.microsoft.com/azure/application-gateway/ingress-controller-multiple-namespace-support)
- [What Does It Mean for the Application Gateway Ingress Controller (AGIC) to Assume “Full Ownership”?](https://techcommunity.microsoft.com/t5/fasttrack-for-azure/what-does-it-mean-for-the-application-gateway-ingress-controller/ba-p/2839051)

It can be deployed in two ways:

Helm

- [How to Install an Application Gateway Ingress Controller (AGIC) Using a New Application Gateway](https://docs.microsoft.com/azure/application-gateway/ingress-controller-install-new)
- [Install an Application Gateway Ingress Controller (AGIC) using an existing Application Gateway](https://docs.microsoft.com/azure/application-gateway/ingress-controller-install-existing)

Add-On

- [Enable the Ingress Controller add-on for a new AKS cluster with a new Application Gateway instance](https://docs.microsoft.com/azure/application-gateway/tutorial-ingress-controller-add-on-new)
- [Enable Application Gateway Ingress Controller add-on for an existing AKS cluster with an existing Application Gateway](https://docs.microsoft.com/azure/application-gateway/tutorial-ingress-controller-add-on-existing)

**Reference:**

[What is Application Gateway Ingress Controller?](https://docs.microsoft.com/azure/application-gateway/ingress-controller-overview)

[Enable Application Gateway Ingress Controller add-on for an existing AKS cluster with an existing Application Gateway](https://docs.microsoft.com/azure/application-gateway/tutorial-ingress-controller-add-on-existing)





### Application Gateway for Containers (PREVIEW)

[Application Gateway for Containers](https://learn.microsoft.com/en-us/azure/application-gateway/for-containers/overview) is the evolution of the Application Gateway Ingress Controller (AGIC). It offers an elastic and scalable ingress to AKS clusters and comprises a new data plane as well as control plane with new set of ARM APIs. The service is managed by an ALB controller component that runs inside the AKS cluster and adheres to Kubernetes Gateway APIs.

Features and Benefits:

  - Traffic splitting / Weighted round robin
  - Mutual authentication to the backend target
  - Kubernetes support for Ingress and Gateway API
  - Flexible deployment strategies
  - Increased performance, offering near real-time updates to add or move pods, routes, and probes


---



## Network Policies

[Kubernetes Network Policies](https://kubernetes.io/docs/concepts/services-networking/network-policies/) are used to secure traffic only between the pods.

There are two ways to implement Network Policies in AKS:

- Azure Network Policies
  - [Azure Container Networking Github Repo](https://github.com/Azure/azure-container-networking/blob/master/README.md)
- Calico Network Policies, an open source network.
  - [Calico Network Policies with AKS](https://cloudblogs.microsoft.com/opensource/2019/10/17/tutorial-calico-network-policies-with-azure-kubernetes-service/)
  - [Calico Open Source Github Repo](https://github.com/projectcalico/calico)  
- [Difference between Azure and Calico network policies](https://docs.microsoft.com/azure/aks/use-network-policies#differences-between-azure-and-calico-policies-and-their-capabilities)
- [How to secure traffic between pods using network policies](https://docs.microsoft.com/azure/aks/use-network-policies)
- [Deploy AKS clusters with network policy using Infrastructure as a code(IAC)](https://azure.github.io/PSRule.Rules.Azure/en/rules/Azure.AKS.NetworkPolicy/)
  
The best practice is to use network policies to allow or deny traffic to pods. By default, all traffic is allowed between pods within a cluster. For improved security, define rules that limit pod communication.

## External Components Access

### Private Endpoints

A private endpoint is a network interface that uses a private IP address from your virtual network. This network interface connects you privately and securely to a service powered by Azure Private Link. By enabling a private endpoint, you're bringing the service into your virtual network.

AKS can privately access any external component private endpoints such as:

- Azure Container Registry
- Azure Key-Vault
- Databases
- Storage Accounts

### ACR

When you're using Azure Container Registry (ACR) with Azure Kubernetes Service (AKS), an authentication mechanism needs to be established. This operation is implemented as part of the CLI, PowerShell, and Portal experience by granting the required permissions to your ACR.

You can set up AKS and ACR integration during the initial creation of your AKS cluster or attaching in an existing cluster. To allow an AKS cluster to interact with ACR, an Azure Active Directory managed identity is used. The following command allows you to authorize an existing ACR in your subscription and configures the appropriate ACRPull role for the managed identity.

New AKS Cluster:

```azurecli
MYACR=myContainerRegistry
az acr create -n $MYACR -g myContainerRegistryResourceGroup --sku premium
az aks create -n myAKSCluster -g myResourceGroup --generate-ssh-keys --attach-acr $MYACR
```

Existing AKS Cluster:

```azurecli
MYACR=myContainerRegistry
az acr create -n $MYACR -g myContainerRegistryResourceGroup --sku premium
az aks update -n myAKSCluster -g myResourceGroup --attach-acr $MYACR
```

**Reference:**

[Authenticate with Azure Container Registry from Azure Kubernetes Service](https://docs.microsoft.com/azure/aks/cluster-container-registry-integration?tabs=azure-cli)

[Connect privately to an Azure container registry using Azure Private Link](https://docs.microsoft.com/azure/container-registry/container-registry-private-link)

### Key Vault

The Azure Key Vault Provider for Secrets Store CSI Driver allows for the integration of an Azure key vault as secrets store with an Azure Kubernetes Service (AKS) cluster via a CSI volume.

AKS will privately communicate with Azure Key-vault to access certs, keys, and secrets.

Accessing Azure Key-vault:

- Azure Active Directory pod identity
- A user-assigned or system-assigned managed identity

**Reference:**

[Use the Azure Key Vault Provider for Secrets Store CSI Driver in an AKS cluster](https://docs.microsoft.com/azure/aks/csi-secrets-store-driver)

[Provide an identity to access the Azure Key Vault Provider for Secrets Store CSI Driver](https://docs.microsoft.com/azure/aks/csi-secrets-store-identity-access)

## Appendix

### Service Mesh

A service mesh provides capabilities like traffic management, resiliency, policy, security, strong identity, and observability to your workloads. Your application is decoupled from these operational capabilities and the service mesh moves them out of the application layer, and down to the infrastructure layer.

Modern applications are typically architected as distributed collections of microservices, with each collection of microservices performing some discrete business function. A service mesh is a dedicated infrastructure layer that you can add to your applications. It allows you to transparently add capabilities like observability, traffic management, and security, without adding them to your own code. The term “service mesh” describes both the type of software you use to implement this pattern, and the security or network domain that is created when you use that software.

Most common use cases:

- Encrypt all traffic in cluster
- Canary and phased rollouts
- Traffic management and manipulation
- Observability

### Istio

Istio is an open source service mesh that layers transparently onto existing distributed applications. Istio’s powerful features provide a uniform and more efficient way to secure, connect, and monitor services. Istio is the path to load balancing, service-to-service authentication, and monitoring – with few or no service code changes.

- Secure service-to-service communication in a cluster with TLS encryption, strong identity-based authentication and authorization.
- Automatic load balancing for HTTP, gRPC, WebSocket, and TCP traffic.
- Fine-grained control of traffic behavior with rich routing rules, retries, failovers, and fault injection.
- A pluggable policy layer and configuration API supporting access controls, rate limits and quotas.
- Automatic metrics, logs, and traces for all traffic within a cluster, including cluster ingress and egress.

**Kiali Dashboard:** Walk through on Kiali dashboard

[**Getting Started with Istio**](https://istio.io/latest/docs/setup/getting-started/)

### Linkerd

Linkerd is a service mesh. It adds observability, reliability, and security to Kubernetes applications without code changes. For example, Linkerd can monitor and report per-service success rates and latencies, can automatically retry failed requests, and can encrypt and validate connections between services, all without requiring any modification of the application itself.

Linkerd is significantly lighter and simpler than Istio. Linkerd is built for security from the ground up, ranging from features like on-by-default mTLS, a data plane that is built in a Rust, memory-safe language, and regular security audits. Finally, Linkerd has publicly committed to open governance and is hosted by the CNCF.

**Linkerd Dashboard:** Walk through on Linkerd dashboard

[**Getting Started with Linkerd**](https://linkerd.io/2.11/getting-started/)

### Open Service Mesh (OSM)

Open Service Mesh (OSM) is a lightweight, extensible, cloud native service mesh that allows users to uniformly manage, secure, and get out-of-the-box observability features for highly dynamic microservice environments.

OSM runs an Envoy-based control plane on Kubernetes and can be configured with SMI APIs. OSM works by injecting an Envoy proxy as a sidecar container with each instance of your application. The Envoy proxy contains and executes rules around access control policies, implements routing configuration, and captures metrics. The control plane continually configures the Envoy proxies to ensure policies and routing rules are up to date and ensures proxies are healthy.

The OSM project was originated by Microsoft and has since been donated and is governed by the Cloud Native Computing Foundation (CNCF).

OSM can be integrated with [Azure Monitor and Azure Application insights](https://docs.microsoft.com/azure/aks/open-service-mesh-azure-monitor):

OSM can also be integrated with [Prometheus and Grafana](https://release-v0-11.docs.openservicemesh.io/docs/demos/prometheus_grafana/):

[**Getting Started with Open Service Mesh**](https://learn.microsoft.com/en-us/azure/aks/open-service-mesh-about)
