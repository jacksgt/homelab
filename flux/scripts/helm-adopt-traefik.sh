NAMESPACE=traefik
RELEASE_NAME=traefik
VALUES_FILE=traefik.values.yaml
CHART="traefik/traefik"
VERSION="10.24.3"

helm template -f "$VALUES_FILE" --version $VERSION $RELEASE_NAME $CHART > /tmp/manifests.yaml
RESOURCES=$(yq '. | (.kind) + "/" + (.metadata.name)' /tmp/manifests.yaml --no-doc | tr '\n' ' ')

echo $RESOURCES
exit

DRY_RUN="none" # set to "none" to run for real

kubectl label -n $NAMESPACE $RESOURCES "app.kubernetes.io/managed-by=Helm" --overwrite  --dry-run=$DRY_RUN
kubectl annotate -n $NAMESPACE $RESOURCES "meta.helm.sh/release-name=$RELEASE_NAME" --overwrite --dry-run=$DRY_RUN
kubectl annotate -n $NAMESPACE $RESOURCES "meta.helm.sh/release-namespace=$NAMESPACE" --overwrite --dry-run=$DRY_RUN
