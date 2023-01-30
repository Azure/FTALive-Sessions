# Azure Machine Learning Enterprise Deployments Live event

In this session you will learn how to design and implement [Azure Machine Learning (AzureML)](https://docs.microsoft.com/azure/machine-learning/overview-what-is-azure-machine-learning) using enterprise deployment features, so you can create a secure configuration that is compliant with your companies policies [Enterprise security and governance for AzureML](https://docs.microsoft.com/en-us/azure/machine-learning/concept-enterprise-security).
The content of this session is available in our [github repository](https://aka.ms/ftalive/azureml/enterprise-ml).

## Agenda

|     | Topic  | Feature | Description  
| :-- | :----- | :-----  | :-----
| 00. | Intro  |     | Introduction to the presenters and the overall session
| 01. | Azure ML Components | | An overview of the resources deployed with AzureML
| 02. | How to Organise | Overview | Guide around the common decision points when planning a deployment
| 03. |  | Team Structure | The way your Data Science teams are organised and collaborate on projects given use case and data segregation, or cost management requirements.
| 04. |  | Environments | The environments used as part of your development and release workflow to segregate development from production
| 05. |  | Regions | The location of your data and the audience you need to serve your Machine Learning solution to
| 06. | Enterprise Security |  | Security and governance features
| 07. |  | Networks | Virtual Networks, Private Endpoints
| 08. |  | Identity | Authentication, Users, and Roles
| 09. |  | Data protection | Failover & disaster recovery
| 10. | Training & deployment | Working with data | Accessing data, Datasets, and Datastores
| 11. | | Training | Scaling securely
| 12. | | Deploy with endpoints | Real-time, Batch, and Pipelines
| 13. | | Deployment targets | Where and how to deploy using AKS, ACI, and Managed Endpoints
| 14. | | Monitoring | Monitor for availability, performance, and operation
| 15. | Costs | Cost management | Best practices to optimize costs, manage budgets, and share quota with Azure Machine Learning

## Additional samples

A list of curated AzureML samples:

- [Fun with AzureML repo](https://github.com/rndazurescript/FunWithAzureML)
- [Many models solution accelerator](https://github.com/microsoft/solution-accelerator-many-models)
- [Official AzureML notebook samples](https://github.com/Azure/MachineLearningNotebooks/)
- [MLOps starter](https://aka.ms/mlops)

## Frequently asked questions

Here is a list of great questions that came up during the live sessions:

- **What is the difference between a compute cluster and an inference cluster?** You can use Azure Machine Learning [compute cluster](https://docs.microsoft.com/azure/machine-learning/how-to-create-attach-compute-cluster?tabs=python) to distribute a training or batch inference process across a cluster of CPU or GPU compute nodes in the cloud. An [inference cluster](https://docs.microsoft.com/azure/machine-learning/how-to-create-attach-kubernetes?tabs=python) refers to an [Azure Kubernetes Service](https://azure.microsoft.com/services/kubernetes-service/) where Azure Machine Learning can deploy trained machine learning models as real time endpoints.
- **How do I prepare the compute instance to already have a list of selected python packages?** You can use a script while deploying the compute instance as seen in the [official Microsoft documentation](https://docs.microsoft.com/azure/machine-learning/how-to-create-manage-compute-instance?tabs=python#use-script-in-a-resource-manager-template).
- **Is there a way to assign a cluster to specific users or user group?** Clusters "belong" to the workspace and all users that have access to the workspace can utilize the clusters. Normally the security boundary of a workspace is around the ML project where all team members have access to the same data and compute resources. Not to be confused with Compute Instances which are dedicated to each member (as they may contain [ssh keys to access remote git repositories](https://docs.microsoft.com/azure/machine-learning/concept-train-model-git-integration)). One can [create a compute instance of behalf of another user](https://docs.microsoft.com/azure/machine-learning/how-to-create-manage-compute-instance?tabs=python#on-behalf) but can not use it.
- **Can AzureML assist me in distributed training?** Yes, the compute clusters of AzureML can support both data and model parallelism. Start from [this documentation](https://docs.microsoft.com/azure/machine-learning/concept-distributed-training) and then reach out to your [FastTrack for Azure](https://azure.microsoft.com/programs/azure-fasttrack/) Engineer owner or PM to get more technical support.
- **How do I ensure that my blob store doesn't get filled with random data overtime?** You can use [Azure Blob Storage lifecycle management](https://docs.microsoft.com/azure/storage/blobs/lifecycle-management-overview) as described in [this AzureML cost optimization article](https://docs.microsoft.com/azure/machine-learning/how-to-manage-optimize-cost#set-data-retention--deletion-policies).
- **Can one restrict access to the functionalities of the workspace?** Yes, AzureML integrates with Azure's Role Based Access Control (RBAC) model allowing you to fine tune access as seen in [this article](https://docs.microsoft.com/azure/machine-learning/how-to-assign-roles).
- **Why does AutoML show 100% sampling in the best model summary?** Sampling is automatically enabled by AutoML to [handle imbalanced data](https://docs.microsoft.com/azure/machine-learning/concept-manage-ml-pitfalls#handle-imbalanced-data) when needed. In our example, all data were used.
- **What are the best practices to version my data, since the dataset only keeps a reference to my actual files?** Have a look on [this article for guidance regarding data versioning](https://docs.microsoft.com/azure/machine-learning/how-to-version-track-datasets).
- **What is the role of Key Vault in AzureML?** If you are not using the [identity-based data access](https://docs.microsoft.com/azure/machine-learning/how-to-identity-based-data-access) option of AzureML, your datastore’s access key is stored in the associated Key Vault, thus allowing you to audit access to those secrets as seen in [this article]( https://docs.microsoft.com/azure/machine-learning/how-to-access-data). Moreover, because Key Vault is a key component of AzureML it allows you to pull secrets using the overall Azureml authentication. For example, from code, you can use [azureml.core.keyvault.Keyvault](https://docs.microsoft.com/en-us/python/api/azureml-core/azureml.core.keyvault.keyvault?view=azure-ml-py) class to pull secrets easily.
- **I want to query my corporate databases from AzureML, should I store the credentials in the Key Vault?** Although Key Vault is a great place to store credentials, I would not advice querying directly the corporate databases from within AzureML to avoid latency, potential ingestion costs, security considerations and potential accidental denial of service attack from an AzureML compute cluster that may "hammer" the database with parallel requests. Instead of that, I would advise copying the training data into an [ADLS Gen 2 using Azure Data Factory of Azure Synapse Analytics]( https://docs.microsoft.com/azure/data-factory/connector-azure-data-lake-storage?tabs=data-factory) and then read the data from there. You can read [the hitchhiker’s guide to the data lake]( https://aka.ms/adls/hitchhikersguide) for guidance and best practices organizing the files in the ADLS Gen 2.
