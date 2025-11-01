#!/bin/sh

# This Helm post-renderer is a really ugly hack
# to point the service to Anubis instead of Gitea directly
# becuase the Gitea Helm chart currently does not support changing the targetPort.
# Refs:
# https://gitea.com/gitea/helm-gitea/issues/900
# https://austindewey.com/2020/07/27/patch-any-helm-chart-template-using-a-kustomize-post-renderer/

set -e
cd gitea/
cat <&0 > all.yaml
kustomize build .
rm -f all.yaml
