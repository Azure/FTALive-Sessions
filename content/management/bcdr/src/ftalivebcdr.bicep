param location string = resourceGroup().location
param VNetName string
param storageAccountName string

module vnet './VNet.bicep' = {
  name: VNetName
  params: {
    vnetName: VNetName
    location: location
  }
}
resource storageaccount 'Microsoft.Storage/storageAccounts@2021-08-01' = {
  name: storageAccountName
  location: location
  sku: {
    name: 'Standard_LRS'
  }
  kind: 'StorageV2'
  properties: {
    accessTier: 'Hot'
    allowBlobPublicAccess: false
    allowSharedKeyAccess: true
    supportsHttpsTrafficOnly: true
  }  
}

var vmlist1 = [
  {
    vmname:'centosvm1'
  }
  {
    vmname:'centosvm2'
  }
]

resource vault 'Microsoft.RecoveryServices/vaults@2022-01-01' = {
  name: 'fta-live-bcdr-vault'
  location: location
  tags: {
    environment: 'fta-live-demo'
  }
  sku: {
    name: 'RS0'
    tier: 'Standard'
  }
  properties: {
  }
}

module deployCentOSVMs './centOSVm.bicep'= [for vm in vmlist1: {
  name: 'deploycentosvms-${vm.vmname}'
  params: {
    location: location
      vmname: vm.vmname
      VNetId: vnet.outputs.vnetId
      SubnetName: 'Servers'
   }
   dependsOn: [
     vault
    ]
}]
