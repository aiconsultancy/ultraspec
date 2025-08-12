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
    echo "  --stack STACK    Technology stack (see interactive menu for options)"
    echo "  --name NAME      Project name for CLAUDE.md"
    echo "  --help           Show this help message"
    echo ""
    echo "Examples:"
    echo "  $0 ~/projects/myapp                    # Interactive mode"
    echo "  $0 ~/projects/myapp --name \"My App\"    # Interactive with name"
    echo ""
    echo "Stack options include:"
    echo "  - Web Applications (Frontend + Backend)"
    echo "  - Mobile Applications (iOS, Android, React Native, Flutter)"
    echo "  - Backend APIs (.NET, Node.js, Python, Go, Rust)"
    echo "  - Frontend SPAs (React, Vue, Angular, Svelte)"
    echo "  - Desktop Applications (Electron, Tauri, .NET MAUI)"
    echo "  - Custom stacks"
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
    echo "1) Web Application - Frontend + Backend"
    echo "2) Mobile Application - iOS/Android"
    echo "3) Backend API - Single Stack"
    echo "4) Frontend SPA - Single Stack"
    echo "5) Desktop Application"
    echo "6) Other (custom stack)"
    echo "7) None (generic)"
    read -p "Enter choice (1-7): " project_type
    
    case $project_type in
        1) STACK="web-app" ;;
        2) STACK="mobile-app" ;;
        3) STACK="backend-api" ;;
        4) STACK="frontend-spa" ;;
        5) STACK="desktop-app" ;;
        6) STACK="custom" ;;
        7) STACK="generic" ;;
        *) 
            print_error "Invalid choice"
            exit 1
            ;;
    esac
fi

# Handle different project types
if [[ "$STACK" == "custom" ]]; then
    echo ""
    read -p "Describe your custom stack (e.g., 'React + FastAPI', 'SwiftUI + Firebase'): " CUSTOM_STACK_DESC
    echo ""
    echo "What type of project structure do you need?"
    echo "1) Frontend only"
    echo "2) Backend only"
    echo "3) Frontend + Backend"
    echo "4) Mobile app"
    echo "5) Mobile + Backend"
    echo "6) Generic structure"
    read -p "Enter choice (1-6): " structure_choice
    
    case $structure_choice in
        1) STACK="generic"; CUSTOM_STRUCTURE="frontend" ;;
        2) STACK="generic"; CUSTOM_STRUCTURE="backend" ;;
        3) STACK="multi-stack"; CUSTOM_STRUCTURE="fullstack" ;;
        4) STACK="generic"; CUSTOM_STRUCTURE="mobile" ;;
        5) STACK="mobile-with-backend"; CUSTOM_STRUCTURE="mobile-backend" ;;
        6) STACK="generic"; CUSTOM_STRUCTURE="generic" ;;
        *)
            print_error "Invalid structure choice"
            exit 1
            ;;
    esac
    
    IS_CUSTOM_STACK=true
    
