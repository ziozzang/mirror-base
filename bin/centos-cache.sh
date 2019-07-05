#!/bin/bash -x

DIR_PREFIX="/mirrors"
yum install -y yum-utils createrepo

mirror () {
  REPO_ID="$1"
  CATEGORY="$2"
  TARGET_DIR="${DIR_PREFIX}/${CATEGORY}"
  mkdir -p ${TARGET_DIR}/${REPO_ID}
  createrepo -v ${TARGET_DIR}/${REPO_ID}
  reposync -l --allow-path-traversal \
    --repoid=${REPO_ID} \
    --download_path=${TARGET_DIR} \
    --downloadcomps --download-metadata
  createrepo -v ${TARGET_DIR}/${REPO_ID}
}


# Original CentOS
mirror "base" "centos7"
mirror "updates" "centos7"
mirror "extras" "centos7"
mirror "centosplus" "centos7"
mirror "cr" "centos7"
mirror "fasttrack" "centos7"

cat <<EOF > /etc/yum.repos.d/elastic-7.repo
[elastic-7.x]
name=Elastic repository for 7.x packages
baseurl=https://artifacts.elastic.co/packages/7.x/yum
gpgcheck=1
gpgkey=https://artifacts.elastic.co/GPG-KEY-elasticsearch
enabled=1
autorefresh=1
type=rpm-md
EOF

cat <<EOF > /etc/yum.repos.d/elastic-6.repo
[elastic-6.x]
name=Elasticsearch repository for 6.x packages
baseurl=https://artifacts.elastic.co/packages/6.x/yum
gpgcheck=1
gpgkey=https://artifacts.elastic.co/GPG-KEY-elasticsearch
enabled=1
autorefresh=1
type=rpm-md
EOF

curl -L https://pkg.osquery.io/rpm/GPG | sudo tee /etc/pki/rpm-gpg/RPM-GPG-KEY-osquery
sudo yum-config-manager --add-repo https://pkg.osquery.io/rpm/osquery-s3-rpm.repo

cat <<EOF > /etc/yum.repos.d/kubernetes.repo
[kubernetes]
name=Kubernetes
baseurl=https://packages.cloud.google.com/yum/repos/kubernetes-el7-x86_64/
enabled=1
gpgcheck=0
repo_gpgcheck=0
gpgkey=https://packages.cloud.google.com/yum/doc/yum-key.gpg https://packages.cloud.google.com/yum/doc/rpm-package-key.gpg
#exclude=kube*
EOF

yum-config-manager \
  --add-repo \
  https://download.docker.com/linux/centos/docker-ce.repo


# No Fast Mirror.
sed -i "s/enabled=1/enabled=0/g" /etc/yum/pluginconf.d/fastestmirror.conf
mirror "kubernetes" "kubernetes"
mirror "docker-ce-stable" "docker"
mirror "elastic-7.x" "elastic"
mirror "elastic-6.x" "elastic"

mkdir -p ${DIR_PREFIX}/key/
curl http://packages.cloud.google.com/yum/doc/yum-key.gpg > ${DIR_PREFIX}/key/kubernetes-yum-key.gpg
curl https://packages.cloud.google.com/yum/doc/rpm-package-key.gpg > ${DIR_PREFIX}/key/kubernetes-rpm-package-key.gpg
curl https://artifacts.elastic.co/GPG-KEY-elasticsearch > ${DIR_PREFIX}/key/elasticsearch-key.gpg

