# Azure Container Apps Introduction           

## Overview
- Azure Container Apps enables you to run microservices and containerized applications on a serverless platform.

## Why choose Azure Container Apps over other cloud services?

[Choose right azure compute service for your application](https://docs.microsoft.com/en-us/azure/architecture/guide/technology-choices/compute-decision-tree#choose-a-candidate-service)

### Azure App Service and Azure Functions

| Benefits | Limitations |
| -------- | ----------- |
| Deploy to Azure in seconds<br>Deploy code or containers<br>Scale easily on demand<br>Ideal for web applications<br>Leverage Deployment slots to minimize downtime|Multi containers deployment<br>DAPR (Distributed Application Runtime)<br>Handling event-driven processing Using KEDA (Kubernetes Event-driven Autoscaler)<br>|


### Azure Container Instances (ACI)

| Benefits | Limitations |
| -------- | ----------- |
| Ease of use<br>Fast container start<br>Custom sizing<br>No need for full orchestration<br>Ideal for simple container-based workloads|No Orchestration (Kubernetes)<br>Not suitable for running large scale applications<br>No service discovery<br>No support for Scaling|

### Azure Kubernetes Service (AKS)

| Benefits | Limitations |
| -------- | ----------- |
|Container orchestration for automating deployment, scaling, and management<br>Auto healing<br>Support for CNCF Projects Like Istio, Flux, Argo<br>DAPR and KEDA support<br>Uses clusters and pods to scale and deploy applications<br>Elastic provisioning<br>|Infrastructure, network and VM management<br>High Learning Curve<br>User responsibility of updates and upgrades<br>Complex Developer Experience<br>Certificate and Secret management<br>Complex troubleshooting<br>|


### Azure Container Apps
| Benefits | Limitations |
| -------- | ----------- |
| Optimized for running general purpose containers, especially for applications that span many microservices deployed in containers<br>Powered by Kubernetes, Dapr, KEDA, and envoy<br>Supports Kubernetes-style apps and microservices with features like service discovery and traffic splitting<br>Scaling based on traffic and pulling from event sources like queues<br>Supports scale to zero<br>Support of long running processes and can run background tasks | No direct access to underlying Kubernetes APIs |


## Container Apps Use Cases
- Deploy and manage a micrososervices architechture with the option to integrate with Dapr.
- Event-drive processing, for example, queue reader application that processes messages as they arrive in a queue.
- Web Applications such ASP.NET Core, Express.js with custom domains, TLS certificates, with integrated authentication.
- Public API endpoints, split traffic between two revisions of the app
- Background processing, for example, continuously running background process that transforms data in a database
![Screenshot](images/ContainerAppUseCases.jpg)

## What can you do with Container Apps

- Run multiple container revisions and manage the container app's application lifecycle.
- Autoscale your apps based on any KEDA-supported scale trigger. Most applications can scale to zero.
![Screenshot](images/ApplicationAutoScalingWithKEDA.png)
- Enable HTTPS ingress without having to manage other Azure infrastructure.
- Split traffic across multiple versions of an application for Blue/Green deployments and A/B testing scenarios.
- Use internal ingress and service discovery for secure internal-only endpoints with built-in DNS-based service discovery.
- Build microservices with DAPR and access its rich set of APIs.
- Run containers from any registry, public or private, including Docker Hub and Azure Container Registry (ACR).
- Use the Azure CLI extension or ARM templates to manage your applications.
- Securely manage secrets directly in your application.
- View application logs using Azure Log Analytics.

## Ingress
- Azure Container Apps allows you to expose your container app to the public web by enabling ingress. 
- When you enable ingress, you do not need to create an Azure Load Balancer, public IP address, or any other Azure resources to enable incoming HTTPS requests.
- Ingress is an application-wide setting. Changes to ingress settings apply to all revisions simultaneously, and do not generate new revisions.
- With ingress enabled, your container app features the following characteristics:
  - Supports TLS termination
  - Supports HTTP/1.1 and HTTP/2
  - Supports WebSocket and gRPC
  - HTTPS endpoints always use TLS 1.2, terminated at the ingress point
  - Endpoints always expose ports 80 (for HTTP) and 443 (for HTTPS).
  - By default, HTTP requests to port 80 are automatically redirected to HTTPS on 443.
  - Request timeout is 240 seconds.
  
![Screenshot](images/ContainerAppsIngress.png)

## Container Apps Environment
- Individual container apps are deployed to a single Container Apps environment, which acts as a secure boundary around groups of container apps. Container Apps in the same environment are deployed in the same virtual network and write logs to the same Log Analytics workspace. You may provide an existing virtual network when you create an environment.
- An Environment can hold one or many Container Apps
- You can have one or many Container Apps Environment
- Reasons to deploy container apps to the same environment include situations when you need to:
  - Manage related services
  - Deploy different applications to the same virtual network
  - Have applications communicate with each other using Dapr
  - Have applications to share the same Dapr configuration
  - Have applications share the same log analytics workspace
- Reasons to deploy container apps to different environments include situations when you want to ensure:
  - Two applications never share the same compute resources
  - Two applications can't communicate with each other via Dapr

![Screenshot](images/ContainerAppsEnvironment2.png)

## Containers and Revisions
- Container Apps support any Linux-based x86-64 (linux/amd64) container image, **Windows Containers are not supported!**
- Containers from any public or private container registry

![Screenshot](images/ContainersInContainerApps2.png)

- Azure Container Apps implements container app versioning by creating **revisions**. 
- A revision is an immutable snapshot of a container app version.
  - The first revision is automatically created when you deploy your container app.
  - New revisions are automatically created when you make a revision-scope change to your container app.
  - While revisions are immutable, they're affected by application-scope changes, which apply to all revisions.
  - You can retain up to 100 revisions, giving you a historical record of your container app updates.
  - You can run multiple revisions concurrently.
  - You can split external HTTP traffic between active revisions.
  - A new revision is created when a container app is updated with revision-scope changes.
  - When you deploy a container app with application-scope changes:
    - The changes are globally applied to all revisions.
    - A new revision isn't created.

![Screenshot](images/ContainerAppsRevisions2.png)

## Application Lifecycle Management in Container Apps

- When you deploy a container app, the first revision is automatically created.
- Container Apps flow through three phases: deployment, update and deactivation.

### Deployment

- When we first deploy a container app, the first revision is automatically created for us.

![Upon deployment, the first revision is automatically created](./media/deployment.png)

### Update

- When we update the container app with a *revision-scope* change, a new revision is created.
- We can either automatically deactivate old revisions, or allow them to remain available.

![As the container app is updated, a new revision is created](./media/updated.png)

### Deactivate

- Once a revision is no longer needed, we can deactivate the revision.
- During deactivation, containers in that revision are shut down.
- We have the option to reactivate them later, provided they haven't been purged.

![Once a revision is no longer needed, we can deactivate individual revisions or choose to automatically deactivate old revisions](./media/deactivation.png).

## VNET Integration

- Azure Container Apps run in the context of an environment supported by a virtual network.
- You can provide a custom VNET or have one automatically generated for you (These are inaccessible to you as they're created in Microsoft's tenant).
- You will need to provide an existing VNET to Container Apps as you create your Container App Environment.

| **Accessibility level** | **Description** |
| ----------------------- | --------------- |
| Internal | No public endpoint. Deployed with a virtual IP mapped to an internal IP address. Internal endpoint is a Azure internal load balancer and IP addresses are used from the custom VNET's list of private IP addresses. |
| External | Environment available for public requests. Deployed with a virtual IP on an external, public facing IP address. |

### Configure VNET for Azure Container Apps Environment

- You can bring your own virtual network when creating a new Azure Container Apps environment. You will need to provide the network along with two subnets: the *control plane* subnet and the *app* subnet.
- The control plane subnet will be used to provide IP addresses from your internal network to the Container Apps control plane infrastructure components as well as your application containers.
- The size of the subnets provided should be at least /21. These subnets should not overlap with the following ranges:
    - 169.254.0.0/16
    - 172.30.0.0/16
    - 172.31.0.0/16
    - 192.0.2.0/24

#### External Access

- If you deploy an external Azure Container Apps environment, this will be accessible via public endpoint. This is an Azure Public IP address:

![External Azure Container Apps Environment](./media/externalACAenvironment.png)

#### Internal Access

- To lock down your environment from the public internet, deploy an internal environment instead.
- This environment will only expose applications via an IP address from within your VNET.
- Configure your network with an **allow-all** configuration by default to ensure the deployment is successful.

![Internal Azure Container Apps Environment](./media/internalACAenvironment.png)