elif [[ "$STACK" == "web-app" ]]; then
    echo ""
    echo "Select frontend stack:"
    echo "1) React + Vite"
    echo "2) React + Next.js"
    echo "3) Vue + Vite"
    echo "4) Angular"
    echo "5) Svelte + SvelteKit"
    echo "6) Other"
    read -p "Enter choice (1-6): " frontend_choice
    
    case $frontend_choice in
        1) FRONTEND_STACK="react-vite" ;;
        2) FRONTEND_STACK="nextjs" ;;
        3) FRONTEND_STACK="vue-vite" ;;
        4) FRONTEND_STACK="angular" ;;
        5) FRONTEND_STACK="sveltekit" ;;
        6) 
            read -p "Enter frontend stack name: " FRONTEND_STACK
            FRONTEND_STACK="custom-$FRONTEND_STACK"
            ;;
        *) 
            print_error "Invalid frontend choice"
            exit 1
            ;;
    esac
    
    echo ""
    echo "Select package manager for frontend:"
    echo "1) pnpm (recommended)"
    echo "2) npm"
    echo "3) yarn"
    echo "4) bun"
    read -p "Enter choice (1-4): " pm_choice
    
    case $pm_choice in
        1) FRONTEND_PM="pnpm" ;;
        2) FRONTEND_PM="npm" ;;
        3) FRONTEND_PM="yarn" ;;
        4) FRONTEND_PM="bun" ;;
        *) 
            print_error "Invalid package manager choice"
            exit 1
            ;;
    esac
    
    echo ""
    echo "Select backend stack:"
    echo "1) .NET Web API (C#)"
    echo "2) .NET with Aspire"
    echo "3) Node.js + Express + TypeScript"
    echo "4) Bun + Elysia"
    echo "5) Go + Gin/Echo"
    echo "6) Python + FastAPI"
    echo "7) Rust + Actix/Axum"
    echo "8) Other"
    read -p "Enter choice (1-8): " backend_choice
    
    case $backend_choice in
        1) BACKEND_STACK="dotnet-api" ;;
        2) BACKEND_STACK="dotnet-aspire" ;;
        3) BACKEND_STACK="node-express" ;;
        4) BACKEND_STACK="bun-elysia" ;;
        5) BACKEND_STACK="go-api" ;;
        6) BACKEND_STACK="python-fastapi" ;;
        7) BACKEND_STACK="rust-api" ;;
        8) 
            read -p "Enter backend stack name: " BACKEND_STACK
            BACKEND_STACK="custom-$BACKEND_STACK"
            ;;
        *) 
            print_error "Invalid backend choice"
            exit 1
            ;;
    esac
    
    STACK="multi-stack"  # Use existing multi-stack handling
    
elif [[ "$STACK" == "mobile-app" ]]; then
    echo ""
    echo "Select mobile platform:"
    echo "1) iOS (Swift/SwiftUI)"
    echo "2) Android (Kotlin/Jetpack Compose)"
    echo "3) Cross-platform (React Native)"
    echo "4) Cross-platform (Flutter)"
    read -p "Enter choice (1-4): " mobile_choice
    
    case $mobile_choice in
        1) 
            MOBILE_STACK="ios-swiftui"
            echo ""
            echo "Include backend API?"
            echo "1) Yes"
            echo "2) No"
            read -p "Enter choice (1-2): " backend_needed
            if [[ "$backend_needed" == "1" ]]; then
                echo ""
                echo "Select backend stack:"
                echo "1) .NET Web API"
                echo "2) Node.js + Express"
                echo "3) Python + FastAPI"
                read -p "Enter choice (1-3): " backend_choice
                case $backend_choice in
                    1) BACKEND_STACK="dotnet-api" ;;
                    2) BACKEND_STACK="node-express" ;;
                    3) BACKEND_STACK="python-fastapi" ;;
                esac
                STACK="mobile-with-backend"
            fi
            ;;
        2) 
            MOBILE_STACK="android-compose"
            echo ""
            echo "Include backend API?"
            echo "1) Yes"
            echo "2) No"
            read -p "Enter choice (1-2): " backend_needed
            if [[ "$backend_needed" == "1" ]]; then
                echo ""
                echo "Select backend stack:"
                echo "1) .NET Web API"
                echo "2) Node.js + Express"
                echo "3) Python + FastAPI"
                read -p "Enter choice (1-3): " backend_choice
                case $backend_choice in
                    1) BACKEND_STACK="dotnet-api" ;;
                    2) BACKEND_STACK="node-express" ;;
                    3) BACKEND_STACK="python-fastapi" ;;
                esac
                STACK="mobile-with-backend"
            fi
            ;;
        3) MOBILE_STACK="react-native" ;;
        4) MOBILE_STACK="flutter" ;;
        *) 
            print_error "Invalid mobile platform choice"
            exit 1
            ;;
    esac
    
