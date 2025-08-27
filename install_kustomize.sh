#!/bin/bash

# OneCommand - Kustomize Installation
# Installs the latest version of Kustomize

set -e

echo "Installing Kustomize..."

# Check if running as root
if [[ $EUID -eq 0 ]]; then
   echo "This script should not be run as root"
   exit 1
fi

# Define temp directory and cleanup on exit
TMP_DIR=$(mktemp -d)
trap "rm -rf $TMP_DIR" EXIT

cd "$TMP_DIR"

# Download and run the official install script
echo "Downloading official Kustomize installation script..."
if ! curl -s -O https://raw.githubusercontent.com/kubernetes-sigs/kustomize/master/hack/install_kustomize.sh; then
    echo "Failed to download Kustomize installation script"
    exit 1
fi

chmod +x install_kustomize.sh

echo "Running Kustomize installation script..."
if ! ./install_kustomize.sh; then
    echo "Failed to run Kustomize installation script"
    exit 1
fi

# Move binary to /usr/local/bin
if [[ -f ./kustomize ]]; then
    echo "Installing Kustomize binary to /usr/local/bin/"
    sudo mv ./kustomize /usr/local/bin/
    sudo chmod +x /usr/local/bin/kustomize
    echo "Kustomize installed successfully at /usr/local/bin/kustomize"
else
    echo "Failed to install kustomize - binary not found."
    exit 1
fi

# Verify installation
echo "Verifying Kustomize installation..."
if kustomize version; then
    echo "Kustomize installation verification successful!"
else
    echo "Kustomize installation verification failed!"
    exit 1
fi
