# AMS 2.0 Architecture (Public Preview)

#### [prev](./businesscase.md) | [home](./introduction.md)  | [next](./features.md)

![image](https://user-images.githubusercontent.com/102125916/197119980-2e2acd96-2bc1-487f-8c9b-525acc67948e.png)




* The architecture is **multi-instance**. You can monitor multiple instances of a given component type across multiple SAP systems (SID) within a virtual network with a single resource of AMS. For example, you can monitor HANA databases, high availability (HA) clusters, Microsoft SQL server, SAP NetWeaver, etc.

* The architecture is **multi-provider**. The architecture diagram shows the SAP HANA provider as an example. Similarly, you can configure more providers for corresponding components to collect data from those components. For example, HANA DB, HA cluster, Microsoft SQL server, and SAP NetWeaver.

* The architecture has an extensible query framework. Write [SQL queries to collect data in JSON]([https://github.com/Azure/AzureMonitorForSAPSolutions/blob/master/sapmon/content/SapHana.json](https://github.com/Azure/AzureMonitorForSAPSolutions/blob/master/sapmon/content/SapHana.json)). Easily add more SQL queries to collect other data.

## The key components of the architecture are

1. The **Azure portal**, where you access the AMS service.

2. The **AMS resource**, where you view monitoring data.

3. The **managed resource group**, which is deployed automatically as part of the AMS resource's deployment. The resources inside the managed resource group help to collect data. Key resources include:

4. An **Azure Functions** resource that hosts the monitoring code. This logic collects data from the source systems and transfers the data to the monitoring framework.

5. An **Azure Key Vault** resource, which securely holds the SAP HANA database credentials and stores information about providers.

6. The **Log Analytics workspace**, which is the destination for storing data. Optionally, you can choose to use an existing workspace in the same subscription as your AMS resource at deployment.