elif [[ "$STACK" == "backend-api" ]]; then
    echo ""
    echo "Select backend stack:"
    echo "1) .NET Web API (C#)"
    echo "2) .NET with Aspire"
    echo "3) Node.js + Express + TypeScript"
    echo "4) Bun + Elysia"
    echo "5) Go + Gin/Echo"
    echo "6) Python + FastAPI"
    echo "7) Rust + Actix/Axum"
    read -p "Enter choice (1-7): " backend_choice
    
    case $backend_choice in
        1) STACK="dotnet" ;;
        2) STACK="dotnet-aspire" ;;
        3) STACK="node-pnpm" ;;
        4) STACK="bun" ;;
        5) STACK="golang" ;;
        6) STACK="python-fastapi" ;;
        7) STACK="rust-api" ;;
        *) 
            print_error "Invalid backend choice"
            exit 1
            ;;
    esac
    
elif [[ "$STACK" == "frontend-spa" ]]; then
    echo ""
    echo "Select frontend stack:"
    echo "1) React + Vite"
    echo "2) React + Next.js"
    echo "3) Vue + Vite"
    echo "4) Angular"
    echo "5) Svelte + SvelteKit"
    read -p "Enter choice (1-5): " frontend_choice
    
    case $frontend_choice in
        1) STACK="react-vite" ;;
        2) STACK="nextjs" ;;
        3) STACK="vue-vite" ;;
        4) STACK="angular" ;;
        5) STACK="sveltekit" ;;
        *) 
            print_error "Invalid frontend choice"
            exit 1
            ;;
    esac
    
    echo ""
    echo "Select package manager:"
    echo "1) pnpm (recommended)"
    echo "2) npm"
    echo "3) yarn"
    echo "4) bun"
    read -p "Enter choice (1-4): " pm_choice
    
    case $pm_choice in
        1) PACKAGE_MANAGER="pnpm" ;;
        2) PACKAGE_MANAGER="npm" ;;
        3) PACKAGE_MANAGER="yarn" ;;
        4) PACKAGE_MANAGER="bun" ;;
        *) 
            print_error "Invalid package manager choice"
            exit 1
            ;;
    esac
    
