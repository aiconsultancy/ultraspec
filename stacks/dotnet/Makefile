# Makefile for .NET projects
# Extends the base Ultraspec Makefile

.PHONY: init build test format lint clean run watch migrate db-update

# Initialize project
init:
	@echo "Initializing .NET project..."
	dotnet restore
	dotnet tool restore

# Build project  
build:
	@echo "Building .NET project..."
	dotnet build

# Run tests
test:
	@echo "Running tests..."
	dotnet test

# Format code
format:
	@echo "Formatting C# code..."
	dotnet format

# Run linters
lint:
	@echo "Running .NET analyzers..."
	dotnet build -warnaserror

# Clean build artifacts
clean:
	@echo "Cleaning .NET artifacts..."
	dotnet clean
	find . -type d -name bin -o -name obj | xargs rm -rf

# Run the application
run:
	@echo "Starting application..."
	dotnet run --project src/Web

# Run in watch mode
watch:
	@echo "Starting in watch mode..."
	dotnet watch run --project src/Web

# Create a new migration
migrate:
	@echo "Creating migration: $(NAME)"
	@if [ -z "$(NAME)" ]; then echo "Error: NAME is required. Usage: make migrate NAME=MigrationName"; exit 1; fi
	dotnet ef migrations add $(NAME) -p src/Infrastructure -s src/Web

# Update database
db-update:
	@echo "Updating database..."
	dotnet ef database update -p src/Infrastructure -s src/Web

# Additional .NET specific targets
test-unit:
	@echo "Running unit tests..."
	dotnet test tests/UnitTests

test-integration:
	@echo "Running integration tests..."
	dotnet test tests/IntegrationTests

test-coverage:
	@echo "Running tests with coverage..."
	dotnet test /p:CollectCoverage=true /p:CoverletOutputFormat=opencover

# Include base Makefile if it exists
-include ../../Makefile.base