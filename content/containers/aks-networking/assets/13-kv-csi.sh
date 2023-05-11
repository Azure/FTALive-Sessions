#####################
# 13 - KeyVault CSI
#####################

LOCATION='australiaeast'
RG_NAME='13-akv-csi-cluster-rg'
KV_NAME='akvcsi42398g398'
UAMI='akv-csi-identity'
serviceAccountName="workload-identity-sa"  # sample name; can be changed
serviceAccountNamespace="default" # can be changed to namespace of your workload
federatedIdentityName="aksfederatedidentity" # can be changed as needed

# add preview Az CLI extension
az feature register --namespace "Microsoft.ContainerService" --name "EnableWorkloadIdentityPreview"
az feature list -o table --query "[?contains(name, 'Microsoft.ContainerService/EnableWorkloadIdentityPreview')].{Name:name,State:properties.state}"
az provider register -n Microsoft.ContainerService
az extension add --name aks-preview

az group create -n $RG_NAME --location $LOCATION

az aks create -n 'akv-csi-cluster' \
  -g $RG_NAME \
  --node-count 1 \
  --enable-addons azure-keyvault-secrets-provider \
  --enable-managed-identity \
  --enable-oidc-issuer \
  --enable-workload-identity

# get kube config
az aks get-credentials -g $RG_NAME -n 'akv-csi-cluster' --admin --context '13-akv-csi-cluster'

kubectl get pods -n kube-system -l 'app in (secrets-store-csi-driver, secrets-store-provider-azure)'

az keyvault create -n $KV_NAME -g $RG_NAME -l $LOCATION
az keyvault secret set --vault-name $KV_NAME -n secret1 --value MyAKSExampleSecret
az keyvault key create --vault-name $KV_NAME -n key1

# install Workload Identity
az identity create --name $UAMI --resource-group $RG_NAME
USER_ASSIGNED_CLIENT_ID="$(az identity show -g $RG_NAME --name $UAMI --query 'clientId' -o tsv)"
IDENTITY_TENANT=$(az aks show --name 'akv-csi-cluster' --resource-group $RG_NAME --query identity.tenantId -o tsv)

az keyvault set-policy -n $KV_NAME --key-permissions get --spn $USER_ASSIGNED_CLIENT_ID
az keyvault set-policy -n $KV_NAME --secret-permissions get --spn $USER_ASSIGNED_CLIENT_ID
az keyvault set-policy -n $KV_NAME --certificate-permissions get --spn $USER_ASSIGNED_CLIENT_ID

AKS_OIDC_ISSUER="$(az aks show --resource-group $RG_NAME --name 'akv-csi-cluster' --query "oidcIssuerProfile.issuerUrl" -o tsv)"
echo $AKS_OIDC_ISSUER

cat <<EOF | kubectl apply -f -
apiVersion: v1
kind: ServiceAccount
metadata:
  annotations:
    azure.workload.identity/client-id: ${USER_ASSIGNED_CLIENT_ID}
  labels:
    azure.workload.identity/use: "true"
  name: ${serviceAccountName}
  namespace: ${serviceAccountNamespace}
EOF

az identity federated-credential create \
    --name $federatedIdentityName \
    --identity-name $UAMI \
    --resource-group $RG_NAME \
    --issuer ${AKS_OIDC_ISSUER} \
    --subject system:serviceaccount:${serviceAccountNamespace}:${serviceAccountName}

cat <<EOF | kubectl apply -f -
# This is a SecretProviderClass example using workload identity to access your key vault
apiVersion: secrets-store.csi.x-k8s.io/v1
kind: SecretProviderClass
metadata:
  name: azure-kvname-workload-identity # needs to be unique per namespace
spec:
  provider: azure
  parameters:
    usePodIdentity: "false"
    useVMManagedIdentity: "false"          
    clientID: "${USER_ASSIGNED_CLIENT_ID}" # Setting this to use workload identity
    keyvaultName: ${KV_NAME}       # Set to the name of your key vault
    cloudName: ""                         # [OPTIONAL for Azure] if not provided, the Azure environment defaults to AzurePublicCloud
    objects:  |
      array:
        - |
          objectName: secret1
          objectType: secret              # object types: secret, key, or cert
          objectVersion: ""               # [OPTIONAL] object versions, default to latest if empty
        - |
          objectName: key1
          objectType: key
          objectVersion: ""
    tenantId: "${IDENTITY_TENANT}"        # The tenant ID of the key vault
EOF

cat <<EOF | kubectl apply -n $serviceAccountNamespace -f -
# This is a sample pod definition for using SecretProviderClass and the user-assigned identity to access your key vault
kind: Pod
apiVersion: v1
metadata:
  name: busybox-secrets-store-inline-user-msi
spec:
  serviceAccountName: ${serviceAccountName}
  containers:
    - name: busybox
      image: k8s.gcr.io/e2e-test-images/busybox:1.29-1
      command:
        - "/bin/sleep"
        - "10000"
      volumeMounts:
      - name: secrets-store01-inline
        mountPath: "/mnt/secrets-store"
        readOnly: true
  volumes:
    - name: secrets-store01-inline
      csi:
        driver: secrets-store.csi.k8s.io
        readOnly: true
        volumeAttributes:
          secretProviderClass: "azure-kvname-workload-identity"
EOF

## show secrets held in secrets-store
kubectl exec busybox-secrets-store-inline-user-msi -- ls /mnt/secrets-store/

## print a test secret 'ExampleSecret' held in secrets-store
kubectl exec busybox-secrets-store-inline-user-msi -- cat /mnt/secrets-store/secret1
kubectl exec busybox-secrets-store-inline-user-msi -- cat /mnt/secrets-store/key1
