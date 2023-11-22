# FastTrack for Azure Live - Azure Kubernetes Service (AKS) in 4 parts

 This multipart series offers a structured approach to successfully designing, deploying, and operating Azure Kubernetes Service and workloads.
 This series structure aligns to any typical workload lifecycle: architecture design, deployment and operations.

 ### Basic Kubernetes knowledge required
- Basic understanding of Azure as a platform.
- Basic understanding of Kubernetes fundamentals and core concepts.

Refer to this Microsoft learn module on [Introduction to Kubernetes](https://learn.microsoft.com/training/modules/intro-to-kubernetes/), especially [how Kubernetes works](https://learn.microsoft.com/training/modules/intro-to-kubernetes/3-how-kubernetes-works).

 # Day 1
 ### [Introduction, Networking Best Practices](../aks-networking/readme.md)
 Learn about Azure specific implementations of Kubernetes networking and best practices for your AKS cluster:
- Choose a networking model, e.g. Kubenet, CNI, CNI Overlay, etc., 
- Virtual Network integration, including IP address planning, private network integration.
- Cluster ingress and egress.
- Network security best practices, network policies.

# Day 2
### [Security Best Practices](../aks-security/readme.md)
Building upon the previous session on AKS networking best practices, we'll learn about securing your cluster and the underlying compute infrastructure, as well as Azure platform integrations to secure your workloads.

- Securing Kubernetes, control plane vs data plane, cluster-level security vs application-level security.
- Node security (compute isolation).
- Kubernetes secrets, Azure Key Vault integration.
- Access & Identity, role-based access control (RBAC) best practices, Azure workload identities.
- Container security, run time security, container registry security, Azure Defender for Containers integration.

# Day 3
### Cluster and Workload Deployment
In the first two sessions we examined how to design an AKS cluster with networking and security best practices. Now we will discuss challenges and best practices for deploying and managing one or multiple clusters.

- Landing Zone considerations.
- Deployment options - Infrastructure as Code (IaC), Azure Portal, Azure CLI, Azure Accelerators.
- Multiple Environments - pre-production vs production clusters and workloads.
- Deployment strategies, CI/CD pipelines, DevOps, and GitOps.

[Handout for Cluster Deployment](../aks-cluster-deployment/README.md)

[Handout for Workload Deployment](../)

# Day 4
### [Operations](../aks-operations/README.md) and [Monitoring](../aks-monitoring/readme.md)
The previous sessions covered how to design and deploy Azure Kubernetes Service (AKS) clusters. Now we'll cover how to successfully operate AKS clusters in production.

- Reliability and business continuity - availability zones, uptime SLAs, backup and restore strategies, disaster recovery.
- Cluster upgrades and patch management - support, lifecycles, and auto-upgrades.
- Resource management strategies.
- Monitoring - control plane vs cluster level (kubelet, nodes) vs workload level (pods).
- Azure Managed Grafana, Azure Monitor managed service for Prometheus, Container Insights.

### Feedback

Please rate this session and help us improve future sessions

[https://aka.ms/ftalive/6-part-aks/feedback](https://aka.ms/ftalive/6-part-aks/feedback)
