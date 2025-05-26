#!/bin/bash

echo "=================================="
echo "      Installed Versions"
echo "=================================="

# Check Docker
echo -n "Docker: "
if command -v docker &> /dev/null; then
    docker --version
else
    echo "Not installed"
fi

# Check kubectl
echo -n "kubectl: "
if command -v kubectl &> /dev/null; then
    kubectl version --client --short
else
    echo "Not installed"
fi

# Check Minikube
echo -n "Minikube: "
if command -v minikube &> /dev/null; then
    minikube version
else
    echo "Not installed"
fi

# Check Helm
echo -n "Helm: "
if command -v helm &> /dev/null; then
    helm version --short
else
    echo "Not installed"
fi

echo "=================================="
