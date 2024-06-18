##############################
# 12 - ACR Private Endpoints
##############################

LOCATION='australiaeast'
RG_NAME='12-acr-cluster-rg'

# create resource group
az group create -n $RG_NAME --location $LOCATION

# create unique string from resource group fqdn
AFFIX=$(az group show -n $RG_NAME --query id | md5sum | head -c 10; echo)
VNET_NAME="$AFFIX-vnet"
ACR_NAME="acr$AFFIX"
CLUSTER_NAME="acr-cluster-$AFFIX"

# creatwe vnet & subnets
az network vnet create \
    --resource-group $RG_NAME \
    -n $VNET_NAME \
    --address-prefixes '192.168.0.0/16' \
    --subnet-name 'pe-subnet' \
    --subnet-prefix '192.168.1.0/24'

SUBNET_ID=$(az network vnet subnet show \
  --resource-group $RG_NAME \
  --vnet-name $VNET_NAME \
  -n 'pe-subnet' \
  --query id -o tsv)

az network vnet subnet update \
  --name 'pe-subnet' \
  --vnet-name $VNET_NAME \
  --resource-group $RG_NAME \
  --disable-private-endpoint-network-policies

 az network vnet subnet create \
  --resource-group $RG_NAME \
  --vnet-name $VNET_NAME \
  --name 'aks-subnet' \
  --address-prefixes 192.168.2.0/24

 AKS_SUBNET_ID=$(az network vnet subnet show \
  --resource-group $RG_NAME \
  --vnet-name $VNET_NAME \
  --name 'aks-subnet' \
  --query id -o tsv)

# create ACR
az acr create --name $ACR_NAME --resource-group $RG_NAME --sku premium 

# create private DNS zone & link it to the vnet
az network private-dns zone create \
  --resource-group $RG_NAME \
  --name "privatelink.azurecr.io"

az network private-dns link vnet create \
  --resource-group $RG_NAME \
  --zone-name "privatelink.azurecr.io" \
  --name 'acr-dns-link' \
  --virtual-network $VNET_NAME \
  --registration-enabled false

# create private endpoint for ACR & required DNS records
REGISTRY_ID=$(az acr show -n $ACR_NAME --resource-group $RG_NAME --query 'id' --output tsv)

az network private-endpoint create \
  --name "acr-pe-$AFFIX" \
  --resource-group $RG_NAME \
  --vnet-name $VNET_NAME \
  --subnet 'pe-subnet' \
  --private-connection-resource-id $REGISTRY_ID \
  --group-ids registry \
  --connection-name "acr-pe-cxn-$AFFIX"

NETWORK_INTERFACE_ID=$(az network private-endpoint show \
  --name "acr-pe-$AFFIX" \
  --resource-group $RG_NAME \
  --query 'networkInterfaces[0].id' \
  --output tsv)

REGISTRY_PRIVATE_IP=$(az network nic show \
  --ids $NETWORK_INTERFACE_ID \
  --query "ipConfigurations[?privateLinkConnectionProperties.requiredMemberName=='registry'].privateIPAddress" \
  --output tsv)

DATA_ENDPOINT_PRIVATE_IP=$(az network nic show \
  --ids $NETWORK_INTERFACE_ID \
  --query "ipConfigurations[?privateLinkConnectionProperties.requiredMemberName=='registry_data_$LOCATION'].privateIPAddress" \
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

az network private-dns record-set a create \
  --name ${ACR_NAME}.${LOCATION}.data \
  --zone-name privatelink.azurecr.io \
  --resource-group $RG_NAME

az network private-dns record-set a add-record \
  --record-set-name $ACR_NAME \
  --zone-name privatelink.azurecr.io \
  --resource-group $RG_NAME \
  --ipv4-address $REGISTRY_PRIVATE_IP

az network private-dns record-set a add-record \
  --record-set-name ${ACR_NAME}.${LOCATION}.data \
  --zone-name privatelink.azurecr.io \
  --resource-group $RG_NAME \
  --ipv4-address $DATA_ENDPOINT_PRIVATE_IP

# create AKS cluster
az aks create -n $CLUSTER_NAME \
  --vnet-subnet-id $AKS_SUBNET_ID \
  --node-count 1 \
  --network-plugin azure \
  --resource-group $RG_NAME \
  --generate-ssh-keys \
  --attach-acr $ACR_NAME 

# add ACR auth to cluster
az aks update --name $CLUSTER_NAME --resource-group $RG_NAME --attach-acr $ACR_NAME

# import container image from Dockerhub
az acr import -n $ACR_NAME --source docker.io/stefanprodan/podinfo:latest -t podinfo:latest

# get kube config
az aks get-credentials --resource-group $RG_NAME --name $CLUSTER_NAME --admin --context '12-acr-cluster'
kubectl config use-context '12-acr-cluster-admin'

# start container
kubectl run podinfo --image=$ACR_NAME.azurecr.io/podinfo:latest 
kubectl get pod

az aks show --resource-group $RG_NAME \
    --name $CLUSTER_NAME \
    --query servicePrincipalProfile.clientId \
    --output tsv
