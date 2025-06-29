#!/bin/bash

# AugmentedClaude Easy Installer
# https://github.com/bacoco/AugmentedClaude

set -e  # Exit on error

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Default values
DEFAULT_DIR="my-augmented-claude"
REPO_URL="https://github.com/bacoco/AugmentedClaude.git"

echo -e "${BLUE}"
echo "    _                                     _           _  ____ _                 _      "
echo "   / \  _   _  __ _ _ __ ___   ___ _ __ | |_ ___  __| |/ ___| | __ _ _   _  __| | ___ "
echo "  / _ \| | | |/ _\` | '_ \` _ \ / _ \ '_ \| __/ _ \/ _\` | |   | |/ _\` | | | |/ _\` |/ _ \\"
echo " / ___ \ |_| | (_| | | | | | |  __/ | | | ||  __/ (_| | |___| | (_| | |_| | (_| |  __/"
echo "/_/   \_\__,_|\__, |_| |_| |_|\___|_| |_|\__\___|\__,_|\____|_|\__,_|\__,_|\__,_|\___|"
echo "              |___/                                                                     "
echo -e "${NC}"
echo -e "${GREEN}Welcome to AugmentedClaude Installer!${NC}"
echo ""

# Check if running through pipe (non-interactive)
if [ ! -t 0 ]; then
    echo -e "${YELLOW}Note: Running in non-interactive mode${NC}"
    # Set defaults for non-interactive mode
    export PROJECT_DIR="$DEFAULT_DIR"
fi

# Function to check if a command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Function to get Node.js version
get_node_version() {
    node -v 2>/dev/null | sed 's/v//' | cut -d. -f1
}

# Check prerequisites
echo -e "${BLUE}Checking prerequisites...${NC}"

# Check for git
if ! command_exists git; then
    echo -e "${RED}✗ Git is not installed${NC}"
    echo "Please install git first: https://git-scm.com/downloads"
    exit 1
else
    echo -e "${GREEN}✓ Git is installed${NC}"
fi

# Check for Node.js
if ! command_exists node; then
    echo -e "${RED}✗ Node.js is not installed${NC}"
    echo "Please install Node.js (v16 or higher): https://nodejs.org/"
    exit 1
else
    NODE_VERSION=$(get_node_version)
    if [ "$NODE_VERSION" -lt 16 ]; then
        echo -e "${RED}✗ Node.js version is too old (v$NODE_VERSION)${NC}"
        echo "Please upgrade to Node.js v16 or higher: https://nodejs.org/"
        exit 1
    else
        echo -e "${GREEN}✓ Node.js $(node -v) is installed${NC}"
    fi
fi

# Check for npm
if ! command_exists npm; then
    echo -e "${RED}✗ npm is not installed${NC}"
    echo "npm should come with Node.js. Please reinstall Node.js."
    exit 1
else
    echo -e "${GREEN}✓ npm $(npm -v) is installed${NC}"
fi

# Check for Claude CLI
if ! command_exists claude; then
    echo -e "${YELLOW}⚠ Claude CLI is not installed${NC}"
    echo ""
    if [ -t 0 ]; then
        read -p "Would you like to install Claude CLI now? (recommended) [Y/n] " -n 1 -r
        echo ""
    else
        REPLY="Y"
        echo "Auto-installing Claude CLI in non-interactive mode..."
    fi
    if [[ ! $REPLY =~ ^[Nn]$ ]]; then
        echo -e "${BLUE}Installing Claude CLI...${NC}"
        npm install -g @anthropic-ai/claude-cli
        if command_exists claude; then
            echo -e "${GREEN}✓ Claude CLI installed successfully${NC}"
        else
            echo -e "${RED}✗ Failed to install Claude CLI${NC}"
            echo "Please install manually: npm install -g @anthropic-ai/claude-cli"
            exit 1
        fi
    else
        echo -e "${YELLOW}⚠ Skipping Claude CLI installation${NC}"
        echo "You'll need to install it later: npm install -g @anthropic-ai/claude-cli"
    fi
else
    echo -e "${GREEN}✓ Claude CLI is installed${NC}"
fi

echo ""
echo -e "${BLUE}Setting up AugmentedClaude...${NC}"

# Get project directory
if [ -t 0 ]; then
    read -p "Enter project directory name [$DEFAULT_DIR]: " PROJECT_DIR
    PROJECT_DIR=${PROJECT_DIR:-$DEFAULT_DIR}
else
    # Already set in non-interactive check above
    echo "Using default directory: $PROJECT_DIR"
fi

# Check if directory exists
if [ -d "$PROJECT_DIR" ]; then
    echo -e "${RED}✗ Directory '$PROJECT_DIR' already exists${NC}"
    if [ -t 0 ]; then
        read -p "Do you want to overwrite it? [y/N] " -n 1 -r
        echo ""
    else
        REPLY="N"
        echo "Cannot overwrite in non-interactive mode. Please remove the directory first."
    fi
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        echo "Installation cancelled."
        exit 1
    fi
    rm -rf "$PROJECT_DIR"
fi

# Clone repository
echo -e "${BLUE}Cloning AugmentedClaude repository...${NC}"
TARGET_DIR="${PROJECT_DIR:-$DEFAULT_DIR}"
echo "Installing to: $TARGET_DIR"
git clone "$REPO_URL" "$TARGET_DIR"

# Enter directory
cd "$TARGET_DIR"

# Optional npm install
echo ""
if [ -t 0 ]; then
    read -p "Install optional MCP dependencies? (recommended for full features) [Y/n] " -n 1 -r
    echo ""
else
    REPLY="Y"
    echo "Auto-installing dependencies in non-interactive mode..."
fi
if [[ ! $REPLY =~ ^[Nn]$ ]]; then
    echo -e "${BLUE}Installing dependencies...${NC}"
    npm install
    echo -e "${GREEN}✓ Dependencies installed${NC}"
else
    echo -e "${YELLOW}⚠ Skipping dependency installation${NC}"
    echo "You can install them later with: npm install"
fi

# Success message
echo ""
echo -e "${GREEN}🎉 AugmentedClaude installation complete!${NC}"
echo ""
echo -e "${BLUE}Next steps:${NC}"
echo -e "1. ${YELLOW}cd $TARGET_DIR${NC}"
echo -e "2. ${YELLOW}claude${NC}"
echo -e "3. Start using natural language commands like:"
echo -e "   - ${GREEN}\"Build a React dashboard\"${NC}"
echo -e "   - ${GREEN}\"Review my code for security issues\"${NC}"
echo -e "   - ${GREEN}\"Debug this performance problem\"${NC}"
echo ""
echo -e "${BLUE}For more information, see:${NC}"
echo -e "- README.md"
echo -e "- HOW_TO_USE.md"
echo ""
echo -e "${GREEN}Happy coding with AugmentedClaude! 🚀${NC}"