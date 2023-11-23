#####################
# Prerequisites
#####################

# AKS cluster cluster with lowest currently supported version in region & OS disks older than 1 week
# cluster must be created more than a week before delivery
# use /assets/cluster/deploy.sh script to deploy the cluster

LOCATION='australiaeast'
RG='fta-aks-ops-rg'
CLUSTER_NAME='fta-aks-ops-aks-3u5rnt64xzuze'
# CLUSTER=$(az aks show -g $RG -n $CLUSTER_NAME --query name -o tsv)

CURRENT_K8S_VERSION=$(az aks show --resource-group $RG -n $CLUSTER_NAME | jq -r .kubernetesVersion)
LATEST_K8S_VERSION=$(az aks get-versions -l $LOCATION | jq -r -c '[.orchestrators[] | .orchestratorVersion][-1]')
LATEST_UPGRADE_K8S_VERSION=$(az aks get-upgrades --resource-group $RG --name $CLUSTER_NAME --query "controlPlaneProfile.upgrades[-1].kubernetesVersion" -o tsv)

az aks get-credentials -g $RG -n $CLUSTER_NAME --admin
kubectl config use-context $CLUSTER_NAME-admin

##############################
# Cluster version upgrades
##############################

# show cluster kubernetes version
az aks show \
    --resource-group $RG \
    --name $CLUSTER_NAME \
    --query '{Name:name, K8SVersion:kubernetesVersion}' -o table
    
# supported versions in an Azure region
az aks get-versions --location $LOCATION --output table

# which version your cluster can upgrade to
printf "Current version: $CURRENT_K8S_VERSION \n Latest version: $LATEST_K8S_VERSION \n Supported upgrade version: $LATEST_UPGRADE_K8S_VERSION \n"

# upgrade an entire cluster (control plane & all node pools)
# this will FAIL as each version has a specific upgrade path that must be followed
az aks upgrade \
    --resource-group $RG \
    --name $CLUSTER_NAME \
    --kubernetes-version $LATEST_K8S_VERSION

# upgrade the control plane only (using a supported upgrade path)
az aks upgrade \
    --resource-group $RG \
    --name $CLUSTER_NAME \
    --kubernetes-version $LATEST_UPGRADE_K8S_VERSION \
    --control-plane-only

# upgrade a specific nodepool
az aks nodepool upgrade \
    --resource-group $RG \
    --cluster-name $CLUSTER_NAME \
    --name linux \
    --kubernetes-version $LATEST_UPGRADE_K8S_VERSION

#######################
# Node OS upgrades
#######################

# list all nodepool kubernetes & OS versions
az aks nodepool list \
    --resource-group $RG \
    --cluster-name $CLUSTER_NAME \
    --query '[].{poolName:name, osType:osType, count:count, aksVersion:orchestratorVersion, imageVersion:nodeImageVersion}' -o table

# show only the 'system' nodepool kubernetes OS image version
az aks nodepool show \
    --cluster-name $CLUSTER_NAME \
    --name system \
    --resource-group $RG \
    --query '{OrchestratorVersion:orchestratorVersion, NodeImageVersion:nodeImageVersion, OSType:osType, ResourceGroup:resourceGroup}' -o table

# get OS upgrades for 'system' nodepool
az aks nodepool get-upgrades \
    --nodepool-name system \
    --cluster-name $CLUSTER_NAME \
    --resource-group $RG \
    -o table

# list image using kubectl
kubectl get nodes \
    -o jsonpath='{range .items[*]}{.metadata.name}{"\t"}{.metadata.labels.kubernetes\.azure\.com\/node-image-version}{"\n"}{end}'

# Update max surge for the 'system' node pool
az aks nodepool show -n system -g $RG --cluster-name $CLUSTER_NAME
az aks nodepool update -n linux -g $RG --cluster-name $CLUSTER_NAME --max-surge 33%
az aks nodepool show -n linux -g $RG --cluster-name $CLUSTER_NAME --query upgradeSettings

# upgrade the image of a node pool (The OS of Windows nodes can only be upgraded by image)
az aks nodepool upgrade --resource-group $RG --cluster-name $CLUSTER_NAME --name system --node-image-only

# list image using kubectl
kubectl get nodes \
    -o jsonpath='{range .items[*]}{.metadata.name}{"\t"}{.metadata.labels.kubernetes\.azure\.com\/node-image-version}{"\n"}{end}'

# upgrade the node image for all node pools in the cluster
az aks upgrade --resource-group $RG --name $CLUSTER_NAME --node-image-only

# list image using kubectl
kubectl get nodes \
    -o jsonpath='{range .items[*]}{.metadata.name}{"\t"}{.metadata.labels.kubernetes\.azure\.com\/node-image-version}{"\n"}{end}'
