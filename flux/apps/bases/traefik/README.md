# Treafik

To access traefik dashboard at <http://localhost:9000/dashboard/>, run:

```sh
ns=traefik
kubectl -n "$ns" port-forward $(kubectl -n "$ns" get pods --selector "app.kubernetes.io/name=traefik" --output=name) 9000:9000
```
