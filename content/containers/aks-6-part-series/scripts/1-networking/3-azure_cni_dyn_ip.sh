####################################################
# 3 - Azure CNI cluster with dynamic IP allocation 
# & enhanced subnet support
####################################################

LOCATION='australiaeast'
SSH_KEY=$(cat ~/.ssh/id_rsa.pub)
RG_NAME='003-cni-dyn-subnet-cluster-rg'

az group create -n $RG_NAME --location $LOCATION

# Create vnet & 2 subnets
az network vnet create -g $RG_NAME --location $LOCATION --name 'cni-dyn-vnet' --address-prefixes '10.0.0.0/8' -o none 
az network vnet subnet create -g $RG_NAME --vnet-name 'cni-dyn-vnet' --name 'node-subnet' --address-prefixes '10.240.0.0/16' -o none 
az network vnet subnet create -g $RG_NAME --vnet-name 'cni-dyn-vnet' --name 'pod-subnet' --address-prefixes '10.241.0.0/16' -o none

NODE_SUBNET_ID=$(az network vnet subnet show -g $RG_NAME --vnet-name 'cni-dyn-vnet' --name 'node-subnet' --query id -o tsv)
POD_SUBNET_ID=$(az network vnet subnet show -g $RG_NAME --vnet-name 'cni-dyn-vnet' --name 'pod-subnet' --query id -o tsv)

az aks create \
    --resource-group $RG_NAME \
    --name 'cni-dyn-subnet-cluster' \
    --network-plugin azure \
    --max-pods 250 \
    --node-count 1 \
    --vnet-subnet-id $NODE_SUBNET_ID \
    --pod-subnet-id $POD_SUBNET_ID \
    --ssh-key-value "$SSH_KEY"

az aks get-credentials -g $RG_NAME -n 'cni-dyn-subnet-cluster' --admin --context '03-cni-dyn-subnet-cluster'
