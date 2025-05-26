#!/bin/bash

echo "=================================="
echo "      Installed Versions"
echo "=================================="

# Docker
echo -n "Docker: "
if command -v docker &> /dev/null; then
    docker --version
else
    echo "Not installed"
fi

# kubectl
echo -n "kubectl: "
if command -v kubectl &> /dev/null; then
    ver=$(kubectl version --client -o json 2>/dev/null | grep gitVersion | cut -d '"' -f4)
    if [[ -n "$ver" ]]; then
        echo "$ver"
    else
        echo "Installed, but version could not be determined"
    fi
else
    echo "Not installed"
fi

# Minikube
echo -n "Minikube: "
if command -v minikube &> /dev/null; then
    minikube version | head -n 1
else
    echo "Not installed"
fi

# Helm
echo -n "Helm: "
if command -v helm &> /dev/null; then
    helm version --short
else
    echo "Not installed"
fi

# Kustomize
echo -n "Kustomize: "
i
