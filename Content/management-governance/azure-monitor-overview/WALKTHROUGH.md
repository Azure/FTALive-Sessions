#### [home](README.md)

# Walkthrough

# [Activity Logs](https://docs.microsoft.com/en-us/azure/azure-monitor/platform/activity-log)

* Audit control plane operations
* Insight into subscription-level events
* Examples include when a resource is modified or a VM is started
* 90 days retention out-of-the-box, with no configuration (send to Logs, Storage Account or Event Hub for longer retention)

## Demo

* **Filter** Timespan: 90 days --> Subscriptions --> Event severity
* **Quick Insights (last 24 hrs)**
* **Errors** [Change history (Preview)](https://docs.microsoft.com/en-us/azure/azure-monitor/platform/activity-log#view-change-history) --> Alert --> Action Group
* **Filter** Resource group: todoapp-rg --> Pin to [Azure Portal Dashboards](https://docs.microsoft.com/en-us/azure/azure-portal/azure-portal-dashboards#:~:text=%20Create%20and%20share%20dashboards%20in%20the%20Azure,want%20to%20copy.%20In%20the%20page...%20More%20)
* **Diagnostic Settings** --> Log Analytics Workspace / Storage Account / Event Hub

# [Metrics](https://docs.microsoft.com/en-us/azure/azure-monitor/platform/data-platform-metrics)

* Lightweight, capable of near-real time scenarios such as alerting
* Numeric data in a time-series database (essentially performance counters)
* Ideal for fast detection of issues
* Collected at regular intervals
* Types include [Platform Metrics](https://docs.microsoft.com/en-us/azure/azure-monitor/platform/data-platform-metrics), [Guest Metrics](https://docs.microsoft.com/en-us/azure/azure-monitor/platform/diagnostics-extension-overview), [Custom Metrics](https://docs.microsoft.com/en-us/azure/azure-monitor/platform/metrics-store-custom-rest-api)
* Up to 93 days retention out-of-the-box, with no configuration (send to Logs, Storage Account or Event Hub for longer retention)

## Demo

* **Chart 1 - DTU** Title: ToDo App DB - Avg [DTU](https://docs.microsoft.com/en-us/azure/azure-sql/database/resource-limits-dtu-single-databases#single-database-storage-sizes-and-compute-sizes) Limit --> Local Time: 30 days --> Scope: SQL Databases --> DTU Limit --> Area chart --> Pin to [Azure Portal Dashboards](https://docs.microsoft.com/en-us/azure/azure-portal/azure-portal-dashboards#:~:text=%20Create%20and%20share%20dashboards%20in%20the%20Azure,want%20to%20copy.%20In%20the%20page...%20More%20)
* **Chart 2 - DTU** Title: ToDo SQL Database - [DTU](https://docs.microsoft.com/en-us/azure/azure-sql/database/resource-limits-dtu-single-databases#single-database-storage-sizes-and-compute-sizes) Used --> Local Time: 30 days --> Scope: SQL Databases --> DTU Used --> Area chart --> Pin to [Azure Portal Dashboards](https://docs.microsoft.com/en-us/azure/azure-portal/azure-portal-dashboards#:~:text=%20Create%20and%20share%20dashboards%20in%20the%20Azure,want%20to%20copy.%20In%20the%20page...%20More%20)
* **Chart 1 - DWU** Title: ToDo Synapse Database - [DWU](https://docs.microsoft.com/en-us/azure/synapse-analytics/sql-data-warehouse/what-is-a-data-warehouse-unit-dwu-cdwu) Limit --> Local Time: 30 days --> Scope: SQL Databases --> DTU Limit --> Area chart --> Pin to [Azure Portal Dashboards](https://docs.microsoft.com/en-us/azure/azure-portal/azure-portal-dashboards#:~:text=%20Create%20and%20share%20dashboards%20in%20the%20Azure,want%20to%20copy.%20In%20the%20page...%20More%20)
* **Chart 2 - DWU** Title: ToDo Synapse Database - [DWU](https://docs.microsoft.com/en-us/azure/synapse-analytics/sql-data-warehouse/what-is-a-data-warehouse-unit-dwu-cdwu) Used --> Local Time: 30 days --> Scope: SQL Databases --> DTU Used --> Area chart --> Pin to [Azure Portal Dashboards](https://docs.microsoft.com/en-us/azure/azure-portal/azure-portal-dashboards#:~:text=%20Create%20and%20share%20dashboards%20in%20the%20Azure,want%20to%20copy.%20In%20the%20page...%20More%20)
* **Chart 1 - Platform metric - VM Standard Namespace - Percentage CPU**
* **Chart 2 - Guest metric - VM Guest Namespace - /Memory/Available MBytes** Configure VM [Diagnostics](https://docs.microsoft.com/en-us/azure/azure-monitor/platform/collect-custom-metrics-guestos-resource-manager-vm?toc=/azure/virtual-machines/windows/toc.json&bc=/azure/virtual-machines/windows/breadcrumb/toc.json)
* **Diagnostic Settings** --> Log Analytics Workspace / Storage Account / Event Hub

# [Logs](https://docs.microsoft.com/en-us/azure/azure-monitor/platform/data-platform-logs)

* Azure Monitor stores log data in a Log Analytics workspace for trending analysis, alerting, and visualization
* Support a variety of data sources e.g. diagnostics, application logs, heartbeats, event logs
* Up to 730 days retention (use [Log Analytics workspace data export in Azure Monitor (preview) via CLI or REST request](https://docs.microsoft.com/en-us/azure/azure-monitor/platform/logs-data-export) for longer retention)
* [Kusto Query Language](https://docs.microsoft.com/en-us/azure/data-explorer/kusto/query/) --> Pin to [Azure Portal Dashboards](https://docs.microsoft.com/en-us/azure/azure-portal/)

## Demo

* Diagnostics setting --> todoapp-rg --> coreDB
* Log Analytics Workspace --> Design, RBAC, Retention
* Data Sources
* Solutions / Workspace summary
* KQL examples --> [Power BI](https://docs.microsoft.com/en-us/azure/azure-monitor/platform/powerbi) / Excel

# [Service Health](https://docs.microsoft.com/en-us/azure/service-health/)

* Service backend health
* Resource health
* Health history
* Planned maintenance
* Health advisories
* Security advisories

## Demo

* [Personalised health map for a critical application](https://docs.microsoft.com/en-us/azure/service-health/service-health-overview#pin-a-personalized-health-map-to-your-dashboard) --> Pin to [Azure Portal Dashboards](https://docs.microsoft.com/en-us/azure/azure-portal/) 
* [Service issue, Planned maintenance, Health advisory, Security advisory alerts](https://docs.microsoft.com/en-us/azure/service-health/alerts-activity-log-service-notifications-portal)

# [Workbooks](https://docs.microsoft.com/en-us/azure/azure-monitor/platform/workbooks-overview)

* Flexible canvas
* Interactive report
* [Multiple data sources](https://docs.microsoft.com/en-us/azure/azure-monitor/platform/workbooks-overview#data-sources)
* [Multiple visualisations](https://docs.microsoft.com/en-us/azure/azure-monitor/platform/workbooks-overview#visualizations)

## Demo

* VM Key Metrics
* [Tabs and Groups](https://github.com/microsoft/Application-Insights-Workbooks/blob/master/Documentation/Groups/Groups.md)

# [Alerting](https://docs.microsoft.com/en-us/azure/azure-monitor/platform/alerts-overview)

* Alert on many signals including Metric values, Log search queries, Activity log events, Health of the underlying Azure platform, Tests for website availability, etc

## Demo

* [Create an alert rule](https://docs.microsoft.com/en-us/azure/azure-monitor/platform/alerts-overview#create-an-alert-rule)
* [Create an action group](https://docs.microsoft.com/en-us/azure/azure-monitor/platform/action-groups)
* [Implement alert suppression for resource group scope with an action rule](https://docs.microsoft.com/en-us/azure/azure-monitor/platform/alerts-action-rules?tabs=portal)
* [Smart groups](https://docs.microsoft.com/en-us/azure/azure-monitor/platform/alerts-smartgroups-overview)

# [Insights](https://docs.microsoft.com/en-us/azure/azure-monitor/insights/insights-overview)

* Customized monitoring experience for particular applications and services
* Collect and analyze both logs and metrics
* Implemented through workbooks (mostly)
* Insights is replacing log analytics [solutions](https://docs.microsoft.com/en-us/azure/azure-monitor/monitor-reference#core-solutions)

## Demo

* [VM] --> Performance: Groups, Workbooks | Service Map
* [Storage] --> Transactions | Capacity
* [Networks] --> Connection Monitor

# [Application Insights](https://docs.microsoft.com/en-us/azure/azure-monitor/app/app-insights-overview)

* Extensible Application Performance Management (APM) service for developers and DevOps professionals
* Monitor live metrics
* Automatically detects performance anomalies
* Powerful analytics tools to help diagnose issues and understand what users do
* Designed to help continuously improve performance and usability
* Works for apps on a wide variety of platforms including .NET, Node.js, Java, and Python hosted on-premises, hybrid, or any public cloud 

## Demo based on [SmartHotel360 Reference Apps](https://github.com/microsoft/smarthotel360) (Application Insights Resource: CH-RetailAppAI)

* Overview | Application dashboard
* Investigate | Application map
* Investigate | Full stack performance diagnostics
* Investigate | Failure detection & debugging
* Investigate | Live stream
* Investigate | Smart detection
* Monitoring | Alert management
* Usage | Users
* Usage | User Flows
* Usage | Retention
* Monitoring | Workbooks
* Overview | Monitor resource group
# [Autoscale](https://docs.microsoft.com/en-us/azure/azure-monitor/platform/autoscale-overview)

* Autoscale to right-size resources to handle application load
* Save money by removing idle resources
* Azure Monitor autoscale applies to [VMSS](https://azure.microsoft.com/services/virtual-machine-scale-sets/), [Cloud Services](https://azure.microsoft.com/services/cloud-services/), [App Service - Web Apps](https://azure.microsoft.com/services/app-service/web/), [API Management services](https://docs.microsoft.com/en-us/azure/api-management/api-management-key-concepts), and [Azure Data Explorer Clusters](https://docs.microsoft.com/en-us/azure/data-explorer/)
* Autoscale rule types:
    * **Metric-based** eg, do this action when CPU usage is above 50%
    * **Time-based** eg, trigger a webhook every 8am on Saturday in a given time zone

## Demo

* [Autoscale quickstart](https://docs.microsoft.com/en-us/azure/azure-monitor/learn/tutorial-autoscale-performance-schedule)
* VMSS Example

# [Traffic Analytics](https://docs.microsoft.com/en-us/azure/network-watcher/traffic-analytics)

* Visibility into user and application activity in cloud networks
* Analyzes network security group (NSG) flow logs
* Visualize network activity across Azure subscriptions and identify hot spots
* Identify security threats with information such as open-ports, applications attempting internet access, and VMs connecting to rogue networks
* Understand traffic flow patterns across Azure regions and the internet to optimize network deployments for performance and capacity
* Pinpoint network misconfigurations leading to failed connections

## Demo

* Connection monitor (Preview) --> Pin to [Azure Portal Dashboards](https://docs.microsoft.com/en-us/azure/azure-portal/)
* Display Units Flows/Bytes/Packets
* Log search query
* Malicious flow search
* View map --> Active regions --> Hover for Bytes in/outbound
* View VNets
* View subnets

# [Azure Resource Graph Explorer](https://docs.microsoft.com/en-us/azure/governance/resource-graph/)

* Resource exploration
* Query at scale across a set of subscriptions to effectively govern Azure
* Used by portal search, all resources, Azure Security Center, etc
* Query resources with complex filtering, grouping, and sorting by resource properties
* Explore resources based on governance requirements
* Assess the impact of applying policies in a vast cloud environment
* Detail changes made to resource properties (preview)
* [Kusto Query Language Starter](https://docs.microsoft.com/en-us/azure/governance/resource-graph/samples/starter?tabs=azure-cli)

## Demo

* **Example query 1** resources | where resourceGroup == 'todoapp-rg' or resourceGroup == 'datademos-rg' | project name,type,location,sku --> Pin to [Azure Portal Dashboards](https://docs.microsoft.com/en-us/azure/azure-portal/azure-portal-dashboards#:~:text=%20Create%20and%20share%20dashboards%20in%20the%20Azure,want%20to%20copy.%20In%20the%20page...%20More%20)
* **Example query 2** resources | where resourceGroup == 'todoapp-rg' or resourceGroup == 'datademos-rg' | summarize count() by type --> Chart --> Pin to [Azure Portal Dashboards](https://docs.microsoft.com/en-us/azure/azure-portal/azure-portal-dashboards#:~:text=%20Create%20and%20share%20dashboards%20in%20the%20Azure,want%20to%20copy.%20In%20the%20page...%20More%20)
* **Example query 3** resourcecontainers | where type == 'microsoft.resources/subscriptions'
* All Resources
* Azure Security Center Inventory

# Tips

* [Azure Resource Graph Explorer](https://docs.microsoft.com/en-us/azure/governance/resource-graph/) queries are case-sensitive
* Do not define [Azure Resource Graph Explorer](https://docs.microsoft.com/en-us/azure/governance/resource-graph/) queries using 'formatted result' view, as the column names and/or values may be different
* Use [Azure Resource Graph Explorer](https://docs.microsoft.com/en-us/azure/governance/resource-graph/) queries as data sources for parameters in [Workbooks](https://docs.microsoft.com/en-us/azure/azure-monitor/platform/workbooks-overview)	
* Do not use multiple browser tabs when working with [Azure Portal Dashboards](https://docs.microsoft.com/en-us/azure/azure-portal/azure-portal-dashboards#:~:text=%20Create%20and%20share%20dashboards%20in%20the%20Azure,want%20to%20copy.%20In%20the%20page...%20More%20)
* Use [diagnostic settings](https://docs.microsoft.com/en-us/azure/azure-monitor/platform/activity-log#send-to-log-analytics-workspace) to retain [Activity Logs](https://docs.microsoft.com/en-us/azure/azure-monitor/platform/activity-log) for longer than 90 days
* Use [Metrics](https://docs.microsoft.com/en-us/azure/azure-monitor/platform/data-platform-metrics) for performance alerts rather than [Logs](https://docs.microsoft.com/en-us/azure/azure-monitor/platform/data-platform-logs) as [Logs](https://docs.microsoft.com/en-us/azure/azure-monitor/platform/data-platform-logs) can have an ingestion delay
* [Metrics](https://docs.microsoft.com/en-us/azure/azure-monitor/platform/data-platform-metrics) configuration is lost once we navigate away from configured metric charts in Azure Monitor - Pin to an [Azure Portal Dashboard](https://docs.microsoft.com/en-us/azure/azure-portal/azure-portal-dashboards#:~:text=%20Create%20and%20share%20dashboards%20in%20the%20Azure,want%20to%20copy.%20In%20the%20page...%20More%20), use the **Share** then **Copy link** option on the configuration page, or add the metrics to a [Workbook](https://docs.microsoft.com/en-us/azure/azure-monitor/platform/workbooks-overview) in order to use configured metrics later
* Configure VM [Guest Metric Diagnostics](https://docs.microsoft.com/en-us/azure/azure-monitor/platform/collect-custom-metrics-guestos-resource-manager-vm?toc=/azure/virtual-machines/windows/toc.json&bc=/azure/virtual-machines/windows/breadcrumb/toc.json) or [Logs](https://docs.microsoft.com/en-us/azure/azure-monitor/platform/data-sources-performance-counters) for custom performance counters
* Programmatically create [Resource Health](https://docs.microsoft.com/en-us/azure/service-health/resource-health-alert-arm-template-guide), [Metric](https://docs.microsoft.com/en-us/azure/azure-monitor/platform/alerts-metric), [Logs](https://docs.microsoft.com/en-us/azure/azure-monitor/platform/alerts-log) alerts at scale using PowerShell, CLI or ARM
* Refer to the [optimise log alert guidance](https://docs.microsoft.com/en-us/azure/azure-monitor/platform/alerts-log-query) when creating log alert queries
* Use the log analytics extension rather than the log analytics agent in order to have automated updates - refer to the [agent comparison tables](https://docs.microsoft.com/en-us/azure/azure-monitor/platform/agents-overview) for more information
* Create [personalised health maps for applications using service health](https://docs.microsoft.com/en-us/azure/service-health/service-health-overview#pin-a-personalized-health-map-to-your-dashboard)
* Use [Workload health](https://docs.microsoft.com/en-us/azure/azure-monitor/platform/workbooks-data-sources#workload-health) and [Resource health](https://docs.microsoft.com/en-us/azure/azure-monitor/platform/workbooks-data-sources#azure-resource-health) data sources in workbooks to pin 'traffic light' health indicators on [Azure Portal Dashboards](https://docs.microsoft.com/en-us/azure/azure-portal/azure-portal-dashboards#:~:text=%20Create%20and%20share%20dashboards%20in%20the%20Azure,want%20to%20copy.%20In%20the%20page...%20More%20)
* Customise [Workbooks](https://docs.microsoft.com/en-us/azure/azure-monitor/platform/workbooks-overview) using [Workbook templates](https://docs.microsoft.com/en-us/azure/azure-monitor/platform/workbooks-overview#workbooks-versus-workbook-templates)
* Refer to [Workbook documentation and examples on Github](https://github.com/microsoft/Application-Insights-Workbooks/tree/master/Documentation)
* [Use a webhook to configure health notifications for problem management systems](https://docs.microsoft.com/en-us/azure/service-health/service-health-alert-webhook-guide)
* Use [Autoscale](https://docs.microsoft.com/en-us/azure/azure-monitor/platform/autoscale-overview) to increase or decrease resources based on a metric value crossing a threshold

#### [home](README.md)
