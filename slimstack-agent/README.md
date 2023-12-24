# SlimStack helm chart

This chart is to install the relevent components required for SlimStack

## Installation

First we need to understand on which cluster the chart is being installed for authentication purposes, talk with SlimStack regarding your customerID and clusterID that is required to install the chart, SlimStack will then provide an authentication token for the cluster.

```
export CUSTOMER_ID=<Customer ID provided by SlimStack>
export CLUSTER_ID=<Cluster ID provided by SlimStack after discussing the cluster that the chart will be installed on>
export AUTH_TOKEN='<Token provided by SlimStack>'

helm install slimstack -n slimstack --create-namespace slimstack-<Version>.tgz --set customerID=$CUSTOMER_ID --set clusterID=$CLUSTER_ID --set auth.token=$AUTH_TOKEN
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
export CLUSTER_ID=<Cluster ID provided by SlimStack after discussing the cluster that the chart will be installed on>

helm install slimstack -n slimstack --create-namespace slimstack-<Version>.tgz --set customerID=$CUSTOMER_ID --set clusterID=$CLUSTER_ID -f <Custom values file location>
```