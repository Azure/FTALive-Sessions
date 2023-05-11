##################################
# 9 - External ingress with AGIC
##################################

LOCATION='australiaeast'
RG_NAME='09-app-gateway-ingress-controller-cluster-rg'
MC_RG_NAME='MC_09-app-gateway-ingress-controller-cluster-rg_agic-cluster_australiaeast'
az group create -n $RG_NAME --location $LOCATION

az aks create -n 'agic-cluster' \
  -g $RG_NAME \
  --node-count 1 \
  --network-plugin azure \
  --enable-managed-identity \
  -a ingress-appgw --appgw-name 'agic-app-gwy' --appgw-subnet-cidr "10.225.0.0/16" --generate-ssh-keys

az aks get-credentials -g $RG_NAME -n 'agic-cluster' --admin --context '09-agic-cluster'

kubectl apply -f ./agic-app.yaml

POD_NAME=`k get po -l=app=ingress-appgw -n kube-system | tail -n +2 | awk '{print $1}'`
k logs $POD_NAME -n kube-system

kubectl get ingress

GW_NAME=`az network application-gateway list -g $MC_RG_NAME --query [].name -o tsv`
IP_ADDR_ID=`az network application-gateway frontend-ip list --gateway-name $GW_NAME --resource-group $MC_RG_NAME --query [].publicIPAddress.id --output tsv`
IP_ADDR=`az network public-ip show --ids $IP_ADDR_ID --query ipAddress --output tsv`

echo http://$IP_ADDR

curl http://$IP_ADDR
