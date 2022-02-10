# Azure Arc-enabled Kubernetes

## Overview

In this session, learn about [Azure Arc-enabled Kubernetes](https://docs.microsoft.com/en-us/azure/azure-arc/kubernetes/overview). We will discuss how to connect Kubernetes clusters to Arc, deploy cluster extensions (monitoring, defender, policy manager) and how to configure cluster for GitOps.  

## Agenda

* What is Azure Arc-enabled Kubernetes?
* Cluster connection
  * Validated partners
* How to deploy cluster extensions
* How to configure GitOps

### Audience

This session is mostly useful for cloud architects and kubernetes administrators who want to integrate their kubernetes clusters with Azure Management to manage at scale multiple managed, third party hosted or on-premises hosted clusters.

### Goals

In this session you will learn how to:

- Understand how Azure Arc for Kubernetes works.
- Connect an existing cluster to Azure Arc
- Deploy cluster extensions to a connected clusters
- Deploy configurations to a connected cluster via GitOps


## Learning Resources and Session Summary

*   Azure Arc enabled Kubernetes enables you to extend Azure management capabilities such as Azure Policy, Monitor, Defender and Inventory to your kubernetes clusters (managed, third party hosted or on-premises)
*   You need to [connect the cluster](https://docs.microsoft.com/en-us/azure/azure-arc/kubernetes/quickstart-connect-cluster) to Arc for Kubernetes to deploy the [cluster agent](https://docs.microsoft.com/en-us/azure/azure-arc/kubernetes/conceptual-agent-overview)
    *   The agent communicates outbound over TCP port 443, but can be configured to use a proxy for outbound communication, review [network configuration](https://docs.microsoft.com/en-us/azure/azure-arc/kubernetes/quickstart-connect-cluster?tabs=azure-cli#meet-network-requirements) requirements
    *   Once connected, agent deploys a few [operators](https://docs.microsoft.com/en-us/azure/azure-arc/kubernetes/quickstart-connect-cluster?tabs=azure-cli#6-view-azure-arc-agents-for-kubernetes) into the ```azure-arc``` namespace
*   You can [deploy cluster extensions](https://docs.microsoft.com/en-us/azure/azure-arc/kubernetes/extensions) on Arc-enabled Kubernetes clusters
    * [List of available extensions](https://docs.microsoft.com/en-us/azure/azure-arc/kubernetes/extensions#currently-available-extensions) 
*   You can [deploy cluster configurations](https://docs.microsoft.com/en-us/azure/azure-arc/kubernetes/tutorial-use-gitops-connected-cluster) on Arc-enabled Kubernetes clusters using GitOps
    * New [preview version](https://docs.microsoft.com/en-us/azure/azure-arc/kubernetes/tutorial-use-gitops-flux2) uses GitOps with Flux v2 that provides [new features](https://fluxcd.io/docs/migration/faq-migration/#why-did-you-rewrite-flux) over v1
*   Enable [Custom Locations](https://docs.microsoft.com/en-us/azure/azure-arc/kubernetes/custom-locations) to configure Arc-enabled Kubernetes clusters as target locations for deploying instances of Azure Services such as Data Services, App Services, Functions, Event Grid, Logic Apps or API Management

Additional learning resources:

*   [Introduction to Azure Arc enabled Kubernetes - Learn | Microsoft Docs](https://docs.microsoft.com/en-us/learn/modules/intro-to-arc-enabled-kubernetes/)
*   [Overview | Azure Arc Jumpstart](https://azurearcjumpstart.io/overview/)
*   [Introduction to Azure Arc enabled Kubernetes with GitOps](https://techcommunity.microsoft.com/t5/video-hub/introduction-to-azure-arc-enabled-kubernetes-with-gitops/ba-p/1693517)

