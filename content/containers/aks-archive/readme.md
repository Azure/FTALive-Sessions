# Service Mesh

A service mesh provides capabilities like traffic management, resiliency, policy, security, strong identity, and observability to your workloads. Your application is decoupled from these operational capabilities and the service mesh moves them out of the application layer, and down to the infrastructure layer.

Modern applications are typically architected as distributed collections of microservices, with each collection of microservices performing some discrete business function. A service mesh is a dedicated infrastructure layer that you can add to your applications. It allows you to transparently add capabilities like observability, traffic management, and security, without adding them to your own code. The term “service mesh” describes both the type of software you use to implement this pattern, and the security or network domain that is created when you use that software.

Most common use cases:

- Encrypt all traffic in cluster
- Canary and phased rollouts
- Traffic management and manipulation
- Observability

## Istio

Istio is an open source service mesh that layers transparently onto existing distributed applications. Istio’s powerful features provide a uniform and more efficient way to secure, connect, and monitor services. Istio is the path to load balancing, service-to-service authentication, and monitoring – with few or no service code changes.

- Secure service-to-service communication in a cluster with TLS encryption, strong identity-based authentication and authorization.
- Automatic load balancing for HTTP, gRPC, WebSocket, and TCP traffic.
- Fine-grained control of traffic behavior with rich routing rules, retries, failovers, and fault injection.
- A pluggable policy layer and configuration API supporting access controls, rate limits and quotas.
- Automatic metrics, logs, and traces for all traffic within a cluster, including cluster ingress and egress.

**Kiali Dashboard:** Walk through on Kiali dashboard

[**Getting Started with Istio**](https://istio.io/latest/docs/setup/getting-started/)

## Linkerd

Linkerd is a service mesh. It adds observability, reliability, and security to Kubernetes applications without code changes. For example, Linkerd can monitor and report per-service success rates and latencies, can automatically retry failed requests, and can encrypt and validate connections between services, all without requiring any modification of the application itself.

Linkerd is significantly lighter and simpler than Istio. Linkerd is built for security from the ground up, ranging from features like on-by-default mTLS, a data plane that is built in a Rust, memory-safe language, and regular security audits. Finally, Linkerd has publicly committed to open governance and is hosted by the CNCF.

**Linkerd Dashboard:** Walk through on Linkerd dashboard

[**Getting Started with Linkerd**](https://linkerd.io/2.11/getting-started/)

## Open Service Mesh (OSM)

Open Service Mesh (OSM) is a lightweight, extensible, cloud native service mesh that allows users to uniformly manage, secure, and get out-of-the-box observability features for highly dynamic microservice environments.

OSM runs an Envoy-based control plane on Kubernetes and can be configured with SMI APIs. OSM works by injecting an Envoy proxy as a sidecar container with each instance of your application. The Envoy proxy contains and executes rules around access control policies, implements routing configuration, and captures metrics. The control plane continually configures the Envoy proxies to ensure policies and routing rules are up to date and ensures proxies are healthy.

The OSM project was originated by Microsoft and has since been donated and is governed by the Cloud Native Computing Foundation (CNCF).

OSM can be integrated with [Azure Monitor and Azure Application insights](https://docs.microsoft.com/azure/aks/open-service-mesh-azure-monitor):

OSM can also be integrated with [Prometheus and Grafana](https://release-v0-11.docs.openservicemesh.io/docs/demos/prometheus_grafana/):

[**Getting Started with Open Service Mesh**](https://docs.microsoft.com/azure/aks/open-service-mesh-about)