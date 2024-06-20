##############################
# 12 - ACR Private Endpoints
##############################

LOCATION='australiaeast'
RG_NAME='12-acr-cluster-rg'
ACR_NAME=<redacted>

az group create -n $RG_NAME --location $LOCATION

az network vnet create \
    -g $RG_NAME \
    -n 'acr-vnet' \
    --address-prefixes '192.168.0.0/16' \
    --subnet-name 'pe-subnet' \
    --subnet-prefix '192.168.1.0/24'

SUBNET_ID=$(az network vnet subnet show \
  -g $RG_NAME \
  --vnet-name 'acr-vnet' \
  -n 'pe-subnet' \
  --query id -o tsv)

az network vnet subnet update \
  --name 'pe-subnet' \
  --vnet-name 'acr-vnet' \
  --resource-group $RG_NAME \
  --disable-private-endpoint-network-policies

 az network vnet subnet create \
  -g $RG_NAME \
  --vnet-name 'acr-vnet' \
  -n 'aks-subnet' \
  --address-prefixes 192.168.2.0/24

 AKS_SUBNET_ID=$(az network vnet subnet show \
    -g $RG_NAME \
    --vnet-name 'acr-vnet' \
    -n 'aks-subnet' \
    --query id -o tsv)

# create ACR
az acr create -n $ACR_NAME -g $RG_NAME --sku premium 

az network private-dns zone create \
  --resource-group $RG_NAME \
  --name "privatelink.azurecr.io"

az network private-dns link vnet create \
  --resource-group $RG_NAME \
  --zone-name "privatelink.azurecr.io" \
  --name 'acr-dns-link' \
  --virtual-network 'acr-vnet' \
  --registration-enabled false

REGISTRY_ID=$(az acr show -n $ACR_NAME -g $RG_NAME --query 'id' --output tsv)

az network private-endpoint create \
    --name 'acr-pe' \
    --resource-group $RG_NAME \
    --vnet-name 'acr-vnet' \
    --subnet 'pe-subnet' \
    --private-connection-resource-id $REGISTRY_ID \
    --group-ids registry \
    --connection-name 'acr-pe-cxn'

NETWORK_INTERFACE_ID=$(az network private-endpoint show \
  --name 'acr-pe' \
  --resource-group $RG_NAME \
  --query 'networkInterfaces[0].id' \
  --output tsv)

REGISTRY_PRIVATE_IP=$(az network nic show \
  --ids $NETWORK_INTERFACE_ID \
  --query "ipConfigurations[?privateLinkConnectionProperties.requiredMemberName=='registry'].privateIpAddress" \
  --output tsv)

DATA_ENDPOINT_PRIVATE_IP=$(az network nic show \
  --ids $NETWORK_INTERFACE_ID \
  --query "ipConfigurations[?privateLinkConnectionProperties.requiredMemberName=='registry_data_$LOCATION'].privateIpAddress" \
  --output tsv)

# An FQDN is associated with each IP address in the IP configurations
REGISTRY_FQDN=$(az network nic show \
  --ids $NETWORK_INTERFACE_ID \
  --query "ipConfigurations[?privateLinkConnectionProperties.requiredMemberName=='registry'].privateLinkConnectionProperties.fqdns" \
  --output tsv)

DATA_ENDPOINT_FQDN=$(az network nic show \
  --ids $NETWORK_INTERFACE_ID \
  --query "ipConfigurations[?privateLinkConnectionProperties.requiredMemberName=='registry_data_$LOCATION'].privateLinkConnectionProperties.fqdns" \
  --output tsv)

az network private-dns record-set a create \
  --name $ACR_NAME \
  --zone-name privatelink.azurecr.io \
  --resource-group $RG_NAME

# Specify registry region in data endpoint name
az network private-dns record-set a create \
  --name ${ACR_NAME}.${LOCATION}.data \
  --zone-name privatelink.azurecr.io \
  --resource-group $RG_NAME

az network private-dns record-set a add-record \
  --record-set-name $ACR_NAME \
  --zone-name privatelink.azurecr.io \
  --resource-group $RG_NAME \
  --ipv4-address $REGISTRY_PRIVATE_IP

# Specify registry region in data endpoint name
az network private-dns record-set a add-record \
  --record-set-name ${ACR_NAME}.${LOCATION}.data \
  --zone-name privatelink.azurecr.io \
  --resource-group $RG_NAME \
  --ipv4-address $DATA_ENDPOINT_PRIVATE_IP

az aks create -n 'acr-cluster' \
  --vnet-subnet-id $AKS_SUBNET_ID \
  --node-count 1 \
  --network-plugin azure \
  -g $RG_NAME \
  --generate-ssh-keys \
  --attach-acr $ACR_NAME 

az aks update -n 'acr-cluster' -g $RG_NAME --attach-acr $ACR_NAME

# get kube config
az aks get-credentials -g $RG_NAME -n 'acr-cluster' --admin --context '12-acr-cluster'
kubectl config use-context '12-acr-cluster-admin'

# import container image from Dockerhub
az acr import -n $ACR_NAME --source docker.io/stefanprodan/podinfo:latest -t podinfo:latest

# start container
kubectl run podinfo <redacted>

az aks show --resource-group $RG_NAME \
    --name 'acr-cluster' \
    --query servicePrincipalProfile.clientId \
    --output tsv

az acr update --name $ACR_NAME --anonymous-pull-enabled

kubectl run -it testpod --image=mcr.microsoft.com/dotnet/runtime-deps:6.0
