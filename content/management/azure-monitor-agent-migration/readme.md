# Azure Monitor - Migration from Legacy Agents to Azure Monitor Agent

## Overview
In this session, learn how to plan and approach your migration from the legacy Microsoft Monitoring Agent/OMS Agent to the Azure Monitor Agent, where used with Azure Monitor and other services.

## Agenda

* Migration Approach
* Additional Considerations
* Tools to use

## Session Summary

When planning the migration, it is important to understand your current environment, and your monitoring strategy. If you do not currently have a well defined monitoring strategy, this is a good time to revisit this.
* [Cloud Monitoring Strategy guidance](https://learn.microsoft.com/en-us/azure/cloud-adoption-framework/strategy/monitoring-strategy)

### Migration approach
* **Understand your agents**
    * How many agents do you have to migrate?
    * Do you have agents residing outside of Azure?
        * You will need to deploy the Azure Arc agent to these servers first
    * Are you using System Center Operations Manager (SCOM)?
        * Start evaluating SCOM Managed Instance
    * How are you deploying agents today?


* **Understand your workspaces**
    * Are all your workspaces in use?
    * Is now a good time to do a cleanup?


* **Understand your data collections**
    * Are you using any legacy solutions for data collection?
    * Do you have any data collections configured in the workspace(s)?
        * Use the DCR generator tool to create Data Collection Rules from your current data collections


* **Understand additional dependencies**
    * Are you using any of the following:
        * Update Management
            * Migrate to Azure Update Manager
        * Change Tracking and Inventory
            * Migrate to the AMA-based Change Tracking and Inventory solution
        * Defender for Cloud - Plan 2?
            * Change your agent deployments in Defender for Cloud to the agentless scanning approach
            * If you are using Defender for Cloud to collect Security Events, create a custom DCR to collect with AMA
            * If you are using Defender for SQL and have SQL installed on Virtual machines, enable auto-deployment of the AMA to these servers.
        * Microsoft Sentinel?
            * Change to the AMA-based data collections in Sentinel


**Tools to use**:
* [AMA Migration Helper workbook](https://portal.azure.com/#view/Microsoft_Azure_Monitoring/AzureMonitoringBrowseBlade/~/workbooks)
* [Guidance for using the AMA Migration Helper workbook](https://learn.microsoft.com/en-us/azure/azure-monitor/agents/azure-monitor-agent-migration-helper-workbook)
* [DCR Config Generator](https://learn.microsoft.com/en-us/azure/azure-monitor/agents/azure-monitor-agent-migration-data-collection-rule-generator)
* [MMA Discovery and Removal Utility](https://learn.microsoft.com/en-us/azure/azure-monitor/agents/azure-monitor-agent-mma-removal-tool)
* [MMA Removal Script](https://github.com/ElanShudnow/AzureCode/tree/main/PowerShell/AzMMARemoval) (Community owned)
* [Workspace Audit Workbook](https://github.com/microsoft/AzureMonitorCommunity/tree/master/Azure%20Services/Log%20Analytics%20workspaces/Workbooks)
* [SCOM Management MP](https://kevinholman.com/2017/05/09/scom-management-mp-making-a-scom-admins-life-a-little-easier/)


## Additional Resources

### Azure Monitor Agent resources
* [Migrate to Azure Monitor Agent from Log Analytics agent](https://learn.microsoft.com/en-us/azure/azure-monitor/agents/azure-monitor-agent-migration)
* [Tools for migrating from Log Analytics Agent to Azure Monitor Agent](https://learn.microsoft.com/en-us/azure/azure-monitor/agents/azure-monitor-agent-migration-tools)
* [Azure Monitor Agent - Supported Services and Features](https://learn.microsoft.com/en-us/azure/azure-monitor/agents/agents-overview#supported-services-and-features)

### Data Collection
* [Data collection rules (DCRs) in Azure Monitor](https://learn.microsoft.com/en-us/azure/azure-monitor/essentials/data-collection-rule-overview)
* [Create and edit data collection rules (DCRs) and associations in Azure Monitor](https://learn.microsoft.com/en-us/azure/azure-monitor/essentials/data-collection-rule-create-edit?tabs=portal)

### Azure Arc
* [What is Azure Arc-enabled servers?](https://learn.microsoft.com/en-us/azure/azure-arc/servers/overview)
* [Plan and deploy Azure Arc-enabled servers](https://learn.microsoft.com/en-us/azure/azure-arc/servers/plan-at-scale-deployment)
* [Connected Machine agent network requirements](https://learn.microsoft.com/en-us/azure/azure-arc/servers/network-requirements?tabs=azure-cloud)


### SCOM Managed Instance
* [About Azure Monitor SCOM Managed Instance](https://learn.microsoft.com/en-us/azure/azure-monitor/scom-manage-instance/overview)
* [Tutorial: Create an instance of Azure Monitor SCOM Managed Instance](https://learn.microsoft.com/en-us/azure/azure-monitor/scom-manage-instance/tutorial-create-scom-managed-instance)

### Update Management Center
* [About Update management center](https://learn.microsoft.com/en-us/azure/update-center/overview)
* [How Update Manager works](https://learn.microsoft.com/en-us/azure/update-manager/workflow-update-manager?tabs=azure-vms%2Cupdate-win)
* [Overview of migration from Automation Update Management to Azure Update Manager](https://learn.microsoft.com/en-us/azure/update-manager/migration-overview?tabs=update-mgmt#azure-portal-experience-preview)

### Change Tracking and Inventory
* [Overview of change tracking and inventory using Azure Monitoring Agent](https://learn.microsoft.com/en-us/azure/automation/change-tracking/overview-monitoring-agent?tabs=win-az-vm)
* [Enable Change Tracking and Inventory using Azure Monitoring Agent](https://learn.microsoft.com/en-us/azure/automation/change-tracking/enable-vms-monitoring-agent?tabs=singlevm%2Carcvm)
* [Migration guidance from Change Tracking and inventory using Log Analytics to Change Tracking and inventory using Azure Monitoring Agent version](https://learn.microsoft.com/en-us/azure/automation/change-tracking/guidance-migration-log-analytics-monitoring-agent?tabs=ct-single-vm%2Climit-single-vm)

### Microsoft Sentinel
* [AMA migration for Microsoft Sentinel](https://learn.microsoft.com/en-us/azure/sentinel/ama-migrate)
* [Create, Edit, and Monitor Data Collection Rules with the Data Collection Rule Toolkit for Sentinel](https://techcommunity.microsoft.com/t5/microsoft-sentinel-blog/create-edit-and-monitor-data-collection-rules-with-the-data/ba-p/3810987)

### Defender for Cloud
* [Plan agents, extensions and Azure Arc for Defender for Servers](https://learn.microsoft.com/en-us/azure/defender-for-cloud/plan-defender-for-servers-agents)
* [Defender for Cloud - Prepare for retirement of the Log Analytics agent](https://learn.microsoft.com/en-us/azure/defender-for-cloud/prepare-deprecation-log-analytics-mma-agent)
* [Enable Microsoft Defender for SQL servers on machines](https://learn.microsoft.com/en-us/azure/defender-for-cloud/defender-for-sql-usage)

### Unified Assessments
* [Migrate On-Demand Assessments from MMA to AMA](https://learn.microsoft.com/en-us/services-hub/unified/health/migration)
