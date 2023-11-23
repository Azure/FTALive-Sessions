param name string
param port int
param tags object = {}
param location string = 'australiaeast'
param acrLoginServer string
param acrName string
param minReplicas int = 1
param maxReplicas int = 5
param traffic array
param imageName string
param acaEnvironmentId string
param resources object = {
  cpu: 2
  memory: '4.0Gi'
}

var suffix = uniqueString(resourceGroup().id)
var appName = '${name}-${suffix}'
var acrAdminPassword = listCredentials(acr.id, acr.apiVersion).passwords[0].value

resource acr 'Microsoft.ContainerRegistry/registries@2022-02-01-preview' existing = {
  name: acrName
}

resource containerApp 'Microsoft.App/containerApps@2022-06-01-preview' = {
  name: appName
  location: location
  tags: tags
  identity: {
    type: 'SystemAssigned'
  }
  properties: {
    configuration: {
      activeRevisionsMode: 'Multiple'
      registries: [
        {
          passwordSecretRef: 'registry-password'
          server: acrLoginServer
          username: acrName
        }
      ]
      secrets: [
        {
          name: 'registry-password'
          value: acrAdminPassword
        }
      ]
      ingress: {
        external: true
        targetPort: int(port)
        traffic: traffic
        transport: 'http'
      }
    }
    managedEnvironmentId: acaEnvironmentId
    template: {
      containers: [
        {
          image: imageName
          name: appName
          resources: resources
          env: []
        }
      ]
      scale: {
        minReplicas: minReplicas
        maxReplicas: maxReplicas
      }
    }
  }
}

output revisionName string = containerApp.properties.latestRevisionName
output fqdn string = containerApp.properties.configuration.ingress.fqdn
