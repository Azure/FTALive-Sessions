# Automating Workload Deployments 

### Agenda
- Pre-Requisite, Build a container sample application and tagging it
- Workload Deployments
  - Push Model
    - Azure DevOps
    - GitHub Workflow
  - Pull Model (GitOps)
    - Flux CD
    - Argo CD
  - Helm
  - Secrets and Config Management
    - KeyVault
    - CSI Secret Driver
    - Managed Identity  
- Versioning & Releases
  - Image promotion

  ## Helm

Helm is a Kubernetes deployment tool that automates the creation, packaging, configuration, and deployment of applications and services to Kubernetes clusters 1. It is a package manager for Kubernetes that streamlines installing, upgrading, fetching dependencies, and configuring deployments on Kubernetes with simple CLI commands 1.

Helm allows software developers to deploy and test an environment in the simplest possible way. Less time is needed to get from development to testing to production. Besides boosting productivity, Helm presents a convenient way for developers to pack and send applications to end users for installation 1.

Helm charts are Helm packages consisting of YAML files and templates which convert into Kubernetes manifest files. Charts are reusable by anyone for any environment, which reduces complexity and duplicates. The three basic concepts of Helm charts are:

Chart: Pre-configured template of Kubernetes resources.
Release: A chart deployed to a Kubernetes cluster using Helm.
Repository: Publicly available charts.

For detailed instruction to deploy application to AKS using Helm, please refer to the following articles: 
- [Existing Application with Helm in AKS](https://learn.microsoft.com/en-us/azure/aks/kubernetes-helm)
- [Develop on AKS with Helm](https://learn.microsoft.com/en-us/azure/aks/quickstart-helm?tabs=azure-cli)
- [Deploy applications on AKS Hybrid with Helm](https://learn.microsoft.com/en-us/azure/aks/hybrid/helm-deploy)
