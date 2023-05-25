helm repo add fairwinds-stable https://charts.fairwinds.com/stable
kubectl create namespace goldilocks
helm install --name goldilocks --namespace goldilocks --set installVPA=true fairwinds-stable/goldilocks


# create & label namespace to allow Goldilocaks to access it
kubectl create ns azure-vote
kubectl label ns azure-vote goldilocks.fairwinds.com/enabled=true

# deploy sample application
kubectl apply -f ./azure-vote-all-in-one-redis.yaml -n azure-vote

# port forward to Goldilocks dashboard
kubectl -n goldilocks port-forward svc/goldilocks-dashboard 8080:80

# get goldilocks controller logs
GOLDILOCKS_CONTROLLER_NAME=`k get pod -n goldilocks -l "app.kubernetes.io/component=controller" -o=jsonpath="{.items[0].metadata.name}"`
k logs $GOLDILOCKS_CONTROLLER_NAME -n goldilocks 
