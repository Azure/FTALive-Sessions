# Azure Kubernetes Services Networking

## Overview

In this session you will learn about Azure Kubernetes Services networking and the core concepts that provide networking to the application in AKS. Additionally, you will also learn about service mesh and its capabilities.

### Agenda

- Overview of AKS networking models, IP address planning and its limitations.
- AKS Private cluster and Egress control.
- Overview of services in Kubernetes and Ingress controllers.
- Overview about different network policies and control traffic between pods.
- Overview about Service Mesh and different open source products.

## Networking Models

AKS support multiple [network models](https://docs.microsoft.com/azure/aks/concepts-network#azure-virtual-networks)

- Kubenet (basic) networking
- Azure CNI (advanced) networking
- Azure CNI Overlay

### Kubenet

[Kubenet](https://kubernetes.io/docs/concepts/extend-kubernetes/compute-storage-net/network-plugins/#kubenet) networking is the default configuration option for AKS cluster creation.

[Kubenet networking model](https://docs.microsoft.com/azure/aks/concepts-network#kubenet-basic-networking)

- Nodes receive IP address from Azure Virtual network.
- Pods receive an IP address from logically differentiated address space.
- NATting for pods to reach resources on virtual network.
- Kubenet network supports only Linux node pools.

[Use kubenet with you own IP address ranges in Azure Kubernetes Service](https://docs.microsoft.com/azure/aks/configure-kubenet)

- By default, UDRs and IP configuration is created and maintained by AKS.
- AKS supports to bring your own subnet and route table.
- If route table does not exist, AKS creates one and adds rules to it.
- AKS will honor the existing route table and add/updates rules accordingly.
- _**Rules added by AKS should not be removed or modified**_

Azure supports a maximum of _**400 routes**_ in a UDR. If you are using Kubenet network model, you cannot have a cluster larger than _**400 nodes**_ in it.

> For every node scale out, AKS adds its respective route in the route table.

The Pods cannot communicate with each other directly. The UDR and IP forwarding has been used for connectivity between pods across nodes. The routing and Ip forwarding are created and maintained by AKS.

You can bring your own route table as well.

- Bring your [own subnet with route table](https://docs.microsoft.com/azure/aks/configure-kubenet#bring-your-own-subnet-and-route-table-with-kubenet)

- Create custom [route table](https://docs.microsoft.com/azure/virtual-network/manage-route-table)

### Dual-Stack Networking

[Dual-Stack Networking](https://learn.microsoft.com/azure/aks/configure-kubenet-dual-stack?tabs=azure-cli%2Ckubectl) nodes receive both an IPv4 and IPv6 address from the Azure virtual network subnet. Pods receive both an IPv4 and IPv6 address from a logically different address space to the Azure virtual network subnet of the nodes.

- If using a managed virtual network, a dual-stack virtual network configuration.
- IPv4 and IPv6 node and pod addresses.
- Outbound rules for both IPv4 and IPv6 traffic.
- Load balancer setup for IPv4 and IPv6 services.

[Deploying a dual-stack AKS Cluster](https://learn.microsoft.com/azure/aks/configure-kubenet-dual-stack?tabs=azure-cli%2Ckubectl#deploying-a-dual-stack-cluster)

- Limitations
  - Azure route tables have a hard limit of 400 routes per table.
    - Each node in a dual-stack cluster requires two routes, one for each IP address family, so dual-stack clusters are limited to 200 nodes.
  - In Azure Linux node pools, service objects are only supported with externalTrafficPolicy: Local.
  - Dual-stack networking is required for the Azure virtual network and the pod CIDR.
    - Single stack IPv6-only isn't supported for node or pod IP addresses. Services can be provisioned on IPv4 or IPv6.
  - The following features are not supported on dual-stack kubenet:
    - Azure network policie
    - Calico network policies
    - NAT Gateway
    - Virtual nodes add-on
    - Windows node pools

### IP Address space

With Kubenet you can use a smaller IP address range and support large clusters.

For more details:

- [IP address availability for kubenet](https://docs.microsoft.com/azure/aks/configure-kubenet#ip-address-availability-and-exhaustion)

- [Limitations and considerations for kubenet](https://docs.microsoft.com/azure/aks/configure-kubenet#limitations--considerations-for-kubenet)

## Azure CNI (advanced)

With [Azure CNI](https://docs.microsoft.com/azure/aks/concepts-network#azure-cni-advanced-networking) every pod gets an IP address from the cluster subnet. These IP addresses must be unique across network space.

[Configure Azure CNI in Azure Kubernetes Service](https://docs.microsoft.com/azure/aks/configure-azure-cni)

- It requires additional planning while designing the IP address space.
- IP address should be planned according to the number of node pools, nodes, and maximum number of pods per node.
- If Internal load balancers are deployed, front IPs are allocated from the cluster subnet

### Planning IP address (Azure CNI)

- [IP address planning](https://docs.microsoft.com/azure/aks/configure-azure-cni#plan-ip-addressing-for-your-cluster)
- [Maximum pods per node](https://docs.microsoft.com/azure/aks/configure-azure-cni#maximum-pods-per-node)
- The minimum value that can be set per node is 10 - [Refer for mandatory node requirement in this case](https://docs.microsoft.com/azure/aks/configure-azure-cni#configure-maximum---new-clusters)

> While planning the IP addresses, leave some additional room for upgrade operations. By default, AKS configures upgrades to surge with 1 extra node.

### Dynamic allocation of IPs and enhanced subnet support

A drawback with the traditional CNI is the exhaustion of pod IP addresses as the AKS cluster grows, resulting in the need to rebuild the entire cluster in a bigger subnet.

The new [dynamic IP](https://docs.microsoft.com/en-us/azure/aks/configure-azure-cni#dynamic-allocation-of-ips-and-enhanced-subnet-support-preview) allocation capability in Azure CNI solves this problem by allotting pod IPs from a subnet separate from the subnet hosting the AKS cluster.

### The IP tables in Azure Kubernetes Service

- Cluster level rules for each service.
- KUBE-MARK-MASQ, KUBE-SVC-xyz, and KUBE-SEP-xyz rules.

IP tables for Azure CNI use one additional rule chain "MASQUERADE" which is called by post routing chain. It is one of the last steps if the packets are leaving cluster. This sets the source IP to the node IP.

The two ways that Azure provides network policies use Linux IP tables to control the traffic between pods.
[Create an AKS cluster with network policies](https://docs.microsoft.com/azure/aks/use-network-policies#network-policy-options-in-aks).

> Walkthrough the customer on the rules and rule chains and how the routing decision has been made.

### If Azure Application Gateway is used, how the networking between Application gateway and AKS can be setup?

Refer [How to setup networking between Application gateway and AKS](https://azure.github.io/application-gateway-kubernetes-ingress/how-tos/networking/#with-kubenet)

Two things to consider when setting up networking between Application gateway and AKS

1. Application gateway deployed in same VNET as AKS.
    - If Azure CNI is used, you are good to go. All the PODs receive routable IP.

2. Application gateway deployed in different VNETs.
    - If deployed in different VNETs, peering between the VNETs is required to enable the communication. If CNI is used, Azure adds the route once the peering enabled between the VNETs.

In either cases if Kubenet used, need to [associate route table](https://azure.github.io/application-gateway-kubernetes-ingress/how-tos/networking/#with-kubenet) created by AKS with application gateway subnet for the routing as pods don't receive routable IPs from the cluster subnet.

### Private AKS cluster

When creating an AKS private cluster the control plane has an internal IP address. Private cluster ensures traffic between API server and node pools remain private network.

- [Create a private Azure Kubernetes Service cluster](https://docs.microsoft.com/azure/aks/private-clusters)

Private endpoint allows the VNET to communicate with Private cluster. To connect with private endpoint, you need a DNS record.

- [Configure Private DNS zone](https://docs.microsoft.com/azure/aks/private-clusters#configure-private-dns-zone )

- If custom DNS resolver used in Hub and Spoke model, the custom DNS resolver VNET should also be linked with private DNS zone.

- [Hub & Spoke with custom DNS.](https://docs.microsoft.com/azure/aks/private-clusters#hub-and-spoke-with-custom-dns)

- Different [options to connect private clusters](https://docs.microsoft.com/azure/aks/private-clusters#options-for-connecting-to-the-private-cluster)

- [Private cluster limitation](https://docs.microsoft.com/azure/aks/private-clusters#limitations)
  - Authorized IP ranges cannot be applied.
  - No support for Azure DevOps Microsoft hosted agents.

### Cluster Egress Control

The cluster deployed on virtual network has outbound dependencies on services outside of virtual network.

- Nodes in an AKS cluster need to access services outside for management & operational purpose. Communicate with the API server, or to download core Kubernetes cluster components, node security updates.

To know more on required network rules and IP address dependencies are [Control egress traffic for cluster nodes in Azure Kubernetes Service](https://docs.microsoft.com/azure/aks/limit-egress-traffic)

### Outbound Type

 AKS cluster can be customized with a unique `outboundType` as `loadbalancer` &  `userDefinedRouting`

- [Cluster egress with User Defined Route](https://docs.microsoft.com/azure/aks/egress-outboundtype)

By default, AKS will use `outboundType` as `loadbalancer` and provision standard SKU load balancer for egress traffic.

- [Outbound type of loadbalancer.](https://docs.microsoft.com/azure/aks/egress-outboundtype#outbound-type-of-loadbalancer)

If `outboundType` is set as `userDefinedRouting`, then AKS won't perform any configuration for egress.

- [Outbound type of userDefinedRouting](https://docs.microsoft.com/azure/aks/egress-outboundtype#outbound-type-of-userdefinedrouting)

### If outbound type set as UDR and sending egress to Azure Firewall

Azure Firewall provides an Azure Kubernetes Service (AzureKubernetesService) FQDN Tag to simplify this configuration.

How to [restrict egress traffic using Azure Firewall?](https://docs.microsoft.com/azure/aks/limit-egress-traffic#restrict-egress-traffic-using-azure-firewall)

- Minimum 20 Frontend IPs on Azure Firewall for production scenario to avoid port exhaustion.
  - [Create Azure Firewall with multiple public IP address](https://docs.microsoft.com/azure/firewall/quick-create-multiple-ip-template)
- Azure Firewall provides `AzureKubernetesService` FQDN tag.
- If `outboundType` as UDR, load balancer deployed when first services with type as `loadbalancer`. [UDR Creation](https://docs.microsoft.com/azure/aks/egress-outboundtype#load-balancer-creation-with-userdefinedrouting)
- Load blajacer with public IP is for inbound requests, rules are configured by Azure.
- No outbound public IP address or oubtound rules

### Additional information

[Using SNAT for outbound connections](https://docs.microsoft.com/azure/load-balancer/load-balancer-outbound-connections)

### Managed NAT Gateway

Whilst AKS customers are able to route egress traffic through an Azure Load Balancer, there are limitations on the amount of outbound flows of traffic that is possible.

### Different Types of Services in Kubernetes

[Basic Concepts of Kubernetes Services](https://kubernetes.io/docs/concepts/services-networking/service/)

- ClusterIP : Default Kubernetes service accessible inside the Kubernetes cluster - no external access.
- NodePort : Most primitive way to get external traffic directly to your service. It opens a specific port on all the Nodes and any traffic sent to this port is forwarded to the service.
- LoadBalancer : Standard way to expose a service to the internet. In Azure, this will spin up an Azure Load Balancer (L4) that gives us a single public IP address that forwards all traffic to your service.
  - [How to create an internal LoadBalancer](https://docs.microsoft.com/azure/aks/internal-lb)
  - [How to create a Standard LoadBalancer](https://docs.microsoft.com/azure/aks/load-balancer-standard)
  - [Use a static public IP address and DNS label with the AKS load balancer](https://docs.microsoft.com/azure/aks/static-ip)
- External DNS : Creates a specific DNS entry for easier application access.

[Cluster egress with Managed NAT Gateway](https://docs.microsoft.com/en-us/azure/aks/nat-gateway)

## Azure CNI Overlay (advanced)

With [Azure CNI Overlay](https://learn.microsoft.com/en-us/azure/aks/azure-cni-overlay) every node gets an IP address from the cluster subnet. Pods receive IPs from a private CIDR provided at the time of cluster creation. Each node is assigned a /24 address space carved out from the same CIDR. Extra nodes created when you scale out a cluster automatically receive /24 address spaces from the same CIDR.

### Planning IP address (Azure CNI Overlay)

- Cluster Nodes
  - Cluster nodes gets deployed into the subnet in your VNet.
  - A /24 subnet can fit upto 251 nodes. Leave room for scaling and upgrades.

- Pods
  - The Overlay solution assigns a /24 address space for pods on every node from the private CIDR that you specify during cluster creation. Ensure the private CIDR is large enough to provide /24 address spaces for new nodes to support future cluster expansion.
  - The /24 size is fixed and can't be increased or decreased.
  - You can run up to 250 pods on a node.
  - Pod CIDR space must not overlap with the cluster subnet range or with the directly connected networks.

- Kubernetes service address range
  - It must be smaller than /12.
  - This range shouldn't overlap with the pod CIDR range, cluster subnet range, and IP range used in peered VNets and on-premises networks.
- Kubernetes DNS service IP address
  - This IP address is within the Kubernetes service address range that's used by cluster service discovery.
  - Don't use the first IP address in your address range, as this address is used for the kubernetes.default.svc.cluster.local address.

### Egress Traffic

- Communication with endpoints outside the cluster happens through the node IP through NAT.
- You can provide outbound (egress) connectivity to the internet for Overlay pods using a Standard SKU Load Balancer or Managed NAT Gateway.
- It translates the source IP ( the pod IP) of the traffic to the primary address of the VM which enables Azure networking stack to route the traffic.
- You can also control egress traffic by directing it to a firewall using User Defined Routes on the cluster subnet.

### Ingress Connectivity

- You can configure ingress connectivity to the cluster using an ingress controller, such as Nginx or HTTP application routing.
- You cannot configure ingress connectivity using Azure App Gateway.

### When to use Overlay?

- You would like to scale to a large number of pods, but have limited IP address space in your VNet.
- Most of the pod communication is within the cluster.
- You don't need advanced AKS features, such as virtual nodes.

### Limitations

- You can't use Application Gateway as an Ingress Controller (AGIC) for an Overlay cluster.
- Virtual Machine Availability Sets (VMAS) aren't supported for Overlay.
- Dual stack networking isn't supported in Overlay.
- You can't use DCsv2-series virtual machines in node pools.

### Different Types of Services in Kubernetes

[Basic Concepts of Kubernetes Services](https://kubernetes.io/docs/concepts/services-networking/service/)

- ClusterIP : Default Kubernetes service accessible inside the Kubernetes cluster - no external access.
- NodePort : Most primitive way to get external traffic directly to your service. It opens a specific port on all the Nodes and any traffic sent to this port is forwarded to the service.
- LoadBalancer : Standard way to expose a service to the internet. In Azure, this will spin up an Azure Load Balancer (L4) that gives us a single public IP address that forwards all traffic to your service.
  - [How to create an internal LoadBalancer](https://docs.microsoft.com/azure/aks/internal-lb)
  - [How to create a Standard LoadBalancer](https://docs.microsoft.com/azure/aks/load-balancer-standard)
  - [Use a static public IP address and DNS label with the AKS load balancer](https://docs.microsoft.com/azure/aks/static-ip)
- External DNS : Creates a specific DNS entry for easier application access.

## Ingress

[Ingress](https://kubernetes.io/docs/concepts/services-networking/ingress/) is to expose HTTP and HTTPS routes from outside of the cluster to the services within the cluster.

- Ingress can distribute traffic based on the URL of the application and handle TLS/SSL termination.
- Ingress also reduces the number of IP addresses you expose and map.

![aks-ingress](https://user-images.githubusercontent.com/83619402/151653201-005f9fbb-fdff-4362-a0b0-b879b6bc6d18.png)

There are two ingress components:

- [Ingress resources](https://docs.microsoft.com/azure/aks/operator-best-practices-network#ingress-resource)
- [Ingress Controllers](https://kubernetes.io/docs/concepts/services-networking/ingress-controllers/)
  - [How to create an ingress controller in Azure Kubernetes Service](https://docs.microsoft.com/azure/aks/ingress-basic?tabs=azure-cli)
  - [How to enable HTTP application routing](https://docs.microsoft.com/azure/aks/http-application-routing)
  - [How to create an ingress controller to an internal virtual network in AKS](https://docs.microsoft.com/azure/aks/ingress-internal-ip?tabs=azure-cli)
  - [How client source IP preservation works for loadbalancer services in AKS](https://techcommunity.microsoft.com/t5/fasttrack-for-azure/how-client-source-ip-preservation-works-for-loadbalancer/ba-p/3033722)
  - [How to restrict application access to AKS cluster within VNET](https://techcommunity.microsoft.com/t5/fasttrack-for-azure/restrict-application-access-in-aks-cluster/ba-p/3017826#)

Best practice is to use ingress resources and controllers to distribute HTTP or HTTPS traffic to your application as it is a layer 7 loadbalancer.

### In-cluster Ingress controllers

There are many options for ingress controllers that are maintained and supported by different companies and communities such as nginx, Traefik, HaProxy, Envoy, etc. You can find the list of these controllers in the [official Kubernetes website](https://kubernetes.io/docs/concepts/services-networking/ingress-controllers/). The most common one is the nginx ingress controller.

### Application Routing add-on

The application routing add-on with nginx delivers the following:

- Easy configuration of managed nginx Ingress controllers based on Kubernetes nginx Ingress controller.
- Integration with Azure DNS for public and private zone management
- SSL termination with certificates stored in Azure Key Vault.

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

AGIC leverages the AKS’ advanced networking, which allocates an IP address for each pod from the subnet shared with Application Gateway. Application Gateway Ingress Controller has direct access to all Kubernetes pods. This eliminates the need for data to pass through kubenet.

AGIC helps eliminate the need to have another load balancer/public IP in front of the AKS cluster and avoids multiple hops in your datapath before requests reach the AKS cluster. Application Gateway talks to pods using their private IP directly and does not require NodePort or KubeProxy services. This also brings better performance to your deployments.

Azure Application Gateway must be in the same Virtual Network or in a Peered Virtual Network. The communication between Azure Application Gateway and AKS will always happen using a Virtual Network connectivity.

You can setup to use End-to-end TLS or TLS offloading.

![image](https://user-images.githubusercontent.com/83619402/150572133-6e213053-41b3-4d4f-b77c-60295289b14d.png)

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

[AKS Add-On Greenfield Deployment](https://docs.microsoft.com/azure/application-gateway/tutorial-ingress-controller-add-on-new)
[AKS Add-On Brownfield Deployment](https://docs.microsoft.com/azure/application-gateway/tutorial-ingress-controller-add-on-existing)
[Helm Greenfield Deployment](https://docs.microsoft.com/azure/application-gateway/ingress-controller-install-new)
[Helm Brownfield Deployment](https://docs.microsoft.com/azure/application-gateway/ingress-controller-install-existing)

### HAProxy Ingress controllers

- [How to install the HAProxy Enterprise Kubernetes Ingress Controller in AKS](https://www.haproxy.com/documentation/kubernetes/latest/installation/enterprise/azure/)

### Application Gateway for Containers (PREVIEW)

[Application Gateway for Containers](https://learn.microsoft.com/en-us/azure/application-gateway/for-containers/overview) is the evolution of the Application Gateway Ingress Controller (AGIC). It offers an elastic and scalable ingress to AKS clusters and comprises a new data plane as well as control plane with new set of ARM APIs. The service is managed by an ALB controller component that runs inside the AKS cluster and adheres to Kubernetes Gateway APIs.

Features and Benefits:

  - Traffic splitting / Weighted round robin
  - Mutual authentication to the backend target
  - Kubernetes support for Ingress and Gateway API
  - Flexible deployment strategies
  - Increased performance, offering near real-time updates to add or move pods, routes, and probes


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
