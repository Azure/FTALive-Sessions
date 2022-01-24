## AKS Networking

## Different Types of Services in Kubernetes

[Basic Concepts of Kubernetes Services](https://kubernetes.io/docs/concepts/services-networking/service/)

- ClusterIP : default Kubernetes service accessible inside the Kubernetes cluster - no external access.
- NodePort : most primitive way to get external traffic directly to your service. It opens a specific port on all the Nodes  and any traffic sent to this port is forwarded to the service.
- LoadBalancer : standard way to expose a service to the internet. In Azure, this will spin up an Azure Load Balancer (L4) that gives us a single public IP address that forwards all traffic to your service.
    - [How to create an internal LoadBalancer](https://docs.microsoft.com/en-us/azure/aks/internal-lb)
    - [How to create a Standard LoadBalancer](https://docs.microsoft.com/en-us/azure/aks/load-balancer-standard)
    - [Use a static public IP address and DNS label with the AKS load balancer](https://docs.microsoft.com/en-us/azure/aks/static-ip)
- External DNS
  
## Network Policies

[Kubernetes Network Policies](https://kubernetes.io/docs/concepts/services-networking/network-policies/) are used to secure traffic only between the pods.

There are two ways to implement Network Policies in AKS:

- Azure Network Policies
    - [Azure Container Networking Github Repo](https://github.com/Azure/azure-container-networking/blob/master/README.md)  
    
- Calico Network Policies, an open source network.
    - [Calico Network Policies with AKS](https://cloudblogs.microsoft.com/opensource/2019/10/17/tutorial-calico-network-policies-with-azure-kubernetes-service/)
    - [Calico Open Source Github Repo](https://github.com/projectcalico/calico)  

- [Difference between Azure and Calico network policies](https://docs.microsoft.com/en-us/azure/aks/use-network-policies#differences-between-azure-and-calico-policies-and-their-capabilities)
- [How to secure traffic between pods using network policies](https://docs.microsoft.com/en-us/azure/aks/use-network-policies)
- [Deploy AKS clusters with network policy using Infrastructure as a code(IAC)](https://azure.github.io/PSRule.Rules.Azure/en/rules/Azure.AKS.NetworkPolicy/)
  
Best practice is to use network policies to allow or deny traffic to pods. By default, all traffic is allowed between pods within a cluster. For improved security, define rules that limit pod communication.

## Ingress

[Ingress](https://kubernetes.io/docs/concepts/services-networking/ingress/) is to expose HTTP and HTTPS routes from outside of the cluster to the services within the cluster.

 - Ingress can distribute traffic based on the URL of the application and handle TLS/SSL termination.
 - Ingress also reduces the number of IP addresses you expose and map.
    
 There are two ingress components:
 
 - [Ingress resources](https://docs.microsoft.com/en-us/azure/aks/operator-best-practices-network#ingress-resource)
 - [Ingress Controllers](https://kubernetes.io/docs/concepts/services-networking/ingress-controllers/)
      - [How to create an ingress controller in Azure Kubernetes Service](https://docs.microsoft.com/en-us/azure/aks/ingress-basic?tabs=azure-cli)
      - [How to enable HTTP application routing](https://docs.microsoft.com/en-us/azure/aks/http-application-routing)
      - [How to create an ingress controller to an internal virtual network in AKS](https://docs.microsoft.com/en-us/azure/aks/ingress-internal-ip?tabs=azure-cli)
           - [How client source IP preservation works for loadbalancer services in AKS](https://techcommunity.microsoft.com/t5/fasttrack-for-azure/how-client-source-ip-preservation-works-for-loadbalancer/ba-p/3033722)
           - [How to restrict application access to AKS cluster within VNET ](https://techcommunity.microsoft.com/t5/fasttrack-for-azure/restrict-application-access-in-aks-cluster/ba-p/3017826#)
   
Best practice is to use ingress resources and controllers to distribute HTTP or HTTPS traffic to your application as it is a layer 7 loadbalancer.

## Application Gateway Ingress Controller(AGIC)

[Application Gateway Ingress Controller (AGIC)](https://docs.microsoft.com/en-us/azure/application-gateway/ingress-controller-overview) allows Azure Application Gateway to be used as the ingress for an Azure Kubernetes Service. It runs in its own pod on the customer’s AKS.

AGIC leverages the AKS’ advanced networking, which allocates an IP address for each pod from the subnet shared with Application Gateway. Application Gateway Ingress Controller has direct access to all Kubernetes pods. This eliminates the need for data to pass through kubenet.

![image](https://user-images.githubusercontent.com/83619402/150572133-6e213053-41b3-4d4f-b77c-60295289b14d.png)

- [Benefits of Application Gateway Ingress Controller](https://docs.microsoft.com/azure/azure-monitor/containers/container-insights-log-query)
- [Application Gateway Ingress Controller Github Repo](https://github.com/Azure/application-gateway-kubernetes-ingress?WT.mc_id=docs-azuredevtips-azureappsdev)
- [Use private IP for internal routing for an Ingress endpoint](https://docs.microsoft.com/en-us/azure/application-gateway/ingress-controller-private-ip)
- [Enable multiple Namespace support in an AKS cluster with Application Gateway Ingress Controller](https://docs.microsoft.com/en-us/azure/application-gateway/ingress-controller-multiple-namespace-support)
- [What Does It Mean for the Application Gateway Ingress Controller (AGIC) to Assume “Full Ownership”?](https://techcommunity.microsoft.com/t5/fasttrack-for-azure/what-does-it-mean-for-the-application-gateway-ingress-controller/ba-p/2839051)


It can be deployed in two ways:

Helm
- [How to Install an Application Gateway Ingress Controller (AGIC) Using a New Application Gateway](https://docs.microsoft.com/en-us/azure/application-gateway/ingress-controller-install-new)
- [Install an Application Gateway Ingress Controller (AGIC) using an existing Application Gateway](https://docs.microsoft.com/en-us/azure/application-gateway/ingress-controller-install-existing)

Add-On
- [Enable the Ingress Controller add-on for a new AKS cluster with a new Application Gateway instance](https://docs.microsoft.com/en-us/azure/application-gateway/tutorial-ingress-controller-add-on-new)
- [Enable Application Gateway Ingress Controller add-on for an existing AKS cluster with an existing Application Gateway](https://docs.microsoft.com/en-us/azure/application-gateway/tutorial-ingress-controller-add-on-existing)
