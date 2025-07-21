#!/bin/bash
#
# Ultraspec Quick Install - Simplified one-liner version
# This creates a project in the current directory with minimal prompts
#
# Usage: curl -fsSL https://raw.githubusercontent.com/aiconsultancy/ultraspec/main/quick-install.sh | bash

set -e

# Colors
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m'

# Banner
echo -e "${BLUE}Ultraspec Quick Setup${NC}"
echo "===================="

# Get project name
read -p "Project name: " PROJECT_NAME

# Show stack options
echo ""
echo "Stack options:"
echo "1) Node.js   2) .NET   3) Go   4) Bun   5) Multi-stack"
read -p "Choose (1-5): " CHOICE

case $CHOICE in
    1) STACK="node-pnpm" ;;
    2) STACK="dotnet" ;;
    3) STACK="golang" ;;
    4) STACK="bun" ;;
    5) STACK="multi-stack" ;;
    *) STACK="node-pnpm" ;;
esac

# Download and run
echo -e "\n${BLUE}Setting up...${NC}"
curl -fsSL https://raw.githubusercontent.com/aiconsultancy/ultraspec/main/install.sh | \
    bash -s -- --name "$PROJECT_NAME" --stack "$STACK" --path "$(pwd)/$PROJECT_NAME"

echo -e "\n${GREEN}Done! Run: cd $PROJECT_NAME${NC}"