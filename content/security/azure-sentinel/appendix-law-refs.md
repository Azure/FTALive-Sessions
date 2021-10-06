# Appendix: FastTrack for Azure Azure Sentinel on Azure Log Analytics Workspace considerations

## What is Azure Log Analytics Workspace? visit [this](Pre-requisites.md#log-analytics) link

This Appendix will have additional reference URLs where you can find Azure Log Analytics Workspace articles as it pertains to Azure Sentinel, use cases, considerations, etc.

_NOTE: Please review the latest best practices design guide prior to familiarizing yourself with these links._

* Understanding Geographical availability and data residency as it pertains to Azure Sentinel - [link](https://docs.microsoft.com/en-us/azure/sentinel/quickstart-onboard#geographical-availability-and-data-residency)

    **NOTE**: Do pay close consideration should you have data sovereignty requirements with the Azure Log Analytics workspaces are available in multiple geographies and how Azure Sentinel will observe that sovereignty.

* **MUST Learn and biggest customer faced challenges**: KQL (Kusto Query Language) when working with Azure Sentinel as its main data store is Azure Log Analytics Workspace. There are _free_ great KQL video based material within the webinar series and Azure Sentinel training.
  * Security Community Webinars - [link](https://techcommunity.microsoft.com/t5/microsoft-security-and/security-community-webinars/ba-p/927888)
  * Become an Azure Sentinel Ninja - [link](https://techcommunity.microsoft.com/t5/azure-sentinel/become-an-azure-sentinel-ninja-the-complete-level-400-training/ba-p/1246310)
  * Microsoft Learning Path... SC-200 part 5: Configure your Azure Sentinel environment - [link](https://docs.microsoft.com/en-us/learn/paths/sc-200-configure-azure-sentinel-environment/)

* Cost. In addition to the [Azure cost calculator for Azure Sentinel](https://azure.microsoft.com/en-us/pricing/details/azure-sentinel/) cost is important and how to understand this via a Workbook to visualize your cost ingestion data - [link](https://techcommunity.microsoft.com/t5/azure-sentinel/ingestion-cost-alert-playbook/ba-p/2006003)

* Understanding how Azure Log Analytics Workspaces and its agent work with a major component, i.e. Syslog, will allow you to determine if your Syslog collector is a single point of failure or not - [link](https://docs.microsoft.com/en-us/azure/sentinel/connect-data-sources#agent-connection-options)
  * Do note there is a VMSS ARM template within the Azure Sentinel GitHub Community repo that can increase your Syslog SLA - [link](https://github.com/Azure/Azure-Sentinel/tree/master/DataConnectors/CEF-VMSS)

* Compliance requirements need for long term retention for Azure Sentinel logs can be performed using Azure Data Explorer (do note there are cost implications that you will need to evaluate) - [link](https://techcommunity.microsoft.com/t5/azure-sentinel/using-azure-data-explorer-for-long-term-retention-of-azure/ba-p/1883947)

* Large data store ( >1TB / day) for Azure Sentinel and/or you have multiple Azure Sentinel workspaces? You should consider reviewing dedicated clusters for your Azure Log Analytics Workspace - [link](https://techcommunity.microsoft.com/t5/azure-sentinel/what-s-new-dedicated-clusters-for-azure-sentinel/ba-p/2072539)

* Azure Sentinel and Ingestion Delays may play mind tricks on you. Remember that you are working with streaming data and date & time have to be top of mind when scheduling your alert rules in KQL queries - [link](https://techcommunity.microsoft.com/t5/azure-sentinel/handling-ingestion-delay-in-azure-sentinel-scheduled-alert-rules/ba-p/2052851)