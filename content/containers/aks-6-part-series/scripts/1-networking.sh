LOCATION='australiaeast'
SSH_KEY=$(cat ~/.ssh/id_rsa.pub)

######################################################
# 1. Kubenet CNI (Container Network Interface) cluster
######################################################

RG_NAME='001-kubenet-cluster-rg'
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
    -n 'kubenet-cluster' \
    --network-plugin kubenet \
    --vnet-subnet-id $SUBNET_ID \
    --ssh-key-value "$SSH_KEY"

# SSH to privileged container on cluster node
az aks get-credentials -g $RG_NAME -n 'kubenet-cluster' --admin
NODE_NAME=$(k get node -o json | jq .items[0].metadata.name -r)
kubectl debug node/$NODE_NAME -it --image=mcr.microsoft.com/dotnet/runtime-deps:6.0
# $ cat /proc/version # get OS details
# $ uname -r # get kernel details
# $ chroot /host # interact with node session

######################################################
# 2. Azure CNI cluster
######################################################
RG_NAME='002-cni-cluster-rg'
az group create -n $RG_NAME --location $LOCATION

az network vnet create -g $RG_NAME --name 'cni-vnet' --address-prefixes '192.168.0.0/16' --subnet-name 'cni-subnet' --subnet-prefix '192.168.1.0/24'
SUBNET_ID=$(az network vnet subnet show -g $RG_NAME --vnet-name 'cni-vnet' --name 'cni-subnet' --query id -o tsv)

az aks create -g $RG_NAME -n 'cni-cluster' \
    --vnet-subnet-id $SUBNET_ID \
    --ssh-key-value "$SSH_KEY" \
    --network-plugin azure \
    --docker-bridge-address '172.17.0.1/16' \
    --dns-service-ip '10.2.0.10' \
    --service-cidr '10.2.0.0/24' \

az aks get-credentials -g $RG_NAME -n 'cni-cluster' --admin

###########################################################################
# 3. Azure CNI cluster with dynamic IP allocation & enhanced subnet support
###########################################################################
RG_NAME='003-cni-dyn-subnet-cluster-rg'
az group create -n $RG_NAME --location $LOCATION

# Create vnet & 2 subnets
az network vnet create -g $RG_NAME --location $LOCATION --name 'cni-dyn-vnet' --address-prefixes '10.0.0.0/8' -o none 
az network vnet subnet create -g $RG_NAME --vnet-name 'cni-dyn-vnet' --name 'node-subnet' --address-prefixes '10.240.0.0/16' -o none 
az network vnet subnet create -g $RG_NAME --vnet-name 'cni-dyn-vnet' --name 'pod-subnet' --address-prefixes '10.241.0.0/16' -o none

NODE_SUBNET_ID=$(az network vnet subnet show -g $RG_NAME --vnet-name 'cni-dyn-vnet' --name 'node-subnet' --query id -o tsv)
POD_SUBNET_ID=$(az network vnet subnet show -g $RG_NAME --vnet-name 'cni-dyn-vnet' --name 'pod-subnet' --query id -o tsv)

az aks create \
    --resource-group $RG_NAME \
    --name 'cni-dyn-subnet-cluster' \
    --network-plugin azure \
    --max-pods 250 \
    --vnet-subnet-id $NODE_SUBNET_ID \
    --pod-subnet-id $POD_SUBNET_ID \
    --ssh-key-value "$SSH_KEY"

az aks get-credentials -g $RG_NAME -n 'cni-dyn-subnet-cluster' --admin

######################
# 4. Private cluster
######################
RG_NAME='004-private-cluster-rg'
az group create -n $RG_NAME --location $LOCATION

az network vnet create \
    --resource-group $RG_NAME \
    --name 'private-vnet' \
    --address-prefixes '192.168.0.0/16' \
    --subnet-name 'private-subnet' \
    --subnet-prefix '192.168.1.0/24'

SUBNET_ID=$(az network vnet subnet show \
    --resource-group $RG_NAME \
    --vnet-name 'private-vnet' \
    --name 'private-subnet' \
    --query id -o tsv)

az aks create \
    --resource-group $RG_NAME \
    --name 'private-cluster' \
    --network-plugin azure \
    --vnet-subnet-id $SUBNET_ID \
    --docker-bridge-address 172.17.0.1/16 \
    --dns-service-ip 10.2.0.10 \
    --service-cidr 10.2.0.0/24 \
    --ssh-key-value "$SSH_KEY" \
    --enable-private-cluster

az aks get-credentials -g $RG_NAME -n 'private-cluster' --admin

################################
# 5. Egress controlled cluster
################################

