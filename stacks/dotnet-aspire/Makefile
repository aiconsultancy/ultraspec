# .NET Aspire Project Makefile

# Help target
.PHONY: help
help:
	@echo "Available commands:"
	@echo "  make init       - Initialize project and install Aspire workload"
	@echo "  make build      - Build the project"
	@echo "  make test       - Run all tests"
	@echo "  make format     - Format code"
	@echo "  make lint       - Run linters"
	@echo "  make clean      - Clean build artifacts"
	@echo "  make run        - Run the AppHost"
	@echo "  make dev        - Run in watch mode"
	@echo ""
	@echo "Database commands:"
	@echo "  make migrate    - Run database migrations"
	@echo "  make seed       - Seed the database"
	@echo ""
	@echo "Aspire specific commands:"
	@echo "  make dashboard  - Open Aspire dashboard"
	@echo "  make manifest   - Generate Aspire manifest"

# Initialize project
.PHONY: init
init:
	@echo "Installing .NET Aspire workload..."
	dotnet workload update
	dotnet workload install aspire
	@echo "Restoring packages..."
	dotnet restore
	@echo "Installing Entity Framework tools..."
	dotnet tool install --global dotnet-ef || true

# Build project
.PHONY: build
build:
	@echo "Building solution..."
	dotnet build

# Run all tests
.PHONY: test
test:
	@echo "Running tests..."
	dotnet test

# Format code
.PHONY: format
format:
	@echo "Formatting code..."
	dotnet format

# Lint code
.PHONY: lint
lint:
	@echo "Running code analysis..."
	dotnet build -warnaserror

# Clean build artifacts
.PHONY: clean
clean:
	@echo "Cleaning build artifacts..."
	dotnet clean
	find . -type d -name bin -o -name obj | xargs rm -rf

# Run the AppHost
.PHONY: run
run:
	@echo "Starting Aspire AppHost..."
	dotnet run --project src/AppHost

# Development mode with watch
.PHONY: dev
dev:
	@echo "Starting in watch mode..."
	dotnet watch run --project src/AppHost

# Run unit tests
.PHONY: test-unit
test-unit:
	@echo "Running unit tests..."
	dotnet test tests/UnitTests

# Run integration tests
.PHONY: test-integration
test-integration:
	@echo "Running integration tests..."
	dotnet test tests/IntegrationTests

# Database migrations
.PHONY: migrate
migrate:
	@echo "Running database migrations..."
	dotnet ef database update -p src/Infrastructure -s src/Web

# Seed database
.PHONY: seed
seed:
	@echo "Seeding database..."
	dotnet run --project src/DataSeeder

# Open Aspire dashboard
.PHONY: dashboard
dashboard:
	@echo "Opening Aspire dashboard..."
	@open http://localhost:18888 || xdg-open http://localhost:18888 || start http://localhost:18888

# Generate Aspire manifest
.PHONY: manifest
manifest:
	@echo "Generating Aspire manifest..."
	dotnet run --project src/AppHost -- --publisher manifest --output-path ./manifest.json