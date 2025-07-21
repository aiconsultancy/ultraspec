# Makefile for Node.js + pnpm projects
# Extends the base Ultraspec Makefile

.PHONY: init build test format lint clean run dev test-watch test-coverage

# Initialize project
init:
	@echo "Initializing Node.js project..."
	pnpm install

# Build project
build:
	@echo "Building TypeScript project..."
	pnpm build

# Run tests
test:
	@echo "Running tests..."
	pnpm test

# Format code
format:
	@echo "Formatting TypeScript/JavaScript code..."
	pnpm format

# Run linters
lint:
	@echo "Running ESLint..."
	pnpm lint

# Clean build artifacts
clean:
	@echo "Cleaning Node.js artifacts..."
	rm -rf dist build coverage .turbo
	find . -name "*.tsbuildinfo" -delete

# Run the application
run: build
	@echo "Starting application..."
	pnpm start

# Run in development mode
dev:
	@echo "Starting in development mode..."
	pnpm dev

# Run tests in watch mode
test-watch:
	@echo "Running tests in watch mode..."
	pnpm test:watch

# Run tests with coverage
test-coverage:
	@echo "Running tests with coverage..."
	pnpm test:coverage

# Additional Node.js specific targets
deps-check:
	@echo "Checking for outdated dependencies..."
	pnpm outdated

deps-update:
	@echo "Updating dependencies..."
	pnpm update

deps-audit:
	@echo "Auditing dependencies for vulnerabilities..."
	pnpm audit

typecheck:
	@echo "Running TypeScript type checking..."
	pnpm typecheck

# Include base Makefile if it exists
-include ../../Makefile.base