PREFIX="egress"
RG_NAME="005-${PREFIX}-rg"
LOCATION="australiaeast"
PLUGIN=azure
AKSNAME="${PREFIX}-cluster"
VNET_NAME="${PREFIX}-vnet"
AKSSUBNET_NAME="${PREFIX}-subnet"
FWSUBNET_NAME="AzureFirewallSubnet"
FWNAME="${PREFIX}-fw"
FWPUBLICIP_NAME="${PREFIX}-fwpublicip"
FWIPCONFIG_NAME="${PREFIX}-fwconfig"
FWROUTE_TABLE_NAME="${PREFIX}-fwrt"
FWROUTE_NAME="${PREFIX}-fwrn"
FWROUTE_NAME_INTERNET="${PREFIX}-fwinternet"

# create Resource Group
az group create -n $RG_NAME --location $LOCATION

# create Vnet
az network vnet create \
    --resource-group $RG_NAME \
    --name $VNET_NAME \
    --location $LOCATION \
    --address-prefixes 10.42.0.0/16 \
    --subnet-name $AKSSUBNET_NAME \
    --subnet-prefix 10.42.1.0/24

# Dedicated subnet for Azure Firewall (Firewall name cannot be changed)
az network vnet subnet create \
    --resource-group $RG_NAME \
    --vnet-name $VNET_NAME \
    --name $FWSUBNET_NAME \
    --address-prefix 10.42.2.0/24

az network public-ip create -g $RG_NAME -n $FWPUBLICIP_NAME -l $LOCATION --sku "Standard"

# Install Azure Firewall preview CLI extension
az extension add --name azure-firewall

# Deploy Azure Firewall
az network firewall create -g $RG_NAME -n $FWNAME -l $LOCATION --enable-dns-proxy true

# Configure Firewall IP Config
az network firewall ip-config create -g $RG_NAME -f $FWNAME -n $FWIPCONFIG_NAME --public-ip-address $FWPUBLICIP_NAME --vnet-name $VNET_NAME

# Capture Firewall IP Address for Later Use
FWPUBLIC_IP=$(az network public-ip show -g $RG_NAME -n $FWPUBLICIP_NAME --query "ipAddress" -o tsv)
FWPRIVATE_IP=$(az network firewall show -g $RG_NAME -n $FWNAME --query "ipConfigurations[0].privateIpAddress" -o tsv)

# Create UDR and add a route for Azure Firewall
az network route-table create -g $RG_NAME -l $LOCATION --name $FWROUTE_TABLE_NAME
az network route-table route create -g $RG_NAME --name $FWROUTE_NAME --route-table-name $FWROUTE_TABLE_NAME --address-prefix 0.0.0.0/0 --next-hop-type VirtualAppliance --next-hop-ip-address $FWPRIVATE_IP
az network route-table route create -g $RG_NAME --name $FWROUTE_NAME_INTERNET --route-table-name $FWROUTE_TABLE_NAME --address-prefix $FWPUBLIC_IP/32 --next-hop-type Internet

# Add FW Network Rules
az network firewall network-rule create -g $RG_NAME -f $FWNAME --collection-name 'aksfwnr' -n 'apiudp' --protocols 'UDP' --source-addresses '*' --destination-addresses "AzureCloud.$LOCATION" --destination-ports 1194 --action allow --priority 100
az network firewall network-rule create -g $RG_NAME -f $FWNAME --collection-name 'aksfwnr' -n 'apitcp' --protocols 'TCP' --source-addresses '*' --destination-addresses "AzureCloud.$LOCATION" --destination-ports 9000
az network firewall network-rule create -g $RG_NAME -f $FWNAME --collection-name 'aksfwnr' -n 'time' --protocols 'UDP' --source-addresses '*' --destination-fqdns 'ntp.ubuntu.com' --destination-ports 123

# Add FW Application Rules
az network firewall application-rule create -g $RG_NAME -f $FWNAME --collection-name 'aksfwar' -n 'fqdn' --source-addresses '*' --protocols 'http=80' 'https=443' --fqdn-tags "AzureKubernetesService" --action allow --priority 100

# Associate route table with next hop to Firewall to the AKS subnet
az network vnet subnet update -g $RG_NAME --vnet-name $VNET_NAME --name $AKSSUBNET_NAME --route-table $FWROUTE_TABLE_NAME

SUBNETID=$(az network vnet subnet show -g $RG_NAME --vnet-name $VNET_NAME --name $AKSSUBNET_NAME --query id -o tsv)

az aks create -g $RG_NAME -n $AKSNAME -l $LOCATION \
  --node-count 3 \
  --network-plugin azure \
  --outbound-type userDefinedRouting \
  --vnet-subnet-id $SUBNETID \
  --api-server-authorized-ip-ranges $FWPUBLIC_IP

# Retrieve your IP address
CURRENT_IP=$(dig @resolver1.opendns.com ANY myip.opendns.com +short)

