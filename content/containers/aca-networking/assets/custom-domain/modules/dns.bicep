param domainName string
param subDomainName string = 'myapp'
param containerAppName string
param appEnvDefaultDomain string
param customDomainVerificationId string

resource dnsZone 'Microsoft.Network/dnsZones@2018-05-01' existing = {
  name: domainName
  
  resource cname 'CNAME@2018-05-01' = {
    name: subDomainName
    properties: {
      TTL: 3600
      CNAMERecord: {
        cname: '${containerAppName}.${appEnvDefaultDomain}'
      }
    }
  }
  
  resource verification 'TXT@2018-05-01' = {
    name: 'asuid.${subDomainName}'
    properties: {
      TTL: 3600
      TXTRecords: [
        {
          value: [ customDomainVerificationId ]
        }
      ]
    }
  }
}


