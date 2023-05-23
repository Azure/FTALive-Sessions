###############################
# 2 - Azure CSI blob cluster
###############################

LOCATION='australiaeast'
SSH_KEY=$(cat ~/.ssh/id_rsa.pub)
RG_NAME='16-blob-csi-cluster-rg'
CLUSTER='blob-csi-cluster'
az group create -n $RG_NAME --location $LOCATION

az network vnet create -g $RG_NAME \
    --name 'cni-vnet' \
    --address-prefixes '192.168.0.0/16' \
    --subnet-name 'cni-subnet' \
    --subnet-prefix '192.168.1.0/24'

SUBNET_ID=$(az network vnet subnet show -g $RG_NAME --vnet-name 'cni-vnet' --name 'cni-subnet' --query id -o tsv)

az aks create -g $RG_NAME -n 'blob-csi-cluster' \
    --vnet-subnet-id $SUBNET_ID \
    --ssh-key-value "$SSH_KEY" \
    --node-count 1 \
    --network-plugin azure \
    --docker-bridge-address '172.17.0.1/16' \
    --dns-service-ip '10.2.0.10' \
    --service-cidr '10.2.0.0/24' \
    --enable-blob-driver

az aks get-credentials -g $RG_NAME -n $CLUSTER --admin --context $CLUSTER
kubectl config use-context "$CLUSTER-admin"

# Dynamic Blob PV
cat << EOF | kubectl apply -f -
apiVersion: apps/v1
kind: StatefulSet
metadata:
  name: statefulset-blob
  labels:
    app: nginx
spec:
  serviceName: statefulset-blob
  replicas: 1
  template:
    metadata:
      labels:
        app: nginx
    spec:
      nodeSelector:
        "kubernetes.io/os": linux
      containers:
        - name: statefulset-blob
          image: mcr.microsoft.com/oss/nginx/nginx:1.19.5
          volumeMounts:
            - name: persistent-storage
              mountPath: /mnt/blob
  updateStrategy:
    type: RollingUpdate
  selector:
    matchLabels:
      app: nginx
  volumeClaimTemplates:
    - metadata:
        name: persistent-storage
      spec:
        storageClassName: azureblob-fuse-premium
        accessModes: ["ReadWriteMany"]
        resources:
          requests:
            storage: 100Gi
EOF

k exec -it statefulset-blob-0 -- bash -c  "echo $(date) >> /mnt/blob/test.txt"
k exec -it statefulset-blob-0 -- cat /mnt/blob/test.txt

#################################
# Custom Storage Class
#################################

cat << EOF | kubectl apply -f -
apiVersion: storage.k8s.io/v1
kind: StorageClass
metadata:
  name: my-azureblob-fuse-premium
provisioner: blob.csi.azure.com
parameters:
  skuName: Standard_LRS  # available values: Standard_LRS, Premium_LRS, Standard_GRS, Standard_RAGRS
reclaimPolicy: Delete
volumeBindingMode: Immediate
allowVolumeExpansion: true
mountOptions:
  - -o allow_other
  - --file-cache-timeout-in-seconds=120
  - --use-attr-cache=true
  - --cancel-list-on-mount-seconds=10  # prevent billing charges on mounting
  - -o attr_timeout=120
  - -o entry_timeout=120
  - -o negative_timeout=120
  - --log-level=LOG_WARNING  # LOG_WARNING, LOG_INFO, LOG_DEBUG
  - --cache-size-mb=1000  # Default will be 80% of available memory, eviction will happen beyond that.
EOF

cat << EOF | kubectl apply -f -
apiVersion: v1
kind: PersistentVolume
metadata:
  annotations:
    pv.kubernetes.io/provisioned-by: blob.csi.azure.com
  name: pv-blob
spec:
  capacity:
    storage: 1Pi
  accessModes:
    - ReadWriteMany
  persistentVolumeReclaimPolicy: Retain  # If set as "Delete" container would be removed after pvc deletion
  storageClassName: azureblob-nfs-premium
  csi:
    driver: blob.csi.azure.com
    readOnly: false
    # make sure volumeid is unique for every identical storage blob container in the cluster
    # character `#` is reserved for internal use and cannot be used in volumehandle
    volumeHandle: unique-volumeid
    volumeAttributes:
      resourceGroup: $NODE_NAME
      storageAccount: $STORAGE_ACCOUNT_NAME
      containerName: my-container
      protocol: nfs
EOF

##########################
# Dynamic storage volume
##########################

# create BlobFuse PVC
cat << EOF | kubectl apply -f -
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: my-blob-fuse-pvc
  annotations:
        volume.beta.kubernetes.io/storage-class: azureblob-fuse-premium
spec:
  accessModes:
  - ReadWriteMany
  storageClassName: azureblob-fuse-premium
  resources:
    requests:
      storage: 200Gi
