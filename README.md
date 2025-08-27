# OneCommand - DevOps Tools Installation Suite

OneCommand is a comprehensive CLI tool for installing and managing essential DevOps tools including Docker, Kubernetes, kubectl, Helm, Minikube, and Kustomize. With a simple interactive menu, you can quickly set up your development environment.

## Features

- 🐳 **Docker Installation** - Complete Docker CE setup with all plugins
- ⚙️ **Kubernetes Tools** - Minikube and Helm installation
- 🎛️ **kubectl** - Kubernetes command-line tool
- 🔧 **Kustomize** - Kubernetes configuration management
- 📊 **Version Checking** - Check installed versions of all tools
- 🎯 **Interactive Menu** - Easy-to-use command-line interface
- 🎨 **Colored Output** - Enhanced user experience with colored output
- ⚡ **Error Handling** - Robust error handling and validation
- 🛠️ **Prerequisites Check** - System requirements validation

## Quick Start

### Method 1: Using setup script (Recommended)

1. **Clone the repository:**
   ```bash
   git clone https://github.com/imostafizur/onecommand.git
   cd onecommand
   ```

2. **Run the setup script:**
   ```bash
   chmod +x setup.sh
   ./setup.sh
   ```

3. **Start using OneCommand:**
   ```bash
   ./install_dashboard.sh
   # Or if installed globally:
   onecommand
   ```

### Method 2: Using Makefile

```bash
# Run setup
make setup

# Install globally (requires sudo)
make install

# Run OneCommand
make run

# Run tests
make test
```

### Method 3: Manual setup

1. **Clone and setup:**
   ```bash
   git clone https://github.com/imostafizur/onecommand.git
   cd onecommand
   chmod +x *.sh
   ```

2. **Run OneCommand:**
   ```bash
   ./install_dashboard.sh
   ```

## Usage

OneCommand provides an interactive menu with the following options:

```
======================================
     OneCommand - DevOps Tools Suite
======================================
1. Install Docker
2. Install Kubernetes Tools (Minikube & Helm)
3. Install kubectl
4. Check Installed Versions
5. Install Kustomize
6. Exit
======================================
```

### Menu Options Explained

1. **Install Docker** - Installs Docker CE with all necessary plugins
2. **Install Kubernetes Tools** - Installs Minikube and Helm
3. **Install kubectl** - Installs the Kubernetes command-line tool
4. **Check Installed Versions** - Displays versions of all installed tools with system info
5. **Install Kustomize** - Installs Kubernetes configuration management tool
6. **Exit** - Exit the application

### Individual Scripts

You can also run individual installation scripts directly:

```bash
./install_docker.sh      # Install Docker
./install_kubectl.sh     # Install kubectl  
./install_k8s_tools.sh   # Install Minikube and Helm
./install_kustomize.sh   # Install Kustomize
./check_versions.sh      # Check versions of installed tools
```

## Configuration

OneCommand supports configuration through the `onecommand.conf` file (created during setup):

```bash
# OneCommand Configuration File
DOCKER_INSTALL_COMPOSE=true
KUBECTL_VERSION=stable
HELM_VERSION=latest
MINIKUBE_VERSION=latest
KUSTOMIZE_VERSION=latest
INSTALL_DIR=/usr/local/bin
LOG_LEVEL=INFO
AUTO_UPDATE_CHECK=true
USE_COLORS=true
CONFIRM_INSTALLATIONS=true
```

## Requirements

- Ubuntu/Debian-based Linux distribution
- `sudo` privileges for installation
- Internet connection for downloading packages
- Required system packages: `curl`, `wget`, `sudo`

## Supported Tools

| Tool | Description | Version Support |
|------|-------------|----------------|
| Docker | Container runtime platform | Latest stable |
| kubectl | Kubernetes command-line tool | Latest stable |
| Minikube | Local Kubernetes cluster | Latest stable |
| Helm | Kubernetes package manager | Latest stable |
| Kustomize | Kubernetes configuration management | Latest stable |

## Testing

Run the test suite to validate functionality:

```bash
# Run basic tests
make test

# Run comprehensive tests  
chmod +x test.sh
./test.sh

# Run development tests (includes linting)
make dev-test
```

## Installation Methods

### Global Installation

Install OneCommand globally to use from anywhere:

```bash
make install
# Now you can run 'onecommand' from anywhere
```

### Local Installation

Install in your user directory:

```bash
./setup.sh
# Follow the prompts for local installation
```

## Makefile Targets

```bash
make help      # Show available targets
make setup     # Run initial setup
make install   # Install globally (requires sudo)
make uninstall # Remove global installation
make run       # Start OneCommand
make test      # Run functionality tests
make clean     # Clean temporary files
```

## Examples

### Basic Usage
```bash
# Start OneCommand
./install_dashboard.sh

# Select option 1 to install Docker
# Select option 4 to check versions
# Select option 6 to exit
```

### Check Current Tool Versions
```bash
./check_versions.sh
```

Output example:
```
======================================
        Installed Tool Versions
======================================
Docker: Docker version 20.10.17, build 100c701
kubectl: v1.24.0
Minikube: minikube version: v1.25.2
Helm: v3.8.2
Kustomize: v4.5.4
======================================

System Information:
OS: Ubuntu 20.04.4 LTS
Kernel: 5.4.0-104-generic
Architecture: x86_64
```

## Troubleshooting

### Common Issues

1. **Permission denied errors:**
   ```bash
   chmod +x *.sh
   ```

2. **Missing sudo privileges:**
   - Ensure your user has sudo access
   - Run `sudo -v` to verify

3. **Internet connection issues:**
   - Check network connectivity
   - Verify DNS resolution

4. **Package installation failures:**
   - Update package lists: `sudo apt-get update`
   - Check available disk space: `df -h`

### Getting Help

- Check the logs for detailed error messages
- Run individual scripts to isolate issues
- Ensure all system requirements are met
- Verify internet connectivity

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

This project is open source and available under the [MIT License](LICENSE).

