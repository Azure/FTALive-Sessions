# Run, Test, and Debug Your Migrated Workflows Locally

#### [home](./readme.md) | [prev](./vs-code-extension.md) | [next](./deploy.md)

To test your migrated Logic App, follow these steps to start a debugging session, and find the URL for the endpoint that's created by the Request trigger. You need this URL so that you can later send a request to that endpoint.

1. If you are debugging a stateless workflow, follow the instructions [here](https://learn.microsoft.com/en-us/azure/logic-apps/create-single-tenant-workflows-visual-studio-code#enable-run-history-stateless) to enable run history which will make it easier to debug your workflow.
1. Make sure your Azurite storage emulator is running
   - In Visual Studio Code, from the View menu, select Command Palette.
   - After the command palette appears, enter Azurite: Start.
1. Select Start Debugging from the Run menu in the Visual Studio Code Activity Bar.
   - The Terminal window will open so you can monitor the debugging session.
1. Find the callback URL for the endpoint on the Request trigger.
1. Use Postman or another tool for creating and sending requests to trigger the logic app  workflow by sending a request to the callback URL.
1. Return to the workflow's overview page in Visual Studio Code to review the workflow's Run History.

A detailed walkthrough of this process can be found [here](https://learn.microsoft.com/en-us/azure/logic-apps/create-single-tenant-workflows-visual-studio-code#run-test-and-debug-locally).