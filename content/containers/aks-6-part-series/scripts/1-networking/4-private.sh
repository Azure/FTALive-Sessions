######################
# 4 - Private cluster
######################

LOCATION='australiaeast'
SSH_KEY=$(cat ~/.ssh/id_rsa.pub)
RG_NAME='04-private-cluster-rg'
az group create -n $RG_NAME --location $LOCATION

az network vnet create \
    --resource-group $RG_NAME \
    --name 'private-vnet' \
    --address-prefixes '192.168.0.0/16' \
    --subnet-name 'private-subnet' \
    --subnet-prefix '192.168.1.0/24'

SUBNET_ID=$(az network vnet subnet show \
    --resource-group $RG_NAME \
    --vnet-name 'private-vnet' \
    --name 'private-subnet' \
    --query id -o tsv)

az aks create \
    --resource-group $RG_NAME \
    --name 'private-cluster' \
    --network-plugin azure \
    --node-count 1 \
    --vnet-subnet-id $SUBNET_ID \
    --docker-bridge-address 172.17.0.1/16 \
    --dns-service-ip 10.2.0.10 \
    --service-cidr 10.2.0.0/24 \
    --ssh-key-value "$SSH_KEY" \
    --enable-private-cluster

az aks get-credentials -g $RG_NAME -n 'private-cluster' --admin --context '04-private-cluster'
