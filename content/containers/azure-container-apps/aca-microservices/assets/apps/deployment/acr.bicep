param location string
param anonymousPullEnabled bool = false

var affix = uniqueString(resourceGroup().id)
var acrName = 'acr${affix}'

resource acr 'Microsoft.ContainerRegistry/registries@2021-12-01-preview' = {
  name: acrName
  location: location
  sku: {
    name: 'Standard'
  }
  properties: {
    adminUserEnabled: true
    anonymousPullEnabled: anonymousPullEnabled
  }
}

output name string = acr.name
