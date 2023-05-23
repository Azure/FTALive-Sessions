helm repo add fairwinds-stable https://charts.fairwinds.com/stable
helm install --name goldilocks --namespace goldilocks --set installVPA=true fairwinds-stable/goldilocks

# create namespace
kubectl create ns httpbin

# label namespace to allow Goldilocaks to access it
kubectl label ns httpbin goldilocks.fairwinds.com/enabled=true

# deploy sample application
cat <<EOF | kubectl apply -n httpbin -f -
apiVersion: v1
kind: Service
metadata:
  name: httpbin
  labels:
    app: httpbin
spec:
  ports:
  - name: http
    port: 8000
    targetPort: 80
  selector:
    app: httpbin
---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: httpbin
spec:
  replicas: 1
  selector:
    matchLabels:
      app: httpbin
      version: v1
  template:
    metadata:
      labels:
        app: httpbin
        version: v1
    spec:
      containers:
      - image: docker.io/kennethreitz/httpbin
        imagePullPolicy: IfNotPresent
        name: httpbin
        ports:
        - containerPort: 80
EOF

# label namespaces


kubectl -n goldilocks port-forward svc/goldilocks-dashboard 8080:80

GOLDILOCKS_CONTROLLER_NAME=`k get pod -n goldilocks -l "app.kubernetes.io/component=controller" -o=jsonpath="{.items[0].metadata.name}"`
k logs $GOLDILOCKS_CONTROLLER_NAME -n goldilocks 