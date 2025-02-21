#!/bin/sh

MANIFEST=${1}
if [ "$MANIFEST" = "-" ]; then
    # redirect manifests from stdin into a file
    TMP_MANIFEST=$(mktemp)
    cat - > "$TMP_MANIFEST"
    trap cleanup INT ABRT TERM EXIT KILL
    MANIFEST="$TMP_MANIFEST"
fi

cleanup() {
  rm -f "$TMP_MANIFEST"
  exit
}


RELEASE_NAME=$(yq '.metadata.name' "$MANIFEST")
CHART_NAME="$(yq '.spec.chart.spec.sourceRef.name' "$MANIFEST")/$(yq '.spec.chart.spec.chart' "$MANIFEST")"
CHART_VERSION=$(yq '.spec.chart.spec.version' "$MANIFEST")

helm template "$RELEASE_NAME" -f <(yq '.spec.values' "$MANIFEST") "$CHART_NAME" --version "$CHART_VERSION"
