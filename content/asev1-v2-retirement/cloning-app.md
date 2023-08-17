# Migrate ASE v1 / v2 to ASE v3 by Cloning Your App

#### [home](./readme.md) | [prev](./backup-restore.md) | [next](./redeploy.md)

Cloning your apps is another feature that can be used to get your Windows apps onto your App Service Environment v3.

- This feature is **only** supported on Windows App Services

## Clone Your App to Your ASE v3
- Go to the Clone App blade of the existing App Service that you wish to migrate to your ASE v3 environment. The Clone App blade can be found under the Development Tools section of the navigation menu.
- Select an existing Resource Group or select Create new
- Enter a name for the new application. This name can be the same as the old app, but note the site's default URL using the new environment will be different. You'll need to update any custom DNS or connected resources to point to the new URL.
- Choose whether or not to clone your deployment source
- Select a Windows App Service Plan from the list which will be populated with the existing App Service Plans from your ASE v3 environment or select Create new
- Click Clone
- Cloning an app can take up to 30 minutes to complete
