# Python FastAPI Project Makefile

# Python commands
PYTHON = python3
PIP = pip3
VENV = venv

# Help target
.PHONY: help
help:
	@echo "Available commands:"
	@echo "  make init       - Initialize virtual environment and install dependencies"
	@echo "  make build      - Compile Python files"
	@echo "  make test       - Run all tests"
	@echo "  make format     - Format code with black and isort"
	@echo "  make lint       - Run linters (flake8, mypy)"
	@echo "  make clean      - Clean build artifacts"
	@echo "  make run        - Run the FastAPI server"
	@echo "  make dev        - Run in development mode with auto-reload"
	@echo ""
	@echo "Database commands:"
	@echo "  make migrate    - Run database migrations"
	@echo "  make seed       - Seed the database"
	@echo ""
	@echo "Additional commands:"
	@echo "  make docs       - Generate API documentation"
	@echo "  make requirements - Update requirements.txt"

# Initialize project
.PHONY: init
init:
	@echo "Creating virtual environment..."
	$(PYTHON) -m venv $(VENV)
	@echo "Activating virtual environment and installing dependencies..."
	. $(VENV)/bin/activate && $(PIP) install --upgrade pip
	. $(VENV)/bin/activate && $(PIP) install -r requirements.txt
	. $(VENV)/bin/activate && $(PIP) install -r requirements-dev.txt 2>/dev/null || true
	@echo "Virtual environment created. Activate with: source $(VENV)/bin/activate"

# Build/compile Python files
.PHONY: build
build:
	@echo "Compiling Python files..."
	$(PYTHON) -m py_compile src/**/*.py

# Run all tests
.PHONY: test
test:
	@echo "Running tests..."
	pytest

# Format code
.PHONY: format
format:
	@echo "Formatting code..."
	black .
	isort .

# Lint code
.PHONY: lint
lint:
	@echo "Running linters..."
	flake8 .
	mypy .

# Clean build artifacts
.PHONY: clean
clean:
	@echo "Cleaning build artifacts..."
	find . -type d -name __pycache__ -exec rm -rf {} + 2>/dev/null || true
	find . -type f -name "*.pyc" -delete
	rm -rf $(VENV)
	rm -rf .pytest_cache
	rm -rf .mypy_cache
	rm -rf htmlcov
	rm -rf dist
	rm -rf *.egg-info

# Run the server
.PHONY: run
run:
	@echo "Starting FastAPI server..."
	uvicorn src.main:app --host 0.0.0.0 --port 8000

# Development mode with auto-reload
.PHONY: dev
dev:
	@echo "Starting FastAPI in development mode..."
	uvicorn src.main:app --reload --host 0.0.0.0 --port 8000

# Run unit tests
.PHONY: test-unit
test-unit:
	@echo "Running unit tests..."
	pytest tests/unit

# Run integration tests
.PHONY: test-integration
test-integration:
	@echo "Running integration tests..."
	pytest tests/integration

# Database migrations
.PHONY: migrate
migrate:
	@echo "Running database migrations..."
	alembic upgrade head

# Seed database
.PHONY: seed
seed:
	@echo "Seeding database..."
	$(PYTHON) scripts/seed_db.py

# Generate API documentation
.PHONY: docs
docs:
	@echo "API documentation available at http://localhost:8000/docs when server is running"
	@echo "ReDoc available at http://localhost:8000/redoc"

# Update requirements.txt
.PHONY: requirements
requirements:
	@echo "Updating requirements.txt..."
	pip freeze > requirements.txt