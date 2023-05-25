kubectl get nodes -o name
kubectl describe node/aks-linux-24709842-vmss00000p

# OSS tool to easilt view node & total cluster allocatable
kube-capacity --util


###########################################
# requests larger than cluster allocatable
###########################################

# pod fails to schedule with error 'pod didn't trigger scale-up: 2 Insufficient memory, 2 Insufficient cpu'

kubectl apply -f - << EOF
apiVersion: v1
kind: Pod
metadata:
  name: unalloc-demo
  namespace: default
spec:
    containers:
    - name: request-demo-ctr
      image: progrium/stress
      resources:
        requests:
          cpu: 12
          memory: 12Gi   
        limits:
          cpu: 14
          memory: 14Gi
      args: 
        - --cpu
        - "1"
        - --vm
        - "256"
EOF

kubectl get event
kubectl delete po unalloc-demo

####################
# OOMKIlled demo
####################

kubectl apply -f - << EOF
apiVersion: v1
kind: Pod
metadata:
  name: oom-killed-demo
  namespace: default
spec:
    containers:
    - name: oom-killed-demo-ctr
      image: progrium/stress
      resources:
        requests:
          cpu: 250m
          memory: 128Mi   
        limits:
          cpu: 500m
          memory: 256Mi
      args: 
        - --cpu
        - "1"
        - --vm
        - "256"
EOF

kubectl get po
kubectl delete po oom-killed-demo

#######################
# Guaranteed QoS demo
#######################

# For a Pod to be given a QoS class of Guaranteed:
    # Every Container in the Pod must have a memory limit and a memory request.
    # For every Container in the Pod, the memory limit must equal the memory request.
    # Every Container in the Pod must have a CPU limit and a CPU request.
    # For every Container in the Pod, the CPU limit must equal the CPU request.

kubectl apply -f - << EOF
apiVersion: v1
kind: Pod
metadata:
  name: guaranteed-qos-demo
  namespace: default
spec:
    containers:
    - name: guaranteed-qos-demo-ctr
      image: nginx
      resources:
        requests:
          cpu: 500m
          memory: 128Mi   
        limits:
          cpu: 500m
          memory: 128Mi
EOF

kubectl get po guaranteed-qos-demo -o yaml
kubectl delete po guaranteed-qos-demo

#######################
# Burstable QoS demo
#######################

# A Pod is given a QoS class of Burstable if:
    # The Pod does not meet the criteria for QoS class Guaranteed.
    # At least one Container in the Pod has a memory or CPU request or limit.

kubectl apply -f - << EOF
apiVersion: v1
kind: Pod
metadata:
  name: burstable-qos-demo
  namespace: default
spec:
  containers:
  - name: burstable-qos-demo-ctr
    image: nginx
    resources:
      limits:
        memory: "200Mi"
      requests:
        memory: "100Mi"
EOF

kubectl get po burstable-qos-demo -o yaml
kubectl delete po burstable-qos-demo

#########################
# BestEffort QoS demo
#########################

# A Pod is given a QoS class of BestEffort if:
    # The Containers in the Pod do not have any memory or CPU limits or requests.

kubectl apply -f - << EOF
apiVersion: v1
kind: Pod
metadata:
  name: best-effort-qos-demo
  namespace: default
spec:
  containers:
  - name: best-effort-qos-demo-ctr
    image: nginx
EOF

kubectl get po best-effort-qos-demo -o yaml
kubectl delete po best-effort-qos-demo

#######################
# Namespace limits
#######################

kubectl apply -f - << EOF
apiVersion: v1
kind: LimitRange
metadata:
  name: mem-limit-range-demo
  namespace: default
spec:
  limits:
  - default:
      memory: 512Mi
    defaultRequest:
      memory: 256Mi
    type: Container
EOF

kubectl describe limitrange mem-limit-range-demo 

# create pod without resource limits

kubectl apply -f - << EOF
apiVersion: v1
kind: Pod
metadata:          
  name: limit-range-demo                     
  namespace: default
