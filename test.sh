#!/bin/bash

# OneCommand Test Suite
# Basic functionality tests for OneCommand

# Color codes
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m'

echo -e "${BLUE}======================================${NC}"
echo -e "${BLUE}    OneCommand Test Suite${NC}"
echo -e "${BLUE}======================================${NC}"

# Test counters
passed=0
total=0

# Test function
test_result() {
    local test_name="$1"
    local success="$2"
    
    ((total++))
    echo -n "Testing $test_name... "
    
    if [[ "$success" == "true" ]]; then
        echo -e "${GREEN}PASS${NC}"
        ((passed++))
    else
        echo -e "${RED}FAIL${NC}"
    fi
}

# File existence tests
test_result "install_dashboard.sh exists" "$([ -f ./install_dashboard.sh ] && echo true || echo false)"
test_result "README.md exists" "$([ -f ./README.md ] && echo true || echo false)"
test_result "Makefile exists" "$([ -f ./Makefile ] && echo true || echo false)"
test_result "setup.sh exists" "$([ -f ./setup.sh ] && echo true || echo false)"

# Executable tests
test_result "install_dashboard.sh is executable" "$([ -x ./install_dashboard.sh ] && echo true || echo false)"
test_result "check_versions.sh is executable" "$([ -x ./check_versions.sh ] && echo true || echo false)"

# Syntax tests
test_result "install_dashboard.sh syntax valid" "$(bash -n ./install_dashboard.sh 2>/dev/null && echo true || echo false)"
test_result "check_versions.sh syntax valid" "$(bash -n ./check_versions.sh 2>/dev/null && echo true || echo false)"

# Functional tests
test_result "version checker runs" "$(./check_versions.sh >/dev/null 2>&1 && echo true || echo false)"
test_result "main menu exits cleanly" "$(echo '6' | ./install_dashboard.sh >/dev/null 2>&1 && echo true || echo false)"

echo ""
echo -e "${BLUE}======================================${NC}"
echo -e "${BLUE}Test Results: ${passed}/${total} passed${NC}"
echo -e "${BLUE}======================================${NC}"

if [[ $passed -eq $total ]]; then
    echo -e "${GREEN}All tests passed! 🎉${NC}"
    exit 0
else
    echo -e "${RED}Some tests failed! ❌${NC}"
    exit 1
fi