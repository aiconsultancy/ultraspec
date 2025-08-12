# iOS SwiftUI Project Makefile

# Project configuration
PROJECT_NAME ?= $(shell basename `pwd`)
SCHEME ?= $(PROJECT_NAME)
CONFIGURATION ?= Debug
PLATFORM ?= iOS Simulator
DEVICE ?= iPhone 15 Pro
DERIVED_DATA_PATH ?= .build

# Xcode commands
XCODEBUILD = xcodebuild
XCRUN = xcrun

# Help target
.PHONY: help
help:
	@echo "Available commands:"
	@echo "  make init       - Initialize project dependencies"
	@echo "  make build      - Build the project"
	@echo "  make test       - Run tests"
	@echo "  make format     - Format code using SwiftFormat"
	@echo "  make lint       - Run SwiftLint"
	@echo "  make clean      - Clean build artifacts"
	@echo "  make run        - Run the app in simulator"
	@echo "  make dev        - Build and run in simulator with live reload"
	@echo ""
	@echo "iOS specific commands:"
	@echo "  make archive    - Create an archive for distribution"
	@echo "  make devices    - List available simulators"

# Initialize project
.PHONY: init
init:
	@echo "Initializing iOS project..."
	@if [ -f "Package.swift" ]; then \
		swift package resolve; \
	fi
	@if ! command -v swiftlint >/dev/null 2>&1; then \
		echo "Installing SwiftLint..."; \
		brew install swiftlint; \
	fi
	@if ! command -v swiftformat >/dev/null 2>&1; then \
		echo "Installing SwiftFormat..."; \
		brew install swiftformat; \
	fi

# Build project
.PHONY: build
build:
	@echo "Building iOS project..."
	$(XCODEBUILD) build \
		-scheme "$(SCHEME)" \
		-configuration "$(CONFIGURATION)" \
		-destination "platform=$(PLATFORM),name=$(DEVICE)" \
		-derivedDataPath "$(DERIVED_DATA_PATH)"

# Run tests
.PHONY: test
test:
	@echo "Running tests..."
	$(XCODEBUILD) test \
		-scheme "$(SCHEME)" \
		-configuration "$(CONFIGURATION)" \
		-destination "platform=$(PLATFORM),name=$(DEVICE)" \
		-derivedDataPath "$(DERIVED_DATA_PATH)"

# Format code
.PHONY: format
format:
	@echo "Formatting Swift code..."
	@if command -v swiftformat >/dev/null 2>&1; then \
		swiftformat .; \
	else \
		echo "SwiftFormat not installed. Run 'make init' first."; \
	fi

# Lint code
.PHONY: lint
lint:
	@echo "Linting Swift code..."
	@if command -v swiftlint >/dev/null 2>&1; then \
		swiftlint; \
	else \
		echo "SwiftLint not installed. Run 'make init' first."; \
	fi

# Clean build artifacts
.PHONY: clean
clean:
	@echo "Cleaning build artifacts..."
	$(XCODEBUILD) clean \
		-scheme "$(SCHEME)" \
		-configuration "$(CONFIGURATION)"
	rm -rf $(DERIVED_DATA_PATH)

# Run in simulator
.PHONY: run
run: build
	@echo "Running app in simulator..."
	$(XCRUN) simctl boot "$(DEVICE)" 2>/dev/null || true
	open -a Simulator
	$(XCRUN) simctl install "$(DEVICE)" "$(DERIVED_DATA_PATH)/Build/Products/$(CONFIGURATION)-iphonesimulator/$(PROJECT_NAME).app"
	$(XCRUN) simctl launch "$(DEVICE)" $(shell defaults read "$(DERIVED_DATA_PATH)/Build/Products/$(CONFIGURATION)-iphonesimulator/$(PROJECT_NAME).app/Info.plist" CFBundleIdentifier)

# Development mode
.PHONY: dev
dev:
	@echo "Starting development mode..."
	@make run
	@echo "App is running. Use Xcode for live development."

# Archive for distribution
.PHONY: archive
archive:
	@echo "Creating archive..."
	$(XCODEBUILD) archive \
		-scheme "$(SCHEME)" \
		-configuration Release \
		-archivePath "./build/$(PROJECT_NAME).xcarchive"

# List available simulators
.PHONY: devices
devices:
	@echo "Available simulators:"
	@$(XCRUN) simctl list devices available