elif [[ "$STACK" == "desktop-app" ]]; then
    echo ""
    echo "Select desktop framework:"
    echo "1) Electron + React"
    echo "2) Tauri + React"
    echo "3) .NET MAUI"
    echo "4) Flutter Desktop"
    read -p "Enter choice (1-4): " desktop_choice
    
    case $desktop_choice in
        1) STACK="electron-react" ;;
        2) STACK="tauri-react" ;;
        3) STACK="dotnet-maui" ;;
        4) STACK="flutter-desktop" ;;
        *) 
            print_error "Invalid desktop framework choice"
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
    
    # Handle custom frontend stacks
    if [[ "$FRONTEND_STACK" == custom-* ]]; then
        cp "$SCRIPT_DIR/stacks/multi-stack/frontend/Makefile.template" "$PROJECT_PATH/frontend/Makefile"
        sed -i.bak "s/\[PACKAGE_MANAGER\]/${FRONTEND_PM:-npm}/g" "$PROJECT_PATH/frontend/Makefile"
    else
        case $FRONTEND_STACK in
            react-vite)
                cp "$SCRIPT_DIR/stacks/react-vite/Makefile" "$PROJECT_PATH/frontend/Makefile"
                sed -i.bak "s/PKG_MANAGER ?= pnpm/PKG_MANAGER ?= ${FRONTEND_PM:-pnpm}/g" "$PROJECT_PATH/frontend/Makefile"
                ;;
            nextjs)
                cp "$SCRIPT_DIR/stacks/nextjs/Makefile" "$PROJECT_PATH/frontend/Makefile" 2>/dev/null || \
                cp "$SCRIPT_DIR/stacks/multi-stack/frontend/Makefile.template" "$PROJECT_PATH/frontend/Makefile"
                sed -i.bak "s/\[PACKAGE_MANAGER\]/${FRONTEND_PM:-pnpm}/g" "$PROJECT_PATH/frontend/Makefile"
                ;;
            vue-vite)
                cp "$SCRIPT_DIR/stacks/vue-vite/Makefile" "$PROJECT_PATH/frontend/Makefile" 2>/dev/null || \
                cp "$SCRIPT_DIR/stacks/multi-stack/frontend/Makefile.template" "$PROJECT_PATH/frontend/Makefile"
                sed -i.bak "s/\[PACKAGE_MANAGER\]/${FRONTEND_PM:-pnpm}/g" "$PROJECT_PATH/frontend/Makefile"
                ;;
            angular)
                cp "$SCRIPT_DIR/stacks/angular/Makefile" "$PROJECT_PATH/frontend/Makefile" 2>/dev/null || \
                cp "$SCRIPT_DIR/stacks/multi-stack/frontend/Makefile.template" "$PROJECT_PATH/frontend/Makefile"
                sed -i.bak "s/\[PACKAGE_MANAGER\]/${FRONTEND_PM:-npm}/g" "$PROJECT_PATH/frontend/Makefile"
                ;;
            sveltekit)
                cp "$SCRIPT_DIR/stacks/sveltekit/Makefile" "$PROJECT_PATH/frontend/Makefile" 2>/dev/null || \
                cp "$SCRIPT_DIR/stacks/multi-stack/frontend/Makefile.template" "$PROJECT_PATH/frontend/Makefile"
                sed -i.bak "s/\[PACKAGE_MANAGER\]/${FRONTEND_PM:-pnpm}/g" "$PROJECT_PATH/frontend/Makefile"
                ;;
        esac
    fi
    rm -f "$PROJECT_PATH/frontend/Makefile.bak"
    
    # Set up backend
    print_info "Configuring backend ($BACKEND_STACK)..."
    
    # Handle custom backend stacks
    if [[ "$BACKEND_STACK" == custom-* ]]; then
        cp "$SCRIPT_DIR/stacks/multi-stack/backend/Makefile.template" "$PROJECT_PATH/backend/Makefile"
        print_warning "Custom backend stack selected. You'll need to configure the Makefile manually."
    else
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
        dotnet-aspire)
            cp "$SCRIPT_DIR/stacks/multi-stack/backend/Makefile.template" "$PROJECT_PATH/backend/Makefile"
            sed -i.bak 's/\[INIT_COMMAND\]/dotnet restore && dotnet workload install aspire/g' "$PROJECT_PATH/backend/Makefile"
            sed -i.bak 's/\[BUILD_COMMAND\]/dotnet build/g' "$PROJECT_PATH/backend/Makefile"
            sed -i.bak 's/\[TEST_COMMAND\]/dotnet test/g' "$PROJECT_PATH/backend/Makefile"
            sed -i.bak 's/\[FORMAT_COMMAND\]/dotnet format/g' "$PROJECT_PATH/backend/Makefile"
            sed -i.bak 's/\[LINT_COMMAND\]/dotnet build -warnaserror/g' "$PROJECT_PATH/backend/Makefile"
            sed -i.bak 's/\[CLEAN_COMMAND\]/dotnet clean && find . -type d -name bin -o -name obj | xargs rm -rf/g' "$PROJECT_PATH/backend/Makefile"
            sed -i.bak 's/\[RUN_COMMAND\]/dotnet run --project src/AppHost/g' "$PROJECT_PATH/backend/Makefile"
            sed -i.bak 's/\[DEV_COMMAND\]/dotnet watch run --project src/AppHost/g' "$PROJECT_PATH/backend/Makefile"
            sed -i.bak 's/\[TEST_UNIT_COMMAND\]/dotnet test tests/UnitTests/g' "$PROJECT_PATH/backend/Makefile"
            sed -i.bak 's/\[TEST_INTEGRATION_COMMAND\]/dotnet test tests/IntegrationTests/g' "$PROJECT_PATH/backend/Makefile"
            sed -i.bak 's/\[MIGRATE_COMMAND\]/dotnet ef database update -p src/Infrastructure -s src/Web/g' "$PROJECT_PATH/backend/Makefile"
            sed -i.bak 's/\[SEED_COMMAND\]/dotnet run --project src/DataSeeder/g' "$PROJECT_PATH/backend/Makefile"
            ;;
        python-fastapi)
            cp "$SCRIPT_DIR/stacks/multi-stack/backend/Makefile.template" "$PROJECT_PATH/backend/Makefile"
            sed -i.bak 's/\[INIT_COMMAND\]/pip install -r requirements.txt/g' "$PROJECT_PATH/backend/Makefile"
            sed -i.bak 's/\[BUILD_COMMAND\]/python -m py_compile src/**/*.py/g' "$PROJECT_PATH/backend/Makefile"
            sed -i.bak 's/\[TEST_COMMAND\]/pytest/g' "$PROJECT_PATH/backend/Makefile"
            sed -i.bak 's/\[FORMAT_COMMAND\]/black . && isort ./g' "$PROJECT_PATH/backend/Makefile"
            sed -i.bak 's/\[LINT_COMMAND\]/flake8 . && mypy ./g' "$PROJECT_PATH/backend/Makefile"
            sed -i.bak 's/\[CLEAN_COMMAND\]/find . -type d -name __pycache__ -exec rm -rf {} +/g' "$PROJECT_PATH/backend/Makefile"
            sed -i.bak 's/\[RUN_COMMAND\]/uvicorn src.main:app --reload/g' "$PROJECT_PATH/backend/Makefile"
            sed -i.bak 's/\[DEV_COMMAND\]/uvicorn src.main:app --reload --host 0.0.0.0 --port 8000/g' "$PROJECT_PATH/backend/Makefile"
            sed -i.bak 's/\[TEST_UNIT_COMMAND\]/pytest tests/unit/g' "$PROJECT_PATH/backend/Makefile"
            sed -i.bak 's/\[TEST_INTEGRATION_COMMAND\]/pytest tests/integration/g' "$PROJECT_PATH/backend/Makefile"
            sed -i.bak 's/\[MIGRATE_COMMAND\]/alembic upgrade head/g' "$PROJECT_PATH/backend/Makefile"
            sed -i.bak 's/\[SEED_COMMAND\]/python scripts/seed_db.py/g' "$PROJECT_PATH/backend/Makefile"
            ;;
        rust-api)
            cp "$SCRIPT_DIR/stacks/multi-stack/backend/Makefile.template" "$PROJECT_PATH/backend/Makefile"
            sed -i.bak 's/\[INIT_COMMAND\]/cargo fetch/g' "$PROJECT_PATH/backend/Makefile"
            sed -i.bak 's/\[BUILD_COMMAND\]/cargo build --release/g' "$PROJECT_PATH/backend/Makefile"
            sed -i.bak 's/\[TEST_COMMAND\]/cargo test/g' "$PROJECT_PATH/backend/Makefile"
            sed -i.bak 's/\[FORMAT_COMMAND\]/cargo fmt/g' "$PROJECT_PATH/backend/Makefile"
            sed -i.bak 's/\[LINT_COMMAND\]/cargo clippy -- -D warnings/g' "$PROJECT_PATH/backend/Makefile"
            sed -i.bak 's/\[CLEAN_COMMAND\]/cargo clean/g' "$PROJECT_PATH/backend/Makefile"
            sed -i.bak 's/\[RUN_COMMAND\]/cargo run --release/g' "$PROJECT_PATH/backend/Makefile"
            sed -i.bak 's/\[DEV_COMMAND\]/cargo watch -x run/g' "$PROJECT_PATH/backend/Makefile"
            sed -i.bak 's/\[TEST_UNIT_COMMAND\]/cargo test --lib/g' "$PROJECT_PATH/backend/Makefile"
            sed -i.bak 's/\[TEST_INTEGRATION_COMMAND\]/cargo test --test integration/g' "$PROJECT_PATH/backend/Makefile"
            sed -i.bak 's/\[MIGRATE_COMMAND\]/diesel migration run/g' "$PROJECT_PATH/backend/Makefile"
            sed -i.bak 's/\[SEED_COMMAND\]/cargo run --bin seed/g' "$PROJECT_PATH/backend/Makefile"
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
    fi
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

