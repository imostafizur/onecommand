#!/bin/bash

# Download the latest release of kubectl
echo "Downloading the latest release of kubectl..."
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"

# Install kubectl
echo "Installing kubectl..."
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl

# Verify the installation
echo "Verifying kubectl installation..."
kubectl version --client

echo "kubectl installation complete."

