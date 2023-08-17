# Migrate ASE v1 / v2 to ASE v3 by Redploying Your App

#### [home](./readme.md) | [prev](./cloning-app.md) | [next](./recap.md)

If the automated migration feature or performing a backup and restore or cloning your app does not meet your needs, you can manually create your apps on your ASE v3 environment and then redeploy them.

- You can use the Export Template feature to generate the necessary ARM templates to recreate the infrastructure for your app such as its App Service and App Service Plan by following the steps documented [here](https://learn.microsoft.com/en-us/azure/app-service/environment/migration-alternatives#manually-create-your-apps-on-an-app-service-environment-v3).
- Once you have recreated your App Service and App Service Plan in your ASE v3 environment, update your existing CI / CD processes to redeploy your application code to the newly created App Service in your ASE v3 environment.