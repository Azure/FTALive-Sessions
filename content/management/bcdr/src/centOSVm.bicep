param vmname string
param VNetId string
param SubnetName string = 'Servers'
param location string = resourceGroup().location

//param avsetid string = 'none'
var nicname='${vmname}-nic'
var OSdiskname='${vmname}-OSDisk'
var vnetId = VNetId
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

resource centosVM 'Microsoft.Compute/virtualMachines@2020-12-01'={
  location: location
  name: vmname
  dependsOn:[
    nic
  ]
  properties:{
     hardwareProfile:{
       vmSize: 'Standard_D2s_v3'
     }
     storageProfile:{
       imageReference:{
         publisher: 'cognosys'
         offer: 'centos-7-8-free'
         sku: 'centos-7-8-free'
         version: 'latest'
       }
       osDisk:{
         osType:'Linux'
         name:OSdiskname
         createOption: 'FromImage'
         caching: 'ReadWrite'
         diskSizeGB: 32
       }
     }
     osProfile:{
       computerName: vmname
       adminUsername: 'azureuser'
       adminPassword: 'Fta-live$2022'
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
  plan:{
    name: 'centos-7-8-free'
    product: 'centos-7-8-free'
    publisher: 'cognosys'
  }
}

output nicIp string = nic.properties.ipConfigurations[0].properties.privateIPAddress
