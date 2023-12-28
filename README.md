# Slimstack helm charts
Here are the Official Slimstack Helm charts

# Installation
## One-liner
Add Slimstack repo:

    helm repo add slimstack https://slimstackio.github.io/charts/

Install the chart in read-only mode:

    helm upgrade -i slimstack slimstack/slimstack -n slimstack --create-namespace \
    --set customerID=<CUSTOMERID> \
    --set clusterID=<CLUSTERID> \
    --set controller.enabled=false \
    --set auth.token=<TOKEN>
