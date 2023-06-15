# Recap Azure ISE to Logic Apps Standard Migration

#### [home](./readme.md) | [prev](./deploy.md)

Integration Service Environment will retire on August 31, 2024. **After August 31, 2024**, customers will no longer have access to their deployed ISE instances. **Any workflows that are running on those instances will no longer be executed and any run history associated with those workflows will also be removed**. Any integration account associated to an ISE instance will also be removed.

A set of tools has been created for Visual Studio Code to assist you in migrating your Integration Service Environment to Logic Apps Standard. These tools will assist you with the following steps in your migration.

1. Export your existing workflows from an ISE to a Logic App Standard project.
1. Run, test, and debug your migrated workflows locally.
1. Deploy your migrated workflows to Azure.

Please leverage these tools to make sure that you have migrated all of your workflows from your Integration Service Environments to Logic App Standard by August 31, 2024.