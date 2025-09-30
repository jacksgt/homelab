# PostgreSQL

Access Postgres shell:

```sh
kubectl -n postgres exec -it postgres-0 -- sh -c 'POSTGRES_PASSWORD_FILE=/opt/bitnami/postgresql/secrets/postgres-password psql -U postgres -h localhost'
```

Basics:

```sh
# list databases:
postgres=# \l

# connect to database:
postgres=# \c example

# show tables:
postgres=# \d
```

Dump SQL of all databases:

```sh
kubectl -n postgres exec postgres-0 -- sh -c 'PGPASSWORD=$POSTGRES_PASSWORD pg_dumpall -U postgres -h localhost' > pg_dumpall_$(date '+%Y%m%d-%H%M%S').sql
```

### Database Size

Get size of Postgres databases:

```sh
\l+
```

Get size of Postgres tables:

```sh
\c <DB_NAME>

\d+
```

## NetworkPolicy

Clients accessing Postgres must set the following labels:

```sh
# pod:
networkpolicy-postgres-access: "enabled"

# namespace:
networkpolicy-postgres-access: "enabled"
kubectl label namespace authentik networkpolicy-postgres-access=enabled
```

## Upgrading

check out pgautoupgrade: https://github.com/pgautoupgrade/docker-pgautoupgrade

https://www.postgresql.org/docs/18/upgrading.html
