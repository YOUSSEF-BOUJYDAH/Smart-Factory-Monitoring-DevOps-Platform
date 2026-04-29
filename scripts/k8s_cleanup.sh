# scripts/k8s-clean.sh
#!/bin/bash

echo "Cleaning Kubernetes..."

kubectl delete -f k8s/ || true
kubectl delete -f monitoring/prometheus.yaml || true
kubectl delete namespace smart-factory || true

echo "Clean done"