#!/bin/bash
set -e

while true; do
  # Get the name of the latest hello-world pod
  POD_NAME=$(kubectl get pods -l app=hello-world -o jsonpath="{.items[0].metadata.name}" 2>/dev/null)

  # Check if the pod exists
  if [ -z "$POD_NAME" ]; then
    echo "No hello-world pod found. Retrying in 5 seconds..."
    sleep 10
    continue
  fi

  # Start port-forwarding
  echo "Starting port-forward for pod: $POD_NAME"
  kubectl port-forward svc/hello-world 3000:5678 --address 0.0.0.0

  # If port-forwarding fails, wait for a few seconds and retry
  echo "Port-forwarding failed. Retrying in 5 seconds..."
  sleep 5
done
