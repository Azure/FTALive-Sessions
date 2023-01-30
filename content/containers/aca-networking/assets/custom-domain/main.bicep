param location string = 'australiaeast'
param prefix string
param imageName string = 'mcr.microsoft.com/azuredocs/containerapps-helloworld:latest'
param certificatePassword string
param externalDnsZoneResourceGroupName string = 'external-dns-zones-rg'
param domainName string = 'kainiindustries.net'
param subDomainName string = 'myapp'
param certificate string

var suffix = uniqueString(resourceGroup().id)
var workspaceName = '${prefix}-wks-${suffix}'
var appName = '${prefix}-app-${suffix}'
var appEnvironmentName = '${prefix}-env-${suffix}'

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

resource ssl_certificate 'Microsoft.App/managedEnvironments/certificates@2022-06-01-preview' = {
  name: 'tls-certificate'
  parent: appEnvironment
  location: location
  properties: {
    value: certificate
    password: certificatePassword
  }
}

resource appEnvironment 'Microsoft.App/managedEnvironments@2022-06-01-preview' = {
  name: appEnvironmentName
  location: location
  sku: {
    name: 'Consumption'
  }
  properties: {
    appLogsConfiguration: {
      destination: 'log-analytics'
      logAnalyticsConfiguration: {
        customerId: wks.properties.customerId
        sharedKey: listKeys(wks.id, wks.apiVersion).primarySharedKey
      }
    }
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
        customDomains: [
          {
            name: '${subDomainName}.${domainName}'
            certificateId: ssl_certificate.id
            bindingType: 'SniEnabled'
          }
        ]
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

module dnsZone 'modules/dns.bicep' = {
  name: 'module-dns-zone-records'
  scope: resourceGroup(externalDnsZoneResourceGroupName)
  params: {
    appEnvDefaultDomain: appEnvironment.properties.defaultDomain
    containerAppName: containerApp.name
    customDomainVerificationId: appEnvironment.properties.customDomainConfiguration.customDomainVerificationId
    domainName: domainName
  }
}

output appFqdn string = '${subDomainName}.${domainName}'
