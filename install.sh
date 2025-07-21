#!/bin/bash
#
# Ultraspec Quick Install Script
# Usage: curl -fsSL https://raw.githubusercontent.com/aiconsultancy/ultraspec/main/install.sh | bash
#
# This script downloads and runs the ultraspec initialization

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Function to print colored output
print_info() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

# ASCII Art Banner
show_banner() {
    echo -e "${BLUE}"
    cat << "EOF"
╦ ╦╦ ╔╦╗╦═╗╔═╗╔═╗╔═╗╔═╗╔═╗
║ ║║  ║ ╠╦╝╠═╣╚═╗╠═╝║╣ ║  
╚═╝╩═╝╩ ╩╚═╩ ╩╚═╝╩  ╚═╝╚═╝
EOF
    echo -e "${NC}"
    echo "Spec-Driven Development for Claude Code"
    echo "========================================"
    echo ""
}

# Function to show usage
usage() {
    echo "Usage: curl -fsSL https://raw.githubusercontent.com/aiconsultancy/ultraspec/main/install.sh | bash -s -- [OPTIONS]"
    echo ""
    echo "Options:"
    echo "  --path PATH      Project path (default: current directory)"
    echo "  --name NAME      Project name"
    echo "  --stack STACK    Technology stack (see below)"
    echo "  --help           Show this help message"
    echo ""
    echo "Available stacks:"
    echo "  dotnet          .NET (C#)"
    echo "  node-pnpm       Node.js + pnpm"
    echo "  bun             Bun"
    echo "  golang          Go"
    echo "  multi-stack     Frontend + Backend combination"
    echo ""
    echo "Examples:"
    echo "  curl -fsSL ... | bash -s -- --name 'My App' --stack node-pnpm"
    echo "  curl -fsSL ... | bash -s -- --path ~/projects/myapp --stack multi-stack"
}

# Default values
PROJECT_PATH=""
PROJECT_NAME=""
STACK=""
TEMP_DIR=""

# Parse command line arguments
while [[ $# -gt 0 ]]; do
    case $1 in
        --path)
            PROJECT_PATH="$2"
            shift 2
            ;;
        --name)
            PROJECT_NAME="$2"
            shift 2
            ;;
        --stack)
            STACK="$2"
            shift 2
            ;;
        --help)
            show_banner
            usage
            exit 0
            ;;
        *)
            print_error "Unknown option: $1"
            usage
            exit 1
            ;;
    esac
done

# Show banner
show_banner

# Check for required tools
check_requirements() {
    local missing_tools=()
    
    if ! command -v git &> /dev/null; then
        missing_tools+=("git")
    fi
    
    if ! command -v curl &> /dev/null && ! command -v wget &> /dev/null; then
        missing_tools+=("curl or wget")
    fi
    
    if [ ${#missing_tools[@]} -ne 0 ]; then
        print_error "Missing required tools: ${missing_tools[*]}"
        print_info "Please install the missing tools and try again."
        exit 1
    fi
}

# Download ultraspec
download_ultraspec() {
    print_info "Downloading ultraspec..."
    
    # Create temporary directory
    TEMP_DIR=$(mktemp -d)
    cd "$TEMP_DIR"
    
    # Download methods
    if command -v curl &> /dev/null; then
        curl -fsSL https://github.com/aiconsultancy/ultraspec/archive/main.tar.gz | tar -xz
    elif command -v wget &> /dev/null; then
        wget -qO- https://github.com/aiconsultancy/ultraspec/archive/main.tar.gz | tar -xz
    else
        print_error "Neither curl nor wget found. Cannot download ultraspec."
        exit 1
    fi
    
    if [ ! -d "ultraspec-main" ]; then
        print_error "Failed to download ultraspec"
        exit 1
    fi
    
    print_success "Downloaded ultraspec"
}

# Interactive setup
interactive_setup() {
    # Get project path if not provided
    if [ -z "$PROJECT_PATH" ]; then
        read -p "Enter project path (default: current directory): " input_path
        PROJECT_PATH="${input_path:-$(pwd)}"
    fi
    
    # Get project name if not provided
    if [ -z "$PROJECT_NAME" ]; then
        read -p "Enter project name: " PROJECT_NAME
        while [ -z "$PROJECT_NAME" ]; do
            print_warning "Project name is required"
            read -p "Enter project name: " PROJECT_NAME
        done
    fi
    
    # Get stack if not provided
    if [ -z "$STACK" ]; then
        echo ""
        echo "Select project type:"
        echo "1) Single Stack - .NET (C#)"
        echo "2) Single Stack - Node.js + pnpm"
        echo "3) Single Stack - Bun"
        echo "4) Single Stack - Go"
        echo "5) Multi-Stack - Frontend + Backend"
        echo "6) None (generic)"
        read -p "Enter choice (1-6): " choice
        
        case $choice in
            1) STACK="dotnet" ;;
            2) STACK="node-pnpm" ;;
            3) STACK="bun" ;;
            4) STACK="golang" ;;
            5) STACK="multi-stack" ;;
            6) STACK="generic" ;;
            *)
                print_error "Invalid choice"
                exit 1
                ;;
        esac
    fi
}

# Run the initialization
run_init() {
    print_info "Initializing project..."
    
    # Make init script executable
    chmod +x "$TEMP_DIR/ultraspec-main/init-ultraspec.sh"
    
    # Run initialization
    "$TEMP_DIR/ultraspec-main/init-ultraspec.sh" "$PROJECT_PATH" \
        --stack "$STACK" \
        --name "$PROJECT_NAME"
    
    local exit_code=$?
    
    # Cleanup
    rm -rf "$TEMP_DIR"
    
    return $exit_code
}

# Main execution
main() {
    # Check requirements
    check_requirements
    
    # Interactive setup if needed
    interactive_setup
    
    # Confirm settings
    echo ""
    print_info "Project settings:"
    echo "  Path: $PROJECT_PATH"
    echo "  Name: $PROJECT_NAME"
    echo "  Stack: $STACK"
    echo ""
    read -p "Continue with these settings? [Y/n] " confirm
    
    if [[ "$confirm" =~ ^[Nn] ]]; then
        print_info "Setup cancelled"
        exit 0
    fi
    
    # Download and run
    download_ultraspec
    
    if run_init; then
        print_success "Project initialized successfully!"
        echo ""
        print_info "Next steps:"
        echo "  1. cd $PROJECT_PATH"
        echo "  2. Review CLAUDE.md for project guidance"
        echo "  3. Run 'make help' to see available commands"
        echo "  4. In Claude Code, use /spec-create to start your first spec"
        echo ""
        print_success "Happy coding with ultraspec! 🚀"
    else
        print_error "Failed to initialize project"
        exit 1
    fi
}

# Handle errors
trap 'rm -rf "$TEMP_DIR"; exit 1' ERR INT TERM

# Run main function
main