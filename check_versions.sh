#!/bin/bash

# OneCommand - Version Checker
# Checks versions of installed DevOps tools

# Color codes for better output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

echo -e "${PURPLE}======================================${NC}"
echo -e "${CYAN}        Installed Tool Versions${NC}"
echo -e "${PURPLE}======================================${NC}"

# Function to check and display tool version
check_tool() {
    local tool_name="$1"
    local command="$2"
    local version_command="$3"
    
    echo -n -e "${BLUE}$tool_name:${NC} "
    if command -v "$command" &> /dev/null; then
        version_output=$(eval "$version_command" 2>/dev/null)
        if [[ -n "$version_output" ]]; then
            echo -e "${GREEN}$version_output${NC}"
        else
            echo -e "${YELLOW}Installed, but version could not be determined${NC}"
        fi
    else
        echo -e "${RED}Not installed${NC}"
    fi
}

# Docker
check_tool "Docker" "docker" "docker --version"

# kubectl
check_tool "kubectl" "kubectl" "kubectl version --client --short 2>/dev/null | sed 's/Client Version: //'"

# Minikube
check_tool "Minikube" "minikube" "minikube version | head -n 1"

# Helm
check_tool "Helm" "helm" "helm version --short"

# Kustomize
check_tool "Kustomize" "kustomize" "kustomize version"

echo -e "${PURPLE}======================================${NC}"

# Additional system information
echo ""
echo -e "${CYAN}System Information:${NC}"
echo -e "${BLUE}OS:${NC} $(lsb_release -ds 2>/dev/null || cat /etc/os-release | grep PRETTY_NAME | cut -d'=' -f2 | tr -d '\"')"
echo -e "${BLUE}Kernel:${NC} $(uname -r)"
echo -e "${BLUE}Architecture:${NC} $(uname -m)"
