param vmname string
param vnetId string
param SubnetName string
param location string =resourceGroup().location
param osType string = 'Windows'
param vmSize string
param adminUserName string ='azureuser'
param adminPassword string ='@zureS3cur3P@ssw0rd'
param publisher string = 'MicrosoftWindowsServer'
param offer string = 'WindowsServer'
param sku string = '2019-Datacenter'
param datadisksizes array
param datadisktypes array
param osDiskSize int = 127
var nicname='${vmname}-nic'
var OSdiskname='${vmname}-OSDisk'
var subnetRef = '${vnetId}/subnets/${SubnetName}'

resource nic 'Microsoft.Network/networkInterfaces@2020-08-01'={
  name: nicname
  location:location
  properties:{
     ipConfigurations:[
        {
          name:'ipconfig1'
          properties:{
            privateIPAllocationMethod: 'Dynamic'
            subnet: {
                id: subnetRef
            }  
          }
        }
     ]
  }
}
resource WindowsVM 'Microsoft.Compute/virtualMachines@2021-07-01' = {
  name: vmname
  location: location
  properties: {
      hardwareProfile: {
          vmSize: vmSize
      }
      osProfile: {
          computerName: vmname
          adminUsername: adminUserName
          adminPassword: adminPassword
      }
      storageProfile: {
          imageReference: {
              publisher: publisher
              offer: offer
              sku: sku
              version: 'latest'
      }
      osDisk: {
          caching: 'ReadWrite'
          createOption: 'FromImage'
          name: '${vmname}-osDisk'
      }
      dataDisks: [for i in range(0,length(datadisksizes)): {
          name: '${vmname}-dataDisk${i}'
          diskSizeGB: datadisksizes[i]
          lun: i
          createOption: 'Empty'
          managedDisk: {
            storageAccountType: datadisktypes[i]
          }
        }]
      }
      networkProfile: {
          networkInterfaces: [
              {
              id: nic.id
              }
          ] 
      }
      diagnosticsProfile: {
          bootDiagnostics: {
              enabled: true
          }
      }
    }
  }

output nicIp string = nic.properties.ipConfigurations[0].properties.privateIPAddress
