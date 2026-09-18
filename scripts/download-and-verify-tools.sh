#!/bin/bash
set -euo pipefail

# Download OKD oc client
VERSION="4.22.0-okd-scos.10"
BASE="https://github.com/okd-project/okd/releases/download/$VERSION/"

for file in openshift-client-linux-amd64-rhel9-$VERSION.tar.gz sha256sum.txt sha256sum.txt.asc
do
  curl -OL "$BASE/$file"
done

# Verify downloads
curl https://okd.io/okd-maintainers2.pub | gpg --import
gpg --verify sha256sum.txt.asc sha256sum.txt
sha256sum --check --ignore-missing sha256sum.txt

# Extract oc client
tar zxf openshift-client-linux-amd64-rhel9-$VERSION.tar.gz && mv oc kubectl /usr/local/bin/

# Download Kubeconform
# renovate: datasource=github-releases depName=yannh/kubeconform
KUBECONFORM_VERSION="0.8.0"
BASE="https://github.com/yannh/kubeconform/releases/download/v$KUBECONFORM_VERSION"

for file in CHECKSUMS kubeconform-linux-amd64.tar.gz
do
  curl -OL "$BASE/$file"
done

# Verify downloads
sha256sum --check --ignore-missing CHECKSUMS

tar zxf kubeconform-linux-amd64.tar.gz && mv kubeconform /usr/local/bin/

# Download opr-paas-cli (kubectl-paas)
# renovate: datasource=github-releases depName=belastingdienst/opr-paas-cli
PAAS_CLI_VERSION="2.0.6"
BASE="https://github.com/belastingdienst/opr-paas-cli/releases/download/v$PAAS_CLI_VERSION"

for file in kubectl-paas_Linux_x86_64.tar.gz opr-paas-cli_${PAAS_CLI_VERSION}_checksums.txt
do
  curl -OL "$BASE/$file"
done

# Verify downloads
sha256sum --check --ignore-missing opr-paas-cli_${PAAS_CLI_VERSION}_checksums.txt

tar zxf kubectl-paas_Linux_x86_64.tar.gz && mv kubectl-paas /usr/local/bin/
