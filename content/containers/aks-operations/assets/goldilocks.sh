helm repo add fairwinds-stable https://charts.fairwinds.com/stable
helm install --name goldilocks --namespace goldilocks --set installVPA=true fairwinds-stable/goldilocks

kubectl -n goldilocks port-forward svc/goldilocks-dashboard 8080:80