# SlimStack helm chart

This chart is to install the relevent components required for SlimStack

## Installation
### One-liner
Add Slimstack repo:
```
helm repo add slimstack https://slimstackio.github.io/charts/
```

Install the chart:
```
export CUSTOMER_ID=<Customer ID provided by SlimStack>
export CLUSTER_ID=<Cluster ID>
export TOKEN=<Authentication token provided by SlimStack>

helm upgrade -i slimstack slimstack/slimstack -n slimstack --create-namespace \
--set customerID=$CUSTOMER_ID \
--set clusterID=$CLUSTER_ID \
--set auth.token=$TOKEN
```

## Secret management

If you prefer to implement your own secret management to provide the authentication token the chart can consume an existing Kubernetes secret.
To do so create a custom values.yaml file with the following:

```
auth:
  createSecret: false

prometheus:
  server:
    extraSecretMounts:
      - name: auth-file # This name is required as "auth-file"
        mountPath: /etc/config/auth
        secretName: <Existing secret name>
```

Then install by running the following:
```
export CUSTOMER_ID=<Customer ID provided by SlimStack>
export CLUSTER_ID=<Cluster ID>

helm upgrade -i slimstack slimstack/slimstack -n slimstack --create-namespace \
--set customerID=$CUSTOMER_ID \
--set clusterID=$CLUSTER_ID \
-f <custom values file>
```