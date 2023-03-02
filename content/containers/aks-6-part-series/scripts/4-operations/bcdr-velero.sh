# install velero client
wget https://github.com/vmware-tanzu/velero/releases/download/v1.9.2/velero-v1.9.2-linux-amd64.tar.gz
tar -xzf ./velero-v1.9.2-linux-amd64.tar.gz 
cp ./velero /usr/local/bin/

# set variables
AZURE_BACKUP_SUBSCRIPTION_NAME=$(az account show --query name -o tsv)
AZURE_TENANT_ID=$(az account show --query tenantId -o tsv)
AZURE_BACKUP_SUBSCRIPTION_ID=$(az account list --query="[?name=='$AZURE_BACKUP_SUBSCRIPTION_NAME'].id | [0]" -o tsv)
AZURE_RESOURCE_GROUP='fta-aks-ops-rg'
AZURE_SUBSCRIPTION_ID=`az account list --query '[?isDefault].id' -o tsv`
AZURE_ROLE=Velero
BLOB_CONTAINER=velero

# switch to correct cluster
k config use-context fta-aks-ops-bcdr

# create storage account
AZURE_STORAGE_ACCOUNT_ID="velero$(uuidgen | cut -d '-' -f5 | tr '[A-Z]' '[a-z]')"
az storage account create \
    --name $AZURE_STORAGE_ACCOUNT_ID \
    --resource-group $AZURE_RESOURCE_GROUP \
    --sku Standard_GRS \
    --encryption-services blob \
    --https-only true \
    --kind BlobStorage \
    --access-tier Hot

# create storage container
az storage container create -n $BLOB_CONTAINER --public-access off --account-name $AZURE_STORAGE_ACCOUNT_ID
AZURE_STORAGE_ACCOUNT_ACCESS_KEY=`az storage account keys list --account-name $AZURE_STORAGE_ACCOUNT_ID --query "[?keyName == 'key1'].value" -o tsv`

# create custom role 'Velero'
az role definition create --role-definition '{
   "Name": "'$AZURE_ROLE'",
   "Description": "Velero related permissions to perform backups, restores and deletions",
   "Actions": [
       "Microsoft.Compute/disks/read",
       "Microsoft.Compute/disks/write",
       "Microsoft.Compute/disks/endGetAccess/action",
       "Microsoft.Compute/disks/beginGetAccess/action",
       "Microsoft.Compute/snapshots/read",
       "Microsoft.Compute/snapshots/write",
       "Microsoft.Compute/snapshots/delete",
       "Microsoft.Storage/storageAccounts/listkeys/action",
       "Microsoft.Storage/storageAccounts/regeneratekey/action"
   ],
   "AssignableScopes": ["/subscriptions/'$AZURE_SUBSCRIPTION_ID'"]
   }'

# create service principal
AZURE_CLIENT_SECRET=$(az ad sp create-for-rbac --name "velero" --role $AZURE_ROLE --query 'password' --scopes  /subscriptions/$AZURE_SUBSCRIPTION_ID -o tsv)
AZURE_CLIENT_ID=`az ad sp list --display-name "velero" --query '[0].appId' -o tsv`

# save creds to local file for install commend to use
cat << EOF  > ./credentials-velero
AZURE_SUBSCRIPTION_ID=${AZURE_SUBSCRIPTION_ID}
AZURE_TENANT_ID=${AZURE_TENANT_ID}
AZURE_CLIENT_ID=${AZURE_CLIENT_ID}
AZURE_CLIENT_SECRET=${AZURE_CLIENT_SECRET}
AZURE_RESOURCE_GROUP=${AZURE_RESOURCE_GROUP}
AZURE_CLOUD_NAME=AzurePublicCloud
EOF

## install velero controller
velero install \
    --provider azure \
    --plugins velero/velero-plugin-for-microsoft-azure:v1.5.0 \
    --bucket $BLOB_CONTAINER \
    --secret-file ./credentials-velero \
    --backup-location-config resourceGroup=$AZURE_RESOURCE_GROUP,storageAccount=$AZURE_STORAGE_ACCOUNT_ID,subscriptionId=$AZURE_BACKUP_SUBSCRIPTION_ID \
    --snapshot-location-config apiTimeout=600,resourceGroup=$AZURE_RESOURCE_GROUP,subscriptionId=$AZURE_BACKUP_SUBSCRIPTION_ID

##########################
# Velero NGINX basic demo
##########################

kubectl apply -f ./nginx-app/base.yaml
k get all -n nginx-example 
k get ns

# create a backup of everyting in the 'nginx-example' namespace
velero backup create nginx-backup --include-namespaces nginx-example

# list backup logs
velero backup describe nginx-backup
velero backup logs nginx-backup

# list namespaces
k get ns

# delete the namespace
kubectl delete namespaces nginx-example

# list namespaces & resources
k get ns
k get all -n nginx-example

# restore namespace & all objects contained within it
velero restore create --from-backup nginx-backup

# list namespaces & resources
k get ns
k get all -n nginx-example

# delete backup
velero backup delete nginx-backup 

#############################################
# Velero with persistent volume claims demo
#############################################

kubectl apply -f ./nginx-app/with-pv.yaml
k get ns
k get all -n nginx-pv-example

# create a backup of everyting in the 'nginx-example' namespace
velero backup create nginx-pv-backup --include-namespaces nginx-pv-example

# list backup logs
velero backup describe nginx-pv-backup
velero backup logs nginx-pv-backup

# list namespaces
k get ns

# delete the namespace
kubectl delete namespaces nginx-pv-example

# list namespaces
k get ns
k get all -n nginx-pv-example

# restore namespace & all objects contained within it
velero restore create --from-backup nginx-pv-backup

# list namespaces
k get ns
k get all -n nginx-pv-example

# delete backup
velero backup delete nginx-pv-backup 