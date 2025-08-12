# React + Vite Project Makefile

# Package manager (can be overridden)
PKG_MANAGER ?= pnpm

# Help target
.PHONY: help
help:
	@echo "Available commands:"
	@echo "  make init       - Initialize project dependencies"
	@echo "  make build      - Build for production"
	@echo "  make test       - Run tests"
	@echo "  make format     - Format code with Prettier"
	@echo "  make lint       - Run ESLint"
	@echo "  make clean      - Clean build artifacts"
	@echo "  make run        - Run production build"
	@echo "  make dev        - Run development server"
	@echo ""
	@echo "Additional commands:"
	@echo "  make preview    - Preview production build"
	@echo "  make typecheck  - Run TypeScript type checking"
	@echo "  make analyze    - Analyze bundle size"

# Initialize project
.PHONY: init
init:
	@echo "Installing dependencies with $(PKG_MANAGER)..."
	$(PKG_MANAGER) install

# Build for production
.PHONY: build
build:
	@echo "Building for production..."
	$(PKG_MANAGER) run build

# Run tests
.PHONY: test
test:
	@echo "Running tests..."
	$(PKG_MANAGER) run test

# Format code
.PHONY: format
format:
	@echo "Formatting code..."
	$(PKG_MANAGER) run format

# Lint code
.PHONY: lint
lint:
	@echo "Linting code..."
	$(PKG_MANAGER) run lint

# Clean build artifacts
.PHONY: clean
clean:
	@echo "Cleaning build artifacts..."
	rm -rf dist
	rm -rf node_modules
	rm -rf coverage

# Run production build
.PHONY: run
run: build
	@echo "Serving production build..."
	$(PKG_MANAGER) run preview

# Development server
.PHONY: dev
dev:
	@echo "Starting development server..."
	$(PKG_MANAGER) run dev

# Preview production build
.PHONY: preview
preview: build
	@echo "Previewing production build..."
	$(PKG_MANAGER) run preview

# TypeScript type checking
.PHONY: typecheck
typecheck:
	@echo "Running TypeScript type checking..."
	$(PKG_MANAGER) run typecheck

# Analyze bundle size
.PHONY: analyze
analyze:
	@echo "Analyzing bundle size..."
	$(PKG_MANAGER) run build -- --analyze