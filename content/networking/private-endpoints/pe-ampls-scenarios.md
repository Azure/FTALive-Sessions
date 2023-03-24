# Special Case - Azure Monitor and Azure Monitor Private Link Scopes

Azure Monitor takes a different approach when implementing Private Endpoints than many other Azure services because all Azure Monitor customers share the same Azure Monitor DNS names when accessing the service. Because of this, the public DNS resolution for the Azure Monitor service domain names need to work for both public and Private Endpoint customers.

## How Azure Monitor Implements Private Endpoints

When you want to make your Azure Monitor resources--such as a Log Analytics Workspace--accessible only over a Private Endpoint, you need to create an Azure Monitor Private Link Scope. 

![Azure Monitor Private Link Scope Topology](img/ampls-basic-topology.png)