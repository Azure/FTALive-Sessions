################################
# 7 - Ingress with NGINX
################################

LOCATION='australiaeast'
RG_NAME='07-nginx-cluster-rg'
NAMESPACE='ingress-basic'
CLUSTER='nginx-cluster'

az group create -n $RG_NAME --location $LOCATION

az aks create \
--resource-group $RG_NAME \
--name $CLUSTER \
--node-count 1

az aks get-credentials -g $RG_NAME -n $CLUSTER --admin --context '07-ingress-basic'
kubectl config use-context '07-ingress-basic-admin'

helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
helm repo update

helm install ingress-nginx ingress-nginx/ingress-nginx \
  --create-namespace \
  --namespace $NAMESPACE \
  --set controller.service.annotations."service\.beta\.kubernetes\.io/azure-load-balancer-health-probe-request-path"=/healthz

kubectl apply -f ./hello-world-one.yaml --namespace ingress-basic
kubectl apply -f ./hello-world-two.yaml --namespace ingress-basic
kubectl apply -f ./hello-world-ingress.yaml --namespace ingress-basic

kubectl run -it aks-ingress-test --image=mcr.microsoft.com/dotnet/runtime-deps:6.0 --namespace ingress-basic
EXTERNAL_IP=$(k get svc ingress-nginx-controller -n ingress-basic -o json | jq .status.loadBalancer.ingress[0].ip -r)

# $ sudo apt-get update && sudo apt-get install -y curl
# $ curl -L http://$EXTERNAL_IP