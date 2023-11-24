# Scale Azure Container Apps Using KEDA Integration: Storage Queues

This demo is based off the [Scale Azure Container Apps Using KEDA Integration](https://techcommunity.microsoft.com/t5/fasttrack-for-azure/scale-azure-container-apps-using-keda-integration/ba-p/3674861) blog post on Tech Community. This demo contains the C# console application and bicep code required to set up the demo environment, and run the demo.

## Create your Azure Resources

The Bicep template will provision the following resources:

- Log Analytics workspace
- Storage Account with a Storage Queue
- Container App Environment
- Container App with associated scaling rules

**How to provision the template**

The following steps will be performed using the Azure CLI.

1. If you haven't done so already, register the *Microsoft.App* provider in your Azure Subscription.

```azurecli
az provider register --namespace Microsoft.App
```

2. Create the following variables in Bash, providing your own unique values for your ```RESOURCE_GROUP```, ```LOG_ANALYTICS_WORKSPACE``` and ```CONTAINERAPPS_ENVIRONMENT``` variables. For ```LOCATION```, use a Azure region that is close to you, and where Azure Container Apps can be deployed:

```bash
RESOURCE_GROUP="YOUR_RESOURCE_GROUP_NAME"
LOCATION="canadacentral"
LOG_ANALYTICS_WORKSPACE="YOUR_LOG_ANALYTICS_WORKSPACE_NAME"
CONTAINERAPPS_ENVIRONMENT="YOUR_CONTAINER_APP_ENV_NAME" 
```

3. Create the resource group that will store our resources:

```bash
az group create \
  --name $RESOURCE_GROUP \
  --location "$LOCATION"
```

4. Deploy the Bicep template by running the following command (Ensure that you are in the same directory as your Bicep file):

```bash
az deployment group create --resource-group $RESOURCE_GROUP --template-file ./main.bicep
```

## Send messages to the queue

1. In your Console App, add the connection string to your storage account in the ```appsettings.json``` file like so:

```json
{
  "ConnectionString": "<YOUR_STORAGE_ACCOUNT_CONNECTION_STRING>",
  "QueueName": "test-queue"
}
```

2. Run your console app to send messages to the queue. This will scale your Container App, which can be viewed by going into the Azure Portal, navigating to your Container App and going to **Metrics**. In the metrics tab, select **Replica Count** to see your container app scale.