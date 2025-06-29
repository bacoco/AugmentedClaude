#!/bin/bash

# AugmentedClaude Update Script
# Updates to the latest version from GitHub

set -e

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m'

echo -e "${BLUE}Updating AugmentedClaude...${NC}"
echo ""

# Check if we're in the right directory
if [ ! -f ".claude-root" ]; then
    echo -e "${RED}✗ Not in an AugmentedClaude project directory${NC}"
    echo "Please run this script from the AugmentedClaude directory"
    exit 1
fi

# Check if it's a git repository
if [ ! -d ".git" ]; then
    echo -e "${RED}✗ Not a git repository${NC}"
    echo "Cannot update - this installation was not cloned from git"
    exit 1
fi

# Check for uncommitted changes
if ! git diff-index --quiet HEAD --; then
    echo -e "${YELLOW}⚠ You have uncommitted changes${NC}"
    echo "Please commit or stash your changes before updating"
    echo ""
    echo "To stash changes: git stash"
    echo "To commit changes: git add . && git commit -m 'Your message'"
    exit 1
fi

# Get current branch
CURRENT_BRANCH=$(git rev-parse --abbrev-ref HEAD)
echo -e "${BLUE}Current branch: $CURRENT_BRANCH${NC}"

# Fetch latest changes
echo -e "${BLUE}Fetching latest changes...${NC}"
git fetch origin

# Check if there are updates
LOCAL=$(git rev-parse HEAD)
REMOTE=$(git rev-parse origin/$CURRENT_BRANCH)

if [ "$LOCAL" = "$REMOTE" ]; then
    echo -e "${GREEN}✓ Already up to date!${NC}"
    exit 0
fi

# Show what will be updated
echo ""
echo -e "${BLUE}Updates available:${NC}"
git log --oneline HEAD..origin/$CURRENT_BRANCH
echo ""

# Confirm update
read -p "Do you want to update? [Y/n] " -n 1 -r
echo ""
if [[ $REPLY =~ ^[Nn]$ ]]; then
    echo "Update cancelled."
    exit 0
fi

# Pull updates
echo -e "${BLUE}Pulling updates...${NC}"
git pull origin $CURRENT_BRANCH

# Update dependencies if package.json changed
if git diff HEAD~ --name-only | grep -q "package.json"; then
    echo ""
    echo -e "${YELLOW}package.json has changed${NC}"
    read -p "Update npm dependencies? [Y/n] " -n 1 -r
    echo ""
    if [[ ! $REPLY =~ ^[Nn]$ ]]; then
        echo -e "${BLUE}Updating dependencies...${NC}"
        npm install
    fi
fi

# Success
echo ""
echo -e "${GREEN}✓ AugmentedClaude updated successfully!${NC}"
echo ""
echo -e "${BLUE}What's new:${NC}"
git log --oneline HEAD~..HEAD
echo ""
echo -e "${GREEN}You can now start using the updated version with: ${YELLOW}claude${NC}"