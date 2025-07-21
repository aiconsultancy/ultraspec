#!/bin/bash

# Ultraspec initialization script
# Sets up a new project with the spec-driven workflow

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Script directory
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

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

# Function to show usage
usage() {
    echo "Usage: $0 [PROJECT_PATH] [OPTIONS]"
    echo ""
    echo "Initialize a new Ultraspec project with spec-driven workflow"
    echo ""
    echo "Options:"
    echo "  --stack STACK    Technology stack: dotnet, node-pnpm, bun, golang"
    echo "  --name NAME      Project name for CLAUDE.md"
    echo "  --help           Show this help message"
    echo ""
    echo "Example:"
    echo "  $0 ~/projects/myapp --stack node-pnpm --name \"My App\""
}

# Parse arguments
PROJECT_PATH=""
STACK=""
PROJECT_NAME=""

while [[ $# -gt 0 ]]; do
    case $1 in
        --stack)
            STACK="$2"
            shift 2
            ;;
        --name)
            PROJECT_NAME="$2"
            shift 2
            ;;
        --help)
            usage
            exit 0
            ;;
        *)
            if [[ -z "$PROJECT_PATH" ]]; then
                PROJECT_PATH="$1"
            fi
            shift
            ;;
    esac
done

# Validate arguments
if [[ -z "$PROJECT_PATH" ]]; then
    print_error "Project path is required"
    usage
    exit 1
fi

# Create project directory if it doesn't exist
if [[ ! -d "$PROJECT_PATH" ]]; then
    print_info "Creating project directory: $PROJECT_PATH"
    mkdir -p "$PROJECT_PATH"
fi

# Convert to absolute path
PROJECT_PATH=$(cd "$PROJECT_PATH" && pwd)

# Ask for stack if not provided
if [[ -z "$STACK" ]]; then
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

# For multi-stack, ask for specific stacks
if [[ "$STACK" == "multi-stack" ]]; then
    echo ""
    echo "Select frontend stack:"
    echo "1) React + Vite + pnpm"
    echo "2) React + Vite + Bun"
    echo "3) Vue + Vite + pnpm"
    echo "4) Next.js + pnpm"
    read -p "Enter choice (1-4): " frontend_choice
    
    case $frontend_choice in
        1) FRONTEND_STACK="react-vite-pnpm" ;;
        2) FRONTEND_STACK="react-vite-bun" ;;
        3) FRONTEND_STACK="vue-vite-pnpm" ;;
        4) FRONTEND_STACK="nextjs-pnpm" ;;
        *) 
            print_error "Invalid frontend choice"
            exit 1
            ;;
    esac
    
    echo ""
    echo "Select backend stack:"
    echo "1) Node.js + Express + TypeScript"
    echo "2) .NET Web API"
    echo "3) Go + Gin/Echo"
    echo "4) Bun + Elysia"
    read -p "Enter choice (1-4): " backend_choice
    
    case $backend_choice in
        1) BACKEND_STACK="node-express" ;;
        2) BACKEND_STACK="dotnet-api" ;;
        3) BACKEND_STACK="go-api" ;;
        4) BACKEND_STACK="bun-elysia" ;;
        *) 
            print_error "Invalid backend choice"
            exit 1
            ;;
    esac
fi

# Ask for project name if not provided
if [[ -z "$PROJECT_NAME" ]]; then
    read -p "Enter project name: " PROJECT_NAME
fi

print_info "Initializing Ultraspec project..."
print_info "Path: $PROJECT_PATH"
print_info "Stack: $STACK"
print_info "Name: $PROJECT_NAME"

# Copy base structure
print_info "Copying base Ultraspec structure..."
cp -r "$SCRIPT_DIR/.claude" "$PROJECT_PATH/"
cp "$SCRIPT_DIR/CLAUDE.md" "$PROJECT_PATH/"

# Create docs/specs directory
mkdir -p "$PROJECT_PATH/docs/specs"

