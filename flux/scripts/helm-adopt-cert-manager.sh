
#         Helm install failed: rendered manifests contain a resource that already exists. Unable to continue with install: ServiceAccount "cert-manager-cainjector" in namespace "cert-manager" exists and cannot be imported into the current release: invalid ownership metadata; label validation error: key "app.kubernetes.io/managed-by" must equal "Helm": current value is "pulumi"; annotation validation error: missing key "meta.helm.sh/release-name": must be set to "cert-manager"; annotation validation error: missing key "meta.helm.sh/release-namespace": must be set to "cert-manager"

NAMESPACE=cert-manager
RELEASE_NAME=cert-manager
VALUES_FILE=cert-manager.values.yaml
CHART="jetstack/cert-manager"

helm template -f "$VALUES_FILE" $RELEASE_NAME $CHART > /tmp/manifests.yaml
RESOURCES=$(yq '. | (.kind) + "/" + (.metadata.name)' manifests.yaml --no-doc | tr '\n' ' ')

DRY_RUN="client" # set to "none" to run for real

kubectl label -n $NAMESPACE $RESOURCES "app.kubernetes.io/managed-by=Helm" --overwrite  --dry-run=$DRY_RUN
kubectl annotate -n $NAMESPACE $RESOURCES "meta.helm.sh/release-name=$RELEASE_NAME" --overwrite --dry-run=$DRY_RUN
kubectl annotate -n $NAMESPACE $RESOURCES "meta.helm.sh/release-namespace=$NAMESPACE" --overwrite --dry-run=$DRY_RUN
