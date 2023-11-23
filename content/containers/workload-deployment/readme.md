# Automating Workload Deployments 

### Agenda
- Workload Deployments
  - Push Model
    - Azure DevOps
    - GitHub Actions
  - Pull Model (GitOps)
    - Flux CD
    - Argo CD
  - Helm
  - Secrets and Config Management
    - KeyVault
    - CSI Secret Driver


## Workload Deployment

## Push Model 

In the context of AKS deployments, a push model refers to a deployment model where the Azure Pipelines and associated agents perform deployments by connecting directly to the AKS cluster. In this model, every time you change your code in a repository that contains a Dockerfile, the images are pushed to your Azure Container Registry, and the manifests are then deployed to your AKS cluster.

You can use Azure Pipelines to automatically deploy to Azure Kubernetes Service (AKS) with continuous integration (CI) and continuous delivery (CD) using Azure DevOps 2. You can create a pipeline that continuously builds and deploys your app.

Please note that the basic approach described here can be adapted for other processes, tools, and services, such as GitHub, Jenkins or Docker Hub.

For insturctions on Push Deployments Using Azure DevOps, please use following references:
- [Deploy to AKS using Azure DevOps Pipelines](https://learn.microsoft.com/en-us/azure/aks/devops-pipeline?tabs=cli&pivots=pipelines-classic)
- [Build CI/CD pipeline for Microservices on AKS](https://learn.microsoft.com/en-us/azure/architecture/microservices/ci-cd-kubernetes)
  
For instructions on Push Deployments using GitHub, please use following references:
- [Deploy to AKS using GitHub Actions](https://learn.microsoft.com/en-us/azure/aks/kubernetes-action)
- [Push Based CI/CD](https://github.com/Azure/aks-baseline-automation/blob/main/workloads/docs/app-flask-push-dockerbuild.md)

## Pull Model
In the context of AKS deployments, a pull model refers to a deployment model where the Kubernetes cluster pulls the configuration from a Git repository. This is also known as GitOps, which is a set of principles for operating and managing a software system that uses source control as the single source of truth.

In a GitOps workflow, the configuration files for your application are stored in a Git repository. When you make changes to the configuration files, you commit them to the repository. The Kubernetes cluster then pulls the changes from the repository and applies them to the cluster. This approach provides a declarative way to manage your infrastructure and applications, and it enables you to easily roll back changes if necessary.

There are several tools available for implementing GitOps on AKS, including Flux and Argo CD. These tools can help you automate the deployment of your applications to AKS and ensure that your cluster is always in the desired state.

- [GitOps for AKS](https://learn.microsoft.com/en-us/azure/architecture/example-scenario/gitops-aks/gitops-blueprint-aks)
- [CI/CD for AKS Apps](https://learn.microsoft.com/en-us/azure/architecture/guide/aks/aks-cicd-github-actions-and-gitops)

## Flux CD

Flux CD is a continuous delivery (CD) and GitOps tool for Kubernetes that simplifies and automates the deployment and lifecycle management of applications and infrastructure on Kubernetes. With Flux CD, developers and operators can declaratively define the desired state of their applications and configurations as code stored in a Git repository. Flux CD works by monitoring your source code repository for changes and automatically generating deployments to keep your applications up to date.
Flux CD is Kubernetes-native and can manage any Kubernetes resource. It enables application deployment (CD) and progressive delivery (PD) through automatic reconciliation. Flux CD can even push back to Git for you with automated container image updates to Git (image scanning and patching).
- [Git going using Flux CD](https://dev.to/azure/git-going-with-gitops-on-aks-a-step-by-step-guide-using-fluxcd-aks-extension-499m)

## Argo CD
Argo CD is a declarative, Kubernetes-native continuous delivery (CD) tool which tracks a repository and detects changes, or "drift". It then applies the required changes to the Kubernetes cluster configuration.
- [Get Started with Argo CD and AKS](https://www.buchatech.com/2021/11/get-started-with-argo-cd-azure-kubernetes-service/)
- [Install ArgoCD on an AKS cluster with NGINX](https://gaunacode.com/install-argocd-on-an-aks-cluster-with-nginx)

## Helm
Helm is a Kubernetes deployment tool that automates the creation, packaging, configuration, and deployment of applications and services to Kubernetes clusters. It is a package manager for Kubernetes that streamlines installing, upgrading, fetching dependencies, and configuring deployments on Kubernetes with simple CLI commands.

Helm allows software developers to deploy and test an environment in the simplest possible way. Less time is needed to get from development to testing to production. Besides boosting productivity, Helm presents a convenient way for developers to pack and send applications to end users for installation.

Helm charts are Helm packages consisting of YAML files and templates which convert into Kubernetes manifest files. Charts are reusable by anyone for any environment, which reduces complexity and duplicates. The three basic concepts of Helm charts are:

- Chart: Pre-configured template of Kubernetes resources.
- Release: A chart deployed to a Kubernetes cluster using Helm.
- Repository: Publicly available charts.

For detailed instruction to deploy application to AKS using Helm, please refer to the following articles: 
- [Existing Application with Helm in AKS](https://learn.microsoft.com/en-us/azure/aks/kubernetes-helm)
- [Develop on AKS with Helm](https://learn.microsoft.com/en-us/azure/aks/quickstart-helm?tabs=azure-cli)
- [Deploy applications on AKS Hybrid with Helm](https://learn.microsoft.com/en-us/azure/aks/hybrid/helm-deploy)

## Secret Management in AKS
Secret management is the process of securely storing and accessing sensitive data, such as passwords, keys, certificates, or connection strings, that your applications need to access other resources or services. AKS provides several options and best practices for secret management, such as:
- [Use the Azure Key Vault provider for Secrets Store CSI Driver in an Azure Kubernetes Service (AKS) cluster](https://learn.microsoft.com/en-us/azure/aks/csi-secrets-store-driver)