elif [[ "$STACK" == "mobile-with-backend" ]]; then
    print_info "Setting up mobile app with backend..."
    
    # Create mobile and backend directories
    mkdir -p "$PROJECT_PATH/mobile" "$PROJECT_PATH/backend"
    
    # Copy multi-stack Makefile (works for mobile+backend too)
    cp "$SCRIPT_DIR/stacks/multi-stack/Makefile" "$PROJECT_PATH/Makefile"
    sed -i.bak 's/frontend/mobile/g' "$PROJECT_PATH/Makefile"
    rm -f "$PROJECT_PATH/Makefile.bak"
    
    # Set up mobile app
    print_info "Configuring mobile app ($MOBILE_STACK)..."
    case $MOBILE_STACK in
        ios-swiftui)
            cp "$SCRIPT_DIR/stacks/ios-swiftui/Makefile" "$PROJECT_PATH/mobile/Makefile"
            ;;
        android-compose)
            cp "$SCRIPT_DIR/stacks/android-compose/Makefile" "$PROJECT_PATH/mobile/Makefile"
            ;;
        react-native)
            cp "$SCRIPT_DIR/stacks/react-native/Makefile" "$PROJECT_PATH/mobile/Makefile" 2>/dev/null || \
            cp "$SCRIPT_DIR/stacks/multi-stack/frontend/Makefile.template" "$PROJECT_PATH/mobile/Makefile"
            sed -i.bak 's/\[PACKAGE_MANAGER\]/npm/g' "$PROJECT_PATH/mobile/Makefile"
            rm -f "$PROJECT_PATH/mobile/Makefile.bak"
            ;;
        flutter)
            cp "$SCRIPT_DIR/stacks/flutter/Makefile" "$PROJECT_PATH/mobile/Makefile" 2>/dev/null || \
            cp "$SCRIPT_DIR/stacks/multi-stack/frontend/Makefile.template" "$PROJECT_PATH/mobile/Makefile"
            ;;
    esac
    
    # Set up backend (reuse existing backend setup code)
    print_info "Configuring backend ($BACKEND_STACK)..."
    case $BACKEND_STACK in
        dotnet-api)
            cp "$SCRIPT_DIR/stacks/dotnet/Makefile" "$PROJECT_PATH/backend/Makefile" 2>/dev/null || \
            cp "$SCRIPT_DIR/stacks/multi-stack/backend/Makefile.template" "$PROJECT_PATH/backend/Makefile"
            ;;
        node-express)
            cp "$SCRIPT_DIR/stacks/node-pnpm/Makefile" "$PROJECT_PATH/backend/Makefile" 2>/dev/null || \
            cp "$SCRIPT_DIR/stacks/multi-stack/backend/Makefile.template" "$PROJECT_PATH/backend/Makefile"
            ;;
        python-fastapi)
            cp "$SCRIPT_DIR/stacks/python-fastapi/Makefile" "$PROJECT_PATH/backend/Makefile"
            ;;
    esac
    
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

