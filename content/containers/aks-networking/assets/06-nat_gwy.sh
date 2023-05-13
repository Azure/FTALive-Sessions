################################
# 6 - Managed NAT Gateway egress
################################

LOCATION='australiaeast'
RG_NAME='06-nat-gwy-cluster-rg'
CLUSTER='nat-gwy-cluster'

az group create -n $RG_NAME --location $LOCATION

az aks create \
    --resource-group $RG_NAME \
    --name 'nat-gwy-cluster' \
    --node-count 1 \
    --outbound-type managedNATGateway \
    --nat-gateway-managed-outbound-ip-count 2 \
    --nat-gateway-idle-timeout 30

az aks get-credentials -g $RG_NAME -n $CLUSTER --admin --context '06-nat-gwy-cluster'
kubectl config use-context '06-nat-gwy-cluster-admin'
