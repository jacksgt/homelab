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
```