# Handle multi-stack setup
if [[ "$STACK" == "multi-stack" ]]; then
    print_info "Setting up multi-stack project..."
    
    # Create frontend and backend directories
    mkdir -p "$PROJECT_PATH/frontend" "$PROJECT_PATH/backend"
    
    # Copy multi-stack Makefile
    cp "$SCRIPT_DIR/stacks/multi-stack/Makefile" "$PROJECT_PATH/Makefile"
    
    # Set up frontend
    print_info "Configuring frontend ($FRONTEND_STACK)..."
    case $FRONTEND_STACK in
        react-vite-pnpm|vue-vite-pnpm)
            cp "$SCRIPT_DIR/stacks/multi-stack/frontend/Makefile.template" "$PROJECT_PATH/frontend/Makefile"
            sed -i.bak 's/\[PACKAGE_MANAGER\]/pnpm/g' "$PROJECT_PATH/frontend/Makefile"
            ;;
        react-vite-bun)
            cp "$SCRIPT_DIR/stacks/multi-stack/frontend/Makefile.template" "$PROJECT_PATH/frontend/Makefile"
            sed -i.bak 's/\[PACKAGE_MANAGER\]/bun/g' "$PROJECT_PATH/frontend/Makefile"
            ;;
        nextjs-pnpm)
            cp "$SCRIPT_DIR/stacks/multi-stack/frontend/Makefile.template" "$PROJECT_PATH/frontend/Makefile"
            sed -i.bak 's/\[PACKAGE_MANAGER\]/pnpm/g' "$PROJECT_PATH/frontend/Makefile"
            sed -i.bak 's/run dev/dev/g' "$PROJECT_PATH/frontend/Makefile"
            sed -i.bak 's/run preview/start/g' "$PROJECT_PATH/frontend/Makefile"
            ;;
    esac
    rm -f "$PROJECT_PATH/frontend/Makefile.bak"
    
    # Set up backend
    print_info "Configuring backend ($BACKEND_STACK)..."
    case $BACKEND_STACK in
        node-express)
            cp "$SCRIPT_DIR/stacks/multi-stack/backend/Makefile.template" "$PROJECT_PATH/backend/Makefile"
            sed -i.bak 's/\[INIT_COMMAND\]/pnpm install/g' "$PROJECT_PATH/backend/Makefile"
            sed -i.bak 's/\[BUILD_COMMAND\]/pnpm build/g' "$PROJECT_PATH/backend/Makefile"
            sed -i.bak 's/\[TEST_COMMAND\]/pnpm test/g' "$PROJECT_PATH/backend/Makefile"
            sed -i.bak 's/\[FORMAT_COMMAND\]/pnpm format/g' "$PROJECT_PATH/backend/Makefile"
            sed -i.bak 's/\[LINT_COMMAND\]/pnpm lint/g' "$PROJECT_PATH/backend/Makefile"
            sed -i.bak 's/\[CLEAN_COMMAND\]/rm -rf dist node_modules/g' "$PROJECT_PATH/backend/Makefile"
            sed -i.bak 's/\[RUN_COMMAND\]/pnpm start/g' "$PROJECT_PATH/backend/Makefile"
            sed -i.bak 's/\[DEV_COMMAND\]/pnpm dev/g' "$PROJECT_PATH/backend/Makefile"
            sed -i.bak 's/\[TEST_UNIT_COMMAND\]/pnpm test:unit/g' "$PROJECT_PATH/backend/Makefile"
            sed -i.bak 's/\[TEST_INTEGRATION_COMMAND\]/pnpm test:integration/g' "$PROJECT_PATH/backend/Makefile"
            sed -i.bak 's/\[MIGRATE_COMMAND\]/pnpm migrate/g' "$PROJECT_PATH/backend/Makefile"
            sed -i.bak 's/\[SEED_COMMAND\]/pnpm db:seed/g' "$PROJECT_PATH/backend/Makefile"
            ;;
        dotnet-api)
            cp "$SCRIPT_DIR/stacks/multi-stack/backend/Makefile.template" "$PROJECT_PATH/backend/Makefile"
            sed -i.bak 's/\[INIT_COMMAND\]/dotnet restore/g' "$PROJECT_PATH/backend/Makefile"
            sed -i.bak 's/\[BUILD_COMMAND\]/dotnet build/g' "$PROJECT_PATH/backend/Makefile"
            sed -i.bak 's/\[TEST_COMMAND\]/dotnet test/g' "$PROJECT_PATH/backend/Makefile"
            sed -i.bak 's/\[FORMAT_COMMAND\]/dotnet format/g' "$PROJECT_PATH/backend/Makefile"
            sed -i.bak 's/\[LINT_COMMAND\]/dotnet build -warnaserror/g' "$PROJECT_PATH/backend/Makefile"
            sed -i.bak 's/\[CLEAN_COMMAND\]/dotnet clean && find . -type d -name bin -o -name obj | xargs rm -rf/g' "$PROJECT_PATH/backend/Makefile"
            sed -i.bak 's/\[RUN_COMMAND\]/dotnet run --project src/Web/g' "$PROJECT_PATH/backend/Makefile"
            sed -i.bak 's/\[DEV_COMMAND\]/dotnet watch run --project src/Web/g' "$PROJECT_PATH/backend/Makefile"
            sed -i.bak 's/\[TEST_UNIT_COMMAND\]/dotnet test tests/UnitTests/g' "$PROJECT_PATH/backend/Makefile"
            sed -i.bak 's/\[TEST_INTEGRATION_COMMAND\]/dotnet test tests/IntegrationTests/g' "$PROJECT_PATH/backend/Makefile"
            sed -i.bak 's/\[MIGRATE_COMMAND\]/dotnet ef database update -p src/Infrastructure -s src/Web/g' "$PROJECT_PATH/backend/Makefile"
            sed -i.bak 's/\[SEED_COMMAND\]/dotnet run --project src/DataSeeder/g' "$PROJECT_PATH/backend/Makefile"
            ;;
        go-api)
            cp "$SCRIPT_DIR/stacks/multi-stack/backend/Makefile.template" "$PROJECT_PATH/backend/Makefile"
            sed -i.bak 's/\[INIT_COMMAND\]/go mod download/g' "$PROJECT_PATH/backend/Makefile"
            sed -i.bak 's/\[BUILD_COMMAND\]/go build -o bin/api ./cmd/api/g' "$PROJECT_PATH/backend/Makefile"
            sed -i.bak 's/\[TEST_COMMAND\]/go test ./... -v/g' "$PROJECT_PATH/backend/Makefile"
            sed -i.bak 's/\[FORMAT_COMMAND\]/gofmt -s -w . && goimports -w ./g' "$PROJECT_PATH/backend/Makefile"
            sed -i.bak 's/\[LINT_COMMAND\]/golangci-lint run/g' "$PROJECT_PATH/backend/Makefile"
            sed -i.bak 's/\[CLEAN_COMMAND\]/go clean && rm -rf bin/g' "$PROJECT_PATH/backend/Makefile"
            sed -i.bak 's/\[RUN_COMMAND\]/.\/bin\/api/g' "$PROJECT_PATH/backend/Makefile"
            sed -i.bak 's/\[DEV_COMMAND\]/air/g' "$PROJECT_PATH/backend/Makefile"
            sed -i.bak 's/\[TEST_UNIT_COMMAND\]/go test ./internal/... -v/g' "$PROJECT_PATH/backend/Makefile"
            sed -i.bak 's/\[TEST_INTEGRATION_COMMAND\]/go test ./tests/integration/... -v/g' "$PROJECT_PATH/backend/Makefile"
            sed -i.bak 's/\[MIGRATE_COMMAND\]/migrate up/g' "$PROJECT_PATH/backend/Makefile"
            sed -i.bak 's/\[SEED_COMMAND\]/go run ./cmd/seeder/g' "$PROJECT_PATH/backend/Makefile"
            ;;
        bun-elysia)
            cp "$SCRIPT_DIR/stacks/multi-stack/backend/Makefile.template" "$PROJECT_PATH/backend/Makefile"
            sed -i.bak 's/\[INIT_COMMAND\]/bun install/g' "$PROJECT_PATH/backend/Makefile"
            sed -i.bak 's/\[BUILD_COMMAND\]/bun build ./src/index.ts --outdir ./dist --target bun/g' "$PROJECT_PATH/backend/Makefile"
            sed -i.bak 's/\[TEST_COMMAND\]/bun test/g' "$PROJECT_PATH/backend/Makefile"
            sed -i.bak 's/\[FORMAT_COMMAND\]/bunx prettier --write ./g' "$PROJECT_PATH/backend/Makefile"
            sed -i.bak 's/\[LINT_COMMAND\]/bunx eslint ./g' "$PROJECT_PATH/backend/Makefile"
            sed -i.bak 's/\[CLEAN_COMMAND\]/rm -rf dist node_modules/g' "$PROJECT_PATH/backend/Makefile"
            sed -i.bak 's/\[RUN_COMMAND\]/bun run dist/index.js/g' "$PROJECT_PATH/backend/Makefile"
            sed -i.bak 's/\[DEV_COMMAND\]/bun --watch src/index.ts/g' "$PROJECT_PATH/backend/Makefile"
            sed -i.bak 's/\[TEST_UNIT_COMMAND\]/bun test unit/g' "$PROJECT_PATH/backend/Makefile"
            sed -i.bak 's/\[TEST_INTEGRATION_COMMAND\]/bun test integration/g' "$PROJECT_PATH/backend/Makefile"
            sed -i.bak 's/\[MIGRATE_COMMAND\]/bun run migrate/g' "$PROJECT_PATH/backend/Makefile"
            sed -i.bak 's/\[SEED_COMMAND\]/bun run seed/g' "$PROJECT_PATH/backend/Makefile"
            ;;
    esac
    rm -f "$PROJECT_PATH/backend/Makefile.bak"
    
    # Use multi-stack CLAUDE.md
    cp "$SCRIPT_DIR/stacks/multi-stack/CLAUDE.md.template" "$PROJECT_PATH/CLAUDE.md"
    
    # Create docker-compose.yml template
    print_info "Creating docker-compose.yml template..."
    cat > "$PROJECT_PATH/docker-compose.yml" << 'EOF'
