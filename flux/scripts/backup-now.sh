#!/bin/sh

mariadb_job="mariadb-backup-$(date +"%Y%m%d-%H%M%S")"
kubectl -n mariadb create job --from="cronjob/mariadb-backup" "${mariadb_job}"
kubectl -n mariadb wait --for=condition=Complete=True "job/${mariadb_job}" --timeout=2m

postgres_job="postgres-backup-$(date +"%Y%m%d-%H%M%S")"
kubectl -n postgres create job --from="cronjob/postgres-backup" "${postgres_job}"
kubectl -n postgres wait --for=condition=Complete=True "job/${postgres_job}" --timeout=2m

node=hp-prodesk-g4
node_job="host-backup-${node}-$(date +"%Y%m%d-%H%M%S")"
kubectl -n kube-system create job --from="cronjob/daily-host-backup-${node}" "${node_job}"
kubectl -n kube-system get jobs -w &
kubectl -n kube-system wait --for=condition=Complete=True "job/${node_job}" --timeout=15m
kill %1
