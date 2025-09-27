#!/bin/bash

REPO_DIR="${HOME}/git/homelab"
REL_PWD="${PWD#$REPO_DIR}"
podman run -it --rm \
       -v "${REPO_DIR}:/homelab:Z" \
       -w "/homelab/${REL_PWD}" \
       -v "${HOME}/.config/helm:/root/.config/helm:Z" \
       -v "${HOME}/.cache/helm:/root/.cache/helm:Z" \
       -v "${HOME}/.kube:/root/.kube:Z,ro" \
       -v "${HOME}/.config/sops:/root/.config/sops:Z,ro" \
       docker.io/jacksgt/homelab-toolbox:latest \
       "$@"
