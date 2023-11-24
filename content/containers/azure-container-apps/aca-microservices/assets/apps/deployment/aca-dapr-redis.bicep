param location string
param acaEnvName string
param redisName string
param acrName string
param pubAppName string
param pubAppPort string
param subAppName string
param subAppPort string
param pubSubName string
param pubSubTopic string
param tag string

var pubAppImage = '${acr.properties.loginServer}/${pubAppName}:${tag}'
var subAppImage = '${acr.properties.loginServer}/${subAppName}:${tag}'

var secrets = [
  {
    name: 'registry-password'
    value: acr.listCredentials().passwords[0].value
  }
]

resource acaEnv 'Microsoft.App/managedEnvironments@2022-03-01' existing = {
  name: acaEnvName
}

resource redis 'Microsoft.Cache/redis@2021-06-01' existing = {
  name: redisName
}

resource acr 'Microsoft.ContainerRegistry/registries@2021-12-01-preview' existing = {
  name: acrName
}

resource subApp 'Microsoft.App/containerApps@2022-03-01' = {
  name: subAppName
  location: location
  identity: {
    type: 'SystemAssigned'
  }
  properties: {
    configuration: {
      activeRevisionsMode: 'single'
      dapr: {
        appId: subAppName
        appPort: int(subAppPort)
        appProtocol: 'http'
        enabled: true
      }
      secrets: secrets
      registries: [
        {
          passwordSecretRef: 'registry-password'
          server: acr.properties.loginServer
          username: acr.name
        }
      ]
      ingress: {
        external: true
        targetPort: int(subAppPort)
        traffic: [
          {
            latestRevision: true
            weight: 100
          }
        ]
        transport: 'http'
      }
    }
    managedEnvironmentId: acaEnv.id
    template: {
      containers: [
        {
          image: subAppImage
          name: subAppName
          resources: {
            cpu: '0.25'
            memory: '0.5Gi'
          }
          env: [
            {
              name: 'PUBSUB_NAME'
              value: pubSubName
            }
            {
              name: 'PUBSUB_TOPIC'
              value: pubSubTopic
            }
          ]
        }
      ]
      scale: {
        minReplicas: 1
        maxReplicas: 10
      }
    }
  }
}

resource pubApp 'Microsoft.App/containerApps@2022-03-01' = {
  name: pubAppName
  location: location
  identity: {
    type: 'SystemAssigned'
  }
  properties: {
    configuration: {
      activeRevisionsMode: 'single'
      dapr: {
        appId: pubAppName
        appPort: int(pubAppPort)
        appProtocol: 'http'
        enabled: true
      }
      secrets: secrets
      registries: [
        {
          passwordSecretRef: 'registry-password'
          server: acr.properties.loginServer
          username: acr.name
        }
      ]
      ingress: {
        external: true
        targetPort: int(pubAppPort)
        traffic: [
          {
            latestRevision: true
            weight: 100
          }
        ]
        transport: 'http'
      }
    }
    managedEnvironmentId: acaEnv.id
    template: {
      containers: [
        {
          image: pubAppImage
          name: pubAppName
          resources: {
            cpu: '0.25'
            memory: '0.5Gi'
          }
          env: [
            {
              name: 'PUBSUB_NAME'
              value: pubSubName
            }
            {
              name: 'PUBSUB_TOPIC'
              value: pubSubTopic
            }
          ]
        }
      ]
      scale: {
        minReplicas: 1
        maxReplicas: 10
      }
    }
  }
}
