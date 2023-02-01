#!/bin/bash

##### Prerequisites #####
# 1. copy a valid public .PFX encoded TLS certificate to a new ./certs directory
# 2. create a file '.env' in the root of the 'custom-domain' directory
# 3. add a line in the .env file to define an environment variable for the certificate password. .i.e. CERTIFICATE_PASSWORD=<your password>

LOCATION='australiaeast'
PREFIX='aca-custom-dns'
RG_NAME="${PREFIX}-rg"
CERT_PATH='./certs/star.kainiindustries.net.bundle.pfx'

# source 'CERTIFICATE_PASSWORD' from .env file
source ./.env

# create resource group
az group create --location $LOCATION --name $RG_NAME

# deploy infrastructure
az deployment group create \
	--resource-group $RG_NAME \
	--name 'infra-deployment' \
	--template-file ./main.bicep \
	--parameters location=$LOCATION \
	--parameters prefix=$PREFIX \
	--parameters certificatePassword=$CERTIFICATE_PASSWORD \
	--parameters certificate="$(cat $CERT_PATH | base64)"

# get deployment template outputs
APP_FQDN=`az deployment group show --resource-group $RG_NAME --name 'infra-deployment' --query properties.outputs.appFqdn.value --output tsv`

echo "APP_FQDN: https://$APP_FQDN"
curl https://$APP_FQDN
