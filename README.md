# Cubieserver - Jack's Homelab

Welcome to the Infrastructure as Code repository serving as the source of truth for Jack's Homelab - "Cubieserver".

> Note: the canonical repository is <https://git.cubieserver.de/Cubieserver/homelab>. The [Github mirror](https://github.com/jacksgt/homelab) is intended for disaster recovery purposes (to avoid the chicken-and-egg problem when bootstrapping the infrastructure).

The installation, setup and configuration of all software involved is handled by two components:

* **Ansible**: used for provisioning physical machines until they can join the Kubernetes cluster
  * *this is currently still in development*
* **Flux**: deploys all services on top of Kubernetes (with local Kustomize manifests and external Helm charts)
  * *find more details in the [flux directory](./flux/README.md)*

An overview of the currently running services can be found on the [Cubieserver homepage](https://www.cubieserver.de).

## Tips & Tricks

### Traefik

To access traefik dashboard at <http://localhost:9000/dashboard/>, run:

```sh
ns=traefik; kubectl -n "$ns" port-forward $(kubectl -n "$ns" get pods --selector "app.kubernetes.io/name=traefik" --output=name) 9000:9000
```

### PostgreSQL Size

Get size of Postgres databases:

```
psql -h <HOST> -U <USER>

\l+
```

Get size of Postgres tables:

```
\c <DB_NAME>

\d+
```

## Truncate all tables in MySQL

Truncates all tables of database `DB_NAME`:

```
SELECT Concat('TRUNCATE TABLE ',table_schema,'.',TABLE_NAME, ';')
FROM INFORMATION_SCHEMA.TABLES WHERE table_schema IN ('DB_NAME');
```

Might need to set `SET FOREIGN_KEY_CHECKS=0;` before running (revert to original behavior with `SET FOREIGN_KEY_CHECKS=1;`)

Source: https://stackoverflow.com/a/17738975

## Import MySQL dump

```
mysql -h HOSTNAME -u USER -p -D DB_NAME -C  < dump.sql
```

optionally use `-f` to continue despite SQL errors

## Run the database cronjob now


```sh
kubectl -n mariadb create job --from=cronjob/mariadb-backup "mariadb-backup-$(date +"%Y%m%d-%H%M%S")"
kubectl -n mariadb get jobs -w
```

## XMPP DNS records

https://prosody.im/doc/dns

record name                   | TTL  | class | 	type | priority | weight | 	port | target
_xmpp-client._tcp.example.com | 3600 | 	IN   | 	SRV  | 0        | 5      | 	5222 | xmpp.example.com
_xmpp-server._tcp.example.com |	3600 |  IN   |	SRV  | 0        | 5      | 	5269 | xmpp.example.com


## Analyze and optimize MySQL tables

```sh
# To check all tables in all databases:
$ mysqlcheck -h HOST -u root -p --all-databases -c

# To analyze all tables in all databases:
$ mysqlcheck -h HOST -u root -p --all-databases -a

# To repair all tables in all databases:
$ mysqlcheck -h HOST -u root -p --all-databases -r

# To optimize all tables in all databases:
$ mysqlcheck -h HOST -u root -p --all-databases -o

# Do the same for a single table
$ mysqlcheck -h HOST -u root -p $DB $TABLE -c/-a/-r/-o
```

https://wiki.archlinux.org/title/MariaDB#Checking,_optimizing_and_repairing_databases


## Show size of tables in MySQL database

```mysql
SELECT
  TABLE_NAME AS `Table`,
  ROUND((DATA_LENGTH + INDEX_LENGTH) / 1024 / 1024) AS `Size (MB)`
FROM
  information_schema.TABLES
WHERE
  TABLE_SCHEMA = "$DATABASE"
ORDER BY
  (DATA_LENGTH + INDEX_LENGTH)
DESC;
```

https://chartio.com/resources/tutorials/how-to-get-the-size-of-a-table-in-mysql/


## PVC Debug Pod

```sh
NAMESPACE=xxx
PVC_NAME=xxx

kubectl create -f - <<EOF
kind: Pod
apiVersion: v1
metadata:
  name: pvc-debugger
  namespace: $NAMESPACE
spec:
  volumes:
    - name: pvc
      persistentVolumeClaim:
        claimName: $PVC_NAME
  containers:
    - name: pvc-debugger
      image: docker.io/library/debian
      command: ['sleep', 'infinity']
      volumeMounts:
        - mountPath: "/data"
          name: pvc
EOF

kubectl -n $NAMESPACE exec -it pvc-debugger -- bash
```

## Force delete namespace

```sh
RESOURCE=namespaces
NAME=my-ns
kubectl proxy &
kubectl get ${RESOURCE}/${NAME} -o json | \
  jq '.spec.finalizers=[]' | \
  curl -X PUT "http://localhost:8001/api/v1/${RESOURCE}/${NAME}/finalize" -H "Content-Type: application/json" --data @-
```

https://stackoverflow.com/a/63066915

## Create kubeconfig for Service Account

```sh
serviceaccount=developer
namespace=kube-system
secret=${serviceaccount}-token
cluster=cubieserver
endpoint=https://k3s.cubieserver.de:443
output="${serviceaccount}_${namespace}_${cluster}.kubeconfig"

ca=$(kubectl --namespace $namespace get secret/$secret -o jsonpath='{.data.ca\.crt}')
token=$(kubectl --namespace $namespace get secret/$secret -o jsonpath='{.data.token}' | base64 --decode)

touch "${output}"
chmod 600 "${output}"
cat > "${output}" <<EOF
---
apiVersion: v1
kind: Config
clusters:
  - name: ${cluster}
    cluster:
      certificate-authority-data: ${ca}
      server: ${endpoint}
contexts:
  - name: ${serviceaccount}@${cluster}
    context:
      cluster: ${cluster}
      namespace: ${namespace}
      user: ${serviceaccount}
users:
  - name: ${serviceaccount}
    user:
      token: ${token}
current-context: ${serviceaccount}@${cluster}
EOF
```

https://stackoverflow.com/a/47776588

## Nextcloud

Reset bruteforce rate-limiting ("Cannot login: Too may requests (429)"):

```
php ./occ security:bruteforce:reset 0.0.0.0
```

or via SQL:

```
SELECT * FROM oc_bruteforce_attempts;
TRUNCATE TABLE oc_bruteforce_attempts;
```

https://help.nextcloud.com/t/cannot-login-too-many-requests/100905/31

## Selfhosted Applications

Lists of self-hosted services, applications and tools:

* https://yunohost.org/en/apps?q=%2Fapps
* https://fleet.linuxserver.io/
* https://github.com/awesome-selfhosted/awesome-selfhosted
