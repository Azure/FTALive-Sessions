## Configuring Microsoft Sentinel
#### [prev](./DataConnector.md) | [home](./introduction.md)  | [next](./Scenarios.md)
### Deploy solutions for SAP application on Microsoft Sentinel

#### Deploying analytics rules
  Analysis rules are a mechanism for finding important security incident's logs from aggregated logs and creating security alerts. Detected security alerts can also create security incidents. A security incident is a framework for assigning a person in charge and managing the lifecycle until it is closed, and has a UI for efficient investigation and a function for recording the investigation status.
  Over 50 analytics rules are provided by default according to the following groups:

  - Initial access
  - Data exfiltration
  - Persistency
  - Attempts to bypass SAP security mechanisms
  - Suspicious privileges operations
  
  A list of analysis rules can be found in the following document: 
  [Built-in analytics rules](https://learn.microsoft.com/en-us/azure/sentinel/sap/sap-solution-security-content#built-in-analytics-rules)

#### Watchlist configuration
  Some analysis rules target specific systems for monitoring, and some analyze specific processes and subjects such as important programs, users, and transactions. In the SAP solution, these analysis conditions are extracted outside the rules as a Watchlist. By using these watchlists, you can maintain the analysis rule detection target and exclusion conditions without directly changing the analysis rule. 
  Maintenance of conventional analysis rules required deep knowledge of KQL, but with simple maintenance, even personnel without knowledge of KQL can easily maintain detection logic (programs). You can customize the following aspects of SAP without changing your code:
  - SAP systems, Networks, Users to be monitored or excluded from monitoring
  - Important ABAP programs, Transactions, Function modules, Profiles, Tables, Roles
  - Old programs and Function modules, FTP server
  - System parameters, Critical authorization objects

  [Available watchlists](https://learn.microsoft.com/en-us/azure/sentinel/sap/sap-solution-security-content#available-watchlists)

#### Deploy workbooks
  Four workbooks are provided as dashboards to visualize security events related to SAP application.

  - Audit log browser
  - Operation with suspicious privileges
  - Access that attempts to bypass SAP's security mechanisms
  - Persistence to SAP, exporting large amounts of data

A list of available workbooks along with it's detailed functionality can be found in the following document: [Monitoring Workbooks](https://techcommunity.microsoft.com/t5/microsoft-sentinel-blog/microsoft-sentinel-sap-continuous-threat-monitoring-workbooks/ba-p/3015630)
</br>

**Related information**  </br>
[Microsoft Sentinel solution for SAP® applications: security content reference](https://learn.microsoft.com/en-us/azure/sentinel/sap/sap-solution-security-content#available-watchlists)
</br>
#### [prev](./DataConnector.md) | [home](./introduction.md)  | [next](./Scenarios.md)
