## Operating Sentinel for SAP
#### [prev](./Pricing.md) | [home](./introduction.md)  | [next](./SentinelIntegrationwithRise.md)
### Incident Response

Here are some examples of possible threat scenarios to SAP application and how to respond to them.

#### Scenario 1. Use and Monitoring of Privileged Users
  
In most security incidents, attackers use high-privileged users to control systems. Commonly known built-in account is often targeted by attackers and should be monitored. If there are other highly privileged accounts that are frequently used in operations, their use should be tracked. 
Log in to the SAP system with some user with system administration privileges. These users are users who have a high-privilege profile "SAP_ALL" that allows them to perform all operations within the SAP system.

1. Log in to the SAP system with the following users in order.

    - Superuser `SAP*` in the SAP system  
      *Special user created when SAP is installed
    - ABAP Dictionary administrative user `DDIC`  
      *Special user created when SAP is installed
    - User `BPINST` who has granted authority profile "SAP_ALL" to general users (dialog users)
    - These users are managed in the Watchlist `SAP - Privileged Users`

2. Check the logs that record user logins in Microsoft Sentinel. This log is stored in a table called `ABAPAuditLog_CL`. This table is further enriched with a function called `SAPAuditLog` and referenced in analysis rules.

3. Privileged user logins are regularly analyzed by the analysis rule `SAP - Sensitive Privileged User Logged in`.
  This analysis rule will generate an incident when a login of a user registered in the Watchlist `SAP - Privileged Users` occurs.
  
4. Make sure that the incident `SAP - Sensitive Privileged User Logged in` is generated.
  Incidents contain the logged-in user, computer, IP address, and SAP system information as the relevant entity.

#### Scenario 2. Execution and monitoring of sensitive transactions 

A malicious user pretending to be a system administrator logs on to the SAP system as 'BPINST' which has system administration privileges `(SAP_ALL, S_A.SYSTEM)`. This user runs the transaction code that the system administrator runs on SAP system. System-managed transaction codes are subject to security monitoring as they indicate significant changes.
  
  1. On the SAP system, execute transaction code "RSAU_CONFIG, SM20, SE38, SE37, RZ10, RZ11", which are assumed to be operated by system administrator. Each code has the following meaning:
      - Trying to disable the audit log setting by running `T-cd: RSAU_CONFIG`. If the audit log is no longer recorded, important transaction histories (audit trail) that occurs on own SAP system will be lost.
      - By running `T-cd: SM20` and spying on the operation (Dialog logon, RFC/CPIC logon, RFC function module call, transaction start, report start, user master change, etc) corresponding to the message ID indicated in [Recommended audit categories](https://learn.microsoft.com/en-us/azure/sentinel/sap/configure-audit) recorded in the audit log, for example, information on linkage with external systems Other than SAP system connection information with other systems may be intercepted.
      - Execute `T-cd: SE38 (ABAP editor)` and execute report programs related to financial accounting, for example **RFBVOR00 – List of intercompany transactions, RFBUST10 – Intercompany transfer posting** to view transaction status at document item level between group companies and intercompany the execution of automatic posting processing of transactions, etc. may result in a serious incident related to the company's financial results.
      - By executing `T-cd: SM37 (General Module Builder)`, malicious general modules may be programmed.
      - Execute `T-cd: RZ10 (Change profile parameters)` and `RZ11 (Update profile parameters)` to change important settings that control the operation of the entire SAP system, restart the SAP system while online, and can be rendered unbootable. It may seriously damage the stable operation of the system. Also, deliberately manipulating the profile parameter **(login/fails_to_user_lock)** that controls account locking by the number of times a dialog user fails to enter a password can prevent a user from accessing own SAP system.
      - These transaction codes are maintained in the Watchlist `SAP - Sensitive Transactions` on Sentinel Workspace.

  2. On the SAP system, execute `SM20` and confirm that the transaction code executed above is recorded in own SAP audit log.

  3. Check the logs that record user logins in Microsoft Sentinel. This log is stored in a table called `ABAPAuditLog_CL`.

  4. Analytics rules `SAP - Execution of a Sensitive Transaction Code` is executing analysis every 5 minutes.
    This analytics rule generates an incident when a transaction listed in the Watchlist `SAP - Sensitive Transactions` is recorded.

  5. If the analytics rule finds a transaction code, an incident `SAP - Execution of a Sensitive Transaction Code` is generated.

  6. The generated incident has the information of the associated entity. In addition to the user who performed this transaction, past incidents with the same entity can be investigated from the same UI.

#### Scenario 3. Viewing and monitoring sensitive tables

SAP systems have tables that store sensitive information. These tables are typically used by applications, but attackers may refer to them directly to quickly obtain information of interest. SAP solution can monitor access to these sensitive tables.

A user **BPINST** with system administration privileges may access the table `USR02` that manages logon data on the SAP system, and read (theft) the last logon date and time of a specific user, the password hash value, etc. In addition, the table `PA0008: HR Master Record` that manages the employee's basic salary may be accessed to view the salary data and the employee's personal data may be leaked.

1. On SAP, execute transaction code `SE38` and execute ABAP program `/1BCDWB/DBUSR02` to access table `USR02` that manages user logon data. 
 This table contains **the most recent logon dates and value of password hashes**.

2. On SAP, execute transaction code `SE16` and access table `PA0008`.  
 This table maintains employee base salary information.

3. Sensitive table information is maintained in Watchlist `SAP - Sensitive Tables`.

4. Direct access to sensitive tables is analyzed by the analytics rule `SAP - Sensitive Tables Direct Access By RFC Logon` and an incident is generated.

#### Scenario 4. Execution and monitoring of sensitive ABAP programs

ABAP programs perform various operations, for example history operations (delete log) for change document objects are performed from ABAP programs. By accessing `Change documents` that record and manage changes and updates to business data (objects), important business logs related to corporate audits may be deleted.

1. On SAP, run the transaction code `SE38` and specify ABAP program `RSCDOK99` to run the Delete Change Documents program. This operation will delete the change document of sales order object `VERKBELEG` used for auditing.

2. These transaction codes are maintained in the Watchlist `SAP - Sensitive ABAP Programs` on Sentinel Workspace.

3. The analytics rule `SAP - Execution of a Sensitive ABAP Program` is monitoring the execution of a sensitive ABAP program and an incident is generated.

**Related information**  </br></br>
[Enable and configure SAP auditing for Microsoft Sentinel](https://learn.microsoft.com/en-us/azure/sentinel/sap/configure-audit?source=recommendations)
</br>
#### [prev](./Pricing.md) | [home](./introduction.md)  | [next](./SentinelIntegrationwithRise.md)

