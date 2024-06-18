param monitorWorkspaceName string
param location string
param aksResourceId string
param actionGroupResourceId string

resource monitorWorkspace 'Microsoft.Monitor/accounts@2023-04-03' = {
  name: monitorWorkspaceName
  location: location
  tags: {}
  properties: {}
}


resource recommendedAlerts 'Microsoft.AlertsManagement/prometheusRuleGroups@2023-03-01' = {
  name: 'RecommendedCIAlerts-${split(aksResourceId, '/')[8]}'
  location: location
  properties: {
    description: 'Kubernetes Alert RuleGroup-RecommendedCIAlerts - 0.1'
    scopes: [
      monitorWorkspace.id
    ]
    clusterName: split(aksResourceId, '/')[8]
    enabled: true
    interval: 'PT5M'
    rules: [
      {
        alert: 'Average CPU usage per container is greater than 95%'
        expression: 'sum (rate(container_cpu_usage_seconds_total{image!="", container_name!="POD"}[5m])) by (pod,cluster,container,namespace) / sum(container_spec_cpu_quota{image!="", container_name!="POD"}/container_spec_cpu_period{image!="", container_name!="POD"}) by (pod,cluster,container,namespace) > .95'
        for: 'PT5M'
        annotations: {
          description: 'Average CPU usage per container is greater than 95%'
        }
        enabled: true
        severity: 4
        resolveConfiguration: {
          autoResolved: true
          timeToResolve: 'PT15M'
        }
        actions: [
          {
            actionGroupId: actionGroupResourceId
          }
        ]
      }
      {
        alert: 'Average Memory usage per container is greater than 95%.'
        expression: '(container_memory_working_set_bytes{container!="", image!="", container_name!="POD"} / on(namespace,cluster,pod,container) group_left kube_pod_container_resource_limits{resource="memory", node!=""}) > .95'
        for: 'PT10M'
        annotations: {
          description: 'Average Memory usage per container is greater than 95%'
        }
        enabled: true
        severity: 4
        resolveConfiguration: {
          autoResolved: true
          timeToResolve: 'PT10M'
        }
        actions: [
          {
            actionGroupId: actionGroupResourceId
          }
        ]
      }
      {
        alert: 'Number of OOM killed containers is greater than 0'
        expression: 'sum by (cluster,container,namespace)(kube_pod_container_status_last_terminated_reason{reason="OOMKilled"}) > 0'
        for: 'PT5M'
        annotations: {
          description: 'Number of OOM killed containers is greater than 0'
        }
        enabled: true
        severity: 4
        resolveConfiguration: {
          autoResolved: true
          timeToResolve: 'PT10M'
        }
        actions: [
          {
            actionGroupId: actionGroupResourceId
          }
        ]
      }
      {
        alert: 'Average PV usage is greater than 80%'
        expression: 'sum by (namespace,cluster,container,pod)(kubelet_volume_stats_used_bytes{job="kubelet"}) / sum by (namespace,cluster,container,pod)(kubelet_volume_stats_capacity_bytes{job="kubelet"})  >.8'
        for: 'PT5M'
        annotations: {
          description: 'Average PV usage is greater than 80%'
        }
        enabled: true
        severity: 4
        resolveConfiguration: {
          autoResolved: true
          timeToResolve: 'PT15M'
        }
        actions: [
          {
            actionGroupId: actionGroupResourceId
          }
        ]
      }
      {
        alert: 'Pod container restarted in last 1 hour'
        expression: 'sum by (namespace, pod, container, cluster) (kube_pod_container_status_restarts_total{job="kube-state-metrics", namespace="kube-system"}) > 0 '
        for: 'PT15M'
        annotations: {
          description: 'Pod container restarted in last 1 hour'
        }
        enabled: true
        severity: 4
        resolveConfiguration: {
          autoResolved: true
          timeToResolve: 'PT10M'
        }
        actions: [
          {
            actionGroupId: actionGroupResourceId
          }
        ]
      }
      {
        alert: 'Node is not ready.'
        expression: 'sum by (namespace,cluster,node)(kube_node_status_condition{job="kube-state-metrics",condition="Ready",status!="true", node!=""}) > 0'
        for: 'PT15M'
        annotations: {
          description: 'Node has been unready for more than 15 minutes '
        }
        enabled: true
        severity: 4
        resolveConfiguration: {
          autoResolved: true
          timeToResolve: 'PT15M'
        }
        actions: [
          {
            actionGroupId: actionGroupResourceId
          }
        ]
      }
      {
        alert: 'Ready state of pods is less than 80%. '
        expression: 'sum by (cluster,namespace,deployment)(kube_deployment_status_replicas_ready) / sum by (cluster,namespace,deployment)(kube_deployment_spec_replicas) <.8 or sum by (cluster,namespace,deployment)(kube_daemonset_status_number_ready) / sum by (cluster,namespace,deployment)(kube_daemonset_status_desired_number_scheduled) <.8 '
        for: 'PT5M'
        annotations: {
          description: 'Ready state of pods is less than 80%.'
        }
        enabled: true
        severity: 4
        resolveConfiguration: {
          autoResolved: true
          timeToResolve: 'PT15M'
        }
        actions: [
          {
            actionGroupId: actionGroupResourceId
          }
        ]
      }
      {
        alert: 'Job did not complete in time'
        expression: 'sum by(namespace,cluster)(kube_job_spec_completions{job="kube-state-metrics"}) - sum by(namespace,cluster)(kube_job_status_succeeded{job="kube-state-metrics"})  > 0 '
        for: 'PT360M'
        annotations: {
          description: 'Number of stale jobs older than six hours is greater than 0'
        }
        enabled: true
        severity: 4
        resolveConfiguration: {
          autoResolved: true
          timeToResolve: 'PT15M'
        }
        actions: [
          {
            actionGroupId: actionGroupResourceId
          }
        ]
      }
      {
        alert: 'Average node CPU utilization is greater than 80%'
        expression: '(  (1 - rate(node_cpu_seconds_total{job="node", mode="idle"}[5m]) ) / ignoring(cpu) group_left count without (cpu)( node_cpu_seconds_total{job="node", mode="idle"}) ) > .8 '
        for: 'PT5M'
        annotations: {
          description: 'Average node CPU utilization is greater than 80%'
        }
        enabled: true
        severity: 4
        resolveConfiguration: {
          autoResolved: true
          timeToResolve: 'PT15M'
        }
        actions: [
          {
            actionGroupId: actionGroupResourceId
          }
        ]
      }
      {
        alert: 'Working set memory for a node is greater than 80%.'
        expression: '1 - avg by (namespace,cluster,job)(node_memory_MemAvailable_bytes{job="node"}) / avg by (namespace,cluster,job)(node_memory_MemTotal_bytes{job="node"}) > .8'
        for: 'PT5M'
        annotations: {
          description: 'Working set memory for a node is greater than 80%.'
        }
        enabled: true
        severity: 4
        resolveConfiguration: {
          autoResolved: true
          timeToResolve: 'PT15M'
        }
        actions: [
          {
            actionGroupId: actionGroupResourceId
          }
        ]
      }
      {
        alert: 'Number of pods in failed state are greater than 0.'
        expression: 'sum by (cluster, namespace, pod) (kube_pod_status_phase{phase="failed"}) > 0'
        for: 'PT5M'
        annotations: {
          description: 'Number of pods in failed state are greater than 0'
        }
        enabled: true
        severity: 4
        resolveConfiguration: {
          autoResolved: true
          timeToResolve: 'PT15M'
        }
        actions: [
          {
            actionGroupId: actionGroupResourceId
          }
        ]
      }
    ]
  }
}

