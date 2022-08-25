Part 1 of 6 | [Security Best Practices &rarr;](./security-best-practices.md)

# Networking

> **Note**   
> _This handout was prepared in advance and intentionally generic. Actual session content may differ based on discussion. Please refer to your own personal notes._

## Overview

### Concepts
	
- [AKS Networking Introduction](https://docs.microsoft.com/azure/aks/concepts-network)
- [AKS Networking Best Practices](https://docs.microsoft.com/azure/aks/operator-best-practices-network)
- [Network Model Comparison Table - Kubenet vs Azure CNI](https://docs.microsoft.com/en-us/azure/aks/concepts-network#compare-network-models)

### How-To Bring Your Own (BYO) Virtual Network

- [VNet with kubenet](https://docs.microsoft.com/azure/aks/configure-kubenet)
- [VNet with Azure CNI](https://docs.microsoft.com/azure/aks/configure-azure-cni)

### Cloud Adoption Framework (CAF) Recommendations

- [AKS Networking design recommendations](https://docs.microsoft.com/azure/cloud-adoption-framework/scenarios/app-platform/aks/network-topology-and-connectivity#design-recommendations)

## Misc. Links

Links shared in chat based on attendee questions.


#### Custom Managed Resource Group Names

For people who prefer different conventions, e.g. `-rg` suffix over default `MC_` prefix

- [MS Docs - FAQ](https://docs.microsoft.com/en-us/azure/aks/faq#can-i-provide-my-own-name-for-the-aks-node-resource-group)
- [Terraform](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/kubernetes_cluster#node_resource_group) via `node_resource_group` argument
- [Azure CLI](https://docs.microsoft.com/en-us/cli/azure/aks?view=azure-cli-latest#az-aks-create) via `--node-resource-group` flag on cluster create

#### Service Types in Kubernetes

[Kubernetes Docs: Service Types](https://kubernetes.io/docs/concepts/services-networking/service/#publishing-services-service-types)

- ClusterIP
- [NodePort](https://kubernetes.io/docs/concepts/services-networking/service/#type-nodeport)
- [LoadBalancer](https://kubernetes.io/docs/concepts/services-networking/service/#loadbalancer)
- [ExternalName](https://kubernetes.io/docs/concepts/services-networking/service/#externalname)

#### Which Networking Model does my cluster have?

Find out with [`az aks show command`](https://docs.microsoft.com/en-us/cli/azure/aks?view=azure-cli-latest#az-aks-show)