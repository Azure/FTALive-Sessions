param location string

var affix = uniqueString(resourceGroup().id)
var containerAppEnvName = 'app-env-${affix}'
var wksName = '${affix}-wks'
var aiName = '${affix}-ai'

resource ai 'Microsoft.Insights/components@2020-02-02' = {
  kind: 'web'
  location: location
  name: aiName
  properties: {
    Application_Type: 'web'
    Flow_Type: 'Bluefield'
    RetentionInDays: 30
  }
}

resource wks 'Microsoft.OperationalInsights/workspaces@2021-06-01' = {
  location: location
  name: wksName
  properties: {
    retentionInDays: 30
    sku: {
      name: 'Standard'
    }
  }
}

resource containerAppEnvironment 'Microsoft.App/managedEnvironments@2022-03-01' = {
  location: location
  name: containerAppEnvName
  properties: {
    daprAIInstrumentationKey: ai.properties.InstrumentationKey
    appLogsConfiguration: {
      destination: 'log-analytics'
      logAnalyticsConfiguration: {
        customerId: wks.properties.customerId
        sharedKey: wks.listKeys().primarySharedKey
      }
    }
  }
}

output name string = containerAppEnvironment.name
