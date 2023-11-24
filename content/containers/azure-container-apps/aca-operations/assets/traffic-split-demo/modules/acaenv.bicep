param location string
param name string
param wksCustomerId string
param wksSharedKey string
param acaInfraSubnetId string = ''
param acaRuntimSubnetId string = ''
param isInternal bool = false
param tags object
param isZoneRedundant bool = false
param vnetConfig object = {
  internal: isInternal
  infrastructureSubnetId: acaInfraSubnetId
  runtimeSubnetId: acaRuntimSubnetId
  platformReservedCidr: '10.0.0.0/16'
  platformReservedDnsIP: '10.0.0.2'
  dockerBridgeCidr: '10.1.0.1/16'
}

resource containerAppEnvironment 'Microsoft.App/managedEnvironments@2022-03-01' = {
  location: location
  name: name
  tags: tags
  properties: {
    vnetConfiguration: isInternal ? vnetConfig : null
    zoneRedundant: isZoneRedundant
    appLogsConfiguration: {
      destination: 'log-analytics'
      logAnalyticsConfiguration: {
        customerId: wksCustomerId
        sharedKey: wksSharedKey
      }
    }
  }
}

output id string = containerAppEnvironment.id
output name string = containerAppEnvironment.name
