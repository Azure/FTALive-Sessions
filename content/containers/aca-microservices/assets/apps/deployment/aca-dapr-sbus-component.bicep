param sbusName string
param acaEnvName string
param pubAppName string
param subAppName string
param pubSubName string

var sbEndpoint = '${sbus.id}/AuthorizationRules/RootManageSharedAccessKey'
var sbusConnectionString = listKeys(sbEndpoint, sbus.apiVersion).primaryConnectionString

resource acaEnv 'Microsoft.App/containerApps@2022-03-01' existing = {
  name: acaEnvName
}

resource sbus 'Microsoft.ServiceBus/namespaces@2022-01-01-preview' existing = {
  name: sbusName
}

resource sbusPubSubDaprComponent 'Microsoft.App/managedEnvironments/daprComponents@2022-03-01' = {
  dependsOn: [
    acaEnv
  ]
  name: '${acaEnv.name}/${pubSubName}'
  properties: {
    componentType: 'pubsub.azure.servicebus'
    version: 'v1'
    ignoreErrors: false
    initTimeout: '60s'
    metadata: [
      {
        name: 'connectionString'
        value: sbusConnectionString
      }
    ]
    scopes: [
      pubAppName
      subAppName
    ]
  }
}
