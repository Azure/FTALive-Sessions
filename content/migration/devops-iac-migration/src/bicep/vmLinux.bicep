param vmname string
param vnetId string
param SubnetName string
param location string =resourceGroup().location
param osType string = 'Windows'
param vmSize string
param adminUserName string ='azureuser'
param adminPassword string ='@zureS3cur3P@ssw0rd'
param publisher string
param offer string
param sku string
param datadisksizes array
param datadisktypes array
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

resource LinuxVM 'Microsoft.Compute/virtualMachines@2020-12-01'=  { 
  location: location
  name: vmname
  dependsOn:[
    nic
  ]
  properties:{
     hardwareProfile:{
       vmSize: vmSize
     }
     storageProfile:{
       imageReference:{
         publisher: publisher
         offer: offer
         sku: sku
         version: 'latest'
       }
       osDisk:{
         osType: osType
         name:OSdiskname
         createOption: 'FromImage'
         caching: 'ReadWrite'
         diskSizeGB: 32
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

     osProfile:{
       computerName: vmname
       adminUsername: adminUserName
       adminPassword: adminPassword
       linuxConfiguration:{
         disablePasswordAuthentication: false
         provisionVMAgent: true
         patchSettings: {
           patchMode:'ImageDefault'
         }
       }
       secrets:[
       ]
        allowExtensionOperations: true
     }

     networkProfile:{
         networkInterfaces:[
            {
              id: resourceId('Microsoft.Network/networkInterfaces', '${nicname}')
            }
         ]
     }
     diagnosticsProfile:{
       bootDiagnostics:{
         enabled:false
       } 
     }
  }
}
output nicIp string = nic.properties.ipConfigurations[0].properties.privateIPAddress
