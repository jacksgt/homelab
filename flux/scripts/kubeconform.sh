#!/bin/bash

set -e
set -u
set -o pipefail

# https://github.com/yannh/kubeconform

kubectl kustomize "${1}" | \
    kubeconform -strict -skip "DbInstance,Database,Secret" \
                -schema-location default -schema-location 'https://raw.githubusercontent.com/datreeio/CRDs-catalog/main/{{.Group}}/{{.ResourceKind}}_{{.ResourceAPIVersion}}.json' \
                -

echo "OK"
