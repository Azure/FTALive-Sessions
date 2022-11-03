####################################################
# 3.5 - Azure CNI cluster with overlay network 
####################################################

LOCATION='westcentralus'
RG_NAME='003_5-cni-dyn-subnet-cluster-rg'

# register preview feature
# az feature register --namespace Microsoft.ContainerService --name AzureOverlayPreview

# Create the resource group
az group create --name $RG_NAME --location $LOCATION

# Create a VNet and a subnet for the cluster nodes 
az network vnet create -g $RG_NAME --location $LOCATION --name 'cni-overlay-vnet' --address-prefixes '10.0.0.0/8' -o none
az network vnet subnet create -g $RG_NAME --vnet-name 'cni-overlay-vnet'  --name 'node-subnet' --address-prefix '10.10.0.0/16' -o none

NODE_SUBNET_ID=$(az network vnet subnet show -g $RG_NAME --vnet-name 'cni-overlay-vnet' --name 'node-subnet' --query id -o tsv)

az aks create \
    -n 'cni-overlay-cluster' \
    -g $RG_NAME \
    --location $LOCATION \
    --network-plugin azure \
    --network-plugin-mode overlay \
    --pod-cidr '192.168.0.0/16' \
    --vnet-subnet-id $NODE_SUBNET_ID

az aks get-credentials -g $RG_NAME -n 'cni-dyn-subnet-cluster' --admin --context '03-5-cni-overlay-cluster'