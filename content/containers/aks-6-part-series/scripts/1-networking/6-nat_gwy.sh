################################
# 6 - Managed NAT Gateway egress
################################

LOCATION='australiaeast'
RG_NAME='006-nat-gwy-cluster-rg'
az group create -n $RG_NAME --location $LOCATION

az aks create \
    --resource-group $RG_NAME \
    --name 'nat-gwy-cluster' \
    --node-count 1 \
    --outbound-type managedNATGateway \
    --nat-gateway-managed-outbound-ip-count 2 \
    --nat-gateway-idle-timeout 30

az aks get-credentials -g $RG_NAME -n 'nat-gwy-cluster' --admin --context '06-nat-gwy-cluster'
