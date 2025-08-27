# OneCommand Makefile
# Standard build and installation targets

.PHONY: help install uninstall test clean setup run

# Default target
help:
	@echo "OneCommand - DevOps Tools Installation Suite"
	@echo ""
	@echo "Available targets:"
	@echo "  setup     - Run initial setup and configuration"
	@echo "  install   - Install OneCommand globally (requires sudo)"
	@echo "  uninstall - Remove OneCommand global installation"
	@echo "  run       - Start OneCommand menu"
	@echo "  test      - Run basic functionality tests"
	@echo "  clean     - Clean temporary files"
	@echo "  help      - Show this help message"

# Run initial setup
setup:
	@echo "Running OneCommand setup..."
	@chmod +x setup.sh
	@./setup.sh

# Install globally
install:
	@echo "Installing OneCommand globally..."
	@chmod +x *.sh
	@sudo mkdir -p /usr/local/share/onecommand
	@sudo cp -r . /usr/local/share/onecommand/
	@echo '#!/bin/bash' | sudo tee /usr/local/bin/onecommand > /dev/null
	@echo 'cd /usr/local/share/onecommand && exec ./install_dashboard.sh "$$@"' | sudo tee -a /usr/local/bin/onecommand > /dev/null
	@sudo chmod +x /usr/local/bin/onecommand
	@echo "OneCommand installed successfully! Run 'onecommand' to start."

# Uninstall global installation
uninstall:
	@echo "Uninstalling OneCommand..."
	@sudo rm -f /usr/local/bin/onecommand
	@sudo rm -rf /usr/local/share/onecommand
	@echo "OneCommand uninstalled successfully."

# Run OneCommand
run:
	@chmod +x install_dashboard.sh
	@./install_dashboard.sh

# Basic functionality tests
test:
	@echo "Running OneCommand functionality tests..."
	@chmod +x *.sh
	@echo "✓ All scripts are executable"
	@./check_versions.sh
	@echo "✓ Version checker works"
	@echo "✓ All tests passed!"

# Clean temporary files
clean:
	@echo "Cleaning temporary files..."
	@rm -f *.tmp
	@rm -f *.log
	@echo "✓ Cleanup completed"

# Development targets (for maintainers)
.PHONY: dev-test dev-lint

dev-test: test
	@echo "Running development tests..."
	@for script in *.sh; do \
		echo "Checking syntax: $$script"; \
		bash -n "$$script" || exit 1; \
	done
	@echo "✓ All scripts have valid syntax"

dev-lint:
	@echo "Running shellcheck linting..."
	@if command -v shellcheck >/dev/null 2>&1; then \
		for script in *.sh; do \
			echo "Linting: $$script"; \
			shellcheck "$$script" || true; \
		done; \
	else \
		echo "shellcheck not found, skipping linting"; \
	fi