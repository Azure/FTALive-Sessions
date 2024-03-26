## Deploy SAP data connector agent

#### [prev](./SAPConfig.md) | [home](./introduction.md)  | [next](./SentinelConfig.md)
For the Microsoft Sentinel solution for SAP® applications to operate correctly, you must first get your SAP data into Microsoft Sentinel. To accomplish this, you need to deploy the solution's SAP data connector agent.

The data connector agent runs as a container on a Linux virtual machine (VM). This VM can be hosted either in Azure, in a third-party cloud, or on-premises.

The agent connects to your SAP system to pull logs and other data from it, then sends those logs to your Microsoft Sentinel workspace. 

### Preparing Linux machine
  - Prepare a Linux machine for deploying the Data Connector Agent. Linux machines can be VM on Azure or physical and virtual machines running on-premises or in other clouds.
    - Ubuntu 18.04 or higher
    - SLES version 15 or higher
    - RHEL version 7.7 or higher

[Deploy and configure the container hosting the SAP data connector agent](https://learn.microsoft.com/en-us/azure/sentinel/sap/deploy-data-connector-agent-container?tabs=managed-identity)

### Authentication Methods

The agent has to connect/authenticate with SAP system to pull logs and other data from it, then sends those logs to your Microsoft Sentinel workspace.

Your SAP authentication mechanism, and where you deploy your VM, will determine how and where your agent configuration information, including your SAP authentication secrets, is stored. These are the options, in descending order of preference:

- An Azure Key Vault, accessed through an Azure system-assigned managed identity
- An Azure Key Vault, accessed through an Azure AD registered-application service principal
- A plaintext configuration file

#### Create a Key Vault
  - Create a Key Vault to store credentials for connecting to SAP applications.
  - Access to KeyVault is controlled by system-assigned managed identities (Azure VM) or registered application service principals (non-Azure VM).
 
#### Plaintext configuration file

- If your SAP authentication is done using SNC and X.509 certificates, your only option is to use a configuration file.
- Deploy the agent connector container using configuration file by following the [link](https://learn.microsoft.com/en-us/azure/sentinel/sap/deploy-data-connector-agent-container?tabs=config-file%2Cazure-portal)

### Deploy data connector agent

  - Transfer [SAP NetWeaver SDK](https://me.sap.com/swdcproduct/%20_APP=00200682500000001943&_EVENT=DISPHIER&HEADER=Y&FUNCTIONBAR=N&EVENT=TREE&NE=NAVIGATE&ENR=01200314690100002214&V=MAINT&TA=ACTUAL&PAGE=SEARCH/SAP%20NW%20RFC%20SDK) to your Linux machine.
  - Run the Kickstart script.
    - Specify SAP application and KeyVault to connect to in the Kickstart script.
  - Configure the container for the data connector to start automatically.



**Related information** </br>

[Data Connector Agent Configuration](https://learn.microsoft.com/en-us/azure/sentinel/sap/deploy-data-connector-agent-container?tabs=managed-identity#managed-identity)

[Kickstart script reference](https://learn.microsoft.com/en-us/azure/sentinel/sap/reference-kickstart)

[Update Microsoft Sentinel's SAP data connector agent](https://learn.microsoft.com/en-us/azure/sentinel/sap/update-sap-data-connector)
</br>
#### [prev](./SAPConfig.md) | [home](./introduction.md)  | [next](./SentinelConfig.md)
