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

// param rgName string
// param suffix string
// param VNetCIDR string = '10.0.0.0/16'
// param SubnetCIDR string = '10.0.1.0/24'
// param BastionSubnetCIDR string = '10.0.2.0/24'
// var vnetName = '${suffix}-vnet'

// resource vnet 'Microsoft.Network/virtualNetworks@2021-05-01' = {
//   name: vnetName
//   location: resourceGroup().location

//   properties: {
//     addressSpace: {
//       addressPrefixes: [
//         VNetCIDR
//       ]
//     }
//     enableVmProtection: false
//     enableDdosProtection: false
//     subnets: [
//       {
//         name: 'Default'
//         properties: {
//           addressPrefix: SubnetCIDR
//         }
//       }
   
//       {
//         name: 'AzureBastionSubnet'
//         properties: {
//           addressPrefix: BastionSubnetCIDR
//         }
//       }
//     ]
//   }
// }
// output vnetid string = vnet.id

