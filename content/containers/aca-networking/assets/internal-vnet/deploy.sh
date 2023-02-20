#!/bin/bash

LOCATION='australiaeast'
PREFIX='aca-internal'
RG_NAME="${PREFIX}-rg"
SSH_KEY=`cat ~/.ssh/id_rsa.pub`

# create resource group
az group create --location $LOCATION --name $RG_NAME

# deploy infrastructure
az deployment group create \
	--resource-group $RG_NAME \
	--name 'infra-deployment' \
	--template-file ./main.bicep \
	--parameters location=$LOCATION \
	--parameters prefix=$PREFIX \
	--parameters publicSshKey="$SSH_KEY" \
	--parameters isZoneRedundant='true'

# get deployment template outputs
APP_FQDN=`az deployment group show --resource-group $RG_NAME --name 'infra-deployment' --query properties.outputs.appFqdn.value --output tsv`
BASTION_HOST_NAME=`az deployment group show --resource-group $RG_NAME --name 'infra-deployment' --query properties.outputs.bastionHostName.value --output tsv`
VM_ID=`az deployment group show --resource-group $RG_NAME --name 'infra-deployment' --query properties.outputs.vmId.value --output tsv`

echo "APP_FQDN: https://$APP_FQDN"

# open ssh tunnel to VM in the same vnet as the ACA environment
az network bastion ssh \
	--name $BASTION_HOST_NAME \
	--resource-group $RG_NAME \
	--target-resource-id $VM_ID \
	--auth-type ssh-key \
	--username 'localadmin' \
	--ssh-key '~/.ssh/id_rsa'

# run these commands in the remote ssh session opened by the previous command
# $ nslookup <APP_FQDN>
# $ curl https://<APP_FQDN>
