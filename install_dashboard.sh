#!/bin/bash

# Function to display the menu
display_menu() {
    echo "==============================="
    echo "      CLI Installation Menu"
    echo "==============================="
    echo "1. Install Docker"
    echo "2. Install Kubernetes Tools (Minikube & Helm)"
    echo "3. Install kubectl"
    echo "4. Exit"
    echo "==============================="
}

# Function to install Docker
install_docker() {
    echo "Starting Docker installation..."
    ./install_docker.sh
}

# Function to install Kubernetes tools (Minikube & Helm)
install_k8s_tools() {
    echo "Starting Kubernetes tools installation..."
    ./install_minikube_helm.sh
}

# Function to install kubectl
install_kubectl() {
    echo "Starting kubectl installation..."
    ./install_kubectl.sh
}

# Main loop
while true; do
    display_menu
    read -p "Please select an option [1-4]: " choice

    case $choice in
        1)
            install_docker
            ;;
        2)
            install_k8s_tools
            ;;
        3)
            install_kubectl
            ;;
        4)
            echo "Exiting..."
            exit 0
            ;;
        *)
            echo "Invalid option. Please select a number between 1 and 4."
            ;;
    esac
done

