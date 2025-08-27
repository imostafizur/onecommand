#!/bin/bash

# OneCommand - DevOps Tools Installation Suite
# A comprehensive CLI tool for installing essential DevOps tools

set -e  # Exit on any error

# Color codes for better output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# Logging functions
log_info() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

log_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

log_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

log_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Check prerequisites
check_prerequisites() {
    log_info "Checking prerequisites..."
    
    # Check if running on supported OS
    if [[ ! -f /etc/os-release ]]; then
        log_error "Unsupported operating system. This tool requires a Linux distribution with /etc/os-release."
        exit 1
    fi
    
    # Check for sudo privileges
    if ! sudo -n true 2>/dev/null; then
        log_warning "This tool requires sudo privileges for installations."
        echo "Please ensure you can run sudo commands."
    fi
    
    # Check internet connection
    if ! ping -c 1 google.com &> /dev/null; then
        log_warning "No internet connection detected. Some installations may fail."
    fi
    
    log_success "Prerequisites check completed."
}

# Function to display the menu
display_menu() {
    clear
    echo -e "${PURPLE}======================================${NC}"
    echo -e "${CYAN}     OneCommand - DevOps Tools Suite${NC}"
    echo -e "${PURPLE}======================================${NC}"
    echo -e "${GREEN}1.${NC} Install Docker"
    echo -e "${GREEN}2.${NC} Install Kubernetes Tools (Minikube & Helm)"
    echo -e "${GREEN}3.${NC} Install kubectl"
    echo -e "${GREEN}4.${NC} Check Installed Versions"
    echo -e "${GREEN}5.${NC} Install Kustomize"
    echo -e "${GREEN}6.${NC} Exit"
    echo -e "${PURPLE}======================================${NC}"
}

# Function to install Docker
install_docker() {
    log_info "Starting Docker installation..."
    if [[ -f "./install_docker.sh" ]]; then
        chmod +x ./install_docker.sh
        if ./install_docker.sh; then
            log_success "Docker installation completed successfully!"
        else
            log_error "Docker installation failed!"
            return 1
        fi
    else
        log_error "Docker installation script not found!"
        return 1
    fi
}

# Function to install Kubernetes tools (Minikube & Helm)
install_k8s_tools() {
    log_info "Starting Kubernetes tools installation..."
    if [[ -f "./install_k8s_tools.sh" ]]; then
        chmod +x ./install_k8s_tools.sh
        if ./install_k8s_tools.sh; then
            log_success "Kubernetes tools installation completed successfully!"
        else
            log_error "Kubernetes tools installation failed!"
            return 1
        fi
    else
        log_error "Kubernetes tools installation script not found!"
        return 1
    fi
}

# Function to install kubectl
install_kubectl() {
    log_info "Starting kubectl installation..."
    if [[ -f "./install_kubectl.sh" ]]; then
        chmod +x ./install_kubectl.sh
        if ./install_kubectl.sh; then
            log_success "kubectl installation completed successfully!"
        else
            log_error "kubectl installation failed!"
            return 1
        fi
    else
        log_error "kubectl installation script not found!"
        return 1
    fi
}

# Function to check installed versions
check_versions() {
    log_info "Checking installed tool versions..."
    if [[ -f "./check_versions.sh" ]]; then
        chmod +x ./check_versions.sh
        ./check_versions.sh
    else
        log_error "Version check script not found!"
        return 1
    fi
}

# Function to install Kustomize
install_kustomize() {
    log_info "Starting Kustomize installation..."
    if [[ -f "./install_kustomize.sh" ]]; then
        chmod +x ./install_kustomize.sh
        if ./install_kustomize.sh; then
            log_success "Kustomize installation completed successfully!"
        else
            log_error "Kustomize installation failed!"
            return 1
        fi
    else
        log_error "Kustomize installation script not found!"
        return 1
    fi
}

# Function to handle user input with validation
get_user_choice() {
    local choice
    read -p "$(echo -e ${CYAN}Please select an option [1-6]:${NC} )" choice
    echo "$choice"
}

# Function to pause and wait for user input
pause() {
    echo ""
    read -p "Press Enter to continue..."
}

# Main function
main() {
    log_info "Welcome to OneCommand - DevOps Tools Installation Suite"
    check_prerequisites
    
    # Main loop
    while true; do
        display_menu
        choice=$(get_user_choice)

        case $choice in
            1)
                echo ""
                if install_docker; then
                    pause
                else
                    log_error "Installation failed. Please check the error messages above."
                    pause
                fi
                ;;
            2)
                echo ""
                if install_k8s_tools; then
                    pause
                else
                    log_error "Installation failed. Please check the error messages above."
                    pause
                fi
                ;;
            3)
                echo ""
                if install_kubectl; then
                    pause
                else
                    log_error "Installation failed. Please check the error messages above."
                    pause
                fi
                ;;
            4)
                echo ""
                check_versions
                pause
                ;;
            5)
                echo ""
                if install_kustomize; then
                    pause
                else
                    log_error "Installation failed. Please check the error messages above."
                    pause
                fi
                ;;
            6)
                echo ""
                log_success "Thank you for using OneCommand! Goodbye!"
                exit 0
                ;;
            *)
                log_warning "Invalid option. Please select a number between 1 and 6."
                sleep 2
                ;;
        esac
    done
}

# Run main function
main "$@"
