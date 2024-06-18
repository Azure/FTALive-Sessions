rgName='fta-aks-ops-rg'
clusterName='fta-aks-ops-aks-3u5rnt64xzuze'
workspaceName='fta-aks-ops-wks-3u5rnt64xzuze'
subscriptionId=$(az account show --query id -o tsv)

az aks disable-addons -a monitoring -g $rgName -n $clusterName
az aks enable-addons -a monitoring --enable-msi-auth-for-monitoring --enable-syslog -g $rgName -n $clusterName
