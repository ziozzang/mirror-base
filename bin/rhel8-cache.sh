#!/bin/bash -x
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
  reposync  \
    --repoid=${REPO_ID} \
    -p "${TARGET_DIR}" \
    --downloadcomps --download-metadata
  #--gpgcheck -l
  createrepo -v ${TARGET_DIR}/${REPO_ID}
}

mirror "ubi-8-baseos" "rhel8"
mirror "ubi-8-appstream" "rhel8"

mirror "rhel-8-for-x86_64-rt-rpms" "rhel8"
mirror "rhel-8-for-x86_64-baseos-rpms" "rhel8"
mirror "codeready-builder-for-rhel-8-x86_64-rpms" "rhel8"
mirror "rhel-8-for-x86_64-appstream-rpms" "rhel8"
mirror "satellite-tools-6.5-for-rhel-8-x86_64-rpms" "rhel8"
mirror "rhel-8-for-x86_64-highavailability-rpms" "rhel8"
mirror "rhel-8-for-x86_64-resilientstorage-rpms" "rhel8"
mirror "ansible-2.8-for-rhel-8-x86_64-rpms" "rhel8"
mirror "rhel-8-for-x86_64-supplementary-rpms" "rhel8"
