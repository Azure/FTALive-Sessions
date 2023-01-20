param location string

var affix = uniqueString(resourceGroup().id)
var name = 'sb-${affix}'

resource sb 'Microsoft.ServiceBus/namespaces@2022-01-01-preview' = {
  location: location
  name: name
  sku: {
    name: 'Standard'
  }
}

output name string = sb.name
