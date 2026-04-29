#!/bin/bash
set -e

NAMESPACE="smart-factory"

echo "Starting Smart Factory deployment..."

# --- Build images ---
echo "Building Docker images in Minikube..."
minikube image build -t smart-factory-api:local -f docker/api.Dockerfile .
minikube image build -t smart-factory-sensor:local -f docker/sensor.Dockerfile .

# --- Deploy Kubernetes ---
echo "Applying Kubernetes manifests..."
kubectl apply -f k8s/namespace.yaml
kubectl apply -f k8s/

# --- Monitoring ---
echo "Deploying monitoring..."
kubectl apply -f monitoring/prometheus.yaml

# --- Wait ---
echo "Waiting for pods..."
sleep 10
kubectl get pods -n $NAMESPACE

# --- Test API ---
echo "Testing API..."
kubectl port-forward svc/api 5000:5000 -n $NAMESPACE > /dev/null 2>&1 &
API_PID=$!
sleep 3

if curl -s http://localhost:5000/health > /dev/null; then
  echo "API is running"
else
  echo "API test failed"
fi

kill $API_PID

# --- Access ---
echo ""
echo "Prometheus → http://localhost:9090"
echo "Grafana   → http://localhost:3000"
echo "Login: admin / admin"
echo ""

kubectl port-forward svc/prometheus 9090:9090 -n $NAMESPACE > /dev/null 2>&1 &
kubectl port-forward svc/grafana 3000:3000 -n $NAMESPACE > /dev/null 2>&1 &

