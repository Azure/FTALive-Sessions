# Migrate ASE v1 / v2 to ASE v3 Using the App Service Backup and Restore Feature

#### [home](./readme.md) | [prev](./automated-migration.md) | [next](./cloning-app.md)

The Azure App Service Backup and Restore feature can be used to restore a custom backup created from your current ASE v1 / v2 to a new ASE v3 environment.

- You must configure custom backups for the application that you wish to restore to your ASE v3 environment. Automatic backups do not support restoration to different App Service Environment versions.
- Prior to restoring the application you must create the App Service you will restore to in your ASE v3 environment. You can choose to restore the production slot, another existing slot, or a new slot that you create during the restoration process.

## Configure Custom Backups
- Go to the Backups blade of the existing App Service that you wish to migrate to your ASE v3 environment.
- Select Configure custom backups
- Select an existing Storage Account or select Create New
- Select an existing Container or select Create New
- Once the storage account and container have been configured, you can initiate an on-demand backup at any time.
- At the top of the Backups blade select Backup Now

## Restore Backup to your ASE v3
- Go to the Backups blade of the existing App Service that you wish to migrate to your ASE v3 environment.
- Click the Restore link next to the custom backup you created earlier
- Select the App Service in your ASE v3 environment that you wish to restore the backup to in the Choose Destination section
- Select an existing slot or select Create New to choose the deployment slot you wish to restore the backup to in the Choose Destination section
- Under Advanced Options select whether you wish to restore your site configuration
- Click Restore
- It can take up to 30 minutes for the restore to complete