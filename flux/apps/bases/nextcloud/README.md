# Nextcloud

## Nextcloud PHP Shell

```
kubectl -n nextcloud exec -it deploy/nextcloud -- su --whitelist-environment=PHP_MEMORY_LIMIT  - www-data -s /bin/bash
```

https://github.com/nextcloud/docker/issues/1413#issuecomment-784329039

## Add STUN server for Nextcloud talk

```sh
# inside the nextcloud container
./occ talk:stun:add stun.framasoft.org:3478
./occ talk:turn:add --secret openrelayprojectsecret -- staticauth.openrelay.metered.ca:80 tcp
```

See https://github.com/pradt2/always-online-stun and https://www.metered.ca/tools/openrelay/
