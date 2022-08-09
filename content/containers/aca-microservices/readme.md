# Azure Container Apps & Dapr

## Overview
In this session you'll learn about microservices, containers and what [Dapr](https://docs.dapr.io/) (Distributed Application Runtime) is and how it integrates with Azure Container Apps.

## Agenda
- Microservices
  - Microservices vs Monolithics applications
- Containers
  - Containers vs Virtual Machines
  - Kubernetes as a container orchestrator
  - Container options in Azure
- Azure Container Apps
  - Overview
  - Under the hood
  - Scalability
- Distributed applications
- Dapr Overview
- Dapr Building Blocks
  - State stores 
  - Service invocation
  - Pubsub brokers
  - Bindings
  - Secret stores
  - Middleware
- Local Development
  - Dapr CLI
- Deployment
  - Deploying Dapr enabled applications
  - Swapping Dapr Components
---

## Microservices
[Microservices](https://docs.microsoft.com/en-us/devops/deliver/what-are-microservices) are applications that are built with many small and independent components. These components are loosely coupled and can be updated independently. They don't need to have all the same technology stack, they can be written in different languages and frameworks and still interact between each other.
### Microservices vs Monolithics applications
Compared to Microservices, [monolithic](https://docs.microsoft.com/en-us/dotnet/architecture/microservices/architect-microservice-container-applications/containerize-monolithic-applications) applications are applications that are built from a single source code base. This is the simplest and most common type of application but it also has some drawbacks compared to modern architectures such as microservices. 

Some of the differences between monolithic and microservices are:

* Mantainability: Since monolithic apps are built from a single code base, it tends to create big repositories that are difficult to organize and collaborate on. Microservices are built from many small components that are loosely coupled and can recide in different repositories, making it easier to maintain and organize.

* Scaling: Individual parts of a monolithic application cannot be scaled independently, since it's all one big application.
The downside to this approach comes when the application grows, requiring it to scale, the whole application will need to be scaled, not just the individual components being utilized, which increases unnecessary cost and time. With microservices it's possible to scale individual components independently.

* Deployment: When we talk about releases, for monolithic applications they typically occur monthly, since the whole application is tighly coupled even if a small part of the app was updated it needs to be entirely re-tested. Small changes can have a big impact in the whole solution. Microservices in the other hand can be released often and can be tested independently, making it easier to have iterative or agile development/releases.

* Resiliency: If a part of a monolithic app is down, the whole application is down. With a more distributed microservice-based platform, you can have individual services fail and the system overall can generally gracefully handle the failures. But monolithic apps are written in a way that they often entirely fail if there's a problem.

## Containers
[Containers](https://azure.microsoft.com/en-us/overview/what-is-a-container/#overview) are software packaged along with their required libraries, configuration and dependencies they need to run. This allows you to write your application in a modular way in indepent parts that can be rapidly deployed and scaled.

The problem of an application failing to run correctly when moved from one environment to another is as old as software development itself. Such problems typically arise due to differences in configuration underlying library requirements and other dependencies.

Containers address this problem by providing a lightweight, immutable infrastructure for application packaging and deployment. An application or service, its dependencies, and its configuration are packaged together as a container image. The containerized application can be tested as a unit and deployed as a container image instance to the host operating system

See [difference between containers and virtual machines](https://docs.microsoft.com/en-us/virtualization/windowscontainers/about/containers-vs-vm)

When thinking about services to run containerized apps, there are a few options to consider in Azure. See the different [container options](https://docs.microsoft.com/en-us/azure/container-apps/compare-options) available in Azure.

### Kubernetes as a container orchestrator

Keeping containerized apps up and running can be complex because they often involve many [containers](https://azure.microsoft.com/en-us/overview/what-is-a-container/#beyond-containers) deployed across different machines. [Kubernetes](https://azure.microsoft.com/en-us/topic/what-is-kubernetes/#overview) provides a way to schedule and deploy those containers—plus scale them to your desired state and manage their lifecycles. Use Kubernetes to implement your container-based applications in a portable, scalable, and extensible way.

One of the drawbacks of using an orchestrator like Kubernetes is that it's a lot of work to get started. You have to learn a lot of new concepts and learn how to use the tools to get the job done and mantain the applications, it can get complex fast and not all organizations has the expertise or time to ramp up the engineers. That's where Azure Container Apps comes in, it's a simple and easy way to get started with containerized applications running Kubernetes under the hood.

<br/>

## Azure Container Apps (ACA)
[Azure Container Apps](https://docs.microsoft.com/en-us/azure/container-apps/overview) enables executing application code packaged in any container and is un-opinionated about runtime or programming model. With ACA, you enjoy the benefits of running containers while leaving behind the concerns of managing cloud infrastructure and complex container orchestrators.

All the good things of Kubernetes without the complexity.
ACA enables you to build serverless microservices based on containers. 
See [Distinctive features](https://docs.microsoft.com/en-us/azure/container-apps/overview#features) of Container Apps.

<br/>


### Under the hood
Azure Container Apps under the hood runs on Azure Kubernetes Service, and includes several open-source projects: Kubernetes Event Driven Autoscaling (KEDA), Distributed Application Runtime (Dapr), and Envoy. This open-source foundation enables teams to build and run portable applications powered by Kubernetes and open standards.

* KEDA: Container Apps can scale based of a wide variety of event types. Any event supported by [KEDA](https://keda.sh/docs/2.7/scalers/) is supported in Container Apps.
* Dapr: [Dapr](https://docs.microsoft.com/en-us/azure/container-apps/dapr-overview?tabs=bicep1%2Cyaml) is built-in to Container Apps, enabling you to use the Dapr API building blocks without any manual deployment of the Dapr runtime.
* Envoy: Azure Container Apps uses [Envoy](https://www.envoyproxy.io/) proxy as an edge HTTP proxy. 

### Scales to zero
Azure Container Apps manages automatic horizontal [scaling](https://docs.microsoft.com/en-us/azure/container-apps/scale-app) through a set of declarative scaling rules. As a container app scales out, new instances of the container app are created on-demand. These instances are known as replicas. When you first create a container app, the scale rule is set to zero. If your container app scales to zero, then you aren't billed usage charges.

For more information on ACA, see the [introduction](../introduction/README.md) module.

## Distributed applications
Multi-tier applications have been developed for many years, but with the advent of Cloud computing, a distributed microservice approach is fast becoming the most popular approach. Distributed systems rely on the underlying platform to provide scalability, resiliency and high-availability to their various services, although few developers are experts in designing these systems.

## Dapr Overview
The Dapr ([Distributed Application Runtime](https://docs.dapr.io/concepts/overview/)) project enables Developers to focus on business logic within their applications instead of the many challenges of designing distributed systems. Dapr provides re-usable building blocks which encapsulate best-practice patterns for distributed systems such as mutual authentication, retries, circuit-breaking and timeouts. In addition, Dapr de-couples your application code from the many implementations of message buses, state and secret stores.

Dapr is language and framework agnostic. Calls from your application to the Dapr sidecar process/container can occur over http or gRPC protocols or optionally use one of [Dapr SDK](https://docs.dapr.io/developing-applications/sdks/) packages for .NET, Go, Java, Javascript, PHP & Python.

Dapr also implements a [CLI tool](https://docs.dapr.io/reference/cli/) to run on your local development machine or Kubernetes cluster to execute managed Dapr instances & provide debugging support.

---
## Dapr Building Blocks
Dapr consists of a set of [building block components](https://docs.dapr.io/concepts/components-concept/) which provide a consistent [API surface](https://docs.dapr.io/reference/api/). Applications interact with Dapr components over a port on `http://localhost` using Http or gRPC rather than accessing cloud services directly.

Dapr components are loaded alongside your application processes. For example, if running within a Kubernetes environment, Dapr components run as sidecar containers injected alongside the application Pod. 

- Each component specification is configured at design-time via YAML files
- Each component uses a generic Dapr [component schema specification](https://docs.dapr.io/operations/components/component-schema/)
- Components of the same type can be changed without needing to change application code. 
  - For example, a pub/sub component implemented for Azure Service Bus may be substituted for another pubsub component implemented for AWS SQS.

<img src="./images/overview-sidecar-model.png" width="500" />

---
## Components
Dapr provides several [high-level component types](https://docs.dapr.io/developing-applications/building-blocks/) with implementations for many different cloud services. Each component type responds to a standard set of urls. This has the effect of de-coupling applications from the cloud service implementation.

### Component types
- State management
  - Data is stored as key/value pairs
  - [State management](https://docs.dapr.io/developing-applications/building-blocks/state-management/state-management-overview/) building block
  - [State management components](https://docs.dapr.io/reference/components-reference/supported-state-stores/)
  - `https://localhost:3500/v1.0/state/{component}`

 
- Service invocation
  - Provide name resolution for service to service invocation
  - [Name resolution](https://docs.dapr.io/reference/components-reference/supported-name-resolution/) building blocks
  - [Service invocation components](https://github.com/dapr/components-contrib/tree/master/nameresolution)
  - `https://localhost:3500/v1.0/invokde/{component}`
- Pub/sub brokers
  - Provides loosely-coupled microservice communication
  - [Publish & Subscribe](https://docs.dapr.io/developing-applications/building-blocks/pubsub/pubsub-overview/) pattern building block
  - [Pubsub components](https://docs.dapr.io/reference/components-reference/supported-pubsub/)
  - `https://localhost:3500/v1.0/publish/{component}`
  - `https://localhost:3500/v1.0/subscribe/{component}`
- Bindings
  - Input & output bindings
  - Allows an application to be triggered by external services or call external services 
  - [Binding components](https://docs.dapr.io/reference/components-reference/supported-bindings/)
  - `https://localhost:3500/v1.0/bindings/{component}`
- Secret stores
  - Provides the ability to store/retrieve information from secure external secret stores
  - [Secret store components](https://docs.dapr.io/reference/components-reference/supported-secret-stores/)
  - `https://localhost:3500/v1.0/secrets/{component}`
- Middleware
  - Custom middleware inserted into the http pipeline
  - [Middleware components](https://docs.dapr.io/reference/components-reference/supported-middleware/)
### Observability
- Provides an easy way to monitor distributed microservices through logs, metrics, tracing and health probes
  - [Distributed tracing](https://docs.dapr.io/operations/monitoring/tracing/)
  - [OpenTelemetry collector](https://docs.dapr.io/operations/monitoring/tracing/open-telemetry-collector/)
  - [Integrate common tracing backends](https://docs.dapr.io/operations/monitoring/tracing/supported-tracing-backends/)
  - New Relic, Jaeger, Zipkin, Application Insights
### Security
- [Mutual authentication (mTLS) support](https://docs.dapr.io/operations/security/mtls/)
- [Endpoint authorization with OAuth](https://docs.dapr.io/operations/security/oauth/)
- [API token authentication](https://docs.dapr.io/operations/security/api-token/)

---

<br/>

## Local Development
Dapr has a CLI tool which provides developers with the ability to write and debug their applications locally against live Dapr components.
The CLI requires a local Docker installation, suh as [Docker Desktop](https://www.docker.com/products/docker-desktop/).
### Dapr CLI
The CLI can be [downloaded for Windows, Linux & MacOs](https://docs.dapr.io/getting-started/install-dapr-cli/) systems.
- Once downloaded, it's simple to create a new development environment using `dapr` command in your shell of choice.
```
$ dapr

          __
     ____/ /___ _____  _____
    / __  / __ '/ __ \/ ___/
   / /_/ / /_/ / /_/ / /    
   \__,_/\__,_/ .___/_/     
             /_/
                                                                           
===============================
Distributed Application Runtime

Usage:
  dapr [command]

Available Commands:
  build-info     Print build info of Dapr CLI and runtime
  list           List all Dapr instances. Supported platforms: Kubernetes and self-hosted
  logs           Get Dapr sidecar logs for an application. Supported platforms: Kubernetes
  mtls           Check if mTLS is enabled. Supported platforms: Kubernetes
  publish       
...
```
- The local Dapr environment must then be initialized
```sh
$ dapr init
```
- List current dapr CLI & runtime versions
```sh
$ dapr --version
```
- Verify the supporting containers are running
```sh
$ docker ps
CONTAINER ID   IMAGE               COMMAND                  CREATED       STATUS                PORTS                              NAMES
14143d945daa   openzipkin/zipkin   "start-zipkin"           10 days ago   Up 5 days (healthy)   9410/tcp, 0.0.0.0:9411->9411/tcp   dapr_zipkin
2e0405a606b5   daprio/dapr:1.7.4   "./placement"            10 days ago   Up 5 days             0.0.0.0:50005->50005/tcp           dapr_placement
9b293cbcba60   redis               "docker-entrypoint.s…"   10 days ago   Up 5 days             0.0.0.0:6379->6379/tcp             dapr_redis
```

- Let's create a simple scenario with 2 applications, a publisher and a subscriber, connected using a queue of some kind. In this case we'll use the local Redis docker container automatically provisioned when Dapr is initialised.

- The Node applications can be found in `./assets/apps/publisher` & `./assets/apps/subscriber`.

- The Dapr Redis component is configured using the YAML file `./assets/apps/components/pubsub.yaml` shown below.
  - `type:` property indicates which component to use. A list of possible pubsub components can be found [here](https://docs.dapr.io/reference/components-reference/supported-pubsub)
  - `name:` property provides the component with a unique instance name used to reference the component from application code.
  - `metadate:` property is specific to each component implementation & contains information used to configure & authenticate to the underlying service.
```yaml
apiVersion: dapr.io/v1alpha1
kind: Component
metadata:
  name: pubsub
spec:
  type: pubsub.redis
  version: v1
  metadata:
  - name: redisHost
    value: localhost:6379
  - name: redisPassword
    value: ""
```
Ensure [Node is installed](https://nodejs.org/en/download/) and restore the package dependencies for each application
```sh
$ cd ./assets/apps/publisher
$ npm install
$ cd ../subscriber
$ npm install
```
The subscriber application code in `./assets/apps/subscriber/server.js` is shown below
```javascript
express=require('express');
bodyParser=require('body-parser');

const APP_PORT = process.env.APP_PORT || '5001';
const PUBSUB_NAME = process.env.PUBSUB_NAME || 'pubsub';
const PUBSUB_TOPIC = process.env.PUBSUB_TOPIC || 'orders';

const app = express();
app.use(bodyParser.json({ type: 'application/*+json' }));

app.get('/dapr/subscribe', (_req, res) => {
    res.json([
        {
            pubsubname: `${PUBSUB_NAME}`,
            topic: `${PUBSUB_TOPIC}`,
            route: "orders"
        }
    ]);
});

// Dapr subscription routes orders topic to this route
app.post('/orders', (req, res) => {
    console.log("Subscriber received:", req.body.data);
    res.sendStatus(200);
});

app.listen(APP_PORT);
```
- The application subscribes to the pubsub service on the path `/dapr/subscribe` using the `$PUBSUB_NAME` & `$PUBSUB_TOPIC` environment variables
- The application web server (express) listens on the port specified in the`$APP_PORT` environment variable and receives messages POSTed to the `/orders` path.

The publisher application code in `./assets/apps/publisher/server.js` is shown below.
```javascript
axios = require("axios");

const DAPR_HOST = process.env.DAPR_HOST || "http://localhost";
const DAPR_HTTP_PORT = process.env.DAPR_HTTP_PORT || "3500";
const PUBSUB_NAME = process.env.PUBSUB_NAME || "pubsub";
const PUBSUB_TOPIC = process.env.PUBSUB_TOPIC || "orders";
const sleepInMilliseconds = 1000
var i = 0

async function main() {
  while (true) { // infinite loop
    i++
    const order = { orderId: i };

    // Publish an event using Dapr pub/sub
    await axios.post(`${DAPR_HOST}:${DAPR_HTTP_PORT}/v1.0/publish/${PUBSUB_NAME}/${PUBSUB_TOPIC}`, order)
      .then(function (response) {
        console.log("Published order: " + response.config.data);
      })
      .catch(function (error) {
        // catch & print errors as JSON
        var errObj = new Object();
        errObj.message = error.message
        errObj.url = error.config.url
        errObj.method = error.config.method
        errObj.data = error.config.data
        
        console.log(JSON.stringify(errObj));
      });

    await sleep(`${sleepInMilliseconds}`);
  }
}

async function sleep(ms) {
  return new Promise(resolve => setTimeout(resolve, ms));
}

main().catch(e => console.error(e))
```
- To publish an event to Redis, the application POSTs an order object as the request body `{orderId: <order number>}` in a for loop to the local Dapr sidecar endpoint `http://localhost:3500/v1.0/publish/pubsup/orders`

Export the environment variables used by the applications
```sh
$ export PUBSUB_NAME=<metadata.name value in the ./components.yaml file>
$ export PUBSUB_TOPIC=orders
```
Run the subscriber application
```sh
$ cd ..
$ dapr run --app-id order-subscriber --components-path ./components --app-port $APP_PORT -- node ./subscriber/server.js
```
In a new terminal window, run the publisher application 
```sh
$ dapr run --app-id order-publisher --components-path ./components -- node ./publisher/server.js
```
Return to the first terminal window, where you should see the orders have been received by the subscriber application
```sh
== APP == Subscriber received: { orderId: 1 }
== APP == Subscriber received: { orderId: 2 }
== APP == Subscriber received: { orderId: 3 }
== APP == Subscriber received: { orderId: 4 }
== APP == Subscriber received: { orderId: 5 }
== APP == Subscriber received: { orderId: 6 }
== APP == Subscriber received: { orderId: 7 }
== APP == Subscriber received: { orderId: 8 }
== APP == Subscriber received: { orderId: 9 }
== APP == Subscriber received: { orderId: 10 }
...
```
List the dapr application instances
```sh
$ dapr list
```
Stop both application instances
```sh
$ dapr stop order-subscriber
$ dapr stop order-publisher
```
- Refer to the [Quickstart documentation](https://docs.dapr.io/getting-started/quickstarts/) for more Dapr quickstarts
---

## Deploying Dapr enabled applications

Azure Container Apps also has built-in support for Dapr. 

In this section, we'll be using the same example node.js applications shown earlier, package them in containers and run them in an Azure Container Apps environment. Initially we will be using an Azure Storage Queue for message storage & delivery.

To achieve this we will execute the following steps:

1. Provision an Azure Container Registry
2. Build the container images
3. Deploy an Azure Container Apps environment
4. Deploy an Azure Redis cache
5. Deploy the Dapr redis component
6. Deploy the Azure Container Apps

### 1. Provision an Azure Container Registry (ACR)

- Export environment variables
```sh
$ export LOCATION='australiaeast'
$ export RG_NAME='aca-dapr-rg'
$ export PUB_APP_NAME='order-publisher'
$ export SUB_APP_NAME='order-subscriber'
$ export SUB_APP_PORT=3000
$ export PUB_APP_PORT=3000
$ export PUBSUB_TOPIC='orders'
$ export TAG='v0.1.0'
``` 
- Create a resource group
```sh
$ az group create --name $RG_NAME --location $LOCATION
```
- Execute a Bicep template to deploy the ACR
```sh
$ az deployment group create \
    --name 'acr-deployment' \
    --resource-group $RG_NAME \
    --template-file ./deployment/acr.bicep \
    --parameters location=$LOCATION
```
- Get the ACR name from the deployment amd export it as an environment variable
```sh
$ export ACR_NAME=$(az deployment group show \
    --name 'acr-deployment' \
    --resource-group $RG_NAME \
    --query properties.outputs.name.value -o tsv)
```

### 2. Build the container images

- Send the application code to the ACR to be built
```sh
$ az acr build \
    -t $PUB_APP_NAME:$TAG \
    --registry $ACR_NAME \
    -f ./Dockerfile \
    ./apps/publisher

$ az acr build \
    -t $SUB_APP_NAME:$TAG \
    --registry $ACR_NAME \
    -f ./Dockerfile \
    ./apps/subscriber
```

### 3. Deploy an Azure Container Apps environment

<br/>

```sh
$ az deployment group create \
    --name 'aca-env-deployment' \
    --resource-group $RG_NAME \
    --template-file ./deployment/aca-env.bicep \
    --parameters location=$LOCATION
```
- Get the ACA environment name
```sh
$ export ACA_ENV_NAME=$(az deployment group show \
    --name 'aca-env-deployment' \
    --resource-group $RG_NAME \
    --query properties.outputs.name.value -o tsv)
```

### 4. Deploy the Redis cache

<br/>

```sh
$ az deployment group create \
    --name 'redis-deployment' \
    --resource-group $RG_NAME \
    --template-file ./deployment/redis.bicep \
    --parameters location=$LOCATION
```
- Get the Redis cache instance name
```sh
$ export REDIS_NAME=$(az deployment group show \
    --name 'redis-deployment' \
    --resource-group $RG_NAME \
    --query properties.outputs.name.value -o tsv)
```

### 5. Deploy the Dapr Redis component

<br/>

```sh
$ az deployment group create \
  --name 'aca-dapr-redis-component-deployment' \
  --resource-group $RG_NAME \
  --template-file ./deployment/aca-dapr-redis-component.bicep \
  --parameters acaEnvName=$ACA_ENV_NAME \
  --parameters pubAppName=$PUB_APP_NAME \
  --parameters subAppName=$SUB_APP_NAME \
  --parameters redisName=$REDIS_NAME \
  --parameters pubSubName='redis-pubsub'
```

### 6. Deploy the Azure Container Apps

<br/>

```sh
$ az deployment group create \
  --name 'aca-apps-deployment' \
  --resource-group $RG_NAME \
  --template-file ./deployment/aca-dapr-redis.bicep \
  --parameters location=$LOCATION \
  --parameters acaEnvName=$ACA_ENV_NAME \
  --parameters acrName=$ACR_NAME \
  --parameters tag=$TAG \
  --parameters redisName=$REDIS_NAME \
  --parameters pubAppName=$PUB_APP_NAME \
  --parameters pubAppPort=$PUB_APP_PORT \
  --parameters subAppName=$SUB_APP_NAME \
  --parameters subAppPort=$SUB_APP_PORT \
  --parameters pubSubName='redis-pubsub' \
  --parameters pubSubTopic=$PUBSUB_TOPIC
```
- Once the deployment has completed, review the `order-subscriber` container logs
 ```sh
 $ az containerapp logs show -n order-subscriber -g aca-dapr-rg --follow

{"TimeStamp":"2022-07-03T23:44:07.89789","Log":"Connecting to the container 'order-subscriber'..."}
{"TimeStamp":"2022-07-03T23:44:07.92267","Log":"Successfully Connected to container: 'order-subscriber' [Revision: 'order-subscriber--ffl4f8v', Replica: 'order-subscriber--ffl4f8v-5fc95db986-w65tb']"}
{"TimeStamp":"2022-07-03T23:39:22.3756732+00:00","Log":"received: { orderId: 35 }"}
{"TimeStamp":"2022-07-03T23:39:23.4013174+00:00","Log":"received: { orderId: 36 }"}
{"TimeStamp":"2022-07-03T23:39:24.4778568+00:00","Log":"received: { orderId: 37 }"}
{"TimeStamp":"2022-07-03T23:39:25.4554992+00:00","Log":"received: { orderId: 38 }"}
{"TimeStamp":"2022-07-03T23:39:26.4825375+00:00","Log":"received: { orderId: 39 }"}
{"TimeStamp":"2022-07-03T23:39:27.5114695+00:00","Log":"received: { orderId: 40 }"}
{"TimeStamp":"2022-07-03T23:39:28.630779+00:00","Log":"received: { orderId: 41 }"}
...
 ```
  - Alternatively, the logs can be viewed in the Azure Portal : Container App -> Log stream.


<br/>

## Swapping Dapr components

Finally, we can see how easy it is to swap Dapr components of the same type. In the next example, the Azure Redis cache instance will be exchanged for an Azure Service Bus instance. 

Note that no code changes will need to be made to either application.

### 1. Create an Azure Service Bus instance

<br/>

```sh
$ az deployment group create \
    --name 'sbus-deployment' \
    --resource-group $RG_NAME \
    --template-file ./deployment/sbus.bicep \
    --parameters location=$LOCATION
```
- Export the service bus details
```sh
$ export SBUS_NAME=$(az deployment group show \
    --name 'sbus-deployment' \
    --resource-group $RG_NAME \
    --query properties.outputs.name.value -o tsv)
```

### 2. Deploy the Dapr Service Bus component

<br/>

```sh
$ az deployment group create \
  --name 'aca-dapr-sbus-component-deployment' \
  --resource-group $RG_NAME \
  --template-file ./deployment/aca-dapr-sbus-component.bicep \
  --parameters acaEnvName=$ACA_ENV_NAME \
  --parameters pubAppName=$PUB_APP_NAME \
  --parameters subAppName=$SUB_APP_NAME \
  --parameters sbusName=$SBUS_NAME \
  --parameters pubSubName='sbus-pubsub'
```

### 3. Increment the container image tags from `v0.1.0` to `v0.1.1`
- This is one way to force a new container app revision
<br/>

```sh
$ export LATEST_TAG='v0.1.1'

$ az acr import --name $ACR_NAME \
  --source $ACR_NAME.azurecr.io/$SUB_APP_NAME:$TAG \
  --image $SUB_APP_NAME:$LATEST_TAG --force

 $ az acr import --name $ACR_NAME \
  --source $ACR_NAME.azurecr.io/$PUB_APP_NAME:$TAG \
  --image $PUB_APP_NAME:$LATEST_TAG --force
 ```
 - Remove the `redis-pubsub` dapr component
 ```sh
 $ az containerapp env dapr-component remove -g $RG_NAME -n $ACA_ENV_NAME --dapr-component-name 'redis-pubsub'
 ```
 ### 4. Re-deploy the container apps 
 - The configuration will now reference the new image tag, which forces the creation of a new Container App revision

 ```sh
 $ az deployment group create \
  --name 'aca-apps-deployment' \
  --resource-group $RG_NAME \
  --template-file ./deployment/aca-dapr-sbus.bicep \
  --parameters location=$LOCATION \
  --parameters acaEnvName=$ACA_ENV_NAME \
  --parameters acrName=$ACR_NAME \
  --parameters tag=$LATEST_TAG \
  --parameters sbusName=$SBUS_NAME \
  --parameters pubAppName=$PUB_APP_NAME \
  --parameters pubAppPort=$PUB_APP_PORT \
  --parameters subAppName=$SUB_APP_NAME \
  --parameters subAppPort=$SUB_APP_PORT \
  --parameters pubSubName='sbus-pubsub' \
  --parameters pubSubTopic=$PUBSUB_TOPIC
 ```
 - Review the `order-subscriber` container logs
 ```sh
 $ az containerapp logs show -n order-subscriber -g aca-dapr-rg --follow

 {"TimeStamp":"2022-07-04T01:16:57.91128","Log":"Connecting to the container 'order-subscriber'..."}
{"TimeStamp":"2022-07-04T01:16:57.93972","Log":"Successfully Connected to container: 'order-subscriber' [Revision: 'order-subscriber--ffl4f8v', Replica: 'order-subscriber--ffl4f8v-5fc95db986-w65tb']"}
{"TimeStamp":"2022-07-04T01:12:31.2009743+00:00","Log":"received: { orderId: 38 }"}
{"TimeStamp":"2022-07-04T01:12:32.2166395+00:00","Log":"received: { orderId: 39 }"}
{"TimeStamp":"2022-07-04T01:12:33.2288081+00:00","Log":"received: { orderId: 40 }"}
{"TimeStamp":"2022-07-04T01:12:34.2422719+00:00","Log":"received: { orderId: 41 }"}
{"TimeStamp":"2022-07-04T01:12:35.3095798+00:00","Log":"received: { orderId: 42 }"}
{"TimeStamp":"2022-07-04T01:12:36.2982969+00:00","Log":"received: { orderId: 43 }"}
{"TimeStamp":"2022-07-04T01:12:37.3142306+00:00","Log":"received: { orderId: 44 }"}
{"TimeStamp":"2022-07-04T01:12:38.3303587+00:00","Log":"received: { orderId: 45 }"}
...
 ```
