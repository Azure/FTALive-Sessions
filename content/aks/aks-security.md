## AKS Security Review Delivery Guide ##

**Goals**:  
- High-level breakdown of all aspects of security that should be considered when running an AKS cluster. 
- Leave behind for customers rather than an emailed dump of links. 
- **Not covered here: specific application security for apps deployed to the cluster**

## Cluster Level concerns ##
These concerns should be considered before setting up the cluster (i.e. running: az aks create) 

- Couple of general articles 
  - https://docs.microsoft.com/en-us/azure/aks/concepts-security 
  - https://docs.microsoft.com/en-us/azure/aks/operator-best-practices-cluster-security 

**Master**
- The cluster's master node(s) are managed by AKS. Locking down access to them is critical. 
- Use a private cluster stronger posture if possible. Ask the question, does the cluster require the API server exposed externally production? If not, expose it privately. 
- The impact of this will be the need for a network connected bastion jumpbox for Kubectl operations, and also a network connected self-hosted agent or Gitops for CI/CD.  
  - https://docs.microsoft.com/en-us/azure/aks/private-clusters 
  - **See "Egress Security" and properly setting the --outbound-type flag for private clusters**

- If a publicly exposed AKS cluster (meaning the API server is publicly accessible), use authorized IP ranges to lock down what internal and external IP's can access the api. 
- **VERY IMPORTANT!**
  - https://docs.microsoft.com/en-us/azure/aks/api-server-authorized-ip-ranges 

**Integrate the cluster with AAD for user auth** 
- Links AAD user authentication with Kubernetes built-in RBAC. This is critical for enforcing subsequent security features like connecting to ACR without stored credentials, running pods with a specific Managed Identity, and properly externalizing secrets. 
  - https://docs.microsoft.com/en-us/azure/aks/managed-aad 

- Use a User Defined MI rather than System Assigned when creating the cluster so identity can be reused on cluster recreate 
  - --assign-identity $IDENTITY 

**Node Security**
- OS patches are applied nightly by AKS. Some patches can only be applied by rebooting the VM, which doesn't happen automatically. 
- Linux kernel updates require a reboot -- Kured daemonset is a solution for safe rebooting (cordoned / drained). 
- Suggested.  Rather than leveraging Kured, recommended approach is to use VMSS Node Image Upgrade, now supported by AKS. This must be scripted by the customer as it's not automatically enforced as of yet (on the roadmap).  This is considered an advantageous approach when compared to Kured, as Node Image Upgrade will bring a new patched OS image and will apply the image to all nodes in a cordoned/drained fashion. 

  - https://docs.microsoft.com/en-us/azure/aks/node-image-upgrade

- Security hardening the AKS agent node host OS. AKS provides a security optimized host OS by default. There is no option to select an alternate operating system. No action need to be taken, but more info here: 
  - https://docs.microsoft.com/en-us/azure/aks/security-hardened-vm-host-image 

**Upgrade Kubernetes version**
- Regularly update K8S version (need to stay within n-2 of officially supported Kuberntes versions) 
  - https://docs.microsoft.com/en-us/azure/aks/operator-best-practices-cluster-security#regularly-update-to-the-latest-version-of-kubernetes 

- Ensure you have headroom for both Azure resource quota and IP address for node surges needed when upgrading a cluster.
  - https://docs.microsoft.com/en-us/azure/aks/upgrade-cluster#customize-node-surge-upgrade 

 **Compute isolation (optional)**
- Leverage isolated VM types if there's a concern about neighbors running on the same physical hardware. 
  - https://docs.microsoft.com/en-us/azure/virtual-machines/isolation 
**Note: for product clusters, separating System and User node pools is a best practice for resiliency and scale reasons, but not necessarily security. https://docs.microsoft.com/en-us/azure/aks/use-system-pools **

**Integrate the cluster with Azure Container Registry** 
- Don't use docker login/password. Connect to ACR through the cluster's AAD integration. See Image Management for more security tweaks around the ACR. 
  - https://docs.microsoft.com/en-us/azure/aks/cluster-container-registry-integration 
  - Deploy ACR with a private endpoint and connect to it from AKS privately. Peering may be needed if a private cluster.

