## Characteristics of Microsoft Sentinel solution for SAP® applications

#### | [home](./introduction.md)  | [next](./SAPConfig.md)

In order to detect threats, it is necessary to consider the unique characteristics of the **Microsoft Sentinel solution for SAP® applications**. For example, an SAP solution should at least know:

- Knowledge of SAP applications
- What attack techniques are available against SAP applications
- What logs does the SAP application generate?
- How to analyze logs to find threats

**Microsoft Sentinel solution for SAP® applications** is a [Microsoft Sentinel solution](https://learn.microsoft.com/en-us/azure/sentinel/sentinel-solutions) that you can use to monitor your SAP systems and detect sophisticated threats throughout the business logic and application layers.


The solution includes the following components:

- The Microsoft Sentinel for SAP data connector for data ingestion.
- Analytics rules and watchlists for threat detection.
- Functions for easy data access.
- Workbooks for interactive data visualization.
- Watchlists for customization of the built-in solution parameters.
- Playbooks for automating responses to threats.

The Microsoft Sentinel for SAP data connector is an agent, installed on a VM or a physical server that collects application logs from across the entire SAP system landscape. It then sends those logs to your Log Analytics workspace in Microsoft Sentinel. You can then use the other content in the Threat Monitoring for SAP solution – the analytics rules, workbooks, and watchlists – to gain insight into your organization's SAP environment and to detect and respond to security threats.

![SAP Diagram](/content/sap-on-azure/images/SAP-diagram.png)

### Special (SAP Solution) data connector

SAP solution provide special data connectors to collect logs from SAP applications. A data connector is a mechanism for extracting logs from log sources and connecting them to Sentinel's data store. Data connectors for SAP solutions are designed as containers running on Linux and can be deployed anywhere, on-premises or in the cloud.

SAP applications generate several important logs and our data connector regularly collects these logs, transforms them into an easy-to-analyze format, and stores them in Microsoft Sentinel's data store (Log Analytics).

### Dedicated analysis rules

In order to discover threats to SAP applications, it is necessary to have both knowledge of the mechanisms of SAP applications and knowledge of attacks that exploit those mechanisms. Since SAP solutions contain many analysis rules for detecting threats, even organizations that do not have mature security monitoring operations and do not have the know-how to maintain analysis rules can simply deploy the solution. so, you can immediately start security monitoring with.

SAP applications are complex and have different analytical aspects. For example, important privileged users and important transactions may change very frequently in operations and analysis rules need to be updated accordingly. 

In the SAP solution, you can customize the objects to be analyzed that change from day to day with a special table called Watchlist. It is designed so that analysts can concentrate on developing analysis rules and operators can maintain updated monitoring targets without going into complicated analysis rules.

#### | [home](./introduction.md)  | [next](./SAPConfig.md)
