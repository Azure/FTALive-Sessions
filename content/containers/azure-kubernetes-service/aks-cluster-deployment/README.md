# Azure Kubernetes Service Cluster Deployment

Overview

- AKS Cluster Deployment Considerations
  - VM Type/Size 
  - Network Model 
  - Network Size 
  - Availability Zone Considerations 
      https://learn.microsoft.com/en-us/azure/aks/availability-zones
  - Private or Public cluster 
      https://learn.microsoft.com/en-us/azure/aks/private-clusters?tabs=azure-portal#limitations
    

- AKS Cluster Deployment Options :
    - Azure Portal
    - Azure CLI
    - Infrastructure as a Code (IaC)
    - Azure Accelerator 
  - Portal Demo 
      https://learn.microsoft.com/en-us/azure/aks/learn/quick-kubernetes-deploy-portal?tabs=azure-cli
  - Azure CLI & Shell Script
      https://learn.microsoft.com/en-us/azure/aks/learn/quick-kubernetes-deploy-cli
      https://learn.microsoft.com/en-us/azure/aks/learn/quick-kubernetes-deploy-powershell
 

- Why Automate Cluster Deployment?
- Landing Zone Considerations

 
 
## "Realistic" IaC Examples for AKS

Complete Open Source Infrastructure as Code examples for AKS

- [Azure Kubernetes Service (AKS) Baseline Cluster](https://github.com/mspnp/aks-baseline/)  
  ARM templates and shell scripts with documentation by Microsoft Patterns and Practices Team
  
- [cloudkube.io AKS Clusters (demo)](https://github.com/julie-ng/cloudkube-aks-clusters)  
  Terraform example of IaC for multiple environments, including Managed Identity and Key Vault integration for example scenario described below.
  
- [Infrastructure as Code (IaC) Comparison](https://github.com/Azure/FTALive-Sessions/tree/main/content/devops/cicd-infra#infrastructure-as-code-iac-comparison) - ARM, Bicep vs Terraform comparison table from the [FTA Live for Infra as Code Handout](https://github.com/Azure/FTALive-Sessions/tree/main/content/devops/cicd-infra#infrastructure-as-code-iac-comparison)


## New Features (As of Nov 2023)
- [Azure Container Storage in AKS](https://azure.microsoft.com/en-us/updates/preview-azure-container-storage-in-aks-cli-experience/)
- [Disable Secure Shell (SSH) support in AKS](https://azure.microsoft.com/en-us/updates/public-preview-disable-secure-shell-ssh-support-in-aks/)
## Reference Links

- [Azure Architecture Center >  Reference Architecture > Secure AKS Baseline](https://docs.microsoft.com/en-us/azure/architecture/reference-architectures/containers/aks/secure-baseline-aks)
- [AKS Landing zone accelerator](https://learn.microsoft.com/en-us/azure/cloud-adoption-framework/scenarios/app-platform/aks/landing-zone-accelerator)
- [Landing Zone checklists ](https://github.com/Azure/review-checklists/tree/main/spreadsheet/macrofree)
- [AKS Baseline for Multi Region Clusters](https://learn.microsoft.com/en-us/azure/architecture/reference-architectures/containers/aks-multi-region/aks-multi-cluster)
- [AKS Roadmap ](https://github.com/Azure/AKS/projects/1)

