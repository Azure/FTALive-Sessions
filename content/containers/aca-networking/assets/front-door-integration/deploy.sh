#!/bin/bash

LOCATION='australiaeast'
PREFIX='afd'
RG_NAME="${PREFIX}-aca-rg"

# create resource group
az group create --location $LOCATION --name $RG_NAME

# deploy infrastructure
az deployment group create \
	--resource-group $RG_NAME \
	--name 'infra-deployment' \
	--template-file ./main.bicep \
	--parameters location=$LOCATION \
	--parameters prefix=$PREFIX

# get deployment template outputs
PLS_NAME=`az deployment group show --resource-group $RG_NAME --name 'infra-deployment' --query properties.outputs.privateLinkServiceName.value --output tsv`
AFD_FQDN=`az deployment group show --resource-group $RG_NAME --name 'infra-deployment' --query properties.outputs.afdFqdn.value --output tsv`
PEC_ID=`az network private-endpoint-connection list -g $RG_NAME -n $PLS_NAME --type Microsoft.Network/privateLinkServices --query [0].id --output tsv`

# approve private endpoint connection
echo "approving private endpoint connection ID: '$PEC_ID'"
az network private-endpoint-connection approve -g $RG_NAME -n $PLS_NAME --id $PEC_ID --description "Approved" 

# test AFD endpoint
curl "https://$AFD_FQDN"
