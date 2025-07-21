# Makefile for Bun projects
# Extends the base Ultraspec Makefile

.PHONY: init build test format lint clean run dev test-watch

# Initialize project
init:
	@echo "Initializing Bun project..."
	bun install

# Build project
build:
	@echo "Building TypeScript project with Bun..."
	bun build ./src/index.ts --outdir ./dist --target bun

# Run tests
test:
	@echo "Running tests with Bun..."
	bun test

# Format code
format:
	@echo "Formatting TypeScript/JavaScript code..."
	bunx prettier --write "**/*.{js,jsx,ts,tsx,json,md}"

# Run linters
lint:
	@echo "Running ESLint..."
	bunx eslint . --ext .js,.jsx,.ts,.tsx

# Clean build artifacts
clean:
	@echo "Cleaning Bun artifacts..."
	rm -rf dist build coverage node_modules bun.lockb

# Run the application
run:
	@echo "Starting application with Bun..."
	bun run src/index.ts

# Run in development mode
dev:
	@echo "Starting in development mode with watch..."
	bun --watch src/index.ts

# Run tests in watch mode
test-watch:
	@echo "Running tests in watch mode..."
	bun test --watch

# Additional Bun specific targets
typecheck:
	@echo "Running TypeScript type checking..."
	bunx tsc --noEmit

deps-update:
	@echo "Updating dependencies..."
	bun update

bundle:
	@echo "Creating production bundle..."
	bun build ./src/index.ts --outdir ./dist --target bun --minify

bench:
	@echo "Running benchmarks..."
	bun run bench

# Include base Makefile if it exists
-include ../../Makefile.base