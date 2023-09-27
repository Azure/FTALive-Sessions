## Deploying Microsoft Sentinel solution for SAP® applications

#### [prev](./SentinelSAPSolution.md) | [home](./introduction.md)  | [next](./DataConnector.md)

### SAP configuration

#### Prerequisites for SAP environment

[Prerequisites for deploying Microsoft Sentinel solution for SAP® applications](https://learn.microsoft.com/en-us/azure/sentinel/sap/prerequisites-for-deploying-sap-continuous-threat-monitoring#create-and-configure-a-role-required)

- Supported SAP versions: SAP_BASIS version 731 or later recommended
- SAP NetWeaver RFC SDK 7.50 for SAP data connector connections [Download here](https://me.sap.com/notes/2573790)
- User on the SAP ABAP side that can be used by SAP data connector agent

All the following procedures are performed in the SAP environment.

- Create a role
  - Create a role to enable the SAP data connector to connect to your SAP system.
    - Deploy "CR:NPLK900271 (K900271.NPL, R900271.NPL)" or by loading the role authorizations from the [MSFTSEN_SENTINEL_CONNECTOR_ROLE_V0.0.27.SAP file](https://github.com/Azure/Azure-Sentinel/tree/master/Solutions/SAP/Sample%20Authorizations%20Role%20File).
    - Depending on the version of SAP Basis (740 or 750 or later), additionally deploy the CR described in [Retrieve additional information from SAP (optional)](https://learn.microsoft.com/en-us/azure/sentinel/sap/prerequisites-for-deploying-sap-continuous-threat-monitoring#retrieve-additional-information-from-sap-optional). `*Although it is described as "optional", please apply it`.

- Install SAP NOTE
  - Install SAP NOTE [2641084 - Standardized read access to data of Security Audit Log](https://me.sap.com/notes/2641084)
- Deploy CRs
- Download and expand the target CR in the SAP environment.
  - Notice that each CR consists of two files, one starting with K (Co-file) and the other starting with R (data file).
  - Copy the cofiles and data files to the transport directory (/usr/sap/trans/cofiles & /usr/sap/trans/data respectively).  
- Import CRs [T-cd: STMS_IMPORT].
- Configuring Roles
  - Once the Import of CR NPLK900271 is completed, a role called `/MSFTSEN/SENTINEL_CONNECTOR` is created in the SAP environment.
  - Generate a profile for the role created via CR **NPLK900271** from [T-cd: PFCG].
- Create a user
  - Create a user for Sentinel connection on the SAP environment. (Please choose username as per your naming convention)
  - Assign the `MSFTSEN/SENTINEL_CONNECTOR` role created above to the user you created.

- Background Job
  - Ensure Standard Background Job SAP_COLLECTOR_FOR_PERFMONITOR is running on the SAP Application under 000 client with DDIC User.


**Related Information** </br>
[Deploy SAP Change Requests and configure authorization](https://learn.microsoft.com/en-us/azure/sentinel/sap/preparing-sap)  


### Configure SAP System Auditing

- Sign in to the SAP GUI and run the RSAU_CONFIG transaction.

- In the Security Audit Log screen, select Parameter under Security Audit Log Configuration section in Configuration tree.

- If the Static security audit active checkbox is marked, system-level auditing is turned on. If it isn't, select Display <-> Change and mark the Static security audit active checkbox.

- By default, the SAP system logs the client name (terminal ID) rather than client IP address. If you want the system to log by client IP address instead, mark the Log peer address not terminal ID checkbox in the General Parameters section.

- If you changed any settings in the Security Audit Log Configuration - Parameter section, select Save to save the changes. Auditing will be activated only after the server is rebooted.


**More information** </br>
[Recommended SAP Audit Categories](https://learn.microsoft.com/en-us/azure/sentinel/sap/configure-audit#recommended-audit-categories)
</br>
#### [prev](./SentinelSAPSolution.md) | [home](./introduction.md)  | [next](./DataConnector.md)
