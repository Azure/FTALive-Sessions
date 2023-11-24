param acaEnvName string
param redisName string
param pubAppName string
param subAppName string
param pubSubName string

resource acaEnv 'Microsoft.App/managedEnvironments@2022-03-01' existing = {
  name: acaEnvName
}

resource redis 'Microsoft.Cache/redis@2021-06-01' existing = {
  name: redisName
}

resource redisPubSubDaprComponent 'Microsoft.App/managedEnvironments/daprComponents@2022-03-01' = {
  dependsOn: [
    acaEnv
  ]
  name: '${acaEnv.name}/${pubSubName}'
  properties: {
    componentType: 'pubsub.redis'
    version: 'v1'
    ignoreErrors: false
    initTimeout: '60s'
    metadata: [
      {
        name: 'redisHost'
        value: '${redis.properties.hostName}:${redis.properties.port}'
      }
      {
        name: 'redisPassword'
        value: redis.listKeys().primaryKey
      }
      {
        name: 'enableTLS'
        value: 'false'
      }
    ]
    scopes: [
      pubAppName
      subAppName
    ]
  }
}
