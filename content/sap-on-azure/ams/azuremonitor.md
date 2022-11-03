# Understanding how Azure Monitor works

#### [prev](./introduction.md) | [home](./readme.md)  | [next](./businesscase.md)

## How does Azure Monitor work?
It all starts with collecting telemetry. Azure Monitor can collect data from Application, Network, Infrastructure and you can also ingest your own custom data. All the data is stored in centralized, fully managed logs and metrics stores.

![](/content/sap-on-azure/images/azuremonitor.png) </br></br>

So what can you do with all the data: </br></br>

1. Typically you start with insights which are end to end experiences we have put together for canonical scenarios or resources such as applications, containers, VMs, network, storage etc. Insights provide guidance and help troubleshoot and root cause issues quickly with a drill down experience.

2. You may in certain cases, just want to visualize the data. For that we provide Azure dashboards, Power BI integrations and a more native experience called Workbooks.

3. After visualizing the data, you may form some hypothesis and want to test them out. For that you need access to the raw data stores. For that we provide metrics explorer and a powerful big data platform called Log Analytics that is capable of querying petabytes of data within seconds.

4. If you want to pro-active and take corrective actions, you can create alerts and runbooks to auto remedy an issue. Or if it’s a capacity issue, you can choose to scale-in or scale-out.

5. Finally, we know that monitoring isn’t done is silos. Azure Monitor provides out of the box integration with popular ITSM and DevOps tools. You can again use APIs, EventHub and Logic Apps to build custom integrations.



---
## Additional Information
  * [Azure Monitor](https://learn.microsoft.com/en-us/azure/azure-monitor/overview)
