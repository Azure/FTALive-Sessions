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
* Understand your agents
    * How many agents do you have to migrate?
    * Do you have agents residing outside of Azure??
    * Are you using System Center Operations Manager (SCOM)?
    * How are you deploying agents today?
* Understand your workspaces
    * Are all your workspaces in use?
    * Is now a good time to do a cleanup?
* Understand your data collections
    * Are you using any legacy solutions for data collection?
    * Do you have any data collections configured in the workspace(s)?
* Understand additional dependencies
    * Are you using any of the following:
        * Update Management?
        * Change Tracking and Inventory
        * Defender for Cloud?
        * Microsoft Sentinel?


Tools to use:
* AMA Migration Tracker workbook
* DCR Config Generator
* [SCOM Management MP](https://kevinholman.com/2017/05/09/scom-management-mp-making-a-scom-admins-life-a-little-easier/)


## Additional Resources
* [Migrate to Azure Monitor Agent from Log Analytics agent](https://learn.microsoft.com/en-us/azure/azure-monitor/agents/azure-monitor-agent-migration)
* [Tools for migrating from Log Analytics Agent to Azure Monitor Agent](https://learn.microsoft.com/en-us/azure/azure-monitor/agents/azure-monitor-agent-migration-tools)
* [Azure Monitor Agent - Supported Services and Features](https://learn.microsoft.com/en-us/azure/azure-monitor/agents/agents-overview#supported-services-and-features)
* [What is Azure Arc-enabled servers?](https://learn.microsoft.com/en-us/azure/azure-arc/servers/overview)
* [About Azure Monitor SCOM Managed Instance (preview)](https://learn.microsoft.com/en-us/system-center/scom/operations-manager-managed-instance-overview?view=sc-om-2022)
* [About Update management center (preview)](https://learn.microsoft.com/en-us/azure/update-center/overview)
* [Enable Change Tracking and Inventory using Azure Monitoring Agent (Preview)](https://learn.microsoft.com/en-us/azure/automation/change-tracking/enable-vms-monitoring-agent?tabs=singlevm)
* [AMA migration for Microsoft Sentinel](https://learn.microsoft.com/en-us/azure/sentinel/ama-migrate)