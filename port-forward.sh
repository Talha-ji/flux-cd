NU nano 7.2                                             port-forward.sh                                                      #!/bin/bash
set -e

# Wait for 1 minute after deployment changes
echo "Waiting for 1 minute to allow the deployment to stabilize..."
sleep 60

while true; do
  # Get the name of the latest hello-world pod
  POD_NAME=$(kubectl get pods -l app=hello-world -o jsonpath="{.items[0].metadata.name}" 2>/dev/null)

  # Check if the pod exists
  if [ -z "$POD_NAME" ]; then
    echo "No hello-world pod found. Retrying in 5 seconds..."
    sleep 5  # Wait for 5 seconds before retrying
    continue
  fi

  # Start port-forwarding
  echo "Found pod: $POD_NAME. Starting port-forward..."
  kubectl port-forward svc/hello-world 3000:5678 --address 0.0.0.0

  # If port-forwarding fails, wait for 5 seconds and retry
  echo "Port-forwarding failed. Retrying in 5 seconds..."
  sleep 5  # Wait for 5 seconds before retrying
done
