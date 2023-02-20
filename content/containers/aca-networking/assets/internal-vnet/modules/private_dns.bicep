param location string 
param acaDefaultDomain string
param vnetId string
param appName string
param acaEnvironmentIpAddress string

resource privateDnsZone 'Microsoft.Network/privateDnsZones@2020-06-01' = {
  name: acaDefaultDomain
  location: 'global'
}

resource privateDnsZoneLink 'Microsoft.Network/privateDnsZones/virtualNetworkLinks@2020-06-01' = {
  name: 'aca-private-dns-zone-vnet-link'
  location: 'global'
  parent: privateDnsZone
  properties: {
    registrationEnabled: false
    virtualNetwork: {
      id: vnetId
    }
  }
}

resource acaAppsRecordSet 'Microsoft.Network/privateDnsZones/A@2020-06-01' = {
  name: appName
  parent: privateDnsZone
  properties: {
    aRecords: [
      {
        ipv4Address: acaEnvironmentIpAddress //containerApp.properties.configuration.ingress.customDomains[0].name
      }
    ]
    ttl: 360
  }
}


