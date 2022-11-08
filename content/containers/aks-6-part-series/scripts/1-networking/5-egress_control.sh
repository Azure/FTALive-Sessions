################################
# 5 - Egress controlled cluster
################################

LOCATION='australiaeast'
SSH_KEY=$(cat ~/.ssh/id_rsa.pub)
PREFIX="fw-egress"
RG_NAME="005-${PREFIX}-rg"
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
az network firewall network-rule create -g $RG_NAME -f $FWNAME --collection-name 'aksfwnr' -n 'deny-the-onion' --protocols 'TCP' --source-addresses '*' --destination-fqdns '*.theonion.com' --destination-ports 443,80

# Add FW Application Rules
az network firewall application-rule create -g $RG_NAME -f $FWNAME --collection-name 'aksfwar' -n 'fqdn' --source-addresses '*' --protocols 'http=80' 'https=443' --fqdn-tags "AzureKubernetesService" --action allow --priority 100

# Associate route table with next hop to Firewall to the AKS subnet
az network vnet subnet update -g $RG_NAME --vnet-name $VNET_NAME --name $AKSSUBNET_NAME --route-table $FWROUTE_TABLE_NAME

SUBNETID=$(az network vnet subnet show -g $RG_NAME --vnet-name $VNET_NAME --name $AKSSUBNET_NAME --query id -o tsv)

az aks create -g $RG_NAME -n $AKSNAME -l $LOCATION \
  --node-count 1 \
  --enable-cluster-autoscaler \
  --min-count 1 \
  --max-count 5 \
  --network-plugin azure \
  --outbound-type userDefinedRouting \
  --vnet-subnet-id $SUBNETID \
  --api-server-authorized-ip-ranges $FWPUBLIC_IP

# Retrieve your IP address
CURRENT_IP=$(dig @resolver1.opendns.com ANY myip.opendns.com +short)

# Add to AKS approved list
az aks update -g $RG_NAME -n $AKSNAME --api-server-authorized-ip-ranges $CURRENT_IP/32

# deploy test application
az aks get-credentials -g $RG_NAME -n $AKSNAME --admin --context '05-egress-cluster'

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

# get a shell on a new pod and try to access a denied url
