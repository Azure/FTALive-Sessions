## Collect SAP HANA audit logs in Microsoft Sentinel (Preview)
#### [prev](./SentinelIntegrationwithRise.md) | [home](./introduction.md)
Microsoft Sentinel SAP HANA support is currently in **PREVIEW**. 

### Collect SAP HANA audit logs

- If your SAP HANA database audit logs are configured with Syslog, you must also configure the Log Analytics agent to collect Syslog files.
- Ensure that SAP HANA audit log trail is configured to use Syslog as described in `SAP Note 0002624117`.
- Check your operating system Syslog files for any relevant HANA database events.
- Install and configure a Log Analytics agent on your machine:
  - Sign in to your HANA database operating system as a user with sudo privileges.
  - In the Azure portal, go to your Log Analytics workspace. On the left pane, under Settings, select Agents management > Linux servers.
  - Under Download and onboard agent for Linux, copy the code that's displayed in the box to your terminal, and then run the script.
- The Log Analytics agent is installed on your machine and connected to your workspace. For more information, see Install Log Analytics agent on Linux computers and OMS Agent for Linux on the Microsoft GitHub repository.
- Refresh the Agents Management > Linux servers tab to confirm that you have 1 Linux computers connected.
- On the left pane, under Settings, select Agents configuration, and then select the Syslog tab.
- In Microsoft Sentinel, check to confirm that HANA database events are now shown in the ingested logs.
Select Add facility to add the facilities you want to collect.
[Collect SAP HANA audit logs in Microsoft Sentinel (Preview)](https://learn.microsoft.com/en-us/azure/sentinel/sap/collect-sap-hana-audit-logs)

#### [prev](./SentinelIntegrationwithRise.md) | [home](./introduction.md)
