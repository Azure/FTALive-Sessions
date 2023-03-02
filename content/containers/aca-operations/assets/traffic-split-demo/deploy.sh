#!/bin/bash

while getopts ":s" option; do
   case $option in
      s) skipBuild=1; # use '-s' cmdline flag to skip the container build step
   esac
done

LOCATION='australiaeast'
ACA_APP_NAME='aca-traffic-split-demo'
RESOURCE_GROUP="$ACA_APP_NAME-rg"
ACA_ENVIRONMENT="$ACA_APP_NAME-env"

BLUE_VERSION='0.1.0'
GREEN_VERSION='0.1.1'
BLUE_IMAGE_NAME="blue-server:0.1.0"
GREEN_IMAGE_NAME="green-server:0.1.1"

# crete resource group
az group create --name $RESOURCE_GROUP --location $LOCATION

# deploy Azure Container Registry
ACR_NAME=`az deployment group create \
    --name 'acr-deployment' \
    --resource-group $RESOURCE_GROUP \
    --template-file ./modules/acr.bicep \
    --query properties.outputs.acrName.value \
    --output tsv`

# build and push the 'blue' & 'green' container images
if [[ $skipBuild != 1 ]]; then
    az acr login --name $ACR_NAME

    az acr build --registry $ACR_NAME \
        --image $ACR_NAME.azurecr.io/$BLUE_IMAGE_NAME \
        --build-arg COLOUR=blue \
        --build-arg VERSION=$BLUE_VERSION \
        --file ./Dockerfile .

    az acr build --registry $ACR_NAME \
        --image $ACR_NAME.azurecr.io/$GREEN_IMAGE_NAME \
        --build-arg COLOUR=green \
        --build-arg VERSION=$GREEN_VERSION \
        --file ./Dockerfile .
fi

# deploy main template
az deployment group create \
    --name 'main-deployment' \
    --resource-group $RESOURCE_GROUP \
    --template-file ./main.bicep \
    --parameters registryName=$ACR_NAME \
    --parameters location=$LOCATION \
    --parameters blueImageName="$ACR_NAME.azurecr.io/$BLUE_IMAGE_NAME" \
    --parameters greenImageName="$ACR_NAME.azurecr.io/$GREEN_IMAGE_NAME"

# get app FQDN
APP_FQDN=`az deployment group show \
    --name 'main-deployment' \
    --resource-group $RESOURCE_GROUP \
    --query properties.outputs.fqdn.value \
    --output tsv`

# get the endpoint
curl "https://$APP_FQDN"
