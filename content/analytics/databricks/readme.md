# Welcome to the FastTrack for Azure Live Databricks Security Session
## We will start 1-2 minutes after the scheduled time to accommodate those still connecting


This call will not be recorded due to the wide audience and to encourage questions.

**Questions?** Feel free to type them in the chat window at any time. Note that questions you post will be public.

**Slideless** No PowerPoint, we promise! As we update this content (http://aka.ms/ftalive-adlsmig) you will get the changes straight away.

Please give us your feedback on https://aka.ms/ftalive-feedback


## Databricks Security

## <img src="Assets/images/databrickssecurity.png" alt="Databricks Security" style="float: left; margin-right:10px;" />

When you set up your Azure Databricks workspace(s) and related services, you need to make sure that security considerations do not take a back seat during the architecture design, deployment and while you’re working with your workspace, notebooks and data. In this session you will learn about the different ways you can secure your Azure Databricks environment from a networking, workspace, cluster, and data perspective. You will learn about applying a security baseline to your Azure Databricks enviornment, how to prevent data exfiltration, how to hide secrets, how to inject Databricks clusters into a managed Vnet, the best practices for securing your workspaces and securing the underlying data that either resides in Azure Data Lake or Delta Lake/Tables.  

The goal of this session will be to inform, influence and train those involved in securing Azure Databricks environments, and show you how to take a layered approach to securing Databricks within Azure. 

It will be delivered by Microsoft FastTrack for Azure engineers. Bring your questions!

## Agenda
* Intro
  * [Databricks Architecture (Control Pland and Data Plan)](https://docs.microsoft.com/en-us/azure/databricks/getting-started/overview)
  * [Security Baseline](https://docs.microsoft.com/en-us/security/benchmark/azure/baselines/databricks-security-baseline?toc=/azure/databricks/toc.json)
* Access Control
  * [Workspace Access Control](https://docs.microsoft.com/en-us/azure/databricks/security/access-control/workspace-acl)
  * [Cluster, Pool and Jobs Access Control](https://docs.microsoft.com/en-us/azure/databricks/security/access-control/cluster-acl)
  * [Delta Live Tables Access Control](https://docs.microsoft.com/en-us/azure/databricks/security/access-control/dlt-acl)
  * [Secret Access Control](https://docs.microsoft.com/en-us/azure/databricks/security/access-control/secret-acl)
* Network Security Options
  * [No Public IP](https://docs.microsoft.com/en-us/azure/databricks/security/secure-cluster-connectivity)
  * [IP Access List](https://docs.microsoft.com/en-us/azure/databricks/security/network/ip-access-list)
  * [VNet Injection](https://docs.microsoft.com/en-us/azure/databricks/administration-guide/cloud-configurations/azure/vnet-inject)
  * etc.
* [Securing the underlying data in ADLS Delta Tables](https://github.com/hurtn/datalake-ADLS-access-patterns-with-Databricks/blob/master/readme.md)
* [Monitoring/Auditing Access](https://docs.microsoft.com/en-us/azure/databricks/administration-guide/account-settings/azure-diagnostic-logs)
* FAQs
* Who to turn to for support?
* QA

You will need:
* Microsoft Teams desktop client or Teams web client to view presentation.
* Optional headphones to make it easier to listen to and interact with the presenters.