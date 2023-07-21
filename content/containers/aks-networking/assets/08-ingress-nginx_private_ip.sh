#####################################
# 8 - Ingress with private NGINX IP
#####################################

LOCATION='australiaeast'
RG_NAME='08-internal-nginx-cluster-rg'
az group create -n $RG_NAME --location $LOCATION

az network vnet create -g $RG_NAME -n 'internal-nginx-vnet' \
    --address-prefix 10.0.0.0/16 \
    --subnet-name 'internal-nginx-subnet' \
    --subnet-prefix 10.0.0.0/24

SUBNETID=$(az network vnet subnet show -g $RG_NAME --vnet-name 'internal-nginx-vnet' --name 'internal-nginx-subnet' --query id -o tsv)

az aks create \
    --resource-group $RG_NAME \
    --name 'internal-nginx-cluster' \
    --network-plugin azure \
    --vnet-subnet-id $SUBNETID \
    --docker-bridge-address 172.17.0.1/16 \
    --dns-service-ip 10.2.0.10 \
    --service-cidr 10.2.0.0/24 \
    --node-count 1

az aks get-credentials -g $RG_NAME -n 'internal-nginx-cluster' --admin --context '08-internal-nginx-cluster'
kubectl config use-context '08-internal-nginx-cluster-admin'

SCOPE=$(az group show -n $RG_NAME | jq .id -r)
ASSIGNEE=$(az aks show -g $RG_NAME -n 'internal-nginx-cluster' | jq .identityProfile.kubeletidentity.clientId -r)
az role assignment create --role "Network Contributor" --assignee $ASSIGNEE --scope $SCOPE
az role assignment create --role "Contributor" --assignee $ASSIGNEE --scope $SCOPE

# Add the ingress-nginx repository
helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx

# Use Helm to deploy an NGINX ingress controller
helm install ingress-nginx ingress-nginx/ingress-nginx \
    --namespace ingress-basic \
    --create-namespace \
    --set controller.replicaCount=2 \
    --set controller.nodeSelector."kubernetes\.io/os"=linux \
    --set controller.admissionWebhooks.patch.nodeSelector."kubernetes\.io/os"=linux \
    --set controller.service.annotations."service\.beta\.kubernetes\.io/azure-load-balancer-health-probe-request-path"=/healthz \
    --set defaultBackend.nodeSelector."kubernetes\.io/os"=linux \
    -f ./internal-ingress.yaml

kubectl get all -n ingress-basic

kubectl apply -f ./hello-world-one.yaml
kubectl apply -f ./hello-world-two.yaml
kubectl apply -f ./hello-world-ingress.yaml

kubectl run -it aks-ingress-test --image=mcr.microsoft.com/dotnet/runtime-deps:6.0 --namespace ingress-basic
# $ apt-get update && apt-get install -y curl
# $ curl http://10.0.0.200

kubectl attach aks-ingress-test -c aks-ingress-test -i -t -n ingress-basic