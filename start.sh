#!/bin/bash

# AugmentedClaude Quick Start Script
# Checks prerequisites and starts Claude

set -e

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m'

echo -e "${BLUE}Starting AugmentedClaude...${NC}"
echo ""

# Check if we're in the right directory
if [ ! -f ".claude-root" ]; then
    echo -e "${RED}✗ Not in an AugmentedClaude project directory${NC}"
    echo "Please run this script from the AugmentedClaude directory"
    exit 1
fi

# Check if Claude CLI is installed
if ! command -v claude >/dev/null 2>&1; then
    echo -e "${RED}✗ Claude CLI is not installed${NC}"
    echo "Install it with: npm install -g @anthropic-ai/claude-cli"
    exit 1
fi

# Check if .claude directory exists
if [ ! -d ".claude" ]; then
    echo -e "${RED}✗ .claude directory not found${NC}"
    echo "Your AugmentedClaude installation may be incomplete"
    exit 1
fi

# Optional: Check for node_modules
if [ ! -d "node_modules" ]; then
    echo -e "${YELLOW}⚠ Dependencies not installed${NC}"
    echo "Some MCP features may not be available"
    echo "Install with: npm install"
    echo ""
fi

# Show quick tips
echo -e "${GREEN}✓ AugmentedClaude is ready!${NC}"
echo ""
echo -e "${BLUE}Quick tips:${NC}"
echo "• Just describe what you want in natural language"
echo "• Examples:"
echo "  - \"Build a user authentication system\""
echo "  - \"Review my code for security issues\""
echo "  - \"Debug this performance problem\""
echo ""
echo -e "${BLUE}Starting Claude...${NC}"
echo ""

# Start Claude
claude