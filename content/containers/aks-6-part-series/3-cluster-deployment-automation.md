
[&larr; Security Best Practices](./2-security-best-practices.md) | Part 3 of 6 | [Operations &rarr;](./4-operations.md)

# Automating Cluster Deployments

Overview

- Why use AKS?
- What do you need to decide before deployment 
  - VM Type/Size 
  - Network Model 
  - Network Size 
  - Availailiy Zone Considerations 
      https://learn.microsoft.com/en-us/azure/aks/availability-zones
  - Private or Public cluster 
      https://learn.microsoft.com/en-us/azure/aks/private-clusters?tabs=azure-portal#limitations
    
- Why Automate Cluster Deployment?
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
 
- Landing Zone Considerations

 
 
## "Realistic" IaC Examples for AKS

Complete Open Source Infrastructure as Code examples for AKS

- [Azure Kubernetes Service (AKS) Baseline Cluster](https://github.com/mspnp/aks-baseline/)  
  ARM templates and shell scripts with documentation by Microsoft Patterns and Practices Team
  
- [cloudkube.io AKS Clusters (demo)](https://github.com/julie-ng/cloudkube-aks-clusters)  
  Terraform example of IaC for multiple environments, including Managed Identity and Key Vault integration for example scenario described below.
  
- [Infrastructure as Code (IaC) Comparison](https://github.com/Azure/FTALive-Sessions/tree/main/content/devops/cicd-infra#infrastructure-as-code-iac-comparison) - ARM, Bicep vs Terraform comparison table from the [FTA Live for Infra as Code Handout](https://github.com/Azure/FTALive-Sessions/tree/main/content/devops/cicd-infra#infrastructure-as-code-iac-comparison)

### Key Vault Integration

- [Azure Docs: Use the Azure Key Vault Provider for Secrets Store CSI Driver in an AKS cluster](https://docs.microsoft.com/en-us/azure/aks/csi-secrets-store-driver) - how to enable and use as addon
- [CSI Driver Homepage](https://azure.github.io/secrets-store-csi-driver-provider-azure/docs/) - more technical details, manual installation via Helm chart, etc.




## Reference Links

- [Azure Architecture Center >  Reference Architecture > Secure AKS Baseline](https://docs.microsoft.com/en-us/azure/architecture/reference-architectures/containers/aks/secure-baseline-aks)
- [AKS Landing zone accelerator](https://learn.microsoft.com/en-us/azure/cloud-adoption-framework/scenarios/app-platform/aks/landing-zone-accelerator)
- [Landing Zone checklists ](https://github.com/Azure/review-checklists/tree/main/spreadsheet/macrofree)





