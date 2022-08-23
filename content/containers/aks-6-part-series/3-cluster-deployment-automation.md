
[&larr; Security Best Practices](./2-security-best-practices.md) | Part 3 of 6 | Operations &rarr;

# Automating Cluster Deployments

Overview

- Why use AKS?
- Why Automate Cluster Deployment?
- AKS Cluster Configuration
  - Portal Demo
  - Azure CLI & Shell Script
- Infrastructure as Code Walkthrough
  - ["Stamp"](https://docs.microsoft.com/en-us/azure/architecture/patterns/deployment-stamp) or "Cookie Cutter" Deployments
  - Configuration Management
  - Key Vault Integration
  - Ingress Controller, TLS and DNS 
- Landing Zone Considerations
- Workload Considerations
- Resource Lifecycles
- Versioning
 
## "Realistic" IaC Examples for AKS

Complete Open Source Infrastructure as Code examples for AKS

- [Azure Kubernetes Service (AKS) Baseline Cluster](https://github.com/mspnp/aks-baseline/)  
  ARM templates and shell scripts with documentation by Microsoft Patterns and Practices Team
- [cloudkube.io AKS Clusters](https://github.com/julie-ng/cloudkube-aks-clusters)  
  Terraform example of IaC for multiple environments, including Managed Identity and Key Vault integration for example scenario described below.

## Scenario - AKS as an Application Platform

The following concepts and structure are a simplified version from **[Cloud Adoption Framework: Compare common cloud operating models](https://docs.microsoft.com/en-us/azure/cloud-adoption-framework/operating-model/compare)**

### Operating Models

- Decentralized Operations
- Centralized Operations
- Enterprise Operations

#### Concerns

- Workload 
- Platform 
- Landing Zone 
- Cloud Foundation

#### Diagram

Example Implementation of above concepts with Azure Kubernetes Service (AKS) as Application Platform

![CI/CD Separations of Concerns](../../../images/cicd-separation-of-concerns.png)