# Add to AKS approved list
az aks update -g $RG_NAME -n $AKSNAME --api-server-authorized-ip-ranges $CURRENT_IP/32

# deploy test application
az aks get-credentials -g $RG_NAME -n $AKSNAME --admin
kubectl apply -f ./voting-app.yaml

# add NAT rule for Azure Firewall
SERVICE_IP=$(kubectl get svc voting-app -o jsonpath='{.status.loadBalancer.ingress[*].ip}')
az network firewall nat-rule create \
    --collection-name exampleset \
    --destination-addresses $FWPUBLIC_IP \
    --destination-ports 80 --firewall-name $FWNAME \
    --name inboundrule \
    --protocols Any \
    --resource-group $RG_NAME \
    --source-addresses '*' \
    --translated-port 80 \
    --action Dnat \
    --priority 100 \
    --translated-address $SERVICE_IP

curl http://$FWPUBLIC_IP

################################
# 6. Managed NAT Gateway egress
################################
RG_NAME='006-nat-gwy-cluster-rg'
az group create -n $RG_NAME --location $LOCATION

az aks create \
    --resource-group $RG_NAME \
    --name 'nat-gwy-cluster' \
    --node-count 3 \
    --outbound-type managedNATGateway \
    --nat-gateway-managed-outbound-ip-count 2 \
    --nat-gateway-idle-timeout 30

az aks get-credentials -g $RG_NAME -n 'nat-gwy-cluster' --admin

################################
# 7. Ingress with NGINX
################################
RG_NAME='007-nginx-cluster-rg'
az group create -n $RG_NAME --location $LOCATION

az aks create \
    --resource-group $RG_NAME \
    --name 'nginx-cluster' \
    --node-count 3

az aks get-credentials -g $RG_NAME -n 'nginx-cluster' --admin

NAMESPACE=ingress-basic

helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
helm repo update

helm install ingress-nginx ingress-nginx/ingress-nginx \
  --create-namespace \
  --namespace $NAMESPACE \
  --set controller.service.annotations."service\.beta\.kubernetes\.io/azure-load-balancer-health-probe-request-path"=/healthz

kubectl apply -f ./aks-helloworld-one.yaml --namespace ingress-basic
kubectl apply -f ./aks-helloworld-two.yaml --namespace ingress-basic
kubectl apply -f ./hello-world-ingress.yaml --namespace ingress-basic

kubectl run -it aks-ingress-test --image=mcr.microsoft.com/dotnet/runtime-deps:6.0 --namespace ingress-basic
EXTERNAL_IP=$(k get svc ingress-nginx-controller -n ingress-basic -o json | jq .status.loadBalancer.ingress[0].ip -r)

# $ apt-get update && apt-get install -y curl
# $ curl -L http://$EXTERNAL_IP

#####################################
# 8. Ingress with private NGINX IP
#####################################
RG_NAME='008-internal-nginx-cluster-rg'
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
    --node-count 3

az aks get-credentials -g $RG_NAME -n 'internal-nginx-cluster' --admin

SCOPE=$(az group show -n $RG_NAME | jq .id -r)
ASSIGNEE=$(az aks show -g $RG_NAME -n 'internal-nginx-cluster' | jq .identityProfile.kubeletidentity.clientId -r)
az role assignment create --role "Network Contributor" --assignee $ASSIGNEE --scope $SCOPE

# Add the ingress-nginx repository
helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx

# Use Helm to deploy an NGINX ingress controller
helm install ingress-nginx ingress-nginx/ingress-nginx \
    --version 4.1.3 \
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

################################
# 9. External ingress with AGIC
################################
RG_NAME='009-app-gateway-ingress-controller-cluster-rg'
az group create -n $RG_NAME --location $LOCATION

az aks create -n 'agic-cluster' -g $RG_NAME --network-plugin azure --enable-managed-identity \
-a ingress-appgw --appgw-name 'agic-app-gwy' --appgw-subnet-cidr "10.225.0.0/16" --generate-ssh-keys

az aks get-credentials -g $RG_NAME -n 'agic-cluster' --admin

kubectl apply -f ./agic-app.yaml
kubectl get ingress

######################
# Network policies
#######################
RG_NAME='010-network-policy-cluster-rg'
az group create -n $RG_NAME --location $LOCATION

az aks create \
    --resource-group $RG_NAME \
    --name 'network-policy-cluster' \
    --node-count 1 \
    --network-plugin azure \
    --network-policy azure

az aks get-credentials -g $RG_NAME -n 'network-policy-cluster' --admin

kubectl create namespace demo

