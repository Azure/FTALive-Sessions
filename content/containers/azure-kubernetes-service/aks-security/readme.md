### FastTrack for Azure Live
# Azure Kubernetes Service (AKS) Security Best Practices

> [!NOTE]
> This handout was prepared in advance and intentionally generic. Actual session content may differ based on discussion. Please also refer to your own personal notes.

## Infrastructure Security

### Private Clusters

- [Create a private Azure Kubernetes Service cluster](https://docs.microsoft.com/en-us/azure/aks/private-clusters)
- Connecting to a private cluster
  - [Secure access to the API server using authorized IP address ranges in Azure Kubernetes Service (AKS)](https://docs.microsoft.com/en-us/azure/aks/api-server-authorized-ip-ranges)
  - [Use command invoke to access a private Azure Kubernetes Service (AKS) cluster](https://docs.microsoft.com/en-us/azure/aks/command-invoke)
  - [Trusted Access (preview)](https://learn.microsoft.com/en-us/azure/aks/trusted-access-feature)


### Network Policies

Control intra-cluster traffic with [Kubernetes Network Policies](https://kubernetes.io/docs/concepts/services-networking/network-policies/).

- [Azure Network Policies for AKS](https://learn.microsoft.com/en-us/azure/aks/use-network-policies)
- [Calico](https://docs.tigera.io/calico/latest/about/) - the most popular open source option 
- [Comparison - Azure vs. Calico](https://learn.microsoft.com/en-us/azure/aks/use-network-policies#differences-between-azure-network-policy-manager-and-calico-network-policy-and-their-capabilities)


### Secure the Kubernetes Control Plane

- [API Server VNet Integration (preview)](https://learn.microsoft.com/en-us/azure/aks/api-server-vnet-integration)
- [Secure access to the API server and cluster nodes](https://learn.microsoft.com/en-us/azure/aks/operator-best-practices-cluster-security?tabs=azure-cli#secure-access-to-the-api-server-and-cluster-nodes)
- [Restrict access to Instance Metadata API](https://docs.microsoft.com/en-us/azure/aks/operator-best-practices-cluster-security#restrict-access-to-instance-metadata-api)

## Management

### Azure Policy

- [Understand Azure Policy for Kubernetes clusters](https://docs.microsoft.com/en-us/azure/governance/policy/concepts/policy-for-kubernetes)
- [Kubernetes Pod Security Standards](https://kubernetes.io/docs/concepts/security/pod-security-standards/) specification:
  - [Azure Policy Initiatives](https://docs.microsoft.com/en-us/azure/aks/policy-reference#initiatives)
  - [Pod Security Admission](https://learn.microsoft.com/en-us/azure/aks/use-psa)


#### References

- [Azure Policy built-in definitions for Azure Kubernetes Service](https://docs.microsoft.com/en-us/azure/aks/policy-reference)
- [Azure Policy Regulatory Complaince](https://learn.microsoft.com/en-us/azure/aks/security-controls-policy)


### Multitenancy

- [Azure Kubernetes Service (AKS) considerations for multitenancy](https://learn.microsoft.com/en-us/azure/architecture/guide/multitenant/service/aks)

## Integrations

Azure Container Rgistry
- [Authenticate with Azure Container Registry from Azure Kubernetes Service](https://docs.microsoft.com/en-us/azure/aks/cluster-container-registry-integration?tabs=azure-cli)



Defender for Containers


Azure Key Vault
- [Azure Key Vault Provider for Secrets Store CSI Driver](https://github.com/Azure/secrets-store-csi-driver-provider-azure)
- [Use the Azure Key Vault Provider for Secrets Store CSI Driver in an AKS cluster](https://docs.microsoft.com/en-us/azure/aks/csi-secrets-store-driver)


Entra Id


- [Access and Identity options for AKS](https://learn.microsoft.com/en-us/azure/aks/concepts-identity)
- [Announcing Azure Active Directory (Azure AD) workload identity for Kubernetes](https://cloudblogs.microsoft.com/opensource/2022/01/18/announcing-azure-active-directory-azure-ad-workload-identity-for-kubernetes/) 
  - Announced 18 January 2022 with Service Principal support. 
  - Managed Identity support is on the roadmap.
- [Workload identity federation](https://docs.microsoft.com/en-us/azure/active-directory/develop/workload-identity-federation)
- [Azure Pod Identity (preview)](https://docs.microsoft.com/en-us/azure/aks/use-azure-ad-pod-identity) - this will be *replaced* and thus will never GA.

---






### Integrate the cluster with Azure Container Registry



### Pod Security

- [Best practices for pod security in Azure Kubernetes Service (AKS)](https://docs.microsoft.com/en-us/azure/aks/developer-best-practices-pod-security)
- [Configure a Security Context for a Pod or Container](https://kubernetes.io/docs/tasks/configure-pod-container/security-context/)
- [Azure Built-In Policy](https://docs.microsoft.com/en-us/azure/aks/policy-reference) "Kubernetes cluster should not allow privileged containers"
  - [Policy Definition](https://portal.azure.com/#blade/Microsoft_Azure_Policy/PolicyDetailBlade/definitionId/%2Fproviders%2FMicrosoft.Authorization%2FpolicyDefinitions%2F95edb821-ddaf-4404-9732-666045e056b4) - link opens in Azure Portal
- [Limit Container Actions with App Armor](https://docs.microsoft.com/en-us/azure/aks/operator-best-practices-cluster-security#app-armor)
- [Microsoft Entra pod-managed identities](https://learn.microsoft.com/en-us/azure/aks/use-azure-ad-pod-identity)
- [Pod Sandbox](https://learn.microsoft.com/en-us/azure/aks/use-pod-sandboxing)

### Azure Policy


### Separate apps across node pools (optional)

- [Create and manage multiple node pools for a cluster in Azure Kubernetes Service (AKS)](https://docs.microsoft.com/en-us/azure/aks/use-multiple-node-pools)

### Image Vulnerabilities

- [Image Cleaner](https://learn.microsoft.com/en-us/azure/aks/image-cleaner)

## Node Security

- [Apply security and kernel updates to Linux nodes in Azure Kubernetes Service (AKS)](https://docs.microsoft.com/en-us/azure/aks/node-updates-kured)
- [Security hardening for AKS agent node host OS](https://docs.microsoft.com/en-us/azure/aks/security-hardened-vm-host-image)
- [Use Azure Dedicated Hosts](https://learn.microsoft.com/en-us/azure/aks/use-azure-dedicated-hosts)

### Network Security Groups

- Add NSGs to the NICs of the cluster nodes is not supported for AKS.
- For subnet NSGs, ensure that management traffic is not blocked. See [Azure network security groups](https://docs.microsoft.com/en-us/azure/aks/concepts-security#azure-network-security-groups) for details.
- [Secure traffic between pods using network policies in Azure Kubernetes Service (AKS)](https://docs.microsoft.com/en-us/azure/aks/use-network-policies)

### Network Policy

- [Secure traffic between pods using network policies in Azure Kubernetes Service (AKS)](https://docs.microsoft.com/en-us/azure/aks/use-network-policies)
  - [Differences between Azure and Calico policies and their capabilities](https://docs.microsoft.com/en-us/azure/aks/use-network-policies#differences-between-azure-and-calico-policies-and-their-capabilities)

### Encryption

- [Bring your own keys (BYOK) with Azure disks in Azure Kubernetes Service (AKS)](https://docs.microsoft.com/en-us/azure/aks/azure-disk-customer-managed-keys)
- [Host-based encryption on Azure Kubernetes Service (AKS)](https://docs.microsoft.com/en-us/azure/aks/enable-host-encryption)

### Compute isolation (optional)

- [Virtual machine isolation in Azure](https://docs.microsoft.com/en-us/azure/virtual-machines/isolation)
- Leverage isolated VM types if there's a concern about neighbors running on the same physical hardware.
- [Manage system node pools in Azure Kubernetes Service (AKS)](https://docs.microsoft.com/en-us/azure/aks/use-system-pools) - Note: this is best practice for resiliency and scale reasons, but not necessarily security.

### Secrets

- [Kubernetes Secrets](https://learn.microsoft.com/en-us/azure/aks/concepts-security#kubernetes-secrets)

## Access and Identity

### Workload Identity


### Microsoft Entra Integration

- [Disable Local Accounts (preview)](https://docs.microsoft.com/en-us/azure/aks/managed-aad#disable-local-accounts)
- [AKS-managed Azure Active Directory integration](https://docs.microsoft.com/en-us/azure/aks/managed-aad)
- [Control access to cluster resources using Kubernetes role-based access control and Azure Active Directory identities in Azure Kubernetes Service](https://docs.microsoft.com/en-us/azure/aks/azure-ad-rbac)
- [Use Azure RBAC for Kubernetes Authorization](https://docs.microsoft.com/en-us/azure/aks/manage-azure-rbac)
- [Clister access control with AKS-managed Entra Integration](https://learn.microsoft.com/en-us/azure/aks/access-control-managed-azure-ad)

## Container Security

### Container Regsitry Access

- [Azure Built-in Policy](https://docs.microsoft.com/en-us/azure/aks/policy-reference#microsoftcontainerservice) "Kubernetes cluster containers should only use allowed images"
  - [Policy Definition](https://github.com/Azure/azure-policy/blob/master/built-in-policies/policyDefinitions/Kubernetes/ContainerAllowedImages.json)
- Acccess registry via [Azure Container Registry roles and permissions](https://docs.microsoft.com/en-us/azure/container-registry/container-registry-roles?tabs=azure-cli)
- [Connect privately to an Azure container registry using Azure Private Link](https://docs.microsoft.com/en-us/azure/container-registry/container-registry-private-link)

### Enable Azure Defender for Containers

Not enabled by default because it requires a [Defender Pricing Plan](https://azure.microsoft.com/pricing/details/defender-for-cloud/)

- [Overview of Microsoft Defender for Containers](https://docs.microsoft.com/en-us/azure/defender-for-cloud/defender-for-containers-introduction)
  - [Run-time protection for Kubernetes nodes and clusters](https://docs.microsoft.com/en-us/azure/defender-for-cloud/defender-for-containers-introduction?tabs=defender-for-container-arch-aks#run-time-protection-for-kubernetes-nodes-and-clusters)
- Reference list [Alerts for containers - Kubernetes clusters](https://docs.microsoft.com/en-us/azure/defender-for-cloud/alerts-reference#alerts-k8scluster)
- [Application Security](https://learn.microsoft.com/en-us/azure/aks/concepts-security#application-security)

### Scan Images

- [Image Integrity to validate signed images (Preview)](https://learn.microsoft.com/en-us/azure/aks/image-integrity?tabs=azure-cli)
- [Use Microsoft Defender for container registries to scan your images for vulnerabilities](https://docs.microsoft.com/en-us/azure/defender-for-cloud/defender-for-container-registries-usage)
- [Identify vulnerable container images in your CI/CD workflows](https://docs.microsoft.com/en-us/azure/defender-for-cloud/defender-for-container-registries-cicd)



## Appendix

### Docs

- [Cluster operator and developer best practices to build and manage applications on Azure Kubernetes Service (AKS)](https://learn.microsoft.com/en-us/azure/aks/best-practices) - overview of all best practice docs, including:
  - multi-tenancy
  - security
  - network and storage
  - developer best practices
  and more.

### Reference Architectures

| Design | Audience | Target Audience |
|:--|:--|:--|
| [Baseline Architecture for an AKS Cluster](https://learn.microsoft.com/en-us/azure/architecture/reference-architectures/containers/aks/baseline-aks) | Azure Architecture Center, Microsoft Patterns and Practices team | Minimum recommended baseline for everyone |
| [AKS Landing Zone Accelerator](https://learn.microsoft.com/en-us/azure/cloud-adoption-framework/scenarios/app-platform/aks/landing-zone-accelerator) | Cloud Adoption Framework team | Enterprise segment |
| [AKS Security Baseline per Microsoft cloud security benchmark v1](https://learn.microsoft.com/en-us/security/benchmark/azure/baselines/azure-kubernetes-service-aks-security-baseline) | Microsoft Security Benchmark team | Customers with compliance requirements, e.g. NIST, PCI-DSS |
