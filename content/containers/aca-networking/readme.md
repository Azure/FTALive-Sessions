# Azure Container Apps Networking

## Overview
In this session you'll learn about ACA core networking concepts and their relevance to different architectures. 

## ACA and Kubernetes term synonymities 
For those familiar with a traditional Kubernetes environment, the following synonymities may help with your understanding of ACA. 

- Container App Environment == Kubernetes Cluster
	- One Environment can host multiple apps
- Container App == Kubernetes Service
	- One Container App can have multiple instances
- Container App instances == Kubernetes Pods
	- One instance can have multiple containers
- Container Environment Public/Private endpoint ==  L7 Ingress Controller/LoadBalancer frontend IP
	- This endpoint must receive traffic with host header for appropriate routing.

## Agenda
-  Container App Environments
	- Vnet integration
	- Overview of public vs private app environments
- HTTP Ingress
- Service Discovery
- Intra Environment and Intra Vnet communications
- Custom Domains
- Load balancing traffic between revisions

## Container App Environments
- Hosts your Container Apps
- Can be integrated with Vnets
	- [Public Environment - Vnet integrated](https://docs.microsoft.com/en-us/azure/container-apps/vnet-custom)
	- [Private Environment - Vnet integrated](https://docs.microsoft.com/en-us/azure/container-apps/vnet-custom-internal)
	- Vnet integration offers optional zone redundancy 
- Native DNS for hosted apps within environment 

Ref: [Container App Environments](https://docs.microsoft.com/en-us/azure/container-apps/environment)

### Vnet integration
- Requires exclusive use of /23 subnet at minimum.
- MC_ Resource Group automatically created includes:
	- Reserved Vnet IPs
	- Public LB with outbound IPs (and frontend IP if Container App Environment is public)
	- If Environment is private, a private LB with singular frontend IP 
- Vnet integration allows for Container App egress to backend services. 

Ref: [Vnet integration](https://docs.microsoft.com/en-us/azure/container-apps/networking#custom-vnet-configuration)


### Environment Endpoints: Public vs Private vs (None)



#### Public
- HTTP Ingress occurs only through public endpoint
- Optional Vnet integration
-- Vnet integration allows access to backend services. 
-- Vnet services can only ingress through public endpoint. 


#### Private
- Vnet integration required
- MC_ Resource Group
-  Private DNS Zones required for ingress from Vnet to Container App


 #### (None)
- An app with ingress disabled can have workloads subscribe to messaging queues and scale accordingly - while optionally only having dependencies with apps in the same environment.
-- Reference: [Background Processing](https://docs.microsoft.com/en-us/azure/container-apps/background-processing)

## Service Discovery

- Upon creation of the environment, the defaultDomain/unique-identifier is known.
	- Make note of this for setting appropriate ENV variables within your environment.
		- *az containerapp env show --name <name> --resource-group <rg> --query properties.defaultDomain*
- Hosted apps within the environment have their names assigned as subDomains to the App Environments defaultDomain.  

[![FQDN Structure](https://docs.microsoft.com/en-us/azure/container-apps/media/connect-apps/azure-container-apps-location.png "FQDN Structure")](https://docs.microsoft.com/en-us/azure/container-apps/media/connect-apps/azure-container-apps-location.png "FQDN Structure")

Ref:  [Connect applications in Azure Container Apps](https://docs.microsoft.com/en-us/azure/container-apps/connect-apps?tabs=bash)

## Container App Ingress

Container Apps have public, private, or no HTTP Ingress: [HTTP Ingress](https://docs.microsoft.com/en-us/azure/container-apps/ingress)

When HTTP Ingress is enabled, you have the option of allowing external traffic - this has different implications depending on the App Environment hosting the app. 

Reference  ***properties.configuration.ingress.external*** property below - the configuration for a single Container App: 

    kind: containerapp
    location: uksouth
    name: hello
    resourceGroup: aca
    type: Microsoft.App/containerApps
    tags:
      tagname: value
    properties:
      managedEnvironmentId: /subscriptions/redacted/resourceGroups/aca/providers/Microsoft.App/managedEnvironments/managedEnvironment-aca-aks-vnet-private-uksouth
      configuration:
        activeRevisionsMode: Multiple
        ingress:
          external: true
          allowInsecure: false
          targetPort: 80
          traffic:
            - latestRevision: true
              weight: 30
          transport: Auto
    

**For public endpoint environments:**
- external traffic enabled entails ingress from anywhere, e.g. internet and/or Vnet
- external traffic disabled entails ingress only from within Container Apps Environment

**For private endpoint environments:**
- external traffic enabled entails ingress from Vnet
- external traffic disabled entrails ingress only from within Container Apps Environment

**Note:** Host header is required for all incoming traffic to Container App.
- From VNet, for private endpont environments you can test traffic to apps:
	- curl https://appName.aca-environment-domain.region.azurecontainerapps.io --resolve appName.aca-environ-domain.region.azurecontainerapps.io:80/443:internal-LB-frontend-IP
		- i.e. curl https://hello.bravebay-8135f561.uksouth.azurecontainerapps.io --resolve hello.bravebay-8135f561.uksouth.azurecontainerapps.io:443:10.0.0.4


Ref: [Setup HTTPS Ingress for Apps](https://docs.microsoft.com/en-us/azure/container-apps/ingress?tabs=bash)



## Intra App Environment and Intra Vnet Communications

- App containers communicate on localhost, share ports. 
- Intra Environment Apps communicate through their FQDNs. 
- Intra Vnet communications for public environments.
	- Ingress through public endpoint, Public Azure DNS resolution
- Intra Vnet communication for private environment
	- Ingress through private endpoint, Private Azure DNS Zone required for ACA Environment FQDN


## Custom Domains

Pre-requisites:
1. Every domain needs a domain cert separately.
2. Certificates are for individual container app and bound to container app only
3. SNI Certs needed 
4. Ingress must be enabled on container app

### Add a custom domain and cert
**Note:** If using new certificate, you must have an existing SNI domain certificate to upload it.
 
1. Check if ingress is enabled by navigating to ACA on Azure portal.
	- If not enabled, enabled [HTTP Ingress](https://docs.microsoft.com/en-us/azure/container-apps/ingress) option under ACA settings and give target port and save.
2. Under settings section, select "Add custom domain".
3.  In Add custom domain window, enter the domain name e.g. contoso.com and then associate the appropriate record for adding custom domain, apex custom domain needs A record so add the A record associated with the domain or if custom domain is a sub-domain that needs a CNAME record, e.g., mycontainerapp.contoso.com, associate CNAME record if it is a sub-domain.
4. After adding the existing or created DNS records, click validate to start domain validation process.
5. Once validation succeeds, select "Next" and click on "bind certificate + Add" for binding the SSL cert with the container app.
6. In case of a new cert created on local machine, pull out the cert by browsing to the folder where the cert is and upload it or add it as a file.
7.  Once adding the SSL cert is done, custom domain added will be listed under the "custom domains".
 
### Managing certificates:
 
1. Can be done via container app environment or through individual container apps.
2. Navigate to the "Add certificate" to add or renew the certificate.
3. Remove the old cert clicking the trash button.
4.  To renew cert, click "renew certificate" to add the new renewed cert to the certs.


Ref: Custom domain names and certificates in Azure Container Apps | Microsoft Docs


## Load balancing traffic between revisions 
- Requires activeRevisionsMode: Multiple
- Per below example, ***latestRevision: true*** adds the weight to the last deployed revision.
	- If the deployment is for a new revision, the weight for ***latestRevision*** gets added to the revision being deployed.
	- If the revision is pre-existing, is being updated, and was not deployed most recently, the weight must be explicitly declared if you wish to route traffic to the revision being updated. 

Per the example below, if revision ***rev4*** is new, it will be assigned a weight of 30. If it's pre-existing and not the latest, it will be assigned a weight of 0 - and the latest revision will be assigned a weight of 30. 

    properties:
      managedEnvironmentId: /subscriptions/<redacted>/resourceGroups/aca/providers/Microsoft.App/managedEnvironments/managedEnvironment-aca-aks-vnet-private-uksouth
      configuration:
        activeRevisionsMode: Multiple
        ingress:
          external: true
          allowInsecure: false
          targetPort: 80
          traffic:
            - latestRevision: true
              weight: 30
            - revisionName: hello--replace-with-mcrhello
              weight: 50
            - revisionName: hello--rev3
              weight: 20
          transport: Auto
      template:
        revisionSuffix: rev4
        containers:
          - image: mcr.microsoft.com/azuredocs/containerapps-helloworld:latest

