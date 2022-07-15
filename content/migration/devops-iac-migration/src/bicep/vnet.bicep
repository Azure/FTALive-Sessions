param virtualNetworkName string
param defaultSubnetName string
param VNetCIDR string
param defaultSubnetCIDR string
param location string
param subnetName string
param subnetCIDR string


resource vnet 'Microsoft.Network/virtualNetworks@2021-05-01' = {
  name: virtualNetworkName
  location: location

  properties: {
    addressSpace: {
      addressPrefixes: [
        VNetCIDR
      ]
    }
    enableVmProtection: false
    enableDdosProtection: false
    subnets: [
      {
        name: defaultSubnetName
        properties: {
          addressPrefix: defaultSubnetCIDR
        }
      }
      {   
        name: subnetName
        properties: {
          addressPrefix: subnetCIDR
        }
      }
    ]
  }
}
output vnetid string = vnet.id
