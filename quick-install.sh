#!/bin/bash
#
# Ultraspec Quick Install - Simplified installation
# 
# For interactive use (recommended):
#   curl -fsSL https://raw.githubusercontent.com/aiconsultancy/ultraspec/main/quick-install.sh -o quick-install.sh && bash quick-install.sh
#
# For non-interactive use:
#   curl -fsSL https://raw.githubusercontent.com/aiconsultancy/ultraspec/main/install.sh | bash -s -- --name "MyApp" --stack node-pnpm --path ./myapp

set -e

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m'

# Check if running interactively
if [ ! -t 0 ]; then
    echo -e "${RED}This quick installer requires interactive input.${NC}"
    echo ""
    echo "Option 1 - Download and run locally (recommended):"
    echo "  curl -fsSL https://raw.githubusercontent.com/aiconsultancy/ultraspec/main/quick-install.sh -o quick-install.sh"
    echo "  bash quick-install.sh"
    echo ""
    echo "Option 2 - Use with parameters:"
    echo "  curl -fsSL https://raw.githubusercontent.com/aiconsultancy/ultraspec/main/install.sh | \\"
    echo "    bash -s -- --name 'MyApp' --stack node-pnpm --path ./myapp"
    echo ""
    exit 1
fi

# Banner
echo -e "${BLUE}"
cat << "EOF"
╦ ╦╦ ╔╦╗╦═╗╔═╗╔═╗╔═╗╔═╗╔═╗
║ ║║  ║ ╠╦╝╠═╣╚═╗╠═╝║╣ ║  
╚═╝╩═╝╩ ╩╚═╩ ╩╚═╝╩  ╚═╝╚═╝
EOF
echo -e "${NC}"
echo "Quick Setup - 2 Questions Only!"
echo "================================"
echo ""

# Get project name
read -p "Project name: " PROJECT_NAME
while [ -z "$PROJECT_NAME" ]; do
    echo -e "${YELLOW}Project name is required${NC}"
    read -p "Project name: " PROJECT_NAME
done

# Show stack options
echo ""
echo "Technology stack:"
echo "  1) Node.js + pnpm"
echo "  2) .NET (C#)"
echo "  3) Go"
echo "  4) Bun"
echo "  5) Multi-stack (Frontend + Backend)"
read -p "Choose [1-5] (default: 1): " CHOICE

CHOICE=${CHOICE:-1}
case $CHOICE in
    1) STACK="node-pnpm" ;;
    2) STACK="dotnet" ;;
    3) STACK="golang" ;;
    4) STACK="bun" ;;
    5) STACK="multi-stack" ;;
    *) STACK="node-pnpm" ;;
esac

# Set project path
PROJECT_PATH="$(pwd)/$PROJECT_NAME"

# Download and run
echo ""
echo -e "${BLUE}Setting up $PROJECT_NAME with $STACK stack...${NC}"
echo ""

# Download the installer and run it with parameters
if command -v curl &> /dev/null; then
    curl -fsSL https://raw.githubusercontent.com/aiconsultancy/ultraspec/main/install.sh | \
        bash -s -- --name "$PROJECT_NAME" --stack "$STACK" --path "$PROJECT_PATH"
elif command -v wget &> /dev/null; then
    wget -qO- https://raw.githubusercontent.com/aiconsultancy/ultraspec/main/install.sh | \
        bash -s -- --name "$PROJECT_NAME" --stack "$STACK" --path "$PROJECT_PATH"
else
    echo -e "${RED}Error: Neither curl nor wget found${NC}"
    exit 1
fi

echo ""
echo -e "${GREEN}✓ Setup complete!${NC}"
echo ""
echo "Next steps:"
echo "  cd $PROJECT_NAME"
echo "  make help"