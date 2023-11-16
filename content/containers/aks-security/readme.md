# AKS Security Best Practices

## Learning Objectives

- FTA Live leave-behind content
- High-level breakdown of all aspects of security that should be considered when running an AKS cluster. 
- **Not covered here: specific application security for apps deployed to the cluster**

## Agenda

Cluster Level Security:

- Master
- Node Security
- Authentication
- Azure Defender for Containers

Network Security:

- Network Security Groups
- Network Policy
- Egress Security

Developer/Configuration Security:

- Container Security
- Azure Policy
- Workload Identity

Image Management Security:

- Image Scanning

## Cluster Level Security

These concerns should be considered before setting up the cluster.

### General References

- Concepts - [Security concepts for applications and clusters in Azure Kubernetes Service (AKS)](https://docs.microsoft.com/en-us/azure/aks/concepts-security)
- Best Practices - [Best practices for cluster security and upgrades in Azure Kubernetes Service (AKS)](https://docs.microsoft.com/en-us/azure/aks/operator-best-practices-cluster-security)

### Kubernetes API Control Plane

Also sometimes referred to as master nodes. These components are managed by provided, managed, and maintained by Microsoft.Per Docs on [Cluster Security](https://docs.microsoft.com/en-us/azure/aks/concepts-security):
  > By default, the Kubernetes API server uses a public IP address and a fully qualified domain name (FQDN). You can limit access to the API server endpoint using authorized IP ranges.

- [Create a private Azure Kubernetes Service cluster](https://docs.microsoft.com/en-us/azure/aks/private-clusters)
- [Secure access to the API server using authorized IP address ranges in Azure Kubernetes Service (AKS)](https://docs.microsoft.com/en-us/azure/aks/api-server-authorized-ip-ranges)
- [Use command invoke to access a private Azure Kubernetes Service (AKS) cluster](https://docs.microsoft.com/en-us/azure/aks/command-invoke)

### Azure AD Integration

- [Disable Local Accounts (preview)](https://docs.microsoft.com/en-us/azure/aks/managed-aad#disable-local-accounts)
- [AKS-managed Azure Active Directory integration](https://docs.microsoft.com/en-us/azure/aks/managed-aad)
- [Control access to cluster resources using Kubernetes role-based access control and Azure Active Directory identities in Azure Kubernetes Service](https://docs.microsoft.com/en-us/azure/aks/azure-ad-rbac)
- [Use Azure RBAC for Kubernetes Authorization](https://docs.microsoft.com/en-us/azure/aks/manage-azure-rbac)
  
### Node Security

- [Apply security and kernel updates to Linux nodes in Azure Kubernetes Service (AKS)](https://docs.microsoft.com/en-us/azure/aks/node-updates-kured)
- [Azure Kubernetes Service (AKS) node image upgrade](https://docs.microsoft.com/en-us/azure/aks/node-image-upgrade)
- [Update an AKS Cluster > Set auto-upgrade channel](https://docs.microsoft.com/en-us/azure/aks/upgrade-cluster#set-auto-upgrade-channel)
- [Apply security updates to Azure Kubernetes Service (AKS) nodes automatically using GitHub Actions](https://docs.microsoft.com/en-us/azure/aks/node-upgrade-github-actions)
- [Use Planned Maintenance to schedule maintenance windows for your Azure Kubernetes Service (AKS) cluster (preview)](https://docs.microsoft.com/en-us/azure/aks/planned-maintenance)
- Application Availability During Upgrades
  - [Customize node surge upgrade](https://docs.microsoft.com/en-us/azure/aks/upgrade-cluster#customize-node-surge-upgrade)
  - [Plan for availability using pod disruption budgets](https://docs.microsoft.com/en-us/azure/aks/operator-best-practices-scheduler#plan-for-availability-using-pod-disruption-budgets)
  - [Special considerations for node pools that span multiple Availability Zones](https://docs.microsoft.com/en-us/azure/aks/upgrade-cluster#special-considerations-for-node-pools-that-span-multiple-availability-zones)
- [Security hardening for AKS agent node host OS](https://docs.microsoft.com/en-us/azure/aks/security-hardened-vm-host-image)

### Restrict access to Instance Metadata API

- [Best practices for cluster security and upgrades](https://docs.microsoft.com/en-us/azure/aks/operator-best-practices-cluster-security) > [Restrict access to Instance Metadata API](https://docs.microsoft.com/en-us/azure/aks/operator-best-practices-cluster-security#restrict-access-to-instance-metadata-api)
  
### Rotate Certificates Periodically

- [Rotate certificates in Azure Kubernetes Service (AKS)](https://docs.microsoft.com/en-us/azure/aks/certificate-rotation) - Note: there is a 30 min downtime for manually invoked certificate rotation operations.

### Compute isolation (optional)

- [Virtual machine isolation in Azure](https://docs.microsoft.com/en-us/azure/virtual-machines/isolation)
- Leverage isolated VM types if there's a concern about neighbors running on the same physical hardware. 
- [Manage system node pools in Azure Kubernetes Service (AKS)](https://docs.microsoft.com/en-us/azure/aks/use-system-pools) - Note: this is best practice for resiliency and scale reasons, but not necessarily security. 

### Integrate the cluster with Azure Container Registry

- [Authenticate with Azure Container Registry from Azure Kubernetes Service](https://docs.microsoft.com/en-us/azure/aks/cluster-container-registry-integration?tabs=azure-cli)

### Enable SSH (optional)

- [Connect to Azure Kubernetes Service (AKS) cluster nodes for maintenance or troubleshooting](https://docs.microsoft.com/en-us/azure/aks/node-access)

### Enable Monitoring and Alerts

- [Create new clusters](https://docs.microsoft.com/en-us/cli/azure/aks?view=azure-cli-latest#az-aks-create) with `--enable-addons monitoring` flag
- [Container insights overview](https://docs.microsoft.com/en-us/azure/azure-monitor/containers/container-insights-overview)
- [Configure scraping of Prometheus metrics with Container insights](https://docs.microsoft.com/en-us/azure/azure-monitor/containers/container-insights-prometheus-integration)
- [How to view Kubernetes logs, events, and pod metrics in real-time](https://docs.microsoft.com/en-us/azure/azure-monitor/containers/container-insights-livedata-overview)
- For recommended metrics to enable alerting, see [Recommended metric alerts (preview) from Container insights](https://docs.microsoft.com/en-us/azure/azure-monitor/containers/container-insights-metric-alerts#enable-alert-rules)

### Enable Azure Defender for Containers

Not enabled by default because it requires a [Defender Pricing Plan](https://azure.microsoft.com/pricing/details/defender-for-cloud/)

- [Overview of Microsoft Defender for Containers](https://docs.microsoft.com/en-us/azure/defender-for-cloud/defender-for-containers-introduction)
  - [Run-time protection for Kubernetes nodes and clusters](https://docs.microsoft.com/en-us/azure/defender-for-cloud/defender-for-containers-introduction?tabs=defender-for-container-arch-aks#run-time-protection-for-kubernetes-nodes-and-clusters)
- Reference list [Alerts for containers - Kubernetes clusters](https://docs.microsoft.com/en-us/azure/defender-for-cloud/alerts-reference#alerts-k8scluster)

### Separate apps across node pools (optional)

- [Create and manage multiple node pools for a cluster in Azure Kubernetes Service (AKS)](https://docs.microsoft.com/en-us/azure/aks/use-multiple-node-pools)

### Encryption

- [Bring your own keys (BYOK) with Azure disks in Azure Kubernetes Service (AKS)](https://docs.microsoft.com/en-us/azure/aks/azure-disk-customer-managed-keys)
- [Host-based encryption on Azure Kubernetes Service (AKS)](https://docs.microsoft.com/en-us/azure/aks/enable-host-encryption)

## Network Security

- [Network concepts for applications in Azure Kubernetes Service (AKS)](https://docs.microsoft.com/en-us/azure/aks/concepts-network)

### Network Security Groups

- Add NSGs to the NICs of the cluster nodes is not supported for AKS.
- For subnet NSGs, ensure that management traffic is not blocked. See [Azure network security groups](https://docs.microsoft.com/en-us/azure/aks/concepts-security#azure-network-security-groups) for details.
- [Secure traffic between pods using network policies in Azure Kubernetes Service (AKS)](https://docs.microsoft.com/en-us/azure/aks/use-network-policies)

### Private Link

- Use [private endpoints](https://docs.microsoft.com/en-us/azure/private-link/private-endpoint-overview) wherever possible to connect Azure resources via a private IP address
- [Private Link for Azure Contaienr Registry](https://docs.microsoft.com/en-us/azure/container-registry/container-registry-private-link?ref=akschecklist)
- [Private Link for Azure Key Vault](https://docs.microsoft.com/en-us/azure/key-vault/general/private-link-service?tabs=portal)

### Network Policy

- [Secure traffic between pods using network policies in Azure Kubernetes Service (AKS)](https://docs.microsoft.com/en-us/azure/aks/use-network-policies)
  - [Differences between Azure and Calico policies and their capabilities](https://docs.microsoft.com/en-us/azure/aks/use-network-policies#differences-between-azure-and-calico-policies-and-their-capabilities)

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

## Developer/Manifest/Configuration Security

- [Best practices for pod security in Azure Kubernetes Service (AKS)](https://docs.microsoft.com/en-us/azure/aks/developer-best-practices-pod-security)
- [Configure a Security Context for a Pod or Container](https://kubernetes.io/docs/tasks/configure-pod-container/security-context/)
- [Azure Built-In Policy](https://docs.microsoft.com/en-us/azure/aks/policy-reference) "Kubernetes cluster should not allow privileged containers"
  - [Policy Definition](https://portal.azure.com/#blade/Microsoft_Azure_Policy/PolicyDetailBlade/definitionId/%2Fproviders%2FMicrosoft.Authorization%2FpolicyDefinitions%2F95edb821-ddaf-4404-9732-666045e056b4) - link opens in Azure Portal
- [Limit Container Actions with App Armor](https://docs.microsoft.com/en-us/azure/aks/operator-best-practices-cluster-security#app-armor)

### Externalize Secrets

- [Azure Key Vault Provider for Secrets Store CSI Driver](https://github.com/Azure/secrets-store-csi-driver-provider-azure)
- [Use the Azure Key Vault Provider for Secrets Store CSI Driver in an AKS cluster](https://docs.microsoft.com/en-us/azure/aks/csi-secrets-store-driver)

### Workload Identity

- [Announcing Azure Active Directory (Azure AD) workload identity for Kubernetes](https://cloudblogs.microsoft.com/opensource/2022/01/18/announcing-azure-active-directory-azure-ad-workload-identity-for-kubernetes/) 
  - Announced 18 January 2022 with Service Principal support. 
  - Managed Identity support is on the roadmap.
- [Workload identity federation (preview)](https://docs.microsoft.com/en-us/azure/active-directory/develop/workload-identity-federation) 
- [Azure Pod Identity (preview)](https://docs.microsoft.com/en-us/azure/aks/use-azure-ad-pod-identity) - this will be *replaced* and thus will never GA.

### Use Namespaces

- [Kubernetes Documentation: Namespaces](https://kubernetes.io/docs/concepts/overview/working-with-objects/namespaces/) 

## Governance Security / Azure Policy

- [Understand Azure Policy for Kubernetes clusters](https://docs.microsoft.com/en-us/azure/governance/policy/concepts/policy-for-kubernetes)
- [Azure Policy built-in definitions for Azure Kubernetes Service](https://docs.microsoft.com/en-us/azure/aks/policy-reference)
- [Azure Policy Initiatives](https://docs.microsoft.com/en-us/azure/aks/policy-reference#initiatives) represent an implementation of the [Kubernetes Pod Security Standards](https://kubernetes.io/docs/concepts/security/pod-security-standards/) specification
- Policy extension can be auto provisioned from the [Defender for Cloud setting](https://docs.microsoft.com/en-us/azure/defender-for-cloud/kubernetes-workload-protections#configure-defender-for-containers-components)

## Image Management Security

Protect and secure aspects of container images and the AKS cluster 

### Scan Images

- [Use Microsoft Defender for container registries to scan your images for vulnerabilities](https://docs.microsoft.com/en-us/azure/defender-for-cloud/defender-for-container-registries-usage)
- [Overview of Microsoft Defender for Containers](https://docs.microsoft.com/en-us/azure/defender-for-cloud/defender-for-containers-introduction)
  - [Run-time protection for Kubernetes nodes and clusters](https://docs.microsoft.com/en-us/azure/defender-for-cloud/defender-for-containers-introduction?tabs=defender-for-container-arch-aks#run-time-protection-for-kubernetes-nodes-and-clusters)
- [Identify vulnerable container images in your CI/CD workflows](https://docs.microsoft.com/en-us/azure/defender-for-cloud/defender-for-container-registries-cicd)

### Container Regsitry Access

- [Azure Built-in Policy](https://docs.microsoft.com/en-us/azure/aks/policy-reference#microsoftcontainerservice) "Kubernetes cluster containers should only use allowed images"
  - [Policy Definition](https://github.com/Azure/azure-policy/blob/master/built-in-policies/policyDefinitions/Kubernetes/ContainerAllowedImages.json)
- Acccess registry via [Azure Container Registry roles and permissions](https://docs.microsoft.com/en-us/azure/container-registry/container-registry-roles?tabs=azure-cli)
- [Connect privately to an Azure container registry using Azure Private Link](https://docs.microsoft.com/en-us/azure/container-registry/container-registry-private-link)