spec:
  containers:
  - name: limit-range-demo-ctr
    image: nginx
EOF

# resource limits are now set to the 'LimitRange' values
kubectl get po limit-range-demo -o=jsonpath='{.spec.containers[0].resources}'

# specify 'limit', but not a 'request'

kubectl apply -f - << EOF
apiVersion: v1
kind: Pod
metadata:
  name: limit-range-demo-2
spec:
  containers:
  - name: limit-range-demo-2-ctr
    image: nginx
    resources:
      limits:
        memory: "1Gi"
EOF

# Container's memory request is set to match its memory limit. 
# Notice that the container was not assigned the default memory request value of 256Mi.
kubectl get po limit-range-demo-2 -o=jsonpath='{.spec.containers[0].resources}'

# specify 'request' but not 'limit'

kubectl apply -f - << EOF
apiVersion: v1
kind: Pod
metadata:
  name: limit-range-demo-3
spec:
  containers:
  - name: limit-range-demo-3-ctr
    image: nginx
    resources:
      requests:
        memory: "128Mi"
EOF

# Container's memory request is set to the value specified in the container's manifest. 
# The container is limited to use no more than 512MiB of memory, which matches the default memory limit for the namespace.

kubectl get po limit-range-demo-3 -o=jsonpath='{.spec.containers[0].resources}'

############################
# Namespace resource quota
############################

# The ResourceQuota places these requirements on the quota-mem-cpu-example namespace:
    # For every Pod in the namespace, each container must have a memory request, memory limit, cpu request, and cpu limit.
    # The memory request total for all Pods in that namespace must not exceed 1 GiB.
    # The memory limit total for all Pods in that namespace must not exceed 2 GiB.
    # The CPU request total for all Pods in that namespace must not exceed 1 cpu.
    # The CPU limit total for all Pods in that namespace must not exceed 2 cpu.

kubectl create ns quota-demo

kubectl apply -f - << EOF
apiVersion: v1
kind: ResourceQuota
metadata:
  name: quota-demo
spec:
  hard:
    requests.cpu: "1"
    requests.memory: 1Gi
    limits.cpu: "2"
    limits.memory: 2Gi
EOF

# display the resource quota
kubectl describe resourcequota quota-demo    

# create a pod
kubectl apply -f - << EOF
apiVersion: v1
kind: Pod
metadata:
  name: res-quota-mem-cpu-demo
  namespace: quota-demo
spec:
  containers:
  - name: res-quota-mem-cpu-demo-ctr
    image: nginx
    resources:
      limits:
        memory: "800Mi"
        cpu: "800m"
      requests:
        memory: "600Mi"
        cpu: "400m"
EOF

kubectl get po res-quota-mem-cpu-demo -n quota-demo --output=yaml

# try to schedule another pod

kubectl apply -f - << EOF
apiVersion: v1
kind: Pod
metadata:
  name: res-quota-mem-cpu-demo-3
spec:
  containers:
  - name: res-quota-mem-cpu-demo-2-ctr
    image: redis
    resources:
      limits:
        memory: "1Gi"
        cpu: "800m"
      requests:
        memory: "700Mi"
        cpu: "400m"
EOF

# pod scheduling fails since we've exceeded the quota
    # pods "res-quota-mem-cpu-demo-2" is forbidden: 
    # exceeded quota: quota-demo, 
    # requested: requests.memory=700Mi, 
    # used: requests.memory=1152Mi, 
    # limited: requests.memory=1Gi

kubectl delete po res-quota-mem-cpu-demo -n quota-demo

#################
# Kubecost demo
#################

# install kubecost
helm repo add kubecost https://kubecost.github.io/cost-analyzer/
helm repo update
helm upgrade --install kubecost kubecost/cost-analyzer --namespace kubecost --create-namespace

# Connect to the Kubecost dashboard UI
kubectl port-forward -n kubecost svc/kubecost-cost-analyzer 9090:9090