# Azure Arc-enabled Servers

Thank you for joining our session on [Azure Arc-enabled servers](https://docs.microsoft.com/en-us/azure/azure-arc/servers/overview). Herewith some resources to get you started:

*   Azure Arc enabled servers enables you to use the Azure Management capabilities, such as Azure Policy, Change Tracking and Inventory, etc on your servers hosted outside of Azure in the same way that you use for Azure-hosted machines
*   You need to deploy [an agent](https://docs.microsoft.com/en-us/azure/azure-arc/servers/agent-overview) to the servers to be managed
    *   The agent communicates outbound over TCP port 443, but can be configured to use a proxy for outbound communication, review [network configuration](https://docs.microsoft.com/en-us/azure/azure-arc/servers/agent-overview#networking-configuration) requirements
    *   For testing purposes, you can onboard one or two servers using an interactive script, which can be generated using the portal: [Connect hybrid machines to Azure from the Azure portal - Azure Arc | Microsoft Docs](https://docs.microsoft.com/en-us/azure/azure-arc/servers/onboard-portal)
    *   For larger scale deployments, you will need to create a Service Principal account, and then use this in the at-scale script you can generate in the portal: [Connect hybrid machines to Azure at scale - Azure Arc | Microsoft Docs](https://docs.microsoft.com/en-us/azure/azure-arc/servers/onboard-service-principal)
*   These at-scale scripts can be used in your standard deployment methods, such as SCCM, Ansible, etc

Additional learning resources:

*   [Introduction to Azure Arc enabled servers - Learn | Microsoft Docs](https://docs.microsoft.com/en-us/learn/modules/intro-to-arc-for-servers/)
*   [Overview | Azure Arc Jumpstart](https://azurearcjumpstart.io/overview/)
*   [Overview of Azure Arc enabled servers - YouTube](https://www.youtube.com/watch?v=2KbILoO3rqc)

Interactive Demos:

*   [Onboarding a server to Azure Arc (octe.azurewebsites.net)](https://octe.azurewebsites.net/Microsoft/viewer/71/index.html#/0/0.)
*   [Using Azure Policy with Arc enabled servers (octe.azurewebsites.net)](https://octe.azurewebsites.net/Microsoft/viewer/68/index.html#/0/0)
*   [Extensions and logs for Arc enabled servers (octe.azurewebsites.net)](https://octe.azurewebsites.net/Microsoft/viewer/72/index.html#/)