EOF

# create Azure Files PVC
cat << EOF | kubectl apply -f -
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: my-azure-file-pvc
  annotations:
        volume.beta.kubernetes.io/storage-class: azurefile-csi-premium
spec:
  accessModes:
  - ReadWriteMany
  storageClassName: azurefile-csi-premium
  resources:
    requests:
      storage: 200Gi
EOF

kubectl get pvc my-blob-fuse-pvc
kubectl get pvc my-azure-file-pvc

# use blobFuse PVC
cat << EOF | kubectl apply -f -
kind: Pod
apiVersion: v1
metadata:
  name: mypod
spec:
  containers:
  - name: mypod
    image: mcr.microsoft.com/oss/nginx/nginx:1.17.3-alpine
    resources:
      requests:
        cpu: 100m
        memory: 128Mi
      limits:
        cpu: 250m
        memory: 256Mi
    volumeMounts:
    - mountPath: "/mnt/blob"
      name: volume
  volumes:
    - name: volume
      persistentVolumeClaim:
        claimName: my-blob-fuse-pvc
EOF

# use Azure Files PVC
cat << EOF | kubectl apply -f -
kind: Pod
apiVersion: v1
metadata:
  name: mypod2
spec:
  containers:
  - name: mypod2
    image: mcr.microsoft.com/oss/nginx/nginx:1.17.3-alpine
    resources:
      requests:
        cpu: 100m
        memory: 128Mi
      limits:
        cpu: 250m
        memory: 256Mi
    volumeMounts:
    - mountPath: "/mnt/file"
      name: volume
  volumes:
    - name: volume
      persistentVolumeClaim:
        claimName: my-azure-file-pvc
EOF

k get pv
k get pvc

kubectl exec -it mypod -- touch /mnt/blob/test.txt
kubectl exec -it mypod -- sh -c "echo $(date) >> /mnt/blob/test.txt"
kubectl exec mypod -- cat /mnt/blob/test.txt
kubectl exec mypod -- df -h

kubectl exec -it mypod2 -- touch /mnt/file/test.txt
kubectl exec -it mypod2 -- sh -c "echo $(date) >> /mnt/file/test.txt"
kubectl exec mypod2 -- cat /mnt/file/test.txt
kubectl exec mypod2 -- df -h

##################################
# Static storage volume
##################################

# create storage account in cluster resource group
STORAGE_ACCOUNT_NAME='cbellee98723498r29834e'
NODE_RG=`az aks show --resource-group $RG_NAME --name $CLUSTER --query nodeResourceGroup -o tsv`
az storage account create -n $STORAGE_ACCOUNT_NAME -g $NODE_RG -l $LOCATION --sku Standard_LRS
KEY=`az storage account keys list -g $NODE_RG -n $STORAGE_ACCOUNT_NAME --query [0].value -o tsv`

# store account key as K8s secret
kubectl create secret generic azure-static-blob-csi-secret \
    --from-literal azurestorageaccountkey="$KEY" \
    --type=Opaque

cat << EOF | kubectl apply -f -
apiVersion: v1
kind: PersistentVolume
metadata:
  annotations:
    pv.kubernetes.io/provisioned-by: blob.csi.azure.com
  name: pv-blob-1
spec:
  capacity:
    storage: 500Gi
  accessModes:
    - ReadWriteMany
  persistentVolumeReclaimPolicy: Retain  # If set as "Delete" container would be removed after pvc deletion
  storageClassName: azureblob-fuse-premium
  mountOptions:
    - -o allow_other
    - --file-cache-timeout-in-seconds=120
  csi:
    driver: blob.csi.azure.com
    readOnly: false
    # volumeid has to be unique for every identical storage blob container in the cluster
    # character `#` is reserved for internal use and cannot be used in volumehandle
    volumeHandle: cbellee-486727184
    volumeAttributes:
      containerName: my-blob-1
      storageAccount: $STORAGE_ACCOUNT_NAME
      resourceGroup: $NODE_RG
      protocol: fuse
    nodeStageSecretRef:
      name: azure-static-blob-csi-secret
      namespace: default
EOF

cat << EOF | kubectl apply -f -
apiVersion: v1
kind: PersistentVolume
metadata:
  annotations:
    pv.kubernetes.io/provisioned-by: blob.csi.azure.com
  name: pv-blob-2
spec:
  capacity:
    storage: 700Gi
  accessModes:
    - ReadWriteMany
  persistentVolumeReclaimPolicy: Retain  # If set as "Delete" container would be removed after pvc deletion
  storageClassName: azureblob-fuse-premium
  mountOptions:
    - -o allow_other
    - --file-cache-timeout-in-seconds=120
  csi:
    driver: blob.csi.azure.com
    readOnly: false
    # volumeid has to be unique for every identical storage blob container in the cluster
    # character `#` is reserved for internal use and cannot be used in volumehandle
    volumeHandle: cbellee-41241233
    volumeAttributes:
      containerName: my-blob-2
      storageAccount: $STORAGE_ACCOUNT_NAME
      resourceGroup: $NODE_RG
      protocol: fuse
    nodeStageSecretRef:
      name: azure-static-blob-csi-secret
      namespace: default
