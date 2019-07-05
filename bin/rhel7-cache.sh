#!/bin/bash

BASE_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
cd "${BASE_DIR}"
echo ">> Moved to '${BASE_DIR}'"

PREFIX_DIR="/mirrors"

mirror () {
  REPO_ID="$1"
  CATEGORY="$2"
  TARGET_DIR="${PREFIX_DIR}/${CATEGORY}"
  mkdir -p ${TARGET_DIR}/${REPO_ID}
  createrepo -v ${TARGET_DIR}/${REPO_ID}
  reposync --gpgcheck -l \
    --repoid=${REPO_ID} \
    --download_path=${TARGET_DIR} \
    --downloadcomps --download-metadata
  createrepo -v ${TARGET_DIR}/${REPO_ID}
}

mirror "rhel-7-server-ansible-2-rpms" "rhel7"
mirror "rhel-7-server-ansible-2.7-rpms" "rhel7"
mirror "rhel-7-server-ansible-2.8-rpms" "rhel7"
mirror "rhel-7-server-devtools-rpms" "rhel7"
mirror "rhel-7-server-extras-rpms" "rhel7"
mirror "rhel-7-server-fastrack-rpms" "rhel7"
mirror "rhel-7-server-openstack-14-tools-rpms" "rhel7"
mirror "rhel-7-server-rh-common-rpms" "rhel7"
mirror "rhel-7-server-supplementary-rpms" "rhel7"
mirror "rhel-atomic-7-cdk-3.8-rpms" "rhel7"
mirror "rhel-atomic-7-cdk-3.7-rpms" "rhel7"
mirror "rhel-atomic-7-cdk-3.6-rpms" "rhel7"
mirror "rhel-server-rhscl-7-rpms" "rhel7"

mirror "rhel-7-server-rpms" "rhel7"
mirror "rhel-7-server-optional-rpms" "rhel7"
mirror "rhel-7-server-extras-rpms" "rhel7"
mirror "rhel-ha-for-rhel-7-server-rpms" "rhel7"
mirror "rhel-ha-for-rhel-7-server-eus-rpms" "rhel7"
mirror "rhel-rs-for-rhel-7-server-rpms" "rhel7"
mirror "rhel-rs-for-rhel-7-server-eus-rpms" "rhel7"
mirror "rhel-7-server-thirdparty-oracle-java-rpms" "rhel7"
mirror "rhel-7-server-thirdparty-oracle-java-source-rpms" "rhel7"
mirror "rhel-7-server-eus-rpms" "rhel7"
mirror "rhel-7-server-eus-rh-common-rpms" "rhel7"

