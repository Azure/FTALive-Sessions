param name string
param location string
param appEnvironmentResourceGroupName string
param loadBalancerName string
param subnetId string

resource loadBalancer 'Microsoft.Network/loadBalancers@2022-07-01' existing = {
  name: loadBalancerName
  scope: resourceGroup(appEnvironmentResourceGroupName)
}

resource privateLinkService 'Microsoft.Network/privateLinkServices@2022-07-01' = {
  name: name
  location: location
  properties: {
    autoApproval: {
      subscriptions: [
        subscription().subscriptionId
      ]
    }
    visibility: {
      subscriptions: [
        subscription().subscriptionId
      ]
    }
    fqdns: []
    enableProxyProtocol: false
    loadBalancerFrontendIpConfigurations: [
      {
        id: loadBalancer.properties.frontendIPConfigurations[0].id
      }
    ]
    ipConfigurations: [
      {
        name: 'ipconfig-0'
        properties: {
          privateIPAllocationMethod: 'Dynamic'
          subnet: {
            id: subnetId
          }
          primary: true
          privateIPAddressVersion: 'IPv4'
        }
      }
    ]
  }
}

output id string = privateLinkService.id
output name string = privateLinkService.name