version: '3.8'

services:
  postgres:
    image: postgres:15-alpine
    environment:
      POSTGRES_DB: ${DB_NAME:-myapp}
      POSTGRES_USER: ${DB_USER:-postgres}
      POSTGRES_PASSWORD: ${DB_PASSWORD:-postgres}
    ports:
      - "5432:5432"
    volumes:
      - postgres_data:/var/lib/postgresql/data
    healthcheck:
      test: ["CMD-SHELL", "pg_isready -U postgres"]
      interval: 10s
      timeout: 5s
      retries: 5

  redis:
    image: redis:7-alpine
    ports:
      - "6379:6379"
    healthcheck:
      test: ["CMD", "redis-cli", "ping"]
      interval: 10s
      timeout: 5s
      retries: 5

volumes:
  postgres_data:
EOF

else
    # Single stack setup
    if [[ "$STACK" != "generic" ]] && [[ -f "$SCRIPT_DIR/stacks/$STACK/Makefile" ]]; then
        print_info "Copying $STACK Makefile..."
        cp "$SCRIPT_DIR/stacks/$STACK/Makefile" "$PROJECT_PATH/Makefile"
    else
        print_info "Copying base Makefile..."
        cp "$SCRIPT_DIR/Makefile.base" "$PROJECT_PATH/Makefile"
    fi
    
    # Copy stack-specific CLAUDE.md if available
    if [[ "$STACK" != "generic" ]] && [[ -f "$SCRIPT_DIR/stacks/$STACK/CLAUDE.md.template" ]]; then
        print_info "Merging $STACK specific configuration..."
        
        # Create a temporary file for the merged content
        TEMP_FILE=$(mktemp)
        
        # Extract the spec-driven workflow section from base CLAUDE.md
        sed -n '/## Spec-Driven Development Workflow/,$p' "$PROJECT_PATH/CLAUDE.md" > "$TEMP_FILE"
        
        # Copy stack-specific template and append workflow section
        cp "$SCRIPT_DIR/stacks/$STACK/CLAUDE.md.template" "$PROJECT_PATH/CLAUDE.md"
        echo "" >> "$PROJECT_PATH/CLAUDE.md"
        cat "$TEMP_FILE" >> "$PROJECT_PATH/CLAUDE.md"
        
        rm "$TEMP_FILE"
    fi
