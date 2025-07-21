# Makefile for Go projects
# Extends the base Ultraspec Makefile

.PHONY: init build test format lint clean run dev test-coverage bench

# Go parameters
GOCMD=go
GOBUILD=$(GOCMD) build
GOTEST=$(GOCMD) test
GOGET=$(GOCMD) get
GOMOD=$(GOCMD) mod
BINARY_NAME=app
BINARY_PATH=bin/$(BINARY_NAME)

# Initialize project
init:
	@echo "Initializing Go project..."
	$(GOMOD) download
	$(GOMOD) tidy
	go install github.com/golangci/golangci-lint/cmd/golangci-lint@latest
	go install golang.org/x/tools/cmd/goimports@latest

# Build project
build:
	@echo "Building Go project..."
	$(GOBUILD) -o $(BINARY_PATH) -v ./cmd/...

# Run tests
test:
	@echo "Running tests..."
	$(GOTEST) -v ./...

# Format code
format:
	@echo "Formatting Go code..."
	gofmt -s -w .
	goimports -w .

# Run linters
lint:
	@echo "Running golangci-lint..."
	golangci-lint run

# Clean build artifacts
clean:
	@echo "Cleaning Go artifacts..."
	$(GOCMD) clean
	rm -rf bin/
	rm -f coverage.out coverage.html

# Run the application
run: build
	@echo "Starting application..."
	./$(BINARY_PATH)

# Run with hot reload (requires air)
dev:
	@echo "Starting in development mode with air..."
	@which air > /dev/null || (echo "Installing air..." && go install github.com/cosmtrek/air@latest)
	air

# Run tests with coverage
test-coverage:
	@echo "Running tests with coverage..."
	$(GOTEST) -v -coverprofile=coverage.out ./...
	$(GOCMD) tool cover -html=coverage.out -o coverage.html
	@echo "Coverage report generated: coverage.html"

# Run benchmarks
bench:
	@echo "Running benchmarks..."
	$(GOTEST) -bench=. -benchmem ./...

# Additional Go specific targets
test-race:
	@echo "Running tests with race detector..."
	$(GOTEST) -race -v ./...

mod-update:
	@echo "Updating Go modules..."
	$(GOGET) -u ./...
	$(GOMOD) tidy

mod-vendor:
	@echo "Vendoring dependencies..."
	$(GOMOD) vendor

build-all:
	@echo "Building for multiple platforms..."
	GOOS=linux GOARCH=amd64 $(GOBUILD) -o bin/$(BINARY_NAME)-linux-amd64 ./cmd/...
	GOOS=darwin GOARCH=amd64 $(GOBUILD) -o bin/$(BINARY_NAME)-darwin-amd64 ./cmd/...
	GOOS=windows GOARCH=amd64 $(GOBUILD) -o bin/$(BINARY_NAME)-windows-amd64.exe ./cmd/...

generate:
	@echo "Running go generate..."
	$(GOCMD) generate ./...

# Include base Makefile if it exists
-include ../../Makefile.base