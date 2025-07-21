# Base Makefile for Ultraspec projects
# This provides common targets that can be extended per stack

.PHONY: help init build test format lint clean

# Default target - show help
help:
	@echo "Ultraspec Project Makefile"
	@echo ""
	@echo "Common targets:"
	@echo "  make init     - Initialize project dependencies"
	@echo "  make build    - Build the project"
	@echo "  make test     - Run tests"
	@echo "  make format   - Format code"
	@echo "  make lint     - Run linters"
	@echo "  make clean    - Clean build artifacts"
	@echo ""
	@echo "Spec workflow:"
	@echo "  make spec-status - Show spec status"
	@echo ""

# Initialize project
init:
	@echo "Initializing project..."
	@echo "Override this target in your Makefile"

# Build project
build:
	@echo "Building project..."
	@echo "Override this target in your Makefile"

# Run tests
test:
	@echo "Running tests..."
	@echo "Override this target in your Makefile"

# Format code
format:
	@echo "Formatting code..."
	@echo "Override this target in your Makefile"

# Run linters
lint:
	@echo "Running linters..."
	@echo "Override this target in your Makefile"

# Clean build artifacts
clean:
	@echo "Cleaning..."
	@echo "Override this target in your Makefile"

# Spec workflow helpers
spec-status:
	@echo "Checking spec status..."
	@find docs/specs -name "tasks.md" -exec sh -c 'echo "=== {} ==="; grep -E "^- \[[ x]\]" {} | wc -l | xargs -I {} sh -c "echo \"Completed: \$(grep -E \"^- \[x\]\" {} | wc -l) / \$(grep -E \"^- \[[ x]\]\" {} | wc -l)\""' \;