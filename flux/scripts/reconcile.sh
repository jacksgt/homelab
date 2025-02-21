#!/bin/sh

flux -n flux-system reconcile source git homelab-apps-prod
sleep 1
flux -n flux-system reconcile kustomization apps-prod
