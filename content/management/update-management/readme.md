# Update management

## Overview

In this session, you will learn about using Update Management in Azure.

## Agenda

* Update Management in Azure Automation
* Update Management Center (Preview)


## Resources and session summary

We spoke through the capabilities of the [Azure Automation Update Management](https://docs.microsoft.com/en-us/azure/automation/update-management/overview) solution:
* This solution relies on an Azure Automation account as well as a Log Analytics workspace.
    * [Supported regions for linked Log Analytics workspace](https://docs.microsoft.com/en-us/azure/automation/how-to/region-mappings)
    * You can [on-board Azure VMs](https://docs.microsoft.com/en-us/azure/automation/update-management/enable-from-portal) from the portal.
    * Non-Azure machines rely on the Microsoft Monitoring Agent being deployed and configured to report to the Log Analytics workspace associated with the solution. 
* There is an agent for both [Windows](https://docs.microsoft.com/en-us/azure/azure-monitor/agents/agent-windows) and [Linux](https://docs.microsoft.com/en-us/azure/azure-monitor/agents/agent-linux)
    * [Supported Linux operating systems](https://docs.microsoft.com/en-us/azure/azure-monitor/agents/agents-overview#linux)
    * [Install the Linux agent using wrapper script](https://docs.microsoft.com/en-us/azure/azure-monitor/agents/agent-linux#install-the-agent-using-wrapper-script)
	* [Install the Windows agent using the command line](https://docs.microsoft.com/en-us/azure/azure-monitor/agents/agent-windows#install-the-agent-using-the-command-line)
	* [Manage updates for multiple machines](https://docs.microsoft.com/en-us/azure/automation/update-management/manage-updates-for-vm)
	* [Manage pre and post-scripts](https://docs.microsoft.com/en-us/azure/automation/update-management/pre-post-scripts)
* You can integrate [SCCM/Microsoft Endpoint Configuration Manager with Update Management](https://docs.microsoft.com/en-us/azure/automation/update-management/mecmintegration)
* [Configure Windows Update settings for Update Management](https://docs.microsoft.com/en-us/azure/automation/update-management/configure-wuagent)
* [Use dynamic groups with Update Management](https://docs.microsoft.com/en-us/azure/automation/update-management/configure-groups)
* [Query Azure Automation Update Management logs | Microsoft Docs](https://docs.microsoft.com/en-us/azure/automation/update-management/query-logs)
