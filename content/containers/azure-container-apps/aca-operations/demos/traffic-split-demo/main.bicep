param name string = 'colour-server'
param registryName string
param port int = 80
param location string
param blueImageName string
param greenImageName string
param tags object = {
  costcentre: 123456
  owner: 'cbellee'
}
param resources object = {
  cpu: 2
  memory: '4.0Gi'
}

var suffix = uniqueString(resourceGroup().id)
var acaEnvironmentName = 'aca-colour-server-${suffix}'

module wks './modules/wks.bicep' = {
  name: 'modules-workspace'
  params: {
    location: location
    retentionInDays: 30
    sku: 'Standard'
    tags: tags
  }
}

module acaEnvironment './modules/acaenv.bicep' = {
  name: 'modules-aca-environment'
  params: {
    location: location
    name: acaEnvironmentName
    wksCustomerId: wks.outputs.customerId
    wksSharedKey: wks.outputs.sharedKey
    tags: tags
  }
}

resource acr 'Microsoft.ContainerRegistry/registries@2022-02-01-preview' existing = {
  name: registryName
}

module blueAppRevision './modules/app.bicep' = {
  name: 'module-blue-revision'
  params: {
    location: location
    tags: tags
    acaEnvironmentId: acaEnvironment.outputs.id
    acrLoginServer: acr.properties.loginServer
    acrName: acr.name
    resources: resources
    traffic: [
      {
        latestRevision: true
        weight: 100
      }
    ]
    imageName: blueImageName
    name: name
    port: port
  }
}

module greenAppRevision './modules/app.bicep' = {
  name: 'module-green-revision'
  params: {
    location: location
    tags: tags
    acaEnvironmentId: acaEnvironment.outputs.id
    acrLoginServer: acr.properties.loginServer
    acrName: acr.name
    resources: resources
    imageName: greenImageName
    traffic: [
      {
        latestRevision: true
        weight: 100
      }
    ]
    name: name
    port: port
  }
  dependsOn: [
    blueAppRevision
  ]
}

module trafficSplitUpdate './modules/app.bicep' = {
  name: 'module-traffic-split'
  params: {
    location: location
    tags: tags
    acaEnvironmentId: acaEnvironment.outputs.id
    acrLoginServer: acr.properties.loginServer
    acrName: acr.name
    resources: resources
    traffic: [
      {
        revisionName: blueAppRevision.outputs.revisionName
        weight: 50
      }
      {
        revisionName: greenAppRevision.outputs.revisionName
        weight: 50
      }
    ]
    imageName: greenImageName
    name: name
    port: port
  }
  dependsOn: [
    greenAppRevision
  ]
}

output fqdn string = trafficSplitUpdate.outputs.fqdn
