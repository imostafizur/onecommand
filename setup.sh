#!/bin/bash

# OneCommand Setup Script
# Sets up the OneCommand software for first-time use

set -e

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

# Welcome message
echo -e "${PURPLE}======================================${NC}"
echo -e "${CYAN}   OneCommand Setup & Installation${NC}"
echo -e "${PURPLE}======================================${NC}"
echo ""

log_info "Welcome to OneCommand setup!"
echo ""

# Check if running on supported OS
if [[ ! -f /etc/os-release ]]; then
    log_error "Unsupported operating system. OneCommand requires a Linux distribution."
    exit 1
fi

# Get OS information
source /etc/os-release
log_info "Detected OS: $PRETTY_NAME"

# Check for required commands
log_info "Checking system requirements..."
missing_commands=()

for cmd in curl wget sudo; do
    if ! command -v "$cmd" &> /dev/null; then
        missing_commands+=("$cmd")
    fi
done

if [[ ${#missing_commands[@]} -ne 0 ]]; then
    log_error "Missing required commands: ${missing_commands[*]}"
    log_info "Please install them using your package manager:"
    log_info "  Ubuntu/Debian: sudo apt-get install ${missing_commands[*]}"
    log_info "  CentOS/RHEL: sudo yum install ${missing_commands[*]}"
    exit 1
fi

log_success "System requirements check passed!"

# Make all scripts executable
log_info "Setting up OneCommand scripts..."
chmod +x *.sh

log_success "Scripts are now executable!"

# Create configuration file if it doesn't exist
if [[ ! -f "onecommand.conf" ]]; then
    log_info "Creating configuration file..."
    cat > onecommand.conf << 'EOF'
# OneCommand Configuration File
# Customize your OneCommand installation preferences

# Installation preferences
DOCKER_INSTALL_COMPOSE=true
KUBECTL_VERSION=stable
HELM_VERSION=latest
MINIKUBE_VERSION=latest
KUSTOMIZE_VERSION=latest

# System settings
INSTALL_DIR=/usr/local/bin
LOG_LEVEL=INFO
AUTO_UPDATE_CHECK=true

# Colors (set to false to disable colored output)
USE_COLORS=true

# Confirmation prompts (set to false to skip confirmations)
CONFIRM_INSTALLATIONS=true
EOF
    log_success "Configuration file created: onecommand.conf"
else
    log_info "Configuration file already exists: onecommand.conf"
fi

# Create symlink for easier access (optional)
INSTALL_GLOBALLY=""
echo ""
read -p "$(echo -e ${CYAN}Would you like to install OneCommand globally? [y/N]:${NC} )" -n 1 -r
echo ""
if [[ $REPLY =~ ^[Yy]$ ]]; then
    log_info "Creating global installation..."
    
    # Create wrapper script
    cat > /tmp/onecommand << 'EOF'
#!/bin/bash
# OneCommand Global Wrapper
ONECOMMAND_DIR=""
if [[ -f /usr/local/share/onecommand/install_dashboard.sh ]]; then
    ONECOMMAND_DIR="/usr/local/share/onecommand"
elif [[ -f "$HOME/.local/share/onecommand/install_dashboard.sh" ]]; then
    ONECOMMAND_DIR="$HOME/.local/share/onecommand"
else
    echo "OneCommand installation not found!"
    exit 1
fi

cd "$ONECOMMAND_DIR"
exec ./install_dashboard.sh "$@"
EOF
    
    # Try to install globally (requires sudo)
    if sudo cp /tmp/onecommand /usr/local/bin/onecommand 2>/dev/null && sudo chmod +x /usr/local/bin/onecommand 2>/dev/null; then
        # Create installation directory and copy files
        sudo mkdir -p /usr/local/share/onecommand
        sudo cp -r . /usr/local/share/onecommand/
        log_success "OneCommand installed globally! You can now run 'onecommand' from anywhere."
        INSTALL_GLOBALLY="global"
    else
        log_warning "Could not install globally (insufficient permissions)."
        log_info "Installing locally instead..."
        mkdir -p "$HOME/.local/share/onecommand"
        cp -r . "$HOME/.local/share/onecommand/"
        mkdir -p "$HOME/.local/bin"
        sed "s|ONECOMMAND_DIR=\"\"|ONECOMMAND_DIR=\"$HOME/.local/share/onecommand\"|" /tmp/onecommand > "$HOME/.local/bin/onecommand"
        chmod +x "$HOME/.local/bin/onecommand"
        log_success "OneCommand installed locally! Add $HOME/.local/bin to your PATH to run 'onecommand' from anywhere."
        INSTALL_GLOBALLY="local"
    fi
    
    rm -f /tmp/onecommand
fi

echo ""
echo -e "${PURPLE}======================================${NC}"
log_success "OneCommand setup completed successfully!"
echo -e "${PURPLE}======================================${NC}"
echo ""

log_info "Next steps:"
if [[ "$INSTALL_GLOBALLY" == "global" ]]; then
    echo -e "${GREEN}•${NC} Run 'onecommand' from anywhere to start the installation menu"
elif [[ "$INSTALL_GLOBALLY" == "local" ]]; then
    echo -e "${GREEN}•${NC} Add $HOME/.local/bin to your PATH, then run 'onecommand'"
    echo -e "${GREEN}•${NC} Or run '$HOME/.local/bin/onecommand' directly"
else
    echo -e "${GREEN}•${NC} Run './install_dashboard.sh' to start the installation menu"
fi
echo -e "${GREEN}•${NC} Edit 'onecommand.conf' to customize installation preferences"
echo -e "${GREEN}•${NC} Check the README.md for detailed usage instructions"

echo ""
log_info "Happy DevOps tooling! 🚀"