# Why Should I Migrate to Logic Apps Standard?

#### [home](./readme.md) | [prev](./readme.md) | [next](./migration-process.md)

- Integration Service Environment has a dependency on Azure Cloud Services (classic), which is being retired at the end of August 2024. ISE will retire at the same date.
- **After August 31, 2024**, customers will no longer have access to their deployed ISE instances. **Any workflows that are running on those instances will no longer be executed and any run history associated with those workflows will also be removed**. Any integration account associated to an ISE instance will also be removed.

## Benefits of Upgrading
- Aligns logic apps workflows used at enterprise level, especially those have compute or network isolation requirements, to the larger application PaaS ecosystem. As Logic Apps Standard runs on top of App Services, it benefits from the improvements that are implemented to the larger application ecosystem. 
- Same level of connector execution isolation provided by ISE connectors, thanks to built-in connectors, which run as part of the workflow runtime engine, and provides the same level of network connectivity and on-premises access available with ISE connectors. 
- Logic Apps Standard share the same granular and elastic scaling that other PaaS tools based on App Services provide. You can define a rich scaling profile, that reacts fast to increase in load and scales down once the load returns to normal values. This fast reaction to changes in demand can lead to cost improvements.
- Logic Apps Standard provides a new development experience, supporting local development, including local execution, debugging, and improved support for source control and automated deployment. With the new application structure, where a group of workflows can be deployed as a single unit in a Logic Apps Standard app, you can also fully separate infrastructure deployment from code logic. 