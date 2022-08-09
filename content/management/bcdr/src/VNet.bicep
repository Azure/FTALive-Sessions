param vnetName string
param addressPrefix string = '10.0.0.0/16'
param location string

resource vnet 'Microsoft.Network/virtualNetworks@2020-06-01' = {
  name: vnetName
  location: location

  properties: {
    addressSpace: {
      addressPrefixes: [
        addressPrefix
      ]
    }
    enableVmProtection: false
    enableDdosProtection: false
    subnets: [
      {
        name: 'Servers'
        properties: {
          addressPrefix: '10.0.0.0/24'
        }
      }
      {
        name: 'AzureFirewallSubnet'
        properties: {
          addressPrefix: '10.0.20.0/24'
        }
      }      
      {
        name: 'AzureBastionSubnet'
        properties: {
          addressPrefix: '10.0.21.0/24'
        }
      }
    ]
  }
}
output vnetId string = vnet.id

