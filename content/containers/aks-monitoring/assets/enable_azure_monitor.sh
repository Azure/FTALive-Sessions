rgName='fta-aks-ops-rg'
clusterName='fta-aks-ops-aks-3u5rnt64xzuze'
workspaceName='fta-aks-ops-wks-3u5rnt64xzuze'
subscriptionId=$(az account show --query id -o tsv)

# AMA replaces the legacy OMS Agent

# Set subscription context
az account set --subscription $subscriptionId

# Enable monitoring on existing cluster
az aks enable-addons -a monitoring -n $clusterName -g $rgName

# Enable monitoring on existing cluster with existing workspace
az aks enable-addons -a monitoring -n $clusterName -g $rgName --workspace-resource-id "/subscriptions/$subscriptionId/resourcegroups/$rgName/providers/microsoft.operationalinsights/workspaces/$workspaceName"

# Verify the status and the agent version
kubectl get ds ama-logs --namespace kube-system

# To verify the agent version running on Windows nodepool.
kubectl get ds omsagent-win --namespace kube-system

# Check the connected workspace details for an existing cluster
az aks show -g $rgName -n $clusterName | grep -i "logAnalyticsWorkspaceResourceID"

# To disable the addon Azure monitor for containers
az aks disable-addons -a monitoring -g $rgName -n $clusterName
