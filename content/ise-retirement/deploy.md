# Deploy Your Migrated Workflows to Azure

#### [home](./readme.md) | [prev](./connect-integration-account-to-workflow.md) | [next](./recap.md)

Once you have completed testing and debugging your migrated workflows locally you can deploy them to Azure using Visual Studio Code or a CI / CD tool such as Azure DevOps.

## Deploy from Visual Studio Code
1. From the Visual Studio Code Activity Bar select the Azure icon to open the Azure extension window.
1. From the toolbar in the Workspace section, select Deploy > Deploy to Logic App.
1. Follow the prompts to deploy your workflows to an existing Logic Apps Standard instance or create a new Logic Apps Standard instance.

A detailed walkthrough of this process can be found [here](https://learn.microsoft.com/en-us/azure/logic-apps/create-single-tenant-workflows-visual-studio-code#deploy-to-azure).

## Deploy from Azure DevOps
1. Build your project. The bundle-based project created by the Visual Studio Code Extension isn't language specific and doesn't require any language specific build steps. You simply need to zip all of the project files using any method you choose.
   - **Important:** Make sure that your .zip file contains the actual build artifacts, including all workflow folders, configuration files such as host.json, connections.json, and any other related files.
1. Before releasing to Azure follow the steps documented [here](https://learn.microsoft.com/en-us/azure/logic-apps/set-up-devops-deployment-single-tenant-azure-logic-apps?tabs=azure-devops#before-release-to-azure) to update the Authentication Type and create any API connections needed.
1. In your release pipeline use the Azure Function App Deploy Task to deploy your Logic Apps Standard to Azure. More details can be found [here](https://learn.microsoft.com/en-us/azure/azure-functions/functions-how-to-azure-devops?view=azure-devops&tabs=csharp%2Cyaml&pivots=v1).
1. Each API connection has access policies. After the zip deployment completes, you must open your logic app resource in the Azure portal, and create access policies for each API connection to set up permissions for the deployed logic app. The zip deployment doesn't create app settings for you. So, after deployment, you must create these app settings based on the local.settings.json file in your local Visual Studio Code project. 
