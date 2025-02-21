#!/bin/sh

echo "+++ SOURCES +++"
kubectl get gitrepository,helmrepository -A

echo
echo "+++ DEPLOYMENTS +++"
kubectl get kustomization,helmrelease -A
