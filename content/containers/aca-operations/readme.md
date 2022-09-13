# Operations


## Container Apps and Environment


### Container App Environment
- Hosts and provides a secured boundary for conatiner apps.
- Can be integrated with Vnets
	- [External Environment - Vnet integrated](https://docs.microsoft.com/en-us/azure/container-apps/vnet-custom)
	- [Internal Environment - Vnet integrated](https://docs.microsoft.com/en-us/azure/container-apps/vnet-custom-internal)
- Zone redundancy is supported only with VNet integrated environment.
- Native DNS for hosted apps within environment.

```bicep
{
  name: name
  location: location
  
  properties: {
       appLogsConfiguration: {
      destination: 'log-analytics'
      logAnalyticsConfiguration: {
        customerId: logsClientId  // loganalytics workspace client id
        sharedKey: logsClientSecret // loganalytics workspace client secret
      }
      
    }
    vnetConfiguration: {
      internal: false
      infrastructureSubnetId: infrasubnet
      dockerBridgeCidr: '10.2.0.1/16'
      platformReservedCidr: '10.1.0.0/16'
      platformReservedDnsIP: '10.1.0.2'
    }
    zoneRedundant: true
  } 
}
```

## Container Apps

- Containers in Azure Container Apps can use any runtime, programming language, or development stack of your choice.
- Any Linux-based x86-64 (linux/amd64) container image.
- Containers from any public or private container registry

### Limitations:
- Windows containers are not supported.
- Azure Container Apps can't run privileged containers. If your program attempts to run a process that requires root access, the application inside the container experiences a runtime error.
- The only supported protocols for a container app's fully qualified domain name (FQDN) are HTTP and HTTPS through ports 80 and 443 respectively.

Best Practices:

- For private Container Apps, deploy the Container App Environment in VNet.
- Use Managed Identity to authenticate to services like Azure Container registry.


### Multiple Containers:

- You can deploy multiple containers in a container App by adding more than one containers in the template.
- The containers in a container app will share same hard disk and network resources and will have the same application lifeccyle.

Use cases:

- Use a container as a sidecar to your primary app.
- Share disk space and the same virtual network.
- Share scale rules among containers.
- Group multiple containers that need to always run together.
- Enable direct communication among containers.

## Revisions

Revision is an immutable snapshot of your container app version. When you deploy/update the containers in an ACA, the service will automatically create a snapshot of your application,called revisions ,and run its containers in a pod.

- The first revision is automatically created when you deploy your container app.
- New revisions are automatically created when you make a revision-scope change to your container app.
- While revisions are immutable, they're affected by application-scope changes, which apply to all revisions.
- You can retain up to 100 revisions, giving you a historical record of your container app updates.
- You can run multiple revisions concurrently.
- You can split external HTTP traffic between active revisions.

You can have single or multiple revisions active at a time by setting the revision mode.

![Revisions](https://docs.microsoft.com/en-us/azure/container-apps/media/revisions/azure-container-apps-revisions.png)

### Revision name

The format of revision name is :

containerappname--revisionsuffix

Container App adds a random string as revision suffix , but you can also customise it by adding it in the [template](https://docs.microsoft.com/en-us/azure/templates/microsoft.app/containerapps?tabs=bicep#template-format) or from CLI and portal :
 
```bicep    
revisionSuffix: 'string'
```

### Update Scopes

- Revision-Scope changes: Any change made to the parameters in the properties.template(i.e revisionSuffix , scale rules, container properties and image) section of the container app is considered to be revision-scope change. It creates a new revision.
- Application-Scope changes: Any change made to the parameters in the properties.configuration(i.e. secrets, ingress,dapr settings) section of the container app resource template is considered to be application-scope change. It doesnot create a new revision , but is applied to all the revisions.
    
 
### Use Cases

- A/B Testing
- Blue/GreenDeployment
- new version of your App
- Traffic splitting

### Traffic Splitting

- You can split http traffic to different revisions by assigning percentage to them.
```bicep

traffic: [
            {
              revisionName: '<REVISION1_NAME>' 
              weight: 80
             }
             {
              revisionName: '<REVISION2_NAME>' 
              weight: 20
              }
          ]
                 
```

## Application Lifecycle Management

- Container Apps application lifecycle revolves around revisions.
- Revisions are immutable snapshots of a version of a Container App.
- When a Container Apps is first deployed, the first revision of that Container App is automatically created.
- New revisions are created when *revision-scope* changes are made to the Container App. New revisions are also created when we change the ``template`` section of the Container Apps configuration.
- Up to 100 revisions can be retained.
- You can run multiple revisions concurrently, allowing you to split external HTTP traffic between active revisions.

Container Apps flow through 3 different phases:

1. **Deployment**
    1. When a container app is deployed, the first revision for that container app is automatically created.
1. **Update**
    1. When we update a container app with a *revision-scope* change, a new revision is created.
    1. We can either automatically deactivate the old revision, or make multiple revisions available.
1. **Deactivation**
    1. Once a revision is no longer needed, we can deactivate that revision (We can reactivate the revision later).
    1. Containers in the revision are shut down during deactivation.

Containers are shut down when:

- A container app scales in.
- A container app is being deleted
- A revision is being deactivated.

When shutdown is initiated, the host will send a [SIGTERM](https://en.wikipedia.org/wiki/Signal_(IPC)) message to the container. If the application does not respond to the ``SIGTERM`` message within 30 seconds, then [SIGKILL](https://en.wikipedia.org/wiki/Signal_(IPC)) will terminate the container.

Read more:

- [Application Lifecycle Management in Azure Container Apps](https://docs.microsoft.com/en-us/azure/container-apps/application-lifecycle-management)
- [Revisions in Azure Container Apps](https://docs.microsoft.com/en-us/azure/container-apps/revisions#revision-scope-changes)



## Scaling

Container Apps manages horizontal scaling through a set of declarative rules. As our app scales out, new instances of the container app are created on demand.

These instances are known as **replicas**. 

You define scaling rules in the ``resources.properties.template.scale`` section of your Bicep or ARM template. Changes to scaling rules are **revision-scope** changes.

There are two scale properties that apply to all rules in your container app:

| **Scale property** | **Description** | **Default value** | **Min value** | **Max value** |
| --- | --- | --- | --- | --- |
| ``minReplicas`` | Minimum number of replicas running for your container app. | 0 | 0 | 30 |
| ``maxReplicas`` | Maximum number of replicas running for your container app. | 10 | 1 | 30 |

### Scaling on HTTP Traffic

You can scale Container Apps based on the number of concurrent HTTP requests made to your revision. With HTTP scaling rules, you control the threshold that determines when to scale out.

| **Scale property** | **Description** | **Default value** | **Min value** | **Max value** |
| --- | --- | --- | --- | --- |
| ``concurrentRequests`` | When the number of requests exceeds the defined value, another replica is added. Replicas will continue to be added up the defined ``maxReplicas`` amount as the number of concurrent requests increase. | 10 | 1 | n/a |

Take the following Bicep example (*Some properties have been omitted for brevity. Please refer to the [Bicep API reference](https://docs.microsoft.com/azure/templates/microsoft.app/containerapps?tabs=bicep) for the full template along with required properties.*):

```bicep
{
    resources: {
        properties: {
            template: {
                scale: {
                   minReplicas: 0,
                   maxReplicas: 5,
                   rules": [{
                     name: 'http-rule',
                     http: {
                       metadata: {
                          concurrentRequests: 100
                      }
                    }
                  }]
                }
            }
        }
    }
}
```

In the above example, this Container App can scale between 0-5 replicas and the threshold is set to 100 concurrent requests per second. 

### Scaling on Events

You can scale your Container Apps on any event that is supported by KEDA. Each event type features different properties in the ``metadata`` section of the KEDA definition, which you use to define a scale rule in Container Apps.

Take the following example:

```bicep
{
  ...
  resources: {
    ...
    properties: {
      configuration: {
        secrets: [{
          name: 'servicebusconnectionstring',
          value: '<MY-CONNECTION-STRING-VALUE>'
        }],
      },
      template: {
        ...
        scale: {
          minReplicas: 0,
          maxReplicas: 30,
          rules: [
          {
            name: 'queue-based-autoscaling',
            custom: {
              type: 'azure-servicebus',
              metadata: {
                queueName: myServiceBusQueue,
                messageCount: 20
              },
              auth: [{
                secretRef: 'servicebusconnectionstring',
                triggerParameter: connection
              }]
        }
    }]
}
```

In this scaling rule, a new replica will be created for every 20 messages placed on the queue. The connection string is provided as a parameter to our configuration file and referenced in the ``secretRef`` property.

### Converting KEDA scalers to Container Apps

- Azure Container Apps supports KEDA ScaledObjects and all of the available KEDA scalers.
- To convert KEDA templates to Container Apps, you should start with a JSON template and add the parameters required for the scale trigger.
- To set up a scale rule in Azure Container Apps, you'll need to provide the trigger type, along with any other required parameters for that trigger.
- KEDA ScaledJobs are not supported in Azure Container Apps.

### CPU

- CPU scaling allows to scale depending on how much CPU is being used in your Container App.
- This doesn't allow your container app to scale to 0.

Take the following example:

```bicep
{
  ...
  resources: {
    ...
    properties: {
      ...
      template: {
        ...
        scale: {
          minReplicas: 1,
          maxReplicas: 10,
          rules: [{
            name: 'cpuScalingRule',
            custom: {
              type: 'cpu',
              metadata: {
                type: 'Utilization',
                value: 70
              }
            }
          }]
        }
      }
    }
  }
}
```

This app will scale when CPU usage exceeds 70%.

### Memory

- Memory scaling allows your container app to scale in or out depending on memory utilization.
- Like CPU, you can't scale to 0 when scaling on memory.

Take the following example:

```bicep
{
  ...
  resources: {
    ...
    properties: {
      ...
      template: {
        ...
        scale: {
          minReplicas: 1,
          maxReplicas: 10,
          rules: [{
            name: 'memoryScalingRule',
            custom: {
              type: 'memory',
              metadata: {
                type: 'Utilization',
                value: 70
              }
            }
          }]
        }
      }
    }
  }
}
```

This will scale our container app when memory usage exceeds 70%.

For further scaling considerations, read this [section](https://docs.microsoft.com/en-us/azure/container-apps/scale-app#considerations).

## [Managed Identity](https://docs.microsoft.com/en-us/azure/container-apps/managed-identity?tabs=portal%2Cdotnet#add-a-user-assigned-identity)


Managed identity allows your container app to access other Azure services which supports AD without managing any credentials.

There are two types of managed identities which can be used by your container app:

- System-assigned identity: It is tied to your container app lifecycle and can only be used by that resource. An app can only have one system-assigned identity.
- A user-assigned identity: It is a standalone Azure resource that can be assigned to your container app and other resources. You can assign multiple user-assigned identities to container app. The identity exists until you delete them.

### Limitations

- The identity is only available within a running container, which means you can't use a managed identity in scaling rules or Dapr configuration.
- To access resources that require a connection string or key, such as storage resources, you'll still need to include the connection string or key in the secretRef of the scaling rule.

### Configure Target Resource

You will need to assign permissions(RBAC) to your managed identity on the target resource to access it from your app. The back-end services for managed identities might maintain a cache per resource URI for upto 24 hours. If you update the access policy of a particular target resource and immediately retrieve a token for that resource, you may continue to get a cached token with outdated permissions until that token expires. There's currently no way to force a token refresh.

### Configuration

You can [enable system identity](https://docs.microsoft.com/en-us/azure/container-apps/managed-identity?tabs=portal%2Cdotnet#add-a-system-assigned-identity) or [assign user identity](https://docs.microsoft.com/en-us/azure/container-apps/managed-identity?tabs=portal%2Cdotnet#add-a-user-assigned-identity) during or after resource creation.



```bicep
identity: {
    type: 'SystemAssigned'
  }
``` 

```bicep
identity: {
    type: 'UserAssigned'
    userAssignedIdentities: {
          '[resourceId(variables('userAssignedIdentitySubscription'),variables('userAssignedIdentityResourceGroup'),'Microsoft.ManagedIdentity/userAssignedIdentities', variables('userAssignedIdentityName'))]': {}
          ssignedIdentities: {
          '[resourceId(variables('userAssignedIdentitySubscription'),variables('userAssignedIdentityResourceGroup'),'Microsoft.ManagedIdentity/userAssignedIdentities', variables('userAssignedIdentityName'))]': {}
        }
  }
```

```bicep
identity: {
        type: 'SystemAssigned,UserAssigned'
        userAssignedIdentities: {
          '[resourceId(variables('userAssignedIdentitySubscription'),variables('userAssignedIdentityResourceGroup'),'Microsoft.ManagedIdentity/userAssignedIdentities', variables('userAssignedIdentityName'))]': {}
        }
    }
``` 
  
## [Authentication](https://docs.microsoft.com/en-us/azure/container-apps/authentication)

Azure Container Apps provides built-in authentication and authorization features (sometimes referred to as "Easy Auth"), to secure your external ingress-enabled container app with minimal or no code. It gives you an option to easily enable authentication at the infrastructure level with built-in authentication for Azure AD and the usual B2C providers.

Container Apps uses federated identity, in which a third-party identity provider manages the user identities and authentication flow for you. The following identity providers are available by default:

- Azure Active Directory
- Facebook
- GitHub
- Google
- Twitter
- Custom OpenID Connect

### Considerations

- This feature should be used with "HTTPS" only.
- "Allow insecure" should be disabled.

### Architecture and Workflow

The authentication and authorization middleware component is injected as a sidecar container on each replica in your application. All incoming request passes through this component , before it reaches to your application. The component performs :

- Authentication of users and clients with the specified identity provider(s)
- Manages the authenticated session
- Injects identity information into HTTP request headers

![Architecture](https://docs.microsoft.com/en-us/azure/container-apps/media/authentication/architecture.png#lightboxImage)

The authentication flow is same for all providers but differs on the usage of provider SDK:

- Without provider SDK: The federation sign-in is delegated to Container apps. It is mainly used for browser apps , where the sign-in page is provided by application.
- With provider SDK: The provided signs in the user and passes the token to Container App for validation.


## Secrets

You can securely store sensitive configuration values as secrets in Azure Container Apps. Once defined, these are available to containers, inside scale rules and via Dapr.

- Secrets are scoped to an application, outside the specific revision of that application.
- Changing, adding and removing secrets does not generate a new revision of your application.
- Each application revision can reference one or more secrets
- Multiple revisions can reference the same secret.
- When a secret is deleted or updated, you can respond to the change by either:
  - Deploying a new revision, or
  - Restarting an existing revision.
- Updated or removed secrets do not automatically restart a revision.
- Before you delete a secret, you will need to deploy a new revision that no longer references that secret. If you change the value of the secret, you'll need to restart the revision to consume the new value.

### Defining and Using Secrets

Secrets are defined at the application level in the ``resources.properties.configuration.secrets`` section. They are then referenced via the ``secretref`` property. The values of secrets are mapped to application-level secrets where the value of ``secretref`` matches the secret name declared at the application level.

Take the following Bicep example (*Some properties have been omitted for brevity. Please refer to the [Bicep API reference](https://docs.microsoft.com/azure/templates/microsoft.app/containerapps?tabs=bicep) for the full template along with required properties.*):

```bicep
properties: {
    managedEnvironmentId: containerAppEnv.id
    configuration: {
      secrets: [
        {
          name: 'queue-connection-string'
          value: '<QUEUE-CONNECTION-STRING-VALUE>'
        }
      ]
    }
    template: {
      containers: [
        {
          image: 'myregistry/myQueueApp:'
          name: todoApiName
          env: [
            {
                "name": "QueueName",
                "value": "myqueue"
            },
            {
                "name": "ConnectionString",
                "secretref": "queue-connection-string"
            }
          ]
        }
      ]
      scale: {
        minReplicas: minReplicas
        maxReplicas: maxReplicas
      }
    }
  }
```

We define a connection string at the application level called ``queue-connection-string``. This will become available to our Container Apps configuration. 

In the ``containers`` property, we reference our secret in our environment variables for our container.

Avoid committing secrets to source control. Pass secrets as parameters in your Bicep or ARM template instead.

Read more:

- [Manage secrets in Azure Container Apps](https://docs.microsoft.com/azure/container-apps/manage-secrets?tabs=arm-template)
- [Manage secrets by using Bicep](https://docs.microsoft.com/azure/azure-resource-manager/bicep/scenarios-secrets)

## Custom domain and Certificates

You can add custom domain to your Container App. Currently, you need to supply your own certificate, rather than have MS supply one.

Pre-requisites:
- Every domain needs a domain cert separately.
- Certificates are for individual container app and bound to container app only.
- SNI Certs needed are needed. If you are using a new certificate, you must have an existing SNI domain certificate file available to upload to Azure.
- [HTTP Ingress](https://docs.microsoft.com/en-us/azure/container-apps/ingress) must be enabled on container app.

You can manage(add/remove/renew) your certificates from container app environment or through individual container apps.

There is a great article about how to use Let’s Encrypt to generate certs for ACA [here](https://dev.to/shibayan/how-to-quickly-setup-a-lets-encrypt-certificate-in-azure-container-apps-3nd7)


## Health probes

[Kubernetes health probes](https://kubernetes.io/docs/tasks/configure-pod-container/configure-liveness-readiness-startup-probes/) like liveness, readiness, and startup probes ,which are mission-critical when deploying applications, are supported on Azure container Apps using either TCP or HTTP(S) probes. 

- HTTP Probes: Implement custom logic to check the status of application dependencies before reporting a healthy status. Success status code should be greater than or equal to 200 , but less than 400.
- TCP Probes: TCP probes wait for a connection to be established with the server to indicate success. A probe failure is registered if no connection is made.

### Limitations

- You can only add one of each probe type per container.
- exec probes aren't supported.
- Port values must be integers; named ports aren't supported.
- gRPC is not supported.

```bicep

probes: [
                        {
                            type: 'liveness'
                            initialDelaySeconds: 15
                            periodSeconds: 30
                            failureThreshold: 3
                            timeoutSeconds: 1
                            httpGet: {
                                port: containerPort
                                path: '/healthz/liveness'
                            }
                        }
                        {
                            type: 'startup'
                            timeoutSeconds: 2
                            httpGet: {
                                port: containerPort
                                path: '/healthz/startup'
                            }
                        }
                        {
                            type: 'readiness'
                            timeoutSeconds: 3
                            failureThreshold: 3
                            httpGet: {
                                port: containerPort
                                path: '/healthz/readiness'
                            }
                        }
                    ]
                    
 ```

## Logging and Monitoring

Container Apps provides built-in observability to provide information on the health of your container app's health throughout its lifecycle. These help you monitor the state of your app to improve performance and respond to critical problems.

These features include:

- Log streaming.
- Container console.
- Azure Monitor metrics.
- Azure Monitor Log Analytics.
- Azure Monitor alerts.

You can also use Application Insights to monitor the code in you containers. Container Apps doesn't support the Application Insights auto-instrumentation agent, but you can instrument your application code using Application Insights SDKs.


## Business Continuity and Disaster Recovery

### Uptime SLA of Azure Container Apps

- The financially backed uptime SLA for Azure Container Apps running in a customer subscription is **99.95**%. 

Read further:

- [SLA for Azure Container Apps](https://azure.microsoft.com/support/legal/sla/container-apps/v1_0/)

### BC/DR best practices

- Azure Container Apps use availability zones to provide high-availability protection for applications and data from data center failures.
- In the event of a full region outage, you have 2 recovery strategies:

    1. **Manual recovery** - Deploy to a new region manually, or wait for region to recover so you can redeploy all environments and apps.
    1. **Resilient recovery** - Deploy Container Apps in advance to multiple regions. You can then use either Azure Front Door or Azure Traffic Manager to handle incoming requests to your Container Apps to point to your primary region. Should an outage occur, you can redirect traffic away from the affected region.

- Ensure that the deployment configuration for your Container Apps are stored in source control so you can redeploy your environment if necessary.

Read further:

- [Disaster Recovery guidance for Azure Container Apps](https://docs.microsoft.com/azure/container-apps/disaster-recovery)
- [Backup and disaster recovery for Azure applications](https://docs.microsoft.com/azure/architecture/framework/resiliency/backup-and-recovery)
