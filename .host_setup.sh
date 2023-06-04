#! /bin/sh

# Debian-buster, amd64
# Root Permission Need (Use `su` and ./docker_setup.sh`)

# ssh install
sudo apt update && sudo apt install openssh-server
systemctl status server

# utils install
sudo apt-get install -y software-properties-common git make vim systemd curl

# chrome install
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo apt install ./google-chrome-stable_current_amd64.deb -y

# docker install
wget https://download.docker.com/linux/debian/dists/buster/pool/stable/amd64/containerd.io_1.6.21-1_amd64.deb
wget https://download.docker.com/linux/debian/dists/buster/pool/stable/amd64/docker-ce_20.10.24~3-0~debian-buster_amd64.deb
wget https://download.docker.com/linux/debian/dists/buster/pool/stable/amd64/docker-ce-cli_20.10.24~3-0~debian-buster_amd64.deb
wget https://download.docker.com/linux/debian/dists/buster/pool/stable/amd64/docker-buildx-plugin_0.10.5-1~debian.10~buster_amd64.deb
wget https://download.docker.com/linux/debian/dists/buster/pool/stable/amd64/docker-compose-plugin_2.17.3-1~debian.10~buster_amd64.deb

sudo dpkg -i ./containerd.io_1.6.21-1_amd64.deb \
  ./docker-ce_20.10.24~3-0~debian-buster_amd64.deb \
  ./docker-ce-cli_20.10.24~3-0~debian-buster_amd64.deb \
  ./docker-buildx-plugin_0.10.5-1~debian.10~buster_amd64.deb \
  ./docker-compose-plugin_2.17.3-1~debian.10~buster_amd64.deb

rm *amd64.deb