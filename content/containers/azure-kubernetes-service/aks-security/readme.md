### FastTrack for Azure Live
# Azure Kubernetes Service (AKS) Security Best Practices


## Infrastructure Security

### Networking Security

The following topics are referenced in the [Networking handout](../aks-networking/networking):

- Controlling egress traffic
- Private clusters
- Network Policies and service mesh

### Secure the Kubernetes Control Plane

- [API Server VNet Integration (preview)](https://learn.microsoft.com/en-us/azure/aks/api-server-vnet-integration)
- [Secure access to the API server and cluster nodes](https://learn.microsoft.com/en-us/azure/aks/operator-best-practices-cluster-security?tabs=azure-cli#secure-access-to-the-api-server-and-cluster-nodes)
- [Restrict access to Instance Metadata API](https://docs.microsoft.com/en-us/azure/aks/operator-best-practices-cluster-security#restrict-access-to-instance-metadata-api)

### Node Security

- [Understand the AKS node update experience](https://learn.microsoft.com/en-us/azure/aks/node-updates-kured#understand-the-aks-node-update-experience), esp. this 🖼️ [diagram](https://learn.microsoft.com/en-us/azure/aks/media/node-updates-kured/node-reboot-process.png).
- [Upgrade Options](https://learn.microsoft.com/en-us/azure/aks/upgrade-cluster) - automatic vs. manual 
- [Center for Internet Security (CIS) Benchmarks for AKS Nodes](https://learn.microsoft.com/en-us/compliance/regulatory/offering-CIS-Benchmark?toc=%2Fazure%2Faks%2Ftoc.json&bc=%2Fazure%2Faks%2Fbreadcrumb%2Ftoc.json)


## Management

### Azure Policy

- [Understand Azure Policy for Kubernetes clusters](https://docs.microsoft.com/en-us/azure/governance/policy/concepts/policy-for-kubernetes)
- [Kubernetes Pod Security Standards](https://kubernetes.io/docs/concepts/security/pod-security-standards/) specification:
  - [Azure Policy Initiatives](https://docs.microsoft.com/en-us/azure/aks/policy-reference#initiatives)
  - [Pod Security Admission](https://learn.microsoft.com/en-us/azure/aks/use-psa)

### Multitenancy

- [Azure Kubernetes Service (AKS) considerations for multitenancy](https://learn.microsoft.com/en-us/azure/architecture/guide/multitenant/service/aks) - overview of concepts and strategies


## Integrations

### Microsoft Entra Integration

- [Access and Identity options for AKS](https://learn.microsoft.com/en-us/azure/aks/concepts-identity) esp. this 🖼️ [diagram](https://learn.microsoft.com/en-us/azure/aks/media/concepts-identity/aad-integration.png)

#### Control Plane

- [Disable (Kubernetes) local accounts](https://learn.microsoft.com/en-us/azure/aks/manage-local-accounts-managed-azure-ad)
- [Use Kubelogin with Azure Kubernetes Service (AKS)](https://learn.microsoft.com/en-us/azure/aks/kubelogin-authentication) - a client-go credential plugin that implements Microsoft Entra ID authentication
- [Conditional Access](https://learn.microsoft.com/en-us/azure/aks/access-control-managed-azure-ad) 
- Role Based Access Control (RBAC)
  - [Use Kubernetes RBAC](https://learn.microsoft.com/en-us/azure/aks/azure-ad-rbac?tabs=portal)
  - [Use Azure RBAC](https://learn.microsoft.com/en-us/azure/aks/manage-azure-rbac)

#### Data Plane

- [Workload Identity overview](https://learn.microsoft.com/en-us/azure/aks/workload-identity-overview?tabs=dotnet)






> [!WARNING]
> [Pod identities](https://learn.microsoft.com/en-us/azure/aks/use-azure-ad-pod-identity) will be completely deprecated in September 2024. Customers should [migrate to workload identities](https://learn.microsoft.com/en-us/azure/aks/workload-identity-migrate-from-pod-identity).





### Additional Azure Services

#### Azure Container Rgistry
- [Authenticate with Azure Container Registry from Azure Kubernetes Service](https://docs.microsoft.com/en-us/azure/aks/cluster-container-registry-integration?tabs=azure-cli)

- [Azure Built-in Policy](https://docs.microsoft.com/en-us/azure/aks/policy-reference#microsoftcontainerservice) "Kubernetes cluster containers should only use allowed images"
  - [Policy Definition](https://github.com/Azure/azure-policy/blob/master/built-in-policies/policyDefinitions/Kubernetes/ContainerAllowedImages.json)
- Acccess registry via [Azure Container Registry roles and permissions](https://docs.microsoft.com/en-us/azure/container-registry/container-registry-roles?tabs=azure-cli)
- [Connect privately to an Azure container registry using Azure Private Link](https://docs.microsoft.com/en-us/azure/container-registry/container-registry-private-link)


#### Defender for Containers
Not enabled by default because it requires a [Defender Pricing Plan](https://azure.microsoft.com/pricing/details/defender-for-cloud/)

- [Overview of Microsoft Defender for Containers](https://docs.microsoft.com/en-us/azure/defender-for-cloud/defender-for-containers-introduction)
  - [Run-time protection for Kubernetes nodes and clusters](https://docs.microsoft.com/en-us/azure/defender-for-cloud/defender-for-containers-introduction?tabs=defender-for-container-arch-aks#run-time-protection-for-kubernetes-nodes-and-clusters)
- Reference list [Alerts for containers - Kubernetes clusters](https://docs.microsoft.com/en-us/azure/defender-for-cloud/alerts-reference#alerts-k8scluster)
- [Application Security](https://learn.microsoft.com/en-us/azure/aks/concepts-security#application-security)


#### Azure Key Vault
- [Azure Key Vault Provider for Secrets Store CSI Driver](https://github.com/Azure/secrets-store-csi-driver-provider-azure)
- [Use the Azure Key Vault Provider for Secrets Store CSI Driver in an AKS cluster](https://docs.microsoft.com/en-us/azure/aks/csi-secrets-store-driver)



---







### Container Image Security

### Scan Images

- [Image Integrity to validate signed images (Preview)](https://learn.microsoft.com/en-us/azure/aks/image-integrity?tabs=azure-cli)
- [Use Microsoft Defender for container registries to scan your images for vulnerabilities](https://docs.microsoft.com/en-us/azure/defender-for-cloud/defender-for-container-registries-usage)
- [Identify vulnerable container images in your CI/CD workflows](https://docs.microsoft.com/en-us/azure/defender-for-cloud/defender-for-container-registries-cicd)



## Appendix

### Docs

- [Best practices Overview for Azure Kubernetes Service (AKS)](https://learn.microsoft.com/en-us/azure/aks/best-practices) 
  - for cluster operators and developers 
  - includes articlees on multi-tenancy, security, network and storage, developer best practices and more.

### Reference Architectures

| Design | Audience | Target Audience |
|:--|:--|:--|
| [Baseline Architecture for an AKS Cluster](https://learn.microsoft.com/en-us/azure/architecture/reference-architectures/containers/aks/baseline-aks) | Azure Architecture Center, Microsoft Patterns and Practices team | Minimum recommended baseline for everyone |
| [AKS Landing Zone Accelerator](https://learn.microsoft.com/en-us/azure/cloud-adoption-framework/scenarios/app-platform/aks/landing-zone-accelerator) | Cloud Adoption Framework team | Enterprise segment |
| [AKS Security Baseline per Microsoft cloud security benchmark v1](https://learn.microsoft.com/en-us/security/benchmark/azure/baselines/azure-kubernetes-service-aks-security-baseline) | Microsoft Security Benchmark team | Customers with compliance requirements, e.g. NIST, PCI-DSS |


### Misc. References

- [Azure Policy built-in definitions for Azure Kubernetes Service](https://docs.microsoft.com/en-us/azure/aks/policy-reference)
- [Azure Policy Regulatory Complaince](https://learn.microsoft.com/en-us/azure/aks/security-controls-policy)



---

- [Image Cleaner](https://learn.microsoft.com/en-us/azure/aks/image-cleaner)







### Pod Security

- [Best practices for pod security in Azure Kubernetes Service (AKS)](https://docs.microsoft.com/en-us/azure/aks/developer-best-practices-pod-security)
- [Configure a Security Context for a Pod or Container](https://kubernetes.io/docs/tasks/configure-pod-container/security-context/)
- [Azure Built-In Policy](https://docs.microsoft.com/en-us/azure/aks/policy-reference) "Kubernetes cluster should not allow privileged containers"
  - [Policy Definition](https://portal.azure.com/#blade/Microsoft_Azure_Policy/PolicyDetailBlade/definitionId/%2Fproviders%2FMicrosoft.Authorization%2FpolicyDefinitions%2F95edb821-ddaf-4404-9732-666045e056b4) - link opens in Azure Portal
- [Limit Container Actions with App Armor](https://docs.microsoft.com/en-us/azure/aks/operator-best-practices-cluster-security#app-armor)
- [Microsoft Entra pod-managed identities](https://learn.microsoft.com/en-us/azure/aks/use-azure-ad-pod-identity)
- [Pod Sandbox](https://learn.microsoft.com/en-us/azure/aks/use-pod-sandboxing)
