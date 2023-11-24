param location string = 'australiaeast'
param prefix string
param imageName string = 'mcr.microsoft.com/azuredocs/containerapps-helloworld:latest'
param publicSshKey string
param isZoneRedundant bool = true

var suffix = uniqueString(resourceGroup().id)
var vnetName = '${prefix}-vnet-${suffix}'
var workspaceName = '${prefix}-wks-${suffix}'
var appName = '${prefix}-app-${suffix}'
var appEnvironmentName = '${prefix}-env-${suffix}'
var bastionName = '${prefix}-bas-${suffix}'
var bastionNsgName = '${prefix}-bas-nsg-${suffix}'

resource vnet 'Microsoft.Network/virtualNetworks@2022-07-01' = {
  name: vnetName
  location: location
  properties: {
    addressSpace: {
      addressPrefixes: [
        '10.0.0.0/16'
      ]
    }
    subnets: [
      {
        name: 'infrastructure-subnet'
        properties: {
          addressPrefix: '10.0.0.0/23'
          delegations: []
          privateEndpointNetworkPolicies: 'Disabled'
          privateLinkServiceNetworkPolicies: 'Enabled'
        }
      }
      {
        name: 'vm-subnet'
        properties: {
          addressPrefix: '10.0.8.0/24'
          delegations: []
          privateEndpointNetworkPolicies: 'Disabled'
          privateLinkServiceNetworkPolicies: 'Enabled'
        }
      }
      {
        name: 'AzureBastionSubnet'
        properties: {
          addressPrefix: '10.0.9.0/24'
          delegations: []
          privateEndpointNetworkPolicies: 'Disabled'
          privateLinkServiceNetworkPolicies: 'Disabled'
        }
      }
    ]
    virtualNetworkPeerings: []
    enableDdosProtection: false
  }
}

module bastion 'modules/bastion.bicep' = {
  name: 'module-azure-bastion'
  params: {
    bastionSubnetId: vnet.properties.subnets[2].id
    hostName: bastionName
    location: location
    nsgName: bastionNsgName
    workspaceId: wks.id
  }
}

module vm 'modules/vm.bicep' = {
  name: 'module-vm'
  params: {
    adminUserName: 'localadmin'
    location: location
    name: 'linux-vm-01'
    sshKey: publicSshKey
    subnetId: vnet.properties.subnets[1].id
  }
}

resource wks 'Microsoft.OperationalInsights/workspaces@2021-12-01-preview' = {
  name: workspaceName
  location: location
  properties: {
    sku: {
      name: 'pergb2018'
    }
    retentionInDays: 30
    features: {
      enableLogAccessUsingOnlyResourcePermissions: true
    }
    workspaceCapping: {
      dailyQuotaGb: -1
    }
    publicNetworkAccessForIngestion: 'Enabled'
    publicNetworkAccessForQuery: 'Enabled'
  }
}

resource appEnvironment 'Microsoft.App/managedEnvironments@2022-06-01-preview' = {
  name: appEnvironmentName
  location: location
  sku: {
    name: 'Consumption'
  }
  properties: {
    vnetConfiguration: {
      internal: true
      infrastructureSubnetId: vnet.properties.subnets[0].id
      dockerBridgeCidr: '10.2.0.1/16'
      platformReservedCidr: '10.1.0.0/16'
      platformReservedDnsIP: '10.1.0.2'
      outboundSettings: {
        outBoundType: 'LoadBalancer'
      }
    }
    appLogsConfiguration: {
      destination: 'log-analytics'
      logAnalyticsConfiguration: {
        customerId: wks.properties.customerId
        sharedKey: listKeys(wks.id, wks.apiVersion).primarySharedKey
      }
    }
    zoneRedundant: isZoneRedundant
  }
}

resource containerApp 'Microsoft.App/containerApps@2022-06-01-preview' = {
  name: appName
  location: location
  identity: {
    type: 'None'
  }
  properties: {
    managedEnvironmentId: appEnvironment.id
    configuration: {
      activeRevisionsMode: 'Single'
      ingress: {
        external: true
        targetPort: 80
        exposedPort: 0
        transport: 'Auto'
        traffic: [
          {
            weight: 100
            latestRevision: true
          }
        ]
        allowInsecure: false
      }
    }
    template: {
      containers: [
        {
          image: imageName
          name: appName
          resources: {
            cpu: '0.25'
            memory: '0.5Gi'
          }
        }
      ]
      scale: {
        maxReplicas: 10
      }
    }
  }
}

module privateDns 'modules/private_dns.bicep' = {
  name: 'module-private-dns'
  params: {
    acaDefaultDomain: appEnvironment.properties.defaultDomain
    acaEnvironmentIpAddress: appEnvironment.properties.staticIp
    appName: appName
    location: location
    vnetId: vnet.id
  }
}

output appFqdn string = containerApp.properties.configuration.ingress.fqdn
output bastionHostName string = bastion.outputs.name
output vmId string = vm.outputs.id
