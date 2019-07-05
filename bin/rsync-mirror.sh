#!/bin/bash

####################################################################
# Mirror using Rsync
# - Code by Jioh L. Jung
####################################################################
# Run using
# > docker run -it --rm -v /mirrors:/mirrors eeacms/rsync

#- Move Script directory as base
BASE_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
cd "${BASE_DIR}"


TARGET_DIR=${TARGET_DIR:-"/mirrors/"}

mirror () {
  REPO_DIR="$1"
  MIRROR_DIR="${TARGET_DIR}/${REPO_DIR}"
  RSYNC_SRC="$2"

  # make sure we never run 2 rsync at the same time
  if [ ! -f "/etc/alpine-release" ] && [ -f "/usr/bin/flock" ]; then
    lockfile="/tmp/${REPO_DIR/\//}-mirror.lock"
    if [ -z "$flock" ] ; then
      exec env flock=1 flock -n $lockfile "$0" "$@"
    fi
  fi
  
  RSYNC_PARAMS=""
  if [ -f "../conf/rsync-exclude-${REPO_DIR/\//}.list" ]; then
    RSYNC_PARAMS="--exclude-from ../conf/rsync-exclude-${REPO_DIR/\//}.list"
  fi

  mkdir -p "${MIRROR_DIR}"
  /usr/bin/rsync \
	--verbose \
        --archive \
        --update \
        --hard-links \
        --delete \
        --recursive \
        --links \
        --perms \
        --times \
        --compress \
        --progress \
        --delete-after \
        --delay-updates \
        --timeout=600 \
        ${RSYNC_PARAMS} \
        "${RSYNC_SRC}" "${MIRROR_DIR}"
}

# Alpine Linux (APK)
mirror "alpine" "rsync://rsync.alpinelinux.org/alpine/"

# Apache
mirror "apache" "rsync://ftp.iij.ad.jp/pub/network/apache/"

# CentOS
mirror "centos" "rsync://ftp.kaist.ac.kr/CentOS/"

# CRAN
mirror "cran" "cran.r-project.org::CRAN"

# Fedora

# Fedora EPEL
mirror "fedora-epel" "rsync://ftp.iij.ad.jp/pub/linux/Fedora/epel"

# Debian
mirror "debian" "rsync://ftp.kaist.ac.kr/debian/"
mirror "debian-security" "rsync://ftp.kaist.ac.kr/debian-security/"

# Jenkins
mirror "jenkins" "rsync://rsync.osuosl.org/jenkins/updates/"

mirror "jenkins-download/download" "rsync://rsync.osuosl.org/jenkins/war"
mirror "jenkins-download/download" "rsync://rsync.osuosl.org/jenkins/plugins"
mirror "jenkins-pkg" "rsync://rsync.osuosl.org/jenkins/redhat-stable"
mirror "jenkins-pkg" "rsync://rsync.osuosl.org/jenkins/redhat"
mirror "jenkins-pkg" "rsync://rsync.osuosl.org/jenkins/debian-stable"
mirror "jenkins-pkg" "rsync://rsync.osuosl.org/jenkins/debian"

curl -L http://updates.jenkins-ci.org/update-center.json > \
  ${TARGET_DIR/jenkins-download/update-center.json

# Ubuntu
mirror "ubuntu" "rsync://ftp.kaist.ac.kr/ubuntu/"

