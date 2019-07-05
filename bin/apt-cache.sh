#!/bin/bash

TARGET_DIR=${TARGET_DIR:-"/mirrors/apt-mirrors"}
apt update && apt install -fy vim apt-mirror gnupg2 curl wget gzip
mkdir -p ${TARGET_DIR}

cat > /etc/apt/mirror.list <<EOF
set base_path ${TARGET_DIR}

# SaltStack for Debian/9
deb http://repo.saltstack.com/apt/debian/9/amd64/2019.2 stretch main
deb http://repo.saltstack.com/apt/debian/9/amd64/latest stretch main
deb http://repo.saltstack.com/py3/debian/9/amd64/2019.2 stretch main
deb http://repo.saltstack.com/py3/debian/9/amd64/latest stretch main
# SaltStack Ubuntu/18.04
deb http://repo.saltstack.com/apt/ubuntu/18.04/amd64/2019.2 bionic main
deb http://repo.saltstack.com/apt/ubuntu/18.04/amd64/latest bionic main
deb http://repo.saltstack.com/py3/ubuntu/18.04/amd64/2019.2 bionic main
deb http://repo.saltstack.com/py3/ubuntu/18.04/amd64/latest bionic main
# SaltStack Ubuntu/16.04
deb http://repo.saltstack.com/py3/ubuntu/16.04/amd64/2019.2 bionic main
deb http://repo.saltstack.com/py3/ubuntu/16.04/amd64/latest bionic main

# Docker
deb [arch=amd64] http://download.docker.com/linux/debian stretch stable
deb [arch=amd64] http://download.docker.com/linux/debian jessie stable
deb [arch=amd64] http://download.docker.com/linux/ubuntu bionic stable

# OS Query
deb [arch=amd64] http://pkg.osquery.io/deb deb main

# Elastic Search
deb https://artifacts.elastic.co/packages/6.x/apt stable main
deb https://artifacts.elastic.co/packages/7.x/apt stable main

# Kubernetes
deb https://apt.kubernetes.io/ kubernetes-xenial main

# MongoDB
deb http://downloads-distro.mongodb.org/repo/debian-sysvinit dist 10gen

# Debian/10
deb http://deb.debian.org/debian buster-updates main
deb http://security.debian.org/debian-security buster/updates main contrib non-free

# Debian/9
deb http://deb.debian.org/debian stretch main contrib non-free
deb http://deb.debian.org/debian stretch-updates main
deb http://security.debian.org/debian-security stretch/updates main contrib non-free

# Debian/8
deb http://deb.debian.org/debian jessie main contrib non-free
deb http://deb.debian.org/debian jessie main
deb http://security.debian.org/debian-security jessie/updates main contrib non-free

# Ubuntu/18.04
deb http://archive.ubuntu.com/ubuntu/ bionic main restricted
deb http://archive.ubuntu.com/ubuntu/ bionic-updates main restricted
deb http://archive.ubuntu.com/ubuntu/ bionic universe
deb http://archive.ubuntu.com/ubuntu/ bionic-updates universe
deb http://archive.ubuntu.com/ubuntu/ bionic multiverse
deb http://archive.ubuntu.com/ubuntu/ bionic-updates multiverse
deb http://archive.ubuntu.com/ubuntu/ bionic-backports main restricted universe multiverse
deb http://security.ubuntu.com/ubuntu/ bionic-security main restricted
deb http://security.ubuntu.com/ubuntu/ bionic-security universe
deb http://security.ubuntu.com/ubuntu/ bionic-security multiverse

# Ubuntu/16.04
deb http://archive.ubuntu.com/ubuntu/ xenial main restricted
deb http://archive.ubuntu.com/ubuntu/ xenial-updates main restricted
deb http://archive.ubuntu.com/ubuntu/ xenial universe
deb http://archive.ubuntu.com/ubuntu/ xenial-updates universe
deb http://archive.ubuntu.com/ubuntu/ xenial multiverse
deb http://archive.ubuntu.com/ubuntu/ xenial-updates multiverse
deb http://archive.ubuntu.com/ubuntu/ xenial-backports main restricted universe multiverse
deb http://security.ubuntu.com/ubuntu/ xenial-security main restricted
deb http://security.ubuntu.com/ubuntu/ xenial-security universe
deb http://security.ubuntu.com/ubuntu/ xenial-security multiverse

#clean http://archive.ubuntu.com/ubuntu

EOF

mkdir -p ${TARGET_DIR}/keys
wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch > \
 ${TARGET_DIR}/keys/elasticsearch.key

wget -qO - https://packages.cloud.google.com/apt/doc/apt-key.gpg > \
 ${TARGET_DIR}/keys/kubernetes.key

wget -qO - https://repo.saltstack.com/apt/debian/9/amd64/latest/SALTSTACK-GPG-KEY.pub  > \
 ${TARGET_DIR}/keys/saltstack.key

# http://download.docker.com/linux/ubuntu/gpg (same with ubuntu & debian GPG keys)
wget -qO - https://download.docker.com/linux/debian/gpg > \
 ${TARGET_DIR}/keys/docker.key

apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 97A80C63C9D8B80B
apt-key export 97A80C63C9D8B80B > ${TARGET_DIR}/keys/osquery.gpg

apt-mirror


