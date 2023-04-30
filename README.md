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


## Selfhosted Applications

Lists of self-hosted services, applications and tools:

* https://yunohost.org/en/apps?q=%2Fapps
* https://fleet.linuxserver.io/
* https://github.com/awesome-selfhosted/awesome-selfhosted