EOF


# create PVC
cat << EOF | kubectl apply -f -
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: pvc-blob-1
spec:
  accessModes:
    - ReadWriteMany
  resources:
    requests:
      storage: 20Gi
  volumeName: pv-blob-1
  storageClassName: azureblob-fuse-premium
EOF

# create PVC
cat << EOF | kubectl apply -f -
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: pvc-blob-2
spec:
  accessModes:
    - ReadWriteMany
  resources:
    requests:
      storage: 40Gi
  volumeName: pv-blob-2
  storageClassName: azureblob-fuse-premium
EOF

# use the PV

cat << EOF | kubectl apply -f -
kind: Pod
apiVersion: v1
metadata:
  name: nginx-blob
spec:
  nodeSelector:
    "kubernetes.io/os": linux
  containers:
    - image: mcr.microsoft.com/oss/nginx/nginx:1.17.3-alpine
      name: nginx-blob
      volumeMounts:
        - name: blob01
          mountPath: "/mnt/blob1"
        - name: blob02
          mountPath: "/mnt/blob2"
  volumes:
    - name: blob01
      persistentVolumeClaim:
        claimName: pvc-blob-1
    - name: blob02
      persistentVolumeClaim:
        claimName: pvc-blob-2
EOF

k exec -it nginx-blob -- touch /mnt/blob1/test.txt
k exec -it nginx-blob -- touch /mnt/blob2/test.txt
k exec -it nginx-blob -- sh -c "echo $(date) >> /mnt/blob1/test.txt"
k exec -it nginx-blob -- sh -c "echo $(date) >> /mnt/blob2/test.txt"

k exec -it nginx-blob -- sh -c "cat /mnt/blob1/test.txt"
k exec -it nginx-blob -- sh -c "cat /mnt/blob2/test.txt"

k exec -it nginx-blob -- sh -c "ls /mnt/blob1"
k exec -it nginx-blob -- sh -c "ls /mnt/blob2"


#################################################################

# create Azure Blob PVC

cat << EOF | kubectl apply -f -
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: my-azure-blob-pvc
  annotations:
        volume.beta.kubernetes.io/storage-class: azureblob-fuse-premium
spec:
  accessModes:
  - ReadWriteMany
  storageClassName: azureblob-fuse-premium
  resources:
    requests:
      storage: 500Gi
EOF

# create Azure File PVC

cat << EOF | kubectl apply -f -
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: my-azure-file-pvc
  annotations:
        volume.beta.kubernetes.io/storage-class: azurefile-csi-premium
spec:
  accessModes:
  - ReadWriteMany
  storageClassName: azurefile-csi-premium
  resources:
    requests:
      storage: 400Gi
EOF

# use Azure Blob PVC
cat << EOF | kubectl apply -f -
kind: Pod
apiVersion: v1
metadata:
  name: azure-blob-csi
spec:
  containers:
  - name: mypod
    image: mcr.microsoft.com/oss/nginx/nginx:1.17.3-alpine
    resources:
      requests:
        cpu: 100m
        memory: 128Mi
      limits:
        cpu: 250m
        memory: 256Mi
    volumeMounts:
    - mountPath: "/mnt/blob"
      name: volume
  volumes:
    - name: volume
      persistentVolumeClaim:
        claimName: my-azure-blob-pvc
EOF

# use Azure File PVC
cat << EOF | kubectl apply -f -
kind: Pod
apiVersion: v1
metadata:
  name: azure-file-csi
spec:
  containers:
  - name: mypod
    image: mcr.microsoft.com/oss/nginx/nginx:1.17.3-alpine
    resources:
      requests:
        cpu: 100m
        memory: 128Mi
      limits:
        cpu: 250m
        memory: 256Mi
    volumeMounts:
    - mountPath: "/mnt/file"
      name: volume
  volumes:
    - name: volume
      persistentVolumeClaim:
        claimName: my-azure-file-pvc
EOF

# list volume sizes inside each pod
k exec -it azure-file-csi -- sh -c "df -h"
k exec -it azure-blob-csi -- sh -c "df -h"

# modify the PVCs.
# increase 'resource.requests.storage' to '400Gi'

# list volume sizes inside each pod.
# notice that the volume size inside the pod using blob storage statys the same.
k exec -it azure-file-csi -- sh -c "df -h"
k exec -it azure-blob-csi -- sh -c "df -h"
