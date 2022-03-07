# Migrating Legacy DotNet Apps into Azure 

## Overview

In this session you will learn about upgrading the DotNet framework of your application to cross-platform and scalable .NET 6. We also dive into deploying our DotNet application to modern PaaS Services such as Azure App Services and Azure Kubernetes Services. 

### Agenda

* Introduction to .NET 6
* Upgrade to .NET 6
* Azure PaaS Services for Web Applications
    * Azure App Service
    * Azure Kubernetes Service
    * Azure Container Instance
    * Azure Container Apps
    * Service Fabric

### Audience

This session is most useful for application developers and architects who want to design cloud native applications or migrate existing applications to the cloud

### Goals

In this session you will learn how to:
* Upgrade and leverage modern .NET 6 framework
* Understand different PaaS Services available to deploy modernized applications and their use case
* Hands-On Deployment to Azure App Service and Azure Kubernetes Service


## Resources

Please find the most relevant resources below to continue your learning after this session:
****
### DotNet 6

- [Introduction](https://dotnet.microsoft.com)

- [Why to migrate?](https://devblogs.microsoft.com/dotnet/announcing-net-6/)

- Considerations before migration

  

### DotNet Upgrade

####    Typical workflow

1. **Preparation:** Review dependencies
   - NuGet packages, loose binaries, front-end dependencies, .NET Framework APIs used
   - Tools: .NET Upgrade Assistant analyze, API Portability Analyzer
2. **Upgrade:** Run the .NET upgrade assistant upgrade command with your solution / project
3. **Fix code and build:** Head back to Visual Studio and attempt to build your code
   - Look for warnings in the Error list, check any NuGet packages that were updated and expect to make additional changes to your code.
4. **Run and test:** There might be changes that aren't apparent until runtime. Test that everything works as expected.




- [Upgrade Assistant](https://dotnet.microsoft.com/en-us/platform/upgrade-assistant)
   * [Upgrade ASP.NET MVC app to .NET 6](https://docs.microsoft.com/en-us/dotnet/core/porting/upgrade-assistant-aspnetmvc)
   * [DotNet Conference video link](https://www.youtube.com/watch?v=cOHXt_0VDRI)
   * [DotNet upgrade eBook](https://docs.microsoft.com/en-us/dotnet/architecture/porting-existing-aspnet-apps/?WT.mc_id=dotnet-35129-website)

   

  ###### What is not Supported? 
  
  -[ASP.NET Web Forms]
    ** Consider Blazor or Razor pages
   -[Server-side WCF]
    ** Consider WebAPI, gRPC or core WCF
   -[Remoting]
    ** Consider StreamJsonRPC, gRPC, or WebAPI
   


### Azure PaaS Services for DotNet apps

- [Azure App Service](https://azure.microsoft.com/en-in/services/app-service/)
   - [Migration to Azure App Service](https://azure.microsoft.com/en-in/services/app-service/migration-tools/)
   - [Containers on App Service](https://azure.microsoft.com/en-us/services/app-service/containers/)
   - [Deploy Containerized Application to Azure App Service](https://docs.microsoft.com/en-us/learn/modules/deploy-run-container-app-service/)


- [Azure Kubernetes Service](https://azure.microsoft.com/en-in/services/kubernetes-service/)
  * [Run Your Application on Kubernetes](https://docs.microsoft.com/en-us/azure/aks/tutorial-kubernetes-prepare-app)
  * [DevOps with Kubernetes](https://www.azuredevopslabs.com/labs/vstsextend/kubernetes/)

- [Azure Container Instances](https://azure.microsoft.com/en-in/services/container-instances/)
  * [Deploying container in ACI](https://docs.microsoft.com/en-us/azure/container-instances/container-instances-quickstart-portal)
- [Azure Container Apps](https://azure.microsoft.com/en-in/services/container-apps/)
  - [Deploying container in ACA](https://docs.microsoft.com/en-us/azure/container-apps/get-started-existing-container-image-portal?pivots=container-apps-private-registry)


- [Azure Service Fabric](https://azure.microsoft.com/en-in/services/service-fabric/)
  * 



