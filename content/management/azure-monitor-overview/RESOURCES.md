# Azure Monitor

## Overview

In this session, you will learn about the different components of Azure Monitor and how you can utilize for end-to-end monitoring across your Cloud Solution. We will discuss Cloud Management capabilities and how to best use the Insights for gaining visibility of your environment, and much more.

## Agenda

* Introduction to Azure Monitor
* Activity Log and Azure Service Health
* Insights covering:
    * Application Insights
    * Virtual Machine Insights
    * Container Insights
    * Other Insights
* Log Analytics workspace design considerations
* Analysing data with log queries and metrics
* Notifications and Visualisations


## Resources and session summary

**Getting Started:**

Cloud Adoption Framework: [Cloud monitoring guide: Introduction](https://docs.microsoft.com/en-gb/azure/cloud-adoption-framework/manage/monitor/) + [Monitoring strategy for cloud deployment models](https://docs.microsoft.com/en-us/azure/cloud-adoption-framework/manage/monitor/cloud-models-monitor-overview)

Scoping monitoring with Azure services: [Link 1](http://contoso.se/blog/?p=4662), [Link 2](https://cloudbunnies.wordpress.com/2020/04/14/scoping-monitoring-with-azure-services/)

We spoke through the components of [Azure Monitor](https://docs.microsoft.com/en-us/azure/azure-monitor/overview):

*   [Azure Monitor overview](https://docs.microsoft.com/en-us/azure/azure-monitor/overview)
*   [Logs in Azure Monitor](https://docs.microsoft.com/en-us/azure/azure-monitor/platform/data-platform-logs)
*   [Azure Monitor data platform](https://docs.microsoft.com/en-us/azure/azure-monitor/platform/data-platform)
*   [Designing your Azure Monitor Logs deployment](https://docs.microsoft.com/en-us/azure/azure-monitor/platform/design-logs-deployment)
* [Azure Monitor Updates](https://aka.ms/azmonupdates)
* [Azure Monitor Documentation](https://aka.ms/MonitoringDocs)
* [Azure Monitor Skills & Courses](https://aka.ms/AzMonSkills)
* [Azure Monitor Case Studies](https://aka.ms/AzMonStories)


**Workspace Design Considerations**
* Reasons to have multiple workspaces include:
    * Different retention requirements for the same log sources for different resources, e.g. longer retention required for production resources vs non-production resources
    * Geographically dispersed resources
    * Separation of Health & Performance logs vs Security Logs.

* [Designing your Azure Monitor Logs deployment](https://docs.microsoft.com/en-us/azure/azure-monitor/logs/design-logs-deployment)
* [Design your Microsoft Sentinel workspace architecture](https://docs.microsoft.com/en-us/azure/sentinel/design-your-workspace-architecture)
* [Azure Monitor Logs data security](https://docs.microsoft.com/en-us/azure/azure-monitor/logs/data-security)



**Cross-service components**

*   We looked at [Azure Service Health](https://docs.microsoft.com/en-us/azure/service-health/) dashboard, and we mentioned that it is possible to [create service health alerts](https://docs.microsoft.com/en-us/azure/service-health/alerts-activity-log-service-notifications-portal?toc=%2Fazure%2Fservice-health%2Ftoc.json) for events.
*   We showed you the [Activity Log](https://docs.microsoft.com/en-us/azure/azure-monitor/essentials/activity-log) which shows the subscription-level events that have occurred in Azure.

**Insights and Solutions**

*   We looked at the Insights available under the Monitor banner, specifically [Application Insights](https://docs.microsoft.com/en-us/azure/azure-monitor/app/app-insights-overview), [VM Insights](https://docs.microsoft.com/en-gb/azure/azure-monitor/insights/vminsights-overview) and [Container Insights](https://docs.microsoft.com/en-gb/azure/azure-monitor/insights/container-insights-overview).
*   For Application Insights, there is a codeless (agent-based) option for [monitoring applications on-prem](https://docs.microsoft.com/en-us/azure/azure-monitor/app/status-monitor-v2-overview) as well as [applications on Azure VMs](https://docs.microsoft.com/en-us/azure/azure-monitor/app/azure-vm-vmss-apps).
* For VM Insights, data collection relies on an agent. It is possible to enable from the [Azure Monitor VM Insights blade in the portal](https://docs.microsoft.com/en-us/azure/azure-monitor/insights/vminsights-enable-single-vm), [enable the agent extension](https://docs.microsoft.com/en-us/azure/azure-monitor/vm/quick-collect-azurevm#enable-the-log-analytics-vm-extension) from the Log Analytics workspace for Azure IaaS machines or install the agent manually [on Windows](https://docs.microsoft.com/en-us/azure/azure-monitor/vm/quick-collect-windows-computer#install-the-agent-for-windows) and [on Linux](https://docs.microsoft.com/en-us/azure/virtual-machines/extensions/oms-linux?toc=/azure/azure-monitor/toc.json). You can also enable the agents [via Azure Policy](https://docs.microsoft.com/en-us/azure/azure-monitor/insights/vminsights-enable-at-scale-policy?toc=/azure/governance/policy/toc.json&bc=/azure/governance/policy/breadcrumb/toc.json).


**Data Collection**

*   Data collection for Azure resources rely on the [diagnostic settings being configured](https://docs.microsoft.com/en-us/azure/azure-monitor/platform/diagnostic-settings) to send logs and metrics to the destination of your choice. If you want to leverage off the native alerting and visualisation capabilities in Azure Monitor, the destination needs to be a Log Analytics workspace.
*   Diagnostic settings can be enabled using Azure Policy – built-in policy gallery: [List of built-in policy definitions - Azure Policy | Microsoft Docs](https://docs.microsoft.com/en-us/azure/governance/policy/samples/built-in-policies#monitoring)
*   Data Collection for virtual machines relies on an agent. There are two agents available today for this purpose: 
    * the [Microsoft Monitoring agent](https://docs.microsoft.com/en-us/azure/azure-monitor/agents/log-analytics-agent) that is used for VM Insights and global collections in the workspace (see VMInsights above). This agent will be deprecated in August 2024.
    * The [Azure Monitor Agent](https://docs.microsoft.com/en-us/azure/azure-monitor/agents/azure-monitor-agent-overview?tabs=PowerShellWindows), which is used by [Data Collection Rules](https://docs.microsoft.com/en-gb/azure/azure-monitor/agents/data-collection-rule-azure-monitor-agent) for data collection. For servers outside of Azure, the [Azure Arc-connected agent](https://docs.microsoft.com/en-us/azure/azure-arc/servers/agent-overview) is also required (more information below).
*   We showed how you can enable the [additional data sources](https://docs.microsoft.com/en-gb/azure/azure-monitor/agents/agent-data-sources) in Log Analytics, such as [Windows Event Logs](https://docs.microsoft.com/en-gb/azure/azure-monitor/agents/data-sources-windows-events), [Performance Counters](hhttps://docs.microsoft.com/en-gb/azure/azure-monitor/agents/data-sources-performance-counters) and [custom log files](https://docs.microsoft.com/en-gb/azure/azure-monitor/agents/data-sources-custom-logs).
* We showed you how to configure [Data Collection Rules](https://docs.microsoft.com/en-gb/azure/azure-monitor/agents/data-collection-rule-azure-monitor-agent) for discreet data collection.

**Notifications and Visualisations**

*   We mentioned that it is possible to configure [Alerts](https://docs.microsoft.com/en-us/azure/azure-monitor/alerts/alerts-overview), which have a variety of outputs or [Action Groups](https://docs.microsoft.com/en-us/azure/azure-monitor/alerts/action-groups), including email, SMS, web hooks, runbooks and the ITSM connector. It is even possible to use [Logic Apps](https://docs.microsoft.com/en-gb/azure/azure-monitor/app/automate-with-logic-apps) or [Azure Automation Runbooks](https://azure.microsoft.com/en-us/blog/using-azure-automation-to-take-actions-on-azure-alerts/) to automate alert responses.
* You can use [Alert Processing Rules](https://docs.microsoft.com/en-us/azure/azure-monitor/alerts/alerts-action-rules?tabs=portal) to suppress alerts during specific windows, or run bulk actions across alerts.
*   We mentioned [Azure Monitor Workbooks](https://docs.microsoft.com/en-us/azure/azure-monitor/platform/workbooks-overview) which can be used to create visual reports. These can then be pinned to an Azure Dashboard.

**Query Language**

To create workbooks, dashboards and alerts, you will need to be comfortable with the query language, Kusto . Here is some information on queries to get you started:

*   [Get started with log queries in Azure Monitor](https://docs.microsoft.com/en-us/azure/azure-monitor/log-query/get-started-queries)
*   [Azure Monitor log queries](https://docs.microsoft.com/en-us/azure/azure-monitor/log-query/query-language)
*   [Azure Monitor log query examples](https://docs.microsoft.com/en-us/azure/azure-monitor/log-query/examples)
*   [Writing efficient log queries](https://docs.microsoft.com/en-us/azure/azure-monitor/log-query/log-query-performance)
*   [Log data ingestion time in Azure Monitor](https://docs.microsoft.com/en-us/azure/azure-monitor/platform/data-ingestion-time)

**Integrations**

*   [Azure Monitor partner integrations](https://docs.microsoft.com/en-us/azure/azure-monitor/platform/partners)
*   [How to trigger complex actions with Azure Monitor alerts](https://docs.microsoft.com/en-us/azure/azure-monitor/platform/action-groups-logic-app)
*   [Connect Azure to ITSM tools using IT Service Management Connector](https://docs.microsoft.com/en-us/azure/azure-monitor/platform/itsmc-overview)

**Hybrid Management**

Azure Arc for Servers allows you to manage your Windows and Linux servers hosted outside of Azure, e.g. on-prem or other clouds, using the same capabilities as you have within Azure. Specifically, this covers using Azure Policy for compliance and configuration management, as well as enriching the experience with using Azure Monitor and Azure Automation Update Management.

*   [Azure Arc enabled servers Overview - Azure Arc | Microsoft Docs](https://docs.microsoft.com/en-us/azure/azure-arc/servers/overview)
*   [Connect hybrid machine with Azure Arc enabled servers - Azure Arc | Microsoft Docs](https://docs.microsoft.com/en-us/azure/azure-arc/servers/learn/quick-enable-hybrid-vm)
