# Android Jetpack Compose Project Makefile

# Gradle wrapper
GRADLE = ./gradlew

# Help target
.PHONY: help
help:
	@echo "Available commands:"
	@echo "  make init       - Initialize project dependencies"
	@echo "  make build      - Build the project"
	@echo "  make test       - Run tests"
	@echo "  make format     - Format code using ktfmt"
	@echo "  make lint       - Run Android Lint and Detekt"
	@echo "  make clean      - Clean build artifacts"
	@echo "  make run        - Run the app on connected device/emulator"
	@echo "  make dev        - Run in development mode with hot reload"
	@echo ""
	@echo "Android specific commands:"
	@echo "  make apk        - Build APK"
	@echo "  make bundle     - Build App Bundle"
	@echo "  make devices    - List connected devices"
	@echo "  make emulator   - Start default emulator"

# Initialize project
.PHONY: init
init:
	@echo "Initializing Android project..."
	@if [ ! -f "gradlew" ]; then \
		echo "Creating Gradle wrapper..."; \
		gradle wrapper; \
	fi
	$(GRADLE) dependencies

# Build project
.PHONY: build
build:
	@echo "Building Android project..."
	$(GRADLE) assembleDebug

# Run tests
.PHONY: test
test:
	@echo "Running tests..."
	$(GRADLE) test
	$(GRADLE) connectedAndroidTest

# Format code
.PHONY: format
format:
	@echo "Formatting Kotlin code..."
	$(GRADLE) ktfmtFormat

# Lint code
.PHONY: lint
lint:
	@echo "Linting Android code..."
	$(GRADLE) lint
	$(GRADLE) detekt

# Clean build artifacts
.PHONY: clean
clean:
	@echo "Cleaning build artifacts..."
	$(GRADLE) clean

# Run on device/emulator
.PHONY: run
run: build
	@echo "Installing and running app..."
	$(GRADLE) installDebug
	@adb shell monkey -p $(shell grep applicationId app/build.gradle.kts | cut -d'"' -f2) -c android.intent.category.LAUNCHER 1

# Development mode
.PHONY: dev
dev:
	@echo "Starting development mode..."
	$(GRADLE) installDebug --continuous &
	@echo "App installed. Use Android Studio for live development."

# Build APK
.PHONY: apk
apk:
	@echo "Building APK..."
	$(GRADLE) assembleRelease

# Build App Bundle
.PHONY: bundle
bundle:
	@echo "Building App Bundle..."
	$(GRADLE) bundleRelease

# List connected devices
.PHONY: devices
devices:
	@echo "Connected devices:"
	@adb devices

# Start emulator
.PHONY: emulator
emulator:
	@echo "Starting Android emulator..."
	@emulator -list-avds | head -1 | xargs -I {} emulator -avd {} &