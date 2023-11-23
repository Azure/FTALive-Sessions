#########################################################
# 1 - Kubenet CNI (Container Network Interface) cluster
#########################################################

LOCATION='australiaeast'
SSH_KEY=$(cat ~/.ssh/id_rsa.pub)
RG_NAME='01-kubenet-cluster-rg'

az group create -n $RG_NAME --location $LOCATION

az network vnet create \
    -g $RG_NAME \
    -n 'kubenet-vnet' \
    --address-prefixes '192.168.0.0/16' \
    --subnet-name 'kubenet-node-subnet' \
    --subnet-prefix '192.168.1.0/24'

SUBNET_ID=$(az network vnet subnet show \
    -g $RG_NAME \
    --vnet-name 'kubenet-vnet' \
    -n 'kubenet-node-subnet' \
    --query id -o tsv)

az aks create \
    --resource-group $RG_NAME \
    --node-count 1 \
    -n 'kubenet-cluster' \
    --network-plugin kubenet \
    --vnet-subnet-id $SUBNET_ID \
    --ssh-key-value "$SSH_KEY"

# SSH to privileged container on cluster node
az aks get-credentials -g $RG_NAME -n 'kubenet-cluster' --admin --context '01-kubenet-cluster'
kubectl config use-context '01-kubenet-cluster-admin'

NODE_NAME=$(k get node -o json | jq .items[0].metadata.name -r)
kubectl debug node/$NODE_NAME -it --image=mcr.microsoft.com/dotnet/runtime-deps:6.0
# $ cat /proc/version # get OS details
# $ uname -r # get kernel details
# $ chroot /host # interact with node session