**Enable SSH (optional)**
- Do this only if SSH'ing to agent nodes is deemed useful for troubleshooting. Safely store these keys. 
  - https://docs.microsoft.com/en-us/azure/aks/aks-ssh 

**Enable Monitoring and Alerts**
- Integrate the cluster with Azure Monitoring. This could involve a discussion of Prometheus metrics scaping and the pros/cons of AKS Container Insights vs Prometheus/Grafana. This is an operations topic, but is also a security best practice as proper monitoring helps detect security breeches. 
  - When creating the cluster: --enable-addons monitoring   
  - https://docs.microsoft.com/en-us/azure/azure-monitor/containers/container-insights-overview  
  - https://docs.microsoft.com/en-us/azure/azure-monitor/containers/container-insights-prometheus-integration 
- Additionally, logs should be captured and monitored. Follow this guidance:
  - https://docs.microsoft.com/en-us/azure/azure-monitor/containers/container-insights-livedata-overview
- For recommended metrics to enable alerting, follow this guidance:
  - https://docs.microsoft.com/en-us/azure/azure-monitor/containers/container-insights-metric-alerts#enable-alert-rules

**Enable Azure Defender for Containers**
- New cloud-native solution for securing containerized solutions. Merges two previous Defender services into one offering. The previous offerings were called Defender for Kubernetes and Defender for Container Registries.
- Provides real-time threat protection of the cluster and host-level nodes and generates alerts for threats and malicious activity. 
- Enables vulnerability scanning of container images both in a registry and at runtime (runtime scanning is in preview). Further expanded below in Image Management Concerns.
- Enabled through Microsoft Defender for Cloud for a fee. This is not enabled by default.
  - https://docs.microsoft.com/en-us/azure/defender-for-cloud/defender-for-containers-introduction
- Cluster and host-level protection
   - Azure Defender for Containers provides protections at the cluster level through analysis of Kubernetes audit logs. In addition, Defender for Containers also includes host-level thread detection of the runtime workload. 
   - Host-level threat detection is powered by Defender profile and is deployed to each Kubernetes node in the cluster to provide protections and collect signals.
   - https://docs.microsoft.com/en-us/azure/defender-for-cloud/defender-for-containers-introduction?tabs=defender-for-container-arch-aks#run-time-protection-for-kubernetes-nodes-and-clusters
   - The full list of container-specific alerts can be found in the Reference table of alerts. https://docs.microsoft.com/en-us/azure/defender-for-cloud/alerts-reference#alerts-k8scluster

**Separate apps across node pools (optional)**
- Proper node pool design is critical for cluster reliability. However, it can also affect security if want to ensure certain application stay physically isolated from each other and will not run the same VM nodes. In this case node pool can provide this level of physical isolation. 
  - https://docs.microsoft.com/en-us/azure/aks/use-multiple-node-pools 
  
**Disable Local Accounts (preview)**
- When deploying an AKS cluster, local accounts are enabled by default. This allows someone using kubectl to --admin and get full access to the cluster. A better solution is when integrating the cluster with AAD, disable local kubernetes accounts and do all RBAC level permissions through AAD accounts (which are auditable and cloud integrated). With AAD integration, local accounts are not needed.
  - https://docs.microsoft.com/en-us/azure/aks/managed-aad#disable-local-accounts

** Encryption **
- All data associated with AKS' VMs are encrypted by default with Azure Storage. By default, this encryption uses Microsoft-managed keys. If customer-managed keys are desired for storage encryption, follow guidance here: 
  - https://docs.microsoft.com/en-us/azure/aks/azure-disk-customer-managed-keys 

 ## Network concerns ##

- Things to consider from a networking perspective as it relates to the cluster. Proper Landing Zone design is outside of the scope of this document. 
- https://docs.microsoft.com/en-us/azure/aks/concepts-network

**Network Security**
  - Do not add NSG's to the subnets hosting the cluster (not supported for AKS).   
  - Use Kubernetes network policy to control flow (east-west) within the cluster between applications/pods.  

