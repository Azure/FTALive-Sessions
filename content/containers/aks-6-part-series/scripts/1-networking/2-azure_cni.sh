###############################
# 2 - Azure CNI cluster
###############################

SSH_KEY=$(cat ~/.ssh/id_rsa.pub)
RG_NAME='002-cni-cluster-rg'
az group create -n $RG_NAME --location $LOCATION

az network vnet create -g $RG_NAME \
    --name 'cni-vnet' \
    --address-prefixes '192.168.0.0/16' \
    --subnet-name 'cni-subnet' \
    --subnet-prefix '192.168.1.0/24'

SUBNET_ID=$(az network vnet subnet show -g $RG_NAME --vnet-name 'cni-vnet' --name 'cni-subnet' --query id -o tsv)

az aks create -g $RG_NAME -n 'cni-cluster' \
    --vnet-subnet-id $SUBNET_ID \
    --ssh-key-value "$SSH_KEY" \
    --node-count 1 \
    --network-plugin azure \
    --docker-bridge-address '172.17.0.1/16' \
    --dns-service-ip '10.2.0.10' \
    --service-cidr '10.2.0.0/24'

az aks get-credentials -g $RG_NAME -n 'cni-cluster' --admin --context '02-cni-cluster'
