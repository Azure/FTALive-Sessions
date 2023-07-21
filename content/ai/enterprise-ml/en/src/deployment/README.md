# Azure Machine Learning - Private Link for most services deployment

This Terraform template deploys the following architecture:

![Deployed resources](../media/architecture_200.png "Deployed resources")

It includes:

* Azure Machine Learning Workspace with Private Link
* Azure Storage Account with VNET binding (using Service Endpoints) and Private Link for Blob and File
* Azure Key Vault with VNET binding (using Service Endpoints) and Private Link
* Azure Container Registry
* Azure Application Insights
* Virtual Network
* Jumphost (Windows) with Bastion for easy access to the VNET
* Compute Cluster (in VNET)
* Compute Instance (in VNET)
* (Azure Kubernetes Service - disabled by default and still under development)

## Instructions

Make sure you have the [Azure CLI](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli) and the Azure Machine Learning CLI extension installed (`az extension add -n azure-cli-ml`).

1. Navigate to the scenario folder you want to deploy
1. Copy `terraform.tfvars.example` to `terraform.tfvars`
1. Update `terraform.tfvars` with your desired values
1. Run Terraform
    ```console
    $ cd 200-advanced-private-link-deployment/
    $ terraform init
    $ terraform plan
    $ terraform apply
    ```