**Private Link**
  - Use a private endpoint wherever possible to connect AKS to privately enabled services like ACR and KeyVault, and external data services like SQL Database, Cosmos DB, MySQL, etc. 
  - Private Link for Azure Contaienr Registry: https://docs.microsoft.com/en-us/azure/container-registry/container-registry-private-link?ref=akschecklist
  - Private Link for Azure Key Vault: https://docs.microsoft.com/en-us/azure/key-vault/general/private-link-service?tabs=portal

**Network Policy**
  - Allow/Deny networking rules to pods inside of the cluster.
  - This is a critical feature for applying who and what can access application pods. Network Policy enables east/west network traffic between pods inside the cluster. Example would be putting appA into namespace A and appB in namespace B, and leveraging Network Policy to not let pods in these applications call each other. Enables isolation and allows for multi-tenant architectures within a single cluster. 
      - https://docs.microsoft.com/en-us/azure/aks/use-network-policies 

  - Azure and Calico are two different flavors of network policy. 
    - https://docs.microsoft.com/en-us/azure/aks/use-network-policies#differences-between-azure-and-calico-policies-and-their-capabilities 

 **Avoid using public IPs to expose load balanced pods**
  - Use an ingress controller to reverse proxy and aggregate Kubernetes services. Perhaps route external traffic through a WAF (AppGw, Front Door, etc) before hitting the  
  ingress controller. Let the ingress controller route to services and then to pods. 
    - https://docs.microsoft.com/en-us/azure/aks/ingress-internal-ip 

**General rule: avoid using public IPs anywhere inside of the AKS cluster if not explicitly required.**

**Egress Security**
  - Route and limit egress traffic leaving the cluster through a firewall/NVA. This protects against data exfiltration.
    - https://docs.microsoft.com/en-us/azure/aks/limit-egress-traffic 

  - Avoid a public IP for egress with a private cluster + Standard LB 
    - **IMPORTANT for private clusters**
  - Private AKS clusters means only that the API server gets a private IP. By default, AKS still uses a public IP for egress traffic from nodes/pods to outside world, even in private AKS instances. This is because the Standard LB requires the ability to egress, and will create a public IP to do so unless you manage egress traffic flow. You can set the outbound type to use a UDR to Azure Firewall or another NVA to disable the creation of the public IP when leveraging the Standard Load Balancer. 
    - https://docs.microsoft.com/en-us/azure/aks/egress-outboundtype. 
  - When setting the outbound-type and creating a UDR on the AKS subnet, ensure proper egress is enabled on the firewall. Follow the documentation here for the necessary firewall settings. https://docs.microsoft.com/en-us/azure/aks/limit-egress-traffic. Important note: Inbound NSGs are not supported on the subnet containing the AKS nodepools. Network Policies should be used within Kubernetes to control ingress. For egress, the recommendation is to use outbound-type, set a UDR, and control egress through an external firewall. 
  - Examples of setting outbound-type: https://docs.microsoft.com/en-us/cli/azure/aks?view=azure-cli-latest#az_aks_create-examples 

## Developer/Manifest/Configuration concerns ##

  - Things to consider from a developer and configuration perspective 

**Secure Container Access to Resources**
  - Do not run containers as root 
    - Define a security context for privilege and access control settings so that the pod/container doesn't get root access. 
      - https://docs.microsoft.com/en-us/azure/aks/developer-best-practices-pod-security 
      - https://kubernetes.io/docs/tasks/configure-pod-container/security-context/ 
    - Best solution -- use this built-in Azure Policy to enforce this cluster wide 
      - https://portal.azure.com/#blade/Microsoft_Azure_Policy/PolicyDetailBlade/definitionId/%2Fproviders%2FMicrosoft.Authorization%2FpolicyDefinitions%2F95edb821-ddaf-4404-9732-666045e056b4 
  - Limit Container Actions
    - AppArmor is a Linux kernel security module that is enabled by default and can be customized through profiles to restrict read, write, and execution actions taken on by a container.
      - https://docs.microsoft.com/en-us/azure/aks/operator-best-practices-cluster-security#app-armor 

