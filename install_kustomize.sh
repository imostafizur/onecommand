#!/bin/bash

set -e

echo "Installing Kustomize..."

# Define temp directory and cleanup on exit
TMP_DIR=$(mktemp -d)
trap "rm -rf $TMP_DIR" EXIT

cd "$TMP_DIR"

# Download and run the official install script
curl -s -O https://raw.githubusercontent.com/kubernetes-sigs/kustomize/master/hack/install_kustomize.sh
chmod +x install_kustomize.sh
./install_kustomize.sh

# Move binary to /usr/local/bin
if [[ -f ./kustomize ]]; then
    sudo mv ./kustomize /usr/local/bin/
    sudo chmod +x /usr/local/bin/kustomize
    echo "Kustomize installed successfully at /usr/local/bin/kustomize"
else
    echo "Failed to install kustomize."
    exit 1
fi

# Verify
echo "Verifying Kustomize installation..."
kustomize version
