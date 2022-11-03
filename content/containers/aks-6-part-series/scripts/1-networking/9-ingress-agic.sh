##################################
# 9 - External ingress with AGIC
##################################

LOCATION='australiaeast'
RG_NAME='009-app-gateway-ingress-controller-cluster-rg'
az group create -n $RG_NAME --location $LOCATION

az aks create -n 'agic-cluster' \
  -g $RG_NAME \
  --node-count 1 \
  --network-plugin azure \
  --enable-managed-identity \
  -a ingress-appgw --appgw-name 'agic-app-gwy' --appgw-subnet-cidr "10.225.0.0/16" --generate-ssh-keys

az aks get-credentials -g $RG_NAME -n 'agic-cluster' --admin --context '09-agic-cluster'

kubectl apply -f ./agic-app.yaml

k logs ingress-appgw-deployment-7499446cb5-995cv -n kube-system

kubectl get ingress