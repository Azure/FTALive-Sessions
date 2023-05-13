#####################
# 14 - Istio
#####################

LOCATION='australiaeast'
RESOURCE_GROUP='14-istio-cluster-rg'
UAMI='akv-csi-identity'
CLUSTER='istio-cluster'

# add preview Az CLI extension
az extension add --name aks-preview
az extension update --name aks-preview
az feature register --namespace "Microsoft.ContainerService" --name "AzureServiceMeshPreview"
az feature show --namespace "Microsoft.ContainerService" --name "AzureServiceMeshPreview"
az provider register --namespace Microsoft.ContainerService

az group create -n $RESOURCE_GROUP --location $LOCATION

az aks create \
--resource-group $RESOURCE_GROUP \
--name $CLUSTER \
--enable-asm

az aks show --resource-group $RESOURCE_GROUP --name $CLUSTER --query 'serviceMeshProfile.mode'
az aks get-credentials --resource-group $RESOURCE_GROUP --name $CLUSTER --admin
kubectl config use-context "$CLUSTER-admin"
kubectl get pods -n aks-istio-system

# enable sidecar injection
kubectl label namespace default istio.io/rev=asm-1-17

# deploy sample app
kubectl apply -f https://raw.githubusercontent.com/istio/istio/release-1.17/samples/bookinfo/platform/kube/bookinfo.yaml

kubectl get services
kubectl get pods

# enable ingress gateway
az aks mesh enable-ingress-gateway --resource-group $RESOURCE_GROUP --name $CLUSTER --ingress-gateway-type external

# check services
kubectl get svc aks-istio-ingressgateway-external -n aks-istio-ingress

# enable external access to the service mesh
kubectl apply -f - <<EOF
apiVersion: networking.istio.io/v1alpha3
kind: Gateway
metadata:
  name: bookinfo-gateway-external
spec:
  selector:
    istio: aks-istio-ingressgateway-external
  servers:
  - port:
      number: 80
      name: http
      protocol: HTTP
    hosts:
    - "*"
---
apiVersion: networking.istio.io/v1alpha3
kind: VirtualService
metadata:
  name: bookinfo-vs-external
spec:
  hosts:
  - "*"
  gateways:
  - bookinfo-gateway-external
  http:
  - match:
    - uri:
        exact: /productpage
    - uri:
        prefix: /static
    - uri:
        exact: /login
    - uri:
        exact: /logout
    - uri:
        prefix: /api/v1/products
    route:
    - destination:
        host: productpage
        port:
          number: 9080
EOF

# set env vars for external ingress & ports
export INGRESS_HOST_EXTERNAL=$(kubectl -n aks-istio-ingress get service aks-istio-ingressgateway-external -o jsonpath='{.status.loadBalancer.ingress[0].ip}')
export INGRESS_PORT_EXTERNAL=$(kubectl -n aks-istio-ingress get service aks-istio-ingressgateway-external -o jsonpath='{.spec.ports[?(@.name=="http2")].port}')
export GATEWAY_URL_EXTERNAL=$INGRESS_HOST_EXTERNAL:$INGRESS_PORT_EXTERNAL

echo "http://$GATEWAY_URL_EXTERNAL/productpage"
curl -s "http://${GATEWAY_URL_EXTERNAL}/productpage" | grep -o "<title>.*</title>"