# create server pod
kubectl run server -n demo \
    --image=k8s.gcr.io/e2e-test-images/agnhost:2.33 \
    --labels="app=server" \
    --port=80 \
    --command -- /agnhost serve-hostname \
    --tcp \
    --http=false \
    --port "80"

# get pod IP
kubectl get pod -n demo --output=wide

# create client pod & get a shell within it
kubectl run -it client -n demo --image=k8s.gcr.io/e2e-test-images/agnhost:2.33 --command -- bash

# enter the following command in the cient shell
# output should be empty (successful)
# $ /agnhost connect <server-ip>:80 --timeout=3s --protocol=tcp 

# apply security policy
kubectl apply -f ./network-policy.yaml

# list the network policy
k describe NetworkPolicy/demo-policy -n demo

# connect to client pod & verify connectivity fails
# client app doesn't have the 'app=client' label, only the 'run=client' label
k describe pod client -n demo

kubectl exec -n demo -it pod/client -- bash
# enter the following command in the cient shell
# output should be 'TIMEOUT' (un-successful) since the network policy now blocks the connection
# $ /agnhost connect <server-ip>:80 --timeout=3s --protocol=tcp 

#######################
# Service Mesh
#######################
RG_NAME='011-osm-cluster-rg'
az group create -n $RG_NAME --location $LOCATION

az aks create \
  --resource-group $RG_NAME \
  --name 'osm-cluster' \
  --enable-addons open-service-mesh

az aks get-credentials -g $RG_NAME -n 'osm-cluster' --admin

# install OSM CLI
OSM_VERSION=v1.0.0
curl -sL "https://github.com/openservicemesh/osm/releases/download/$OSM_VERSION/osm-$OSM_VERSION-linux-amd64.tar.gz" | tar -vxzf -
sudo mv ./linux-amd64/osm /usr/local/bin/osm

# verify OSM is running
az aks show --resource-group $RG_NAME --name 'osm-cluster'  --query 'addonProfiles.openServiceMesh.enabled'

kubectl get deployments -n kube-system --selector app.kubernetes.io/name=openservicemesh.io
kubectl get pods -n kube-system --selector app.kubernetes.io/name=openservicemesh.io
kubectl get services -n kube-system --selector app.kubernetes.io/name=openservicemesh.io
kubectl get meshconfig osm-mesh-config -n kube-system -o yaml

# deploy sample application
kubectl create namespace bookstore
kubectl create namespace bookbuyer
kubectl create namespace bookthief
kubectl create namespace bookwarehouse

osm namespace add bookstore bookbuyer bookthief bookwarehouse

kubectl apply -f https://raw.githubusercontent.com/openservicemesh/osm-docs/release-v1.2/manifests/apps/bookbuyer.yaml
kubectl apply -f https://raw.githubusercontent.com/openservicemesh/osm-docs/release-v1.2/manifests/apps/bookthief.yaml
kubectl apply -f https://raw.githubusercontent.com/openservicemesh/osm-docs/release-v1.2/manifests/apps/bookstore.yaml
kubectl apply -f https://raw.githubusercontent.com/openservicemesh/osm-docs/release-v1.2/manifests/apps/bookwarehouse.yaml
kubectl apply -f https://raw.githubusercontent.com/openservicemesh/osm-docs/release-v1.2/manifests/apps/mysql.yaml


# verify dpeloyment
kubectl get pods,deployments,serviceaccounts -n bookbuyer
kubectl get pods,deployments,serviceaccounts -n bookthief
kubectl get pods,deployments,serviceaccounts,services,endpoints -n bookstore
kubectl get pods,deployments,serviceaccounts,services,endpoints -n bookwarehouse

# port-forward each application
bash <<EOF
./port-forward-bookbuyer-ui.sh &
./port-forward-bookstore-ui-v1.sh &
./port-forward-bookthief-ui.sh &
wait
EOF

# access the apps
# http://localhost:8080 - bookbuyer
# http://localhost:8081 - bookstore ui v1
# http://localhost:8083 - bookthief

# display current service mesh configuration
kubectl get meshconfig osm-mesh-config -n kube-system -o jsonpath='{.spec.traffic.enablePermissiveTrafficPolicyMode}{"\n"}'

# enable Permissive policy mode
kubectl patch meshconfig osm-mesh-config -n kube-system -p '{"spec":{"traffic":{"enablePermissiveTrafficPolicyMode":true}}}' --type=merge

# disable premissive mode
kubectl patch meshconfig osm-mesh-config -n kube-system -p '{"spec":{"traffic":{"enablePermissiveTrafficPolicyMode":false}}}' --type=merge

# enable OSM policy to prevent 'bookthief' from accessing the bookstore
# books being stolen should now stop
kubectl apply -f ./osm-policy-deny-bookthief.yaml

##########################
# External components
##########################

## Private Endpoints
## ACR
## KeyVault CSI