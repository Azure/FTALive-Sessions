# create sample app with PV
kubectl create ns nginx-pv-example
kubectl apply -f ./nginx-app/with-pv.yaml -n nginx-pv-example

kubectl get all -n nginx-pv-example
kubectl get pv
kubectl get pvc -n nginx-pv-example

# backup the cluster in the Azure portal

# delete the namespace
kubectl delete namespaces nginx-pv-example
kubectl get ns nginx-pv-example

# restore the namespace & PV using the portal backup GUI

# ensure namespace has been restored
kubectl get all-n nginx-pv-example
kubectl get pv
kubectl get pvc -n nginx-pv-example