# Handle custom stack description
if [[ "$IS_CUSTOM_STACK" == "true" ]]; then
    print_info "Updating CLAUDE.md for custom stack..."
    sed -i.bak "s/\[PRIMARY LANGUAGE\/FRAMEWORK\]/$CUSTOM_STACK_DESC/g" "$PROJECT_PATH/CLAUDE.md"
    
    # Create appropriate project structure
    case $CUSTOM_STRUCTURE in
        frontend)
            mkdir -p "$PROJECT_PATH/src/components" "$PROJECT_PATH/src/styles" "$PROJECT_PATH/public"
            ;;
        backend)
            mkdir -p "$PROJECT_PATH/src/controllers" "$PROJECT_PATH/src/models" "$PROJECT_PATH/src/services"
            ;;
        fullstack)
            # Already handled by multi-stack setup
            ;;
        mobile)
            mkdir -p "$PROJECT_PATH/src/screens" "$PROJECT_PATH/src/components" "$PROJECT_PATH/src/services"
            ;;
        mobile-backend)
            # Already handled by mobile-with-backend setup
            ;;
        generic)
            mkdir -p "$PROJECT_PATH/src" "$PROJECT_PATH/tests"
            ;;
    esac
    rm -f "$PROJECT_PATH/CLAUDE.md.bak"
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
        dotnet|dotnet-aspire|dotnet-maui)
            cat >> "$PROJECT_PATH/.gitignore" << 'EOF'

