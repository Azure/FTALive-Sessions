LOCATION='australiaeast'
RG_NAME='aca-dapr-rg'

SUB_APP_NAME='sub'
SUB_APP_PORT=5001

PUB_APP_NAME='pub'
PUB_APP_PORT=5002

STATE_STORE_NAME='state'
PUB_SUB_NAME='pubsub'
TOPIC_NAME='orders'

SQL_ADMIN_LOGIN_NAME='dbadmin'

TAG='v0.1.3'

# deploy resource group
az group create --name $RG_NAME --location $LOCATION

# deploy ACR
ACR_NAME=$(az deployment group create \
    --name 'acr-deployment' \
    --resource-group $RG_NAME \
    --template-file ./acr.bicep \
    --parameters location=$LOCATION \
    --query properties.outputs.acrName.value -o tsv)

# build container images
az acr build \
    -t $PUB_APP_NAME:$TAG \
    --registry $ACR_NAME \
    -f ./Dockerfile \
    ./apps/publisher

az acr build \
    -t $SUB_APP_NAME:$TAG \
    --registry $ACR_NAME \
    -f ./Dockerfile \
    ./apps/subscriber

# deploy environment
az deployment group create \
    --name 'aca-deployment' \
    --resource-group $RG_NAME \
    --template-file ./main.bicep \
    --parameters location=$LOCATION \
    --parameters tag=$TAG \
    --parameters sqlAdminLoginName=$SQL_ADMIN_LOGIN_NAME \
    --parameters sqlAdminPassword=$SQL_ADMIN_PASSWORD \
    --parameters acrName=$ACR_NAME \
    --parameters pubAppName=$PUB_APP_NAME \
    --parameters pubAppPort=$PUB_APP_PORT \
    --parameters subAppName=$SUB_APP_NAME \
    --parameters subAppPort=$SUB_APP_PORT \
    --parameters stateStoreName=$STATE_STORE_NAME \
    --parameters pubSubName=$PUB_SUB_NAME \
    --parameters sbTopicName=$TOPIC_NAME