fi

# Update project name in CLAUDE.md
if [[ -n "$PROJECT_NAME" ]]; then
    print_info "Setting project name..."
    sed -i.bak "s/\[PROJECT DESCRIPTION - Update this section with your project details\]/# $PROJECT_NAME\n\n[PROJECT DESCRIPTION]/g" "$PROJECT_PATH/CLAUDE.md"
    sed -i.bak "s/\[PROJECT DESCRIPTION\]/$PROJECT_NAME/g" "$PROJECT_PATH/CLAUDE.md"
    rm "$PROJECT_PATH/CLAUDE.md.bak"
fi

# Make hook scripts executable
chmod +x "$PROJECT_PATH/.claude/hooks/"*.sh

# Create initial .gitignore if it doesn't exist
if [[ ! -f "$PROJECT_PATH/.gitignore" ]]; then
    print_info "Creating .gitignore..."
    cat > "$PROJECT_PATH/.gitignore" << 'EOF'
# Ultraspec
.claude/hooks/logs/

# Environment
.env
.envrc
*.local

# OS
.DS_Store
Thumbs.db

# IDE
.vscode/
.idea/
*.swp
*.swo
EOF

    # Add stack-specific gitignore entries
    case $STACK in
        dotnet)
            cat >> "$PROJECT_PATH/.gitignore" << 'EOF'

