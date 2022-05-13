param location string = resourceGroup().location
param VNetName string

module vnet './VNet.bicep' = {
  name: VNetName
  params: {
    vnetName: VNetName
    location: location
  }
}