**Externalize Secrets**
  - Externalize application secrets to KeyVault and connect to K8S secrets/pods/envVars. Not GA as of yet.  
    - https://github.com/Azure/secrets-store-csi-driver-provider-azure 
    - https://docs.microsoft.com/en-us/azure/key-vault/general/key-vault-integrate-kubernetes 

**Leverage Pod Identity**
  - Instead of authorizing access to resources at the cluster level, do so for individual pods with Managed Identity. 
  - Pod Identity should be leveraged when externalizing secrets to KeyVault. 
    - https://docs.microsoft.com/en-us/azure/aks/operator-best-practices-identity#use-pod-identities 

  - **NOTE: Pod Identity is not supported with Windows node pools as of yet. Can instead access KV secrets from the cluster MI through CSI driver.**

**Use Namespaces to logically isolate deployments**
  - Leverage namespaces along with Network Policies for application isolation. Namespace on their own provide no isolation and are not a security layer.  
    - https://kubernetes.io/docs/concepts/overview/working-with-objects/namespaces/ 

**Governance concerns / Azure Policy**
  - Set of governance and compliance rules to enforce organizational standards and to assess compliance at-scale. 
    - https://docs.microsoft.com/en-us/azure/governance/policy/concepts/policy-for-kubernetes 
    - https://docs.microsoft.com/en-us/azure/aks/policy-reference 

  - Azure Policy extends Gatekeeper v3, an admission controller webhook for Open Policy Agent (OPA), to apply at-scale enforcements and safeguards on your clusters in a centralized, consistent manner. Azure Policy makes it possible to manage and report on the compliance state of your Kubernetes clusters from one place. 

  - Examples of commonly used policies: 
    - Enforce that authorized IP ranges are defined on a publicly exposed AKS cluster. 
    - Deny root access to pods
    - Pull images only from trusted registries
  - Examples of how an organization wants the platform to respond to a non-complaint resource include: 
    - Deny the resource change 
    - Log the change to the resource 
    - Alter the resource before the change 
    - Alter the resource after the change 
    - Deploy related compliant resources 

  - Azure Advisor -- bubbles up recommendations. Both from Azure Policy and overall platform. 

 ## Image Management concerns ##
  - Protect and secure aspects of container images and the AKS cluster 

 **Scan images**
   - This was previously mentioned. Scan container images to ensure they are free of vulnerabilities. Microsoft Defender for Container Registries includes a vulnerability scanner to scan the registry's images and provide visibility into image. The integrated scanner is powered by Qualys.  
    - https://docs.microsoft.com/en-us/azure/defender-for-cloud/defender-for-container-registries-usage 
   - In addition, Defender for Containers expands on registry scanning and introduces a preview feature for run-time vulnerability scanning. This is powered by Defender profile and is deployed to each Kubernetes node in the cluster to provide protections and collect signals.
    - https://docs.microsoft.com/en-us/azure/defender-for-cloud/defender-for-containers-introduction?tabs=defender-for-container-arch-aks#scanning-images-at-runtime

**Lock down allowed container images**
  - Ensure the AKS cluster restricts pulling container images to only trusted registries. This is a common policy to consider enforcing. It will ensure the use images from trusted registries to reduce the Kubernetes cluster's exposure risk to unknown vulnerabilities, security issues and malicious images. 
    - https://docs.microsoft.com/en-us/azure/aks/policy-reference#microsoftcontainerservice 

**Lock down ACR with RBAC**
  - This was previously mentioned. Instead of accessing a container registry from AKS with Docker credentials stored in the cluster, access it through AAD Managed Identity on the cluster. This is only possible with AAD enabled clusters. Easiest to enable this when creating the cluster.  
    - https://docs.microsoft.com/en-us/azure/container-registry/container-registry-roles 

**Network lock-down of ACR with Private Link**
  - This was previously mentioned. Expose ACR through private link removing external access to the registry. Note, vnet peering will be required if AKS deployed in private cluster.  
    - https://docs.microsoft.com/en-us/azure/container-registry/container-registry-private-link
