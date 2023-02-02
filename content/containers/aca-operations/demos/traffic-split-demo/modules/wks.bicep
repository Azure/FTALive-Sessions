param location string = resourceGroup().location
param retentionInDays int = 30
param tags object

@allowed([
  'Standard'
  'PerGB2018'
])
param sku string = 'Standard'

var suffix = uniqueString(resourceGroup().id)
var name = 'wks${suffix}'

resource wks 'Microsoft.OperationalInsights/workspaces@2021-06-01' = {
  location: location
  name: name
  tags: tags
  properties: {
    retentionInDays: retentionInDays
    sku: {
      name: sku
    }
  }
}

output name string = wks.name
output id string = wks.id
output sharedKey string = wks.listKeys().primarySharedKey
output customerId string = wks.properties.customerId
output workspace object = wks