# .NET
bin/
obj/
*.user
*.userosscache
*.sln.docstates
.vs/
EOF
            ;;
        node-pnpm|bun)
            cat >> "$PROJECT_PATH/.gitignore" << 'EOF'

# Node/Bun
node_modules/
dist/
build/
coverage/
*.log
.pnpm-debug.log*
EOF
            ;;
        golang)
            cat >> "$PROJECT_PATH/.gitignore" << 'EOF'

# Go
bin/
vendor/
*.exe
*.test
*.prof
coverage.out
coverage.html
EOF
            ;;
    esac
fi

# Create example spec module
print_info "Creating example spec module..."
mkdir -p "$PROJECT_PATH/docs/specs/example-feature"

cat > "$PROJECT_PATH/docs/specs/example-feature/reqs.md" << 'EOF'
# Requirements: Example Feature

## Overview
This is an example feature to demonstrate the spec-driven workflow.

## User Stories

### Story 1: Basic Example
**As a** developer  
**I want** to see an example of the spec workflow  
**So that** I can understand how to use it

**Acceptance Criteria:**
1. **GIVEN** a new project  
   **WHEN** I run /spec-status  
   **THEN** I see this example module

## Notes
- Delete this example when you create your first real spec
- Use `/spec-create` to create new modules
EOF

print_success "Ultraspec project initialized successfully!"
echo ""
print_info "Next steps:"
echo "  1. cd $PROJECT_PATH"
echo "  2. Review CLAUDE.md for project guidance"
echo "  3. Run 'make help' to see available commands"
echo "  4. Use /spec-create to create your first spec module"
echo ""
print_info "Spec workflow commands:"
echo "  /spec-create [name]  - Create new spec module"
echo "  /spec-reqs          - Generate requirements"
echo "  /spec-design        - Create design document"
echo "  /spec-tasks         - Generate task list"
echo "  /spec-execute       - Implement tasks"
echo "  /spec-status        - Check progress"
echo "  /spec-list          - List all specs"