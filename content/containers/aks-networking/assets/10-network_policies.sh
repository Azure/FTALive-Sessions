#########################
# 10 - Network policies
#########################

LOCATION='australiaeast'
RG_NAME='10-network-policy-cluster-rg'
az group create -n $RG_NAME --location $LOCATION

az aks create \
    --resource-group $RG_NAME \
    --name 'network-policy-cluster' \
    --node-count 1 \
    --network-plugin azure \
    --network-policy azure

az aks get-credentials -g $RG_NAME -n 'network-policy-cluster' --admin --context '10-network-policy-cluster'

kubectl create namespace demo

##########
# DEMO 
##########

# create server pod
kubectl run server -n demo \
    --image=k8s.gcr.io/e2e-test-images/agnhost:2.33 \
    --labels="app=server" \
    --port=80 \
    --command -- /agnhost serve-hostname \
    --tcp \
    --http=false \
    --port "80"

# get pod IP
kubectl get pod -n demo --output=wide

# create client pod & get a shell within it
kubectl run -it client -n demo --image=k8s.gcr.io/e2e-test-images/agnhost:2.33 --command -- bash

# enter the following command in the cient shell
# output should be empty (successful)
# $ /agnhost connect <server-ip>:80 --timeout=3s --protocol=tcp 

# apply security policy
kubectl apply -f ./network-policy.yaml

# list the network policy
k describe NetworkPolicy/demo-policy -n demo

# connect to client pod & verify connectivity fails
# client app doesn't have the 'app=client' label, only the 'run=client' label
k describe pod client -n demo

kubectl exec -n demo -it pod/client -- bash
# enter the following command in the cient shell
# output should be 'TIMEOUT' (un-successful) since the network policy now blocks the connection
# $ /agnhost connect <server-ip>:80 --timeout=3s --protocol=tcp 
