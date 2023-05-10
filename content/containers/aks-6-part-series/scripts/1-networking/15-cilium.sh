################################
# 15 - Azure CNI with Cilium 
################################

LOCATION='australiaeast'
RESOURCE_GROUP='15-cilium-cluster-rg'
CLUSTER='cilium-cluster'
VNET_NAME='cilium-vnet'

# add preview Az CLI extension
az extension add --name aks-preview
az extension update --name aks-preview
az feature register --namespace "Microsoft.ContainerService" --name "CiliumDataplanePreview"
az feature show --namespace "Microsoft.ContainerService" --name "CiliumDataplanePreview"
az provider register --namespace Microsoft.ContainerService

# create a resource group
az group create -n $RESOURCE_GROUP --location $LOCATION

# Create a VNet with a subnet for nodes and a subnet for pods
az network vnet create -g $RESOURCE_GROUP --location $LOCATION --name $VNET_NAME --address-prefixes '10.0.0.0/8' -o none 
NODE_SUBNET_ID=`az network vnet subnet create -g $RESOURCE_GROUP --vnet-name $VNET_NAME --name nodesubnet --address-prefixes '10.240.0.0/16' --query id -o tsv` 
POD_SUBNET_ID=`az network vnet subnet create -g $RESOURCE_GROUP --vnet-name $VNET_NAME --name podsubnet --address-prefixes '10.241.0.0/16' --query id -o tsv -o tsv`

az aks create -n $CLUSTER \
--resource-group $RESOURCE_GROUP \
--location $LOCATION \
--max-pods 250 \
--network-plugin azure \
--vnet-subnet-id $NODE_SUBNET_ID \
--pod-subnet-id $POD_SUBNET_ID \
--network-dataplane cilium

az aks get-credentials -g $RESOURCE_GROUP -n $CLUSTER --admin

# chekc cilium status
cilium status

# check node-to-node health
kubectl -n kube-system exec ds/cilium -- cilium-health status

# check connectivity
cilium connectivity test

# deploy test applications
kubectl create ns tenant-a
kubectl create ns tenant-b
kubectl create ns tenant-c
kubectl create -f https://docs.isovalent.com/v1.11/public/tenant-services.yaml -n tenant-a
kubectl create -f https://docs.isovalent.com/v1.11/public/tenant-services.yaml -n tenant-b
kubectl create -f https://docs.isovalent.com/v1.11/public/tenant-services.yaml -n tenant-c

# verify communication between namespaces
kubectl exec -n tenant-a frontend-service -- curl -sI backend-service.tenant-a
kubectl exec -n tenant-a frontend-service -- curl -sI backend-service.tenant-b
kubectl exec -n tenant-a frontend-service -- curl -sI backend-service.tenant-c

# verify public internet access
kubectl exec -n tenant-a frontend-service -- curl -sI --max-time 5 api.twitter.com

# apply cilium network policy
cat ./cilium-network-policy-1.yaml
kubectl apply -f ./cilium-network-policy-1.yaml

# run connectivity tests again
kubectl exec -n tenant-a frontend-service -- curl -sI --max-time 5 api.twitter.com
kubectl exec -n tenant-a frontend-service -- curl -sI --max-time 5 backend-service.tenant-b
kubectl exec -n tenant-a frontend-service -- curl -sI --max-time 5 backend-service.tenant-c
kubectl exec -n tenant-a frontend-service -- curl -sI --max-time 5 backend-service.tenant-a

# remvoe network policy
kubectl delete NetworkPolicy -n tenant-a default-policy