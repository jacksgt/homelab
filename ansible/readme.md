# Ansible

## Setup

```sh
python3 -m venv venv
source venv/bin/activate
pip3 install -r requirements.txt
```

## Add new dependencies

```sh
pip3 install netaddr
pip3 freeze > requirements.txt
```

## Running

Run playbooks:

```sh
#  only for the localhost:
ansible-playbook playbooks/01_os.yml --limit $(hostname)

# for a group of servers
ansible-playbook playbooks/01_os.yml --limit debian

# for setting up a Gitea Actions Runner on Hetzner Cloud:
export HCLOUD_TOKEN=""
export CI_RUNNER_TOKEN=""
ansible-playbook playbooks/05_ci_runner.yml
```

## Secrets

Managed using SOPS + age:

```sh
sops inventory/group_vars/all/<NEW>.secret.yaml
sops edit inventory/group_vars/all/storage.secret.yaml
```

See <https://docs.ansible.com/ansible/latest/collections/community/sops/docsite/guide.html>
