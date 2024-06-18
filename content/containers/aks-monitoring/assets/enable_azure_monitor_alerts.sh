rgName='fta-aks-ops-rg'
location='australiasoutheast'
clusterName='fta-aks-ops-aks-3u5rnt64xzuze'
workspaceName='fta-aks-ops-wks-3u5rnt64xzuze'
subscriptionId=$(az account show --query id -o tsv)
actionGroupResourceId=`az monitor action-group show -g $rgName -n 'send email' --query id -o tsv`
aksResourceId=`az aks show -n $clusterName -g $rgName --query id -o tsv`

az deployment group create \
-g $rgName \
-n 'az_mon_alerts' \
--template-file ./AzureMonitorAlertsProfle.bicep \
--parameters monitorWorkspaceName=$workspaceName \
--parameters location=$location \
--parameters aksResourceId=$aksResourceId \
--parameters actionGroupResourceId="$actionGroupResourceId"

k apply -f - << EOF
apiVersion: v1
kind: Pod
metadata:
  name: pending-sample-app
spec:
  containers:
    - image: gcr.io/kuar-demo/kuard-amd64:1
      name: kuard
      livenessProbe:
        httpGet:
          path: /healthy
          port: 8080
        initialDelaySeconds: 5
        timeoutSeconds: 1
        periodSeconds: 10
        failureThreshold: 3
      ports:
        - containerPort: 8181
          name: http
          protocol: TCP
      resources:
        requests:
          memory: "200Gi"
          cpu: "250m"
        limits:
          memory: "200Gi"
          cpu: "500m"
EOF