# .NET
bin/
obj/
*.user
*.userosscache
*.sln.docstates
.vs/
*.suo
*.ntvs*
*.njsproj
*.sln.docstates
EOF
            ;;
        node-pnpm|bun|react-vite|nextjs|vue-vite|angular|sveltekit|electron-react|tauri-react)
            cat >> "$PROJECT_PATH/.gitignore" << 'EOF'

# Node/Bun
node_modules/
dist/
build/
coverage/
*.log
.pnpm-debug.log*
.npm
.yarn
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
        python-fastapi)
            cat >> "$PROJECT_PATH/.gitignore" << 'EOF'

# Python
__pycache__/
*.py[cod]
*$py.class
*.so
venv/
ENV/
.pytest_cache/
.mypy_cache/
htmlcov/
*.egg-info/
EOF
            ;;
        rust-api)
            cat >> "$PROJECT_PATH/.gitignore" << 'EOF'

# Rust
target/
Cargo.lock
**/*.rs.bk
EOF
            ;;
        ios-swiftui)
            cat >> "$PROJECT_PATH/.gitignore" << 'EOF'

# iOS/Swift
.build/
*.xcodeproj/*
!*.xcodeproj/project.pbxproj
!*.xcodeproj/xcshareddata/
*.xcworkspace/*
!*.xcworkspace/contents.xcworkspacedata
DerivedData/
*.pbxuser
*.mode1v3
*.mode2v3
*.perspectivev3
EOF
            ;;
        android-compose)
            cat >> "$PROJECT_PATH/.gitignore" << 'EOF'

# Android
*.iml
.gradle/
local.properties
.idea/
.DS_Store
build/
captures/
.externalNativeBuild
.cxx
*.apk
*.aab
*.ap_
*.dex
EOF
            ;;
        flutter|flutter-desktop)
            cat >> "$PROJECT_PATH/.gitignore" << 'EOF'

# Flutter
.dart_tool/
.flutter-plugins
.flutter-plugins-dependencies
.packages
.pub-cache/
.pub/
build/
*.iml
*.ipr
*.iws
.idea/
EOF
            ;;
        react-native)
            cat >> "$PROJECT_PATH/.gitignore" << 'EOF'

# React Native
node_modules/
ios/Pods/
android/.gradle/
android/app/build/
*.xcworkspace
*.pbxuser
*.mode1v3
*.mode2v3
*.perspectivev3
EOF
            ;;
        multi-stack|mobile-with-backend)
            cat >> "$PROJECT_PATH/.gitignore" << 'EOF'

# Multi-stack
node_modules/
dist/
build/
bin/
obj/
*.log
.vs/
venv/
__pycache__/
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