#######################
# 11 - Service Mesh
#######################

LOCATION='australiaeast'
RG_NAME='11-osm-cluster-rg'
az group create -n $RG_NAME --location $LOCATION

az aks create \
  --resource-group $RG_NAME \
  --name 'osm-cluster' \
  --node-count 1 --enable-cluster-autoscaler --min-count 1 --max-count 5 \
  --enable-addons open-service-mesh

az aks get-credentials -g $RG_NAME -n 'osm-cluster' --admin --context '11-osm-cluster'
kubectl config use-context '11-osm-cluster-admin'

# install OSM CLI
OSM_VERSION=v1.0.0
curl -sL "https://github.com/openservicemesh/osm/releases/download/$OSM_VERSION/osm-$OSM_VERSION-linux-amd64.tar.gz" | tar -vxzf -
sudo mv ./linux-amd64/osm /usr/local/bin/osm

# verify OSM is running
az aks show --resource-group $RG_NAME --name 'osm-cluster'  --query 'addonProfiles.openServiceMesh.enabled'

kubectl get deployments -n kube-system --selector app.kubernetes.io/name=openservicemesh.io
kubectl get pods -n kube-system --selector app.kubernetes.io/name=openservicemesh.io
kubectl get services -n kube-system --selector app.kubernetes.io/name=openservicemesh.io
kubectl get meshconfig osm-mesh-config -n kube-system -o yaml

# deploy sample application
kubectl create namespace bookstore
kubectl create namespace bookbuyer
kubectl create namespace bookthief
kubectl create namespace bookwarehouse

osm namespace add bookstore bookbuyer bookthief bookwarehouse

kubectl apply -f https://raw.githubusercontent.com/openservicemesh/osm-docs/release-v1.2/manifests/apps/bookbuyer.yaml
kubectl apply -f https://raw.githubusercontent.com/openservicemesh/osm-docs/release-v1.2/manifests/apps/bookthief.yaml
kubectl apply -f https://raw.githubusercontent.com/openservicemesh/osm-docs/release-v1.2/manifests/apps/bookstore.yaml
kubectl apply -f https://raw.githubusercontent.com/openservicemesh/osm-docs/release-v1.2/manifests/apps/bookwarehouse.yaml
kubectl apply -f https://raw.githubusercontent.com/openservicemesh/osm-docs/release-v1.2/manifests/apps/mysql.yaml


# verify dpeloyment
kubectl get pods,deployments,serviceaccounts -n bookbuyer
kubectl get pods,deployments,serviceaccounts -n bookthief
kubectl get pods,deployments,serviceaccounts,services,endpoints -n bookstore
kubectl get pods,deployments,serviceaccounts,services,endpoints -n bookwarehouse

# port-forward each application
bash <<EOF
./port-forward-bookbuyer-ui.sh &
./port-forward-bookstore-ui-v1.sh &
./port-forward-bookthief-ui.sh &
wait
EOF

# access the apps
# http://localhost:8080 - bookbuyer
# http://localhost:8081 - bookstore ui v1
# http://localhost:8083 - bookthief

# display current service mesh configuration
kubectl get meshconfig osm-mesh-config -n kube-system -o jsonpath='{.spec.traffic.enablePermissiveTrafficPolicyMode}{"\n"}'

# enable Permissive policy mode
kubectl patch meshconfig osm-mesh-config -n kube-system -p '{"spec":{"traffic":{"enablePermissiveTrafficPolicyMode":true}}}' --type=merge

# disable premissive mode
kubectl patch meshconfig osm-mesh-config -n kube-system -p '{"spec":{"traffic":{"enablePermissiveTrafficPolicyMode":false}}}' --type=merge

# enable OSM policy to prevent 'bookthief' from accessing the bookstore
# books being stolen should now stop
kubectl apply -f ./osm-policy-deny-bookthief.yaml