resource communityALerts 'Microsoft.AlertsManagement/prometheusRuleGroups@2023-03-01' = {
  name: 'communityCIAlerts-${split(aksResourceId, '/')[8]}'
  location: location
  properties: {
    description: 'Kubernetes Alert RuleGroup-communityCIAlerts - 0.1'
    scopes: [
      monitorWorkspace.id
    ]
    clusterName: split(aksResourceId, '/')[8]
    enabled: true
    interval: 'PT1M'
    rules: [
      {
        alert: 'KubePodCrashLooping'
        expression: 'max_over_time(kube_pod_container_status_waiting_reason{reason="CrashLoopBackOff", job="kube-state-metrics"}[5m]) >= 1'
        for: 'PT15M'
        labels: {
          severity: 'warning'
        }
        severity: 3
        enabled: true
        resolveConfiguration: {
          autoResolved: true
          timeToResolve: 'PT10M'
        }
        actions: [
          {
            actionGroupId: actionGroupResourceId
          }
        ]
      }
      {
        alert: 'KubePodNotReady'
        expression: 'sum by (namespace, pod, cluster) (  max by(namespace, pod, cluster) (    kube_pod_status_phase{job="kube-state-metrics", phase=~"Pending|Unknown"}  ) * on(namespace, pod, cluster) group_left(owner_kind) topk by(namespace, pod, cluster) (    1, max by(namespace, pod, owner_kind, cluster) (kube_pod_owner{owner_kind!="Job"})  )) > 0'
        for: 'PT15M'
        labels: {
          severity: 'warning'
        }
        severity: 3
        enabled: true
        resolveConfiguration: {
          autoResolved: true
          timeToResolve: 'PT10M'
        }
        actions: [
          {
            actionGroupId: actionGroupResourceId
          }
        ]
      }
      {
        alert: 'KubeDeploymentReplicasMismatch'
        expression: '(  kube_deployment_spec_replicas{job="kube-state-metrics"}    >  kube_deployment_status_replicas_available{job="kube-state-metrics"}) and (  changes(kube_deployment_status_replicas_updated{job="kube-state-metrics"}[10m])    ==  0)'
        for: 'PT15M'
        labels: {
          severity: 'warning'
        }
        severity: 3
        enabled: true
        resolveConfiguration: {
          autoResolved: true
          timeToResolve: 'PT10M'
        }
        actions: [
          {
            actionGroupId: actionGroupResourceId
          }
        ]
      }
      {
        alert: 'KubeStatefulSetReplicasMismatch'
        expression: '(  kube_statefulset_status_replicas_ready{job="kube-state-metrics"}    !=  kube_statefulset_status_replicas{job="kube-state-metrics"}) and (  changes(kube_statefulset_status_replicas_updated{job="kube-state-metrics"}[10m])    ==  0)'
        for: 'PT15M'
        labels: {
          severity: 'warning'
        }
        severity: 3
        enabled: true
        resolveConfiguration: {
          autoResolved: true
          timeToResolve: 'PT10M'
        }
        actions: [
          {
            actionGroupId: actionGroupResourceId
          }
        ]
      }
      {
        alert: 'KubeJobNotCompleted'
        expression: 'time() - max by(namespace, job_name, cluster) (kube_job_status_start_time{job="kube-state-metrics"}  and kube_job_status_active{job="kube-state-metrics"} > 0) > 43200'
        labels: {
          severity: 'warning'
        }
        severity: 3
        enabled: true
        resolveConfiguration: {
          autoResolved: true
          timeToResolve: 'PT10M'
        }
        actions: [
          {
            actionGroupId: actionGroupResourceId
          }
        ]
      }
      {
        alert: 'KubeJobFailed'
        expression: 'kube_job_failed{job="kube-state-metrics"}  > 0'
        for: 'PT15M'
        labels: {
          severity: 'warning'
        }
        severity: 3
        enabled: true
        resolveConfiguration: {
          autoResolved: true
          timeToResolve: 'PT10M'
        }
        actions: [
          {
            actionGroupId: actionGroupResourceId
          }
        ]
      }
      {
        alert: 'KubeHpaReplicasMismatch'
        expression: '(kube_horizontalpodautoscaler_status_desired_replicas{job="kube-state-metrics"}  !=kube_horizontalpodautoscaler_status_current_replicas{job="kube-state-metrics"})  and(kube_horizontalpodautoscaler_status_current_replicas{job="kube-state-metrics"}  >kube_horizontalpodautoscaler_spec_min_replicas{job="kube-state-metrics"})  and(kube_horizontalpodautoscaler_status_current_replicas{job="kube-state-metrics"}  <kube_horizontalpodautoscaler_spec_max_replicas{job="kube-state-metrics"})  and changes(kube_horizontalpodautoscaler_status_current_replicas{job="kube-state-metrics"}[15m]) == 0'
        for: 'PT15M'
        labels: {
          severity: 'warning'
        }
        severity: 3
        enabled: true
        resolveConfiguration: {
          autoResolved: true
          timeToResolve: 'PT10M'
        }
        actions: [
          {
            actionGroupId: actionGroupResourceId
          }
        ]
      }
      {
        alert: 'KubeHpaMaxedOut'
        expression: 'kube_horizontalpodautoscaler_status_current_replicas{job="kube-state-metrics"}  ==kube_horizontalpodautoscaler_spec_max_replicas{job="kube-state-metrics"}'
        for: 'PT15M'
        labels: {
          severity: 'warning'
        }
        severity: 3
        enabled: true
        resolveConfiguration: {
          autoResolved: true
          timeToResolve: 'PT10M'
        }
        actions: [
          {
            actionGroupId: actionGroupResourceId
          }
        ]
      }
      {
        alert: 'KubeCPUQuotaOvercommit'
        expression: 'sum(min without(resource) (kube_resourcequota{job="kube-state-metrics", type="hard", resource=~"(cpu|requests.cpu)"}))  /sum(kube_node_status_allocatable{resource="cpu", job="kube-state-metrics"})  > 1.5'
        for: 'PT5M'
        labels: {
          severity: 'warning'
        }
        severity: 3
        enabled: true
        resolveConfiguration: {
          autoResolved: true
          timeToResolve: 'PT10M'
        }
        actions: [
          {
            actionGroupId: actionGroupResourceId
          }
        ]
      }
      {
        alert: 'KubeMemoryQuotaOvercommit'
        expression: 'sum(min without(resource) (kube_resourcequota{job="kube-state-metrics", type="hard", resource=~"(memory|requests.memory)"}))  /sum(kube_node_status_allocatable{resource="memory", job="kube-state-metrics"})  > 1.5'
        for: 'PT5M'
        labels: {
          severity: 'warning'
        }
        severity: 3
        enabled: true
        resolveConfiguration: {
          autoResolved: true
          timeToResolve: 'PT10M'
        }
        actions: [
          {
            actionGroupId: actionGroupResourceId
          }
        ]
      }
      {
        alert: 'KubeQuotaAlmostFull'
        expression: 'kube_resourcequota{job="kube-state-metrics", type="used"}  / ignoring(instance, job, type)(kube_resourcequota{job="kube-state-metrics", type="hard"} > 0)  > 0.9 < 1'
        for: 'PT15M'
        labels: {
          severity: 'info'
        }
        severity: 3
        enabled: true
        resolveConfiguration: {
          autoResolved: true
          timeToResolve: 'PT10M'
        }
        actions: [
          {
            actionGroupId: actionGroupResourceId
          }
        ]
      }
      {
        alert: 'KubeVersionMismatch'
        expression: 'count by (cluster) (count by (git_version, cluster) (label_replace(kubernetes_build_info{job!~"kube-dns|coredns"},"git_version","$1","git_version","(v[0-9]*.[0-9]*).*"))) > 1'
        for: 'PT15M'
        labels: {
          severity: 'warning'
        }
        severity: 3
        enabled: true
        resolveConfiguration: {
          autoResolved: true
          timeToResolve: 'PT10M'
        }
        actions: [
          {
            actionGroupId: actionGroupResourceId
          }
        ]
      }
      {
        alert: 'KubeNodeUnreachable'
        expression: '(kube_node_spec_taint{job="kube-state-metrics",key="node.kubernetes.io/unreachable",effect="NoSchedule"} unless ignoring(key,value) kube_node_spec_taint{job="kube-state-metrics",key=~"ToBeDeletedByClusterAutoscaler|cloud.google.com/impending-node-termination|aws-node-termination-handler/spot-itn"}) == 1'
        for: 'PT15M'
        labels: {
          severity: 'warning'
        }
        severity: 3
        enabled: true
        resolveConfiguration: {
          autoResolved: true
          timeToResolve: 'PT10M'
        }
        actions: [
          {
            actionGroupId: actionGroupResourceId
          }
        ]
      }
      {
        alert: 'KubeletTooManyPods'
        expression: 'count by(cluster, node) (  (kube_pod_status_phase{job="kube-state-metrics",phase="Running"} == 1) * on(instance,pod,namespace,cluster) group_left(node) topk by(instance,pod,namespace,cluster) (1, kube_pod_info{job="kube-state-metrics"}))/max by(cluster, node) (  kube_node_status_capacity{job="kube-state-metrics",resource="pods"} != 1) > 0.95'
        for: 'PT15M'
        labels: {
          severity: 'info'
        }
        severity: 3
        enabled: true
        resolveConfiguration: {
          autoResolved: true
          timeToResolve: 'PT10M'
        }
        actions: [
          {
            actionGroupId: actionGroupResourceId
          }
        ]
      }
      {
        alert: 'KubeNodeReadinessFlapping'
        expression: 'sum(changes(kube_node_status_condition{status="true",condition="Ready"}[15m])) by (cluster, node) > 2'
        for: 'PT15M'
        labels: {
          severity: 'warning'
        }
        severity: 3
        enabled: true
        resolveConfiguration: {
          autoResolved: true
          timeToResolve: 'PT10M'
        }
        actions: [
          {
            actionGroupId: actionGroupResourceId
          }
        ]
      }
    ]

  }
}
