# AKS Security Best Practices

## Agenda

- Securing Kubernetes
- Node security
- Access & Identity
- Container security
- Network Security

## General References

- Concepts - [Security concepts for applications and clusters in Azure Kubernetes Service (AKS)](https://docs.microsoft.com/en-us/azure/aks/concepts-security)
- Best Practices - [Best practices for cluster security and upgrades in Azure Kubernetes Service (AKS)](https://docs.microsoft.com/en-us/azure/aks/operator-best-practices-cluster-security)
- Cloud Adoption Framework - [Security for AKS](https://learn.microsoft.com/en-us/azure/cloud-adoption-framework/scenarios/app-platform/aks/security)

## Securing Kubernetes Clusters

### Kubernetes API Control Plane

Also sometimes referred to as master nodes. These components are managed by provided, managed, and maintained by Microsoft.Per Docs on [Cluster Security](https://docs.microsoft.com/en-us/azure/aks/concepts-security):
  > By default, the Kubernetes API server uses a public IP address and a fully qualified domain name (FQDN). You can limit access to the API server endpoint using authorized IP ranges.

- [Create a private Azure Kubernetes Service cluster](https://docs.microsoft.com/en-us/azure/aks/private-clusters)
- [Secure access to the API server using authorized IP address ranges in Azure Kubernetes Service (AKS)](https://docs.microsoft.com/en-us/azure/aks/api-server-authorized-ip-ranges)
- [Use command invoke to access a private Azure Kubernetes Service (AKS) cluster](https://docs.microsoft.com/en-us/azure/aks/command-invoke)
- [Trusted Access (preview)](https://learn.microsoft.com/en-us/azure/aks/trusted-access-feature)

### Restrict access to Instance Metadata API

- [Best practices for cluster security and upgrades](https://docs.microsoft.com/en-us/azure/aks/operator-best-practices-cluster-security)
- [Restrict access to Instance Metadata API](https://docs.microsoft.com/en-us/azure/aks/operator-best-practices-cluster-security#restrict-access-to-instance-metadata-api)

### Use Namespaces

- [Kubernetes Documentation: Namespaces](https://kubernetes.io/docs/concepts/overview/working-with-objects/namespaces/)

### Rotate Certificates Periodically

- [Rotate certificates in Azure Kubernetes Service (AKS)](https://docs.microsoft.com/en-us/azure/aks/certificate-rotation) - Note: there is a 30 min downtime for manually invoked certificate rotation operations.
- [Custom certificate authority in AKS (preview)](https://learn.microsoft.com/en-us/azure/aks/custom-certificate-authority)

### Externalize Secrets

- [Azure Key Vault Provider for Secrets Store CSI Driver](https://github.com/Azure/secrets-store-csi-driver-provider-azure)
- [Use the Azure Key Vault Provider for Secrets Store CSI Driver in an AKS cluster](https://docs.microsoft.com/en-us/azure/aks/csi-secrets-store-driver)

### Integrate the cluster with Azure Container Registry

- [Authenticate with Azure Container Registry from Azure Kubernetes Service](https://docs.microsoft.com/en-us/azure/aks/cluster-container-registry-integration?tabs=azure-cli)

### Pod Security

- [Best practices for pod security in Azure Kubernetes Service (AKS)](https://docs.microsoft.com/en-us/azure/aks/developer-best-practices-pod-security)
- [Configure a Security Context for a Pod or Container](https://kubernetes.io/docs/tasks/configure-pod-container/security-context/)
- [Azure Built-In Policy](https://docs.microsoft.com/en-us/azure/aks/policy-reference) "Kubernetes cluster should not allow privileged containers"
  - [Policy Definition](https://portal.azure.com/#blade/Microsoft_Azure_Policy/PolicyDetailBlade/definitionId/%2Fproviders%2FMicrosoft.Authorization%2FpolicyDefinitions%2F95edb821-ddaf-4404-9732-666045e056b4) - link opens in Azure Portal
- [Limit Container Actions with App Armor](https://docs.microsoft.com/en-us/azure/aks/operator-best-practices-cluster-security#app-armor)
- [Microsoft Entra pod-managed identities](https://learn.microsoft.com/en-us/azure/aks/use-azure-ad-pod-identity)
- [Pod Sandbox](https://learn.microsoft.com/en-us/azure/aks/use-pod-sandboxing)

### Azure Policy

- [Understand Azure Policy for Kubernetes clusters](https://docs.microsoft.com/en-us/azure/governance/policy/concepts/policy-for-kubernetes)
- [Azure Policy built-in definitions for Azure Kubernetes Service](https://docs.microsoft.com/en-us/azure/aks/policy-reference)
- [Azure Policy Initiatives](https://docs.microsoft.com/en-us/azure/aks/policy-reference#initiatives) represent an implementation of the [Kubernetes Pod Security Standards](https://kubernetes.io/docs/concepts/security/pod-security-standards/) specification
- Policy extension can be auto provisioned from the [Defender for Cloud setting](https://docs.microsoft.com/en-us/azure/defender-for-cloud/kubernetes-workload-protections#configure-defender-for-containers-components)
- [Azure Policy Regulatory Complaince](https://learn.microsoft.com/en-us/azure/aks/security-controls-policy)
- [Pod Security Admission](https://learn.microsoft.com/en-us/azure/aks/use-psa)

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

- [Access and Identity options for AKS](https://learn.microsoft.com/en-us/azure/aks/concepts-identity)
- [Announcing Azure Active Directory (Azure AD) workload identity for Kubernetes](https://cloudblogs.microsoft.com/opensource/2022/01/18/announcing-azure-active-directory-azure-ad-workload-identity-for-kubernetes/) 
  - Announced 18 January 2022 with Service Principal support. 
  - Managed Identity support is on the roadmap.
- [Workload identity federation](https://docs.microsoft.com/en-us/azure/active-directory/develop/workload-identity-federation)
- [Azure Pod Identity (preview)](https://docs.microsoft.com/en-us/azure/aks/use-azure-ad-pod-identity) - this will be *replaced* and thus will never GA.

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

### Policys for Confidential Containers

[Security Policy for Confidential Containers](https://github.com/MicrosoftDocs/azure-docs/commits/main/articles/confidential-computing/confidential-containers-aks-security-policy.md)

## Network Security

- [Network concepts for applications in Azure Kubernetes Service (AKS)](https://docs.microsoft.com/en-us/azure/aks/concepts-network)
- [API Server VNet Integration (preview)](https://learn.microsoft.com/en-us/azure/aks/api-server-vnet-integration)

### Private Link

- Use [private endpoints](https://learn.microsoft.com/en-us/azure/aks/private-clusters?tabs=azure-portal#use-a-private-endpoint-connection) wherever possible to connect Azure resources via a private IP address
- [Private Link for Azure Contaienr Registry](https://docs.microsoft.com/en-us/azure/container-registry/container-registry-private-link?ref=akschecklist)
- [Private Link for Azure Key Vault](https://docs.microsoft.com/en-us/azure/key-vault/general/private-link-service?tabs=portal)

### Exposing Kubernetes Services

- Avoid using public IPs to expose load balanced pods
- Use an ingress controller to reverse proxy and aggregate Kubernetes services. 
  - [Create an ingress controller to an internal virtual network in Azure Kubernetes Service (AKS)](https://docs.microsoft.com/en-us/azure/aks/ingress-internal-ip?tabs=azure-cli)
- Use the _"Kubernetes clusters should use internal load balancers"_ [policy](https://docs.microsoft.com/en-us/azure/aks/policy-reference) to make a Kubernetes service accessible only to applications running in the same virtual network as the Kubernetes cluster.

### Egress Security

- [Control egress traffic for cluster nodes in Azure Kubernetes Service (AKS)](https://docs.microsoft.com/en-us/azure/aks/limit-egress-traffic)
- Avoid a public IP for egress with a private cluster + Standard LB
- [Customize cluster egress with a User-Defined Route](https://docs.microsoft.com/en-us/azure/aks/egress-outboundtype)
- [Control egress traffic for cluster nodes in Azure Kubernetes Service (AKS)](https://docs.microsoft.com/en-us/azure/aks/limit-egress-traffic)
- [Customize cluster egress with a User-Defined Route](https://docs.microsoft.com/en-us/azure/aks/egress-outboundtype)
  - [Outbound type of `loadBalancer`](https://docs.microsoft.com/en-us/azure/aks/egress-outboundtype#outbound-type-of-loadbalancer)
  - [Outbound type of `userDefinedRouting`](https://docs.microsoft.com/en-us/azure/aks/egress-outboundtype#outbound-type-of-userdefinedrouting)

### Enable SSH (optional)

- [Connect to Azure Kubernetes Service (AKS) cluster nodes for maintenance or troubleshooting](https://docs.microsoft.com/en-us/azure/aks/node-access)