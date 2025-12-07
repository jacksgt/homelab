#!/bin/bash

REPO_DIR="${HOME}/git/homelab"
REL_PWD="${PWD#$REPO_DIR}"
podman run -it --rm \
       -v "${REPO_DIR}:/homelab:Z" \
       -w "/homelab/${REL_PWD}" \
       -v "${HOME}/.ssh/:/root/.ssh:Z,ro" \
       -v "${HOME}/.config/sops:/root/.config/sops:Z,ro" \
       docker.io/alpine/ansible:2.18.6 \
       ansible-playbook -i inventory/hosts.ini "$@"
