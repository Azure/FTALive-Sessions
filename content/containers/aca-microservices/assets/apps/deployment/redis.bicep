param location string

var affix = uniqueString(resourceGroup().id)
var name = 'redis-${affix}'

resource redis 'Microsoft.Cache/Redis@2019-07-01' = {
  name: name
  location: location
  properties: {
    redisVersion: 6
    enableNonSslPort: true
    sku: {
      capacity: 1
      family: 'C'
      name: 'Basic'
    }
  }
}

output name string = redis.name
output hostName string = redis.properties.hostName
output key string = redis.listKeys().primaryKey
