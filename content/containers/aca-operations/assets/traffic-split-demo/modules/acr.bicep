param location string = resourceGroup().location
param anonymousPullEnabled bool = false

var suffix = uniqueString(resourceGroup().id)
var acrName = 'acr${suffix}'

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

output acrName string = acr.name
output acrLoginServer string = acr.properties.loginServer
