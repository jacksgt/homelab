TIMESTAMP := $(shell date '+%Y%m%d-%H%M%S')
TOOLBOX_IMAGE := docker.io/jacksgt/homelab-toolbox:latest

MARIADB_BACKUP_CRONJOB_NAME := mariadb-backup
backup-mariadb:
	kubectl -n mariadb create job $(MARIADB_BACKUP_CRONJOB_NAME)-$(TIMESTAMP) --from=cronjob/$(MARIADB_BACKUP_CRONJOB_NAME)
	sleep 3
	kubectl -n mariadb logs job/$(MARIADB_BACKUP_CRONJOB_NAME)-$(TIMESTAMP) --follow

POSTGRES_BACKUP_CRONJOB_NAME := postgres-pgdumpall
backup-postgres:
	kubectl -n postgres create job $(POSTGRES_BACKUP_CRONJOB_NAME)-$(TIMESTAMP) --from=cronjob/$(POSTGRES_BACKUP_CRONJOB_NAME)
	sleep 3
	kubectl -n postgres logs job/$(POSTGRES_BACKUP_CRONJOB_NAME)-$(TIMESTAMP) --follow

build-toolbox:
	podman image build \
	--label "org.opencontainers.image.created=$(shell date --rfc-3339=seconds)" \
	--label "org.opencontainers.image.revision=$(shell git rev-parse HEAD)" \
        --rewrite-timestamp --timestamp=0 \
	-t $(TOOLBOX_IMAGE) toolbox/

publish-toolbox:
	podman image push $(TOOLBOX_IMAGE)

kube-dump:
	mkdir -p kubedump/$(TIMESTAMP)
	podman run --rm \
	-v "${HOME}/.kube:/root/.kube:Z" \
	-v "${PWD}/kubedump/$(TIMESTAMP):/workspace/kubedump:Z" \
	$(TOOLBOX_IMAGE) \
	kubedump -dir /workspace/kubedump \
	--ignore-groups 'authentication.k8s.io,authorization.k8s.io,coordination.k8s.io,discovery.k8s.io,events.k8s.io,metrics.k8s.io' \
	--ignore-resources 'endpoints,events,replicationcontrollers,controllerrevisions,replicasets'

# https://kite.zzde.me/config/
k8s-dashboard:
	podman run --rm -it \
	-e ANONYMOUS_USER_ENABLED=true \
	-p 127.0.0.1:8080:8080 \
	-v "${HOME}/.kube:/var/kube:ro,Z" \
	-e KUBECONFIG=/var/kube/config \
	ghcr.io/zxh326/kite:v0.7.3
