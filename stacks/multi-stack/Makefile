# Makefile for multi-stack projects
# Manages both frontend and backend with unified commands

.PHONY: init build test format lint clean run dev help

# Default target - show help
help:
	@echo "Multi-Stack Project Makefile"
	@echo ""
	@echo "Common targets:"
	@echo "  make init     - Initialize all stacks"
	@echo "  make build    - Build all stacks"
	@echo "  make test     - Run all tests"
	@echo "  make format   - Format all code"
	@echo "  make lint     - Run all linters"
	@echo "  make clean    - Clean all artifacts"
	@echo "  make run      - Run all services"
	@echo "  make dev      - Run in development mode"
	@echo ""
	@echo "Stack-specific targets:"
	@echo "  make frontend-[target]  - Run target for frontend only"
	@echo "  make backend-[target]   - Run target for backend only"
	@echo ""
	@echo "Examples:"
	@echo "  make frontend-test      - Run frontend tests only"
	@echo "  make backend-build      - Build backend only"

# Initialize all stacks
init: frontend-init backend-init
	@echo "All stacks initialized"

# Build all stacks
build: frontend-build backend-build
	@echo "All stacks built"

# Run all tests
test: frontend-test backend-test
	@echo "All tests completed"

# Format all code
format: frontend-format backend-format
	@echo "All code formatted"

# Run all linters
lint: frontend-lint backend-lint
	@echo "All linting completed"

# Clean all artifacts
clean: frontend-clean backend-clean
	@echo "All artifacts cleaned"

# Run all services
run:
	@echo "Starting all services..."
	@$(MAKE) -j2 frontend-run backend-run

# Development mode (runs both in parallel)
dev:
	@echo "Starting development mode..."
	@$(MAKE) -j2 frontend-dev backend-dev

# Frontend targets (will be overridden by actual implementation)
frontend-init:
	@echo "Frontend init not configured. Add commands to frontend/Makefile"

frontend-build:
	@echo "Frontend build not configured"

frontend-test:
	@echo "Frontend test not configured"

frontend-format:
	@echo "Frontend format not configured"

frontend-lint:
	@echo "Frontend lint not configured"

frontend-clean:
	@echo "Frontend clean not configured"

frontend-run:
	@echo "Frontend run not configured"

frontend-dev:
	@echo "Frontend dev not configured"

# Backend targets (will be overridden by actual implementation)
backend-init:
	@echo "Backend init not configured. Add commands to backend/Makefile"

backend-build:
	@echo "Backend build not configured"

backend-test:
	@echo "Backend test not configured"

backend-format:
	@echo "Backend format not configured"

backend-lint:
	@echo "Backend lint not configured"

backend-clean:
	@echo "Backend clean not configured"

backend-run:
	@echo "Backend run not configured"

backend-dev:
	@echo "Backend dev not configured"

# Include stack-specific Makefiles if they exist
-include frontend/Makefile
-include backend/Makefile

# Additional multi-stack specific targets
services-up:
	@echo "Starting all services with docker-compose..."
	docker-compose up -d

services-down:
	@echo "Stopping all services..."
	docker-compose down

services-logs:
	@echo "Showing service logs..."
	docker-compose logs -f

test-integration:
	@echo "Running integration tests..."
	@$(MAKE) services-up
	@sleep 5  # Wait for services
	@$(MAKE) frontend-test-e2e backend-test-integration
	@$(MAKE) services-down

# Database operations (if applicable)
db-migrate:
	@echo "Running database migrations..."
	@cd backend && $(MAKE) migrate

db-seed:
	@echo "Seeding database..."
	@cd backend && $(MAKE) db-seed