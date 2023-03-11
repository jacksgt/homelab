## intel-nuc-v7

```
apt install -y systemd-timesyncd
systemctl enable --now systemd-timesyncd
timedatectl set-timezone Europe/Zurich
```

Install tailscale (following <https://tailscale.com/download/linux/debian-bullseye>):

```
curl -fsSL https://pkgs.tailscale.com/stable/debian/bullseye.noarmor.gpg | tee /usr/share/keyrings/tailscale-archive-keyring.gpg >/dev/null
curl -fsSL https://pkgs.tailscale.com/stable/debian/bullseye.tailscale-keyring.list | tee /etc/apt/sources.list.d/tailscale.list
apt-get update
apt-get install tailscale
tailscale up
```

Install k3s:

```
curl -s -L -o /opt/k3s-install.sh https://get.k3s.io
INSTALL_K3S_VERSION=v1.25.4+k3s1 \
K3S_URL=https://100.82.187.44:6443 \
K3S_TOKEN=<NODE_TOKEN> \
NSTALL_K3S_EXEC="--node-ip 192.168.1.160 --node-external-ip $(tailscale ip -4) --flannel-iface tailscale0" \
bash /opt/k3s-install.sh
```
