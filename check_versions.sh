#!/bin/bash

echo "=================================="
echo "      Installed Versions"
echo "=================================="

# print_tool_version <display_name> <command_name> <version_function>
print_tool_version() {
    local name=$1 cmd=$2
    shift 2

    echo -n "$name: "
    if command -v "$cmd" &> /dev/null; then
        "$@"
    else
        echo "Not installed"
    fi
}

docker_version() {
    docker --version
}

kubectl_version() {
    ver=$(kubectl version --client -o json 2>/dev/null | grep gitVersion | cut -d '"' -f4)
    if [[ -n "$ver" ]]; then
        echo "$ver"
    else
        echo "Installed, but version could not be determined"
    fi
}

minikube_version() {
    minikube version | head -n 1
}

helm_version() {
    helm version --short
}

kustomize_version() {
    kustomize version
}

print_tool_version "Docker" docker docker_version
print_tool_version "kubectl" kubectl kubectl_version
print_tool_version "Minikube" minikube minikube_version
print_tool_version "Helm" helm helm_version
print_tool_version "Kustomize" kustomize kustomize_version

echo "=================================="
