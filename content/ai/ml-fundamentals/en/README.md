# Azure Machine Learning fundamentals Live event

In this session you will get an understanding of the overall [Azure Machine Learning (AzureML)](https://docs.microsoft.com/azure/machine-learning/overview-what-is-azure-machine-learning) components and how you can start using the [AzureML studio](https://docs.microsoft.com/azure/machine-learning/overview-what-is-machine-learning-studio) web portal to accelerate you AI journey in the cloud.
The content of this session is available in our [github repository](https://aka.ms/ftalive/azureml/fundamentals).

## Agenda

|     | Topic  | Feature | Description  
| :-- | :----- | :-----  | :-----
| 00. | Intro  |     | Introduction to the presenters and the overall session
| 01. | Resources in [Azure portal](http://portal.azure.com/) | | A lap around the resources deployed with AzureML
| 02. | [AzureML studio](https://ml.azure.com/) | Overview | Guide around the studio user interface
| 03. |  | Compute | Go through the various workspace compute options
| 04. |  | Datastores | Explore the [supported data storing engines](https://docs.microsoft.com/azure/machine-learning/how-to-access-data#supported-data-storage-service-types) and why you need to register them
| 05. |  | Datasets | Register a dataset stored within a datastore and gain insights on the data
| 06. | AutoML | Wizard | Train an ML model on top of the dataset you just registered
| 07. |  | Run | Explore what happens when running an AutoML process
| 08. |  | Models | Review models trained and how they were tuned
| 09. |  | Model explanation | Get insights on [how the trained model works](https://interpret.ml/) and the [Responsible AI toolbox](https://responsibleaitoolbox.ai/)
| 10. | Model deployment | Deploy to ACI | Deploy a real time inference endpoint into Azure Container Instance
| 11. | | Model registry | Review artifacts stored
| 12. | | Real time endpoints | Review swagger.json and [test](https://reqbin.com/etrbvco6) the ACI endpoint
| 13. | Notebooks | Folder structure | Review where notebooks are saved
| 14. |  | Samples | Get a sample notebook to get started
| 15. |  | IntelliSense | Show coding productivity boosters within Notebooks
| 16. |  | Terminal | Work with terminal and git
|     | AzureML SDK (v1) | (Optional) | Attendees can self-practice on the SDK v1 through the provided samples 
| 17. |  | Working with resources | Manipulate your AzureML workspace with python code
| 18. |  | Logging metrics | Explore AzureML SDK and MLflow
| 19. |  | Submit script | Execute code on a remote cluster
| 20. |  | Environments | Add code dependencies in the executing context
| 21. |  | Author pipeline | Orchestrate multiple steps in a pipeline
| 22. |  | Review pipeline endpoints | Explore the published pipeline and how to invoke via REST
| 23. |  | Parallel batch processing | Batch inference pipelines

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
- **Can I interact with unix commands in the compute instances like I would do on a local machine?** Yes, you can access [the compute instance's terminal](https://docs.microsoft.com/en-us/azure/machine-learning/how-to-access-terminal). You can even [access the terminal through VSCode](https://docs.microsoft.com/en-us/azure/machine-learning/how-to-set-up-vs-code-remote?tabs=studio).
- **Would you recommend one cluster per data scientist, or do we share the cluster?** / **Is there a way to assign a cluster to specific users or user group?** Clusters "belong" to the workspace and all users that have access to the workspace can utilize the clusters. Normally the security boundary of a workspace is around the ML project where all team members have access to the same data and compute resources. Not to be confused with Compute Instances which are dedicated to each member (as they may contain [ssh keys to access remote git repositories](https://docs.microsoft.com/azure/machine-learning/concept-train-model-git-integration)). One can [create a compute instance on behalf of another user](https://docs.microsoft.com/azure/machine-learning/how-to-create-manage-compute-instance?tabs=python#on-behalf) but can not use it.
- **Can AzureML assist me in distributed training?** Yes, the compute clusters of AzureML can support both data and model parallelism. Start from [this documentation](https://docs.microsoft.com/azure/machine-learning/concept-distributed-training) and then reach out to your [FastTrack for Azure](https://azure.microsoft.com/programs/azure-fasttrack/) Engineer owner or PM to get more technical support.
- **How do I ensure that my blob store doesn't get filled with random data overtime?** You can use [Azure Blob Storage lifecycle management](https://docs.microsoft.com/azure/storage/blobs/lifecycle-management-overview) as described in [this AzureML cost optimization article](https://docs.microsoft.com/azure/machine-learning/how-to-manage-optimize-cost#set-data-retention--deletion-policies).
- **Can one restrict access to the functionalities of the workspace?** Yes, AzureML integrates with Azure's Role Based Access Control (RBAC) model allowing you to fine tune access as seen in [this article](https://docs.microsoft.com/azure/machine-learning/how-to-assign-roles).
- **Does the AutoML have capability to process data or do we need to process the data before sending to AutoML?** AutoML offers some [featurization features](https://docs.microsoft.com/en-us/azure/machine-learning/how-to-configure-auto-features) that you can configure to automatically process the incoming data.
- **Why does AutoML show 100% sampling in the best model summary?** Sampling is automatically enabled by AutoML to [handle imbalanced data](https://docs.microsoft.com/azure/machine-learning/concept-manage-ml-pitfalls#handle-imbalanced-data) when needed. In our example, all data were used.
- **What are the best practices to version my data, since the dataset only keeps a reference to my actual files?** Have a look on [this article for guidance regarding data versioning](https://docs.microsoft.com/azure/machine-learning/how-to-version-track-datasets).
- **What is the role of Key Vault in AzureML?** If you are not using the [identity-based data access](https://docs.microsoft.com/azure/machine-learning/how-to-identity-based-data-access) option of AzureML, your datastore’s access key is stored in the associated Key Vault, thus allowing you to audit access to those secrets as seen in [this article]( https://docs.microsoft.com/azure/machine-learning/how-to-access-data). Moreover, because Key Vault is a key component of AzureML it allows you to pull secrets using the overall Azureml authentication. For example, from code, you can use [azureml.core.keyvault.Keyvault](https://docs.microsoft.com/en-us/python/api/azureml-core/azureml.core.keyvault.keyvault?view=azure-ml-py) class to pull secrets easily.
- **I want to query my corporate databases from AzureML, should I store the credentials in the Key Vault?** Although Key Vault is a great place to store credentials, I would not advice querying directly the corporate databases from within AzureML to avoid latency, potential ingestion costs, security considerations and potential accidental denial of service attack from an AzureML compute cluster that may "hammer" the database with parallel requests. Instead of that, I would advise copying the training data into an [ADLS Gen 2 using Azure Data Factory of Azure Synapse Analytics]( https://docs.microsoft.com/azure/data-factory/connector-azure-data-lake-storage?tabs=data-factory) and then read the data from there. You can read [the hitchhiker’s guide to the data lake]( https://aka.ms/adls/hitchhikersguide) for guidance and best practices organizing the files in the ADLS Gen 2.
- **Can datasets be registered programmatically?** Yes, have a look on [this notebook](./src/notebooks/010_basic_sdk.ipynb) to see how you can easily do this through the AzureML SDK.
- **How can I pass secure variables to our scripts?** Key Vault is a key component of AzureML. It allows you to pull secrets using the overall Azureml authentication. For example, from code, you can use [azureml.core.keyvault.Keyvault](https://docs.microsoft.com/en-us/python/api/azureml-core/azureml.core.keyvault.keyvault?view=azure-ml-py) class to pull secrets easily.
- **Can we run an Auto ML experiment on our compute instance instead of a cluster?** Yes you can select a compute instance instead of a cluster. You will just have to ensure that your compute instance has enough memory to load the data and run parallel model trainings.
- **Does Auto-ML take into account imbalanced datasets for classification?** Yes it does. Have a look on [this article regarding overfitting and imbalanced data](https://docs.microsoft.com/en-us/azure/machine-learning/concept-manage-ml-pitfalls).
- **Can we tweak the AutoML train/test split, cross validation etc settings?** You can configure some options regarding cross validation from the studio web interface. You have full control through the AzureML SDK, [as seen in this document](https://docs.microsoft.com/en-us/azure/machine-learning/how-to-configure-cross-validation-data-splits#prerequisites).
- **Am I able to use cognitive services in my AzureML pipelines?** Cognitive services is one of the many services you can integrate with. You just need to design your solution to be able to handle [potential throttling](https://docs.microsoft.com/en-us/azure/architecture/patterns/throttling) in case you spin up too many jobs in parallel. For example, [Bing Web Search API will return a 429 error code](https://docs.microsoft.com/en-us/bing/search-apis/bing-web-search/reference/error-codes).
- **How can I integrate with Source Version Control systems like GIT?** You can [read this article regarding git integration](https://docs.microsoft.com/azure/machine-learning/concept-train-model-git-integration) and you can also use [this template notebook](https://github.com/rndazurescript/FunWithAzureML/blob/master/GitIntegration.ipynb) if you don't want to use the terminal.
- **Can I use a Spark cluster as compute?** You can use [Synapse Spark step](https://docs.microsoft.com/en-us/azure/machine-learning/how-to-use-synapsesparkstep) or just specify `pyspark` as your target framework as seen in [this data preparation article](https://docs.microsoft.com/en-us/azure/machine-learning/how-to-data-prep-synapse-spark-pool).
- **Do I have to physically download the `config.json` file?** No, you can generate the file if you want to, as seen in the [GitHub Action of this repository](../.github/workflows/fundamentals-notebooks-ci.yml).
- **What is the difference between public and private endpoints?** Have a look on the [network security and isolation feature](https://docs.microsoft.com/en-us/azure/machine-learning/concept-enterprise-security#network-security-and-isolation) that AzureML provides.
- **Can I use Bicep instead of ARM to deploy workspace or compute instances?** The Azure Portal and the AzureML Studio offer you to download ARM templates to automate the deployment of those artifacts. You can then [decompile ARM to Bicep](https://docs.microsoft.com/en-us/azure/azure-resource-manager/bicep/decompile?tabs=azure-cli) if you want. Alternatively, you can start from the [Bicep examples we offer](https://docs.microsoft.com/en-us/azure/templates/microsoft.machinelearningservices/workspaces?tabs=bicep).
- **Can I use Terraform to deploy AzureML workspace?** Yes, you can [manage Azure Machine Learning workspaces using Terraform](https://docs.microsoft.com/en-us/azure/machine-learning/how-to-manage-workspace-terraform?tabs=publicworkspace)
- **Can I create a dataset using Apache Iceberg or Databricks Delta?** Although you can not register these files as a Tabular dataset, you can still register them as a File dataset. This will allow you to mount the files next to your scripts and then you can use python libraries to consume the data stored in these formats.
