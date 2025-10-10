# Poseidon's Trident - Makefile
# Comprehensive targets for common development tasks

.DEFAULT_GOAL := help
.PHONY: help

# Color output
BLUE := \033[0;34m
GREEN := \033[0;32m
YELLOW := \033[0;33m
RED := \033[0;31m
NC := \033[0m # No Color

# Python configuration
PYTHON := python
VENV := venv
VENV_BIN := $(VENV)/bin
ifeq ($(OS),Windows_NT)
	VENV_BIN := $(VENV)/Scripts
	PYTHON := python
endif

# Project directories
SRC_DIR := .
TEST_DIR := tests
DOCS_DIR := docs
BUILD_DIR := build
DIST_DIR := dist

# Docker configuration
DOCKER_COMPOSE := docker-compose
DOCKER_IMAGE := poseidon-trident
DOCKER_TAG := latest

##@ Help

help: ## Display this help message
	@echo "$(BLUE)Poseidon's Trident - Makefile Targets$(NC)"
	@echo ""
	@awk 'BEGIN {FS = ":.*##"; printf "Usage:\n  make $(GREEN)<target>$(NC)\n"} /^[a-zA-Z_0-9-]+:.*?##/ { printf "  $(GREEN)%-20s$(NC) %s\n", $$1, $$2 } /^##@/ { printf "\n$(BLUE)%s$(NC)\n", substr($$0, 5) } ' $(MAKEFILE_LIST)

##@ Setup & Installation

install: ## Install project dependencies
	@echo "$(BLUE)Installing dependencies...$(NC)"
	$(PYTHON) -m pip install --upgrade pip
	$(PYTHON) -m pip install -r requirements.txt
	@echo "$(GREEN)✓ Dependencies installed successfully$(NC)"

install-dev: ## Install development dependencies
	@echo "$(BLUE)Installing development dependencies...$(NC)"
	$(PYTHON) -m pip install --upgrade pip
	$(PYTHON) -m pip install -r requirements.txt
	$(PYTHON) -m pip install pytest pytest-cov black flake8 pylint mypy pre-commit semgrep mkdocs
	@echo "$(GREEN)✓ Development dependencies installed$(NC)"

venv: ## Create virtual environment
	@echo "$(BLUE)Creating virtual environment...$(NC)"
	$(PYTHON) -m venv $(VENV)
	@echo "$(GREEN)✓ Virtual environment created$(NC)"
	@echo "$(YELLOW)Activate with: source $(VENV_BIN)/activate$(NC)"

init: venv install ## Initialize project (create venv + install deps)
	@echo "$(BLUE)Initializing project...$(NC)"
	mkdir -p logs data backups
	@echo "$(GREEN)✓ Project initialized$(NC)"

setup: init install-dev ## Complete setup for development
	@echo "$(BLUE)Setting up pre-commit hooks...$(NC)"
	$(VENV_BIN)/pre-commit install || true
	@echo "$(GREEN)✓ Development environment ready!$(NC)"

##@ Code Quality

format: ## Format code with Black
	@echo "$(BLUE)Formatting code with Black...$(NC)"
	$(PYTHON) -m black $(SRC_DIR)
	@echo "$(GREEN)✓ Code formatted$(NC)"

format-check: ## Check code formatting without making changes
	@echo "$(BLUE)Checking code formatting...$(NC)"
	$(PYTHON) -m black --check $(SRC_DIR)

lint: ## Lint code with Flake8
	@echo "$(BLUE)Linting with Flake8...$(NC)"
	$(PYTHON) -m flake8 $(SRC_DIR) --exclude=$(VENV),node_modules,__pycache__
	@echo "$(GREEN)✓ Linting passed$(NC)"

lint-pylint: ## Lint code with Pylint
	@echo "$(BLUE)Linting with Pylint...$(NC)"
	$(PYTHON) -m pylint $(SRC_DIR)/*.py --disable=C0111,C0103 || true

type-check: ## Run type checking with mypy
	@echo "$(BLUE)Running type checks...$(NC)"
	$(PYTHON) -m mypy $(SRC_DIR) --ignore-missing-imports || true

security-scan: ## Run security scan with Semgrep
	@echo "$(BLUE)Running security scan...$(NC)"
	semgrep --config .semgrep.yaml --error --quiet $(SRC_DIR) || echo "$(YELLOW)⚠ Security issues found$(NC)"

check: format-check lint type-check security-scan ## Run all code quality checks
	@echo "$(GREEN)✓ All checks passed$(NC)"

fix: format lint ## Auto-fix code issues (format + basic lint)
	@echo "$(GREEN)✓ Code fixed$(NC)"

##@ Testing

test: ## Run all tests
	@echo "$(BLUE)Running tests...$(NC)"
	$(PYTHON) -m pytest $(TEST_DIR) -v

test-fast: ## Run tests without verbose output
	@echo "$(BLUE)Running tests (fast mode)...$(NC)"
	$(PYTHON) -m pytest $(TEST_DIR)

test-cov: ## Run tests with coverage report
	@echo "$(BLUE)Running tests with coverage...$(NC)"
	$(PYTHON) -m pytest $(TEST_DIR) --cov=$(SRC_DIR) --cov-report=html --cov-report=term
	@echo "$(GREEN)✓ Coverage report generated in htmlcov/$(NC)"

test-watch: ## Run tests in watch mode
	@echo "$(BLUE)Running tests in watch mode...$(NC)"
	$(PYTHON) -m pytest $(TEST_DIR) -f

test-unit: ## Run unit tests only
	@echo "$(BLUE)Running unit tests...$(NC)"
	$(PYTHON) -m pytest $(TEST_DIR) -v -m "not integration"

test-integration: ## Run integration tests only
	@echo "$(BLUE)Running integration tests...$(NC)"
	$(PYTHON) -m pytest $(TEST_DIR) -v -m "integration"

test-encryption: ## Run encryption tests
	@echo "$(BLUE)Running encryption tests...$(NC)"
	$(PYTHON) -m pytest $(TEST_DIR)/test_encryption.py -v

test-firewall: ## Run firewall tests
	@echo "$(BLUE)Running firewall tests...$(NC)"
	$(PYTHON) -m pytest $(TEST_DIR)/test_firewall.py -v

test-threat: ## Run threat detection tests
	@echo "$(BLUE)Running threat detection tests...$(NC)"
	$(PYTHON) -m pytest $(TEST_DIR)/test_threat_detection.pytest_threat_detection.py -v

##@ Application

run: ## Run the main application (GUI)
	@echo "$(BLUE)Starting Poseidon's Trident UI...$(NC)"
	$(PYTHON) UI.py

run-web: ## Run the web application
	@echo "$(BLUE)Starting Flask web server...$(NC)"
	$(PYTHON) app.py

run-ml: ## Run ML-based threat detection
	@echo "$(BLUE)Starting threat detection engine...$(NC)"
	$(PYTHON) PoseidonsTrident_Cybersecurity.py

run-server: ## Run the secure server
	@echo "$(BLUE)Starting secure server...$(NC)"
	$(PYTHON) server.py

run-client: ## Run the secure client
	@echo "$(BLUE)Starting secure client...$(NC)"
	$(PYTHON) client.py

start: ## Start application using start.sh script
	@echo "$(BLUE)Starting application...$(NC)"
	bash start.sh

##@ Database

db-init: ## Initialize database
	@echo "$(BLUE)Initializing database...$(NC)"
	mkdir -p data
	$(PYTHON) -c "from database import Database; db = Database('sqlite:///data/poseidon.db')"
	@echo "$(GREEN)✓ Database initialized$(NC)"

db-reset: ## Reset database (WARNING: deletes all data)
	@echo "$(RED)⚠ This will delete all database data!$(NC)"
	@read -p "Are you sure? [y/N] " -n 1 -r; \
	if [[ $$REPLY =~ ^[Yy]$$ ]]; then \
		rm -f poseidon.db data/poseidon.db; \
		echo "\n$(BLUE)Recreating database...$(NC)"; \
		$(PYTHON) -c "from database import Database; db = Database('sqlite:///data/poseidon.db')"; \
		echo "$(GREEN)✓ Database reset complete$(NC)"; \
	fi

db-backup: ## Backup database
	@echo "$(BLUE)Backing up database...$(NC)"
	mkdir -p backups
	cp poseidon.db backups/poseidon_backup_$$(date +%Y%m%d_%H%M%S).db 2>/dev/null || \
	cp data/poseidon.db backups/poseidon_backup_$$(date +%Y%m%d_%H%M%S).db 2>/dev/null || \
	echo "$(YELLOW)No database found to backup$(NC)"
	@echo "$(GREEN)✓ Database backed up$(NC)"

db-restore: ## Restore database from latest backup
	@echo "$(BLUE)Restoring database from latest backup...$(NC)"
	@LATEST=$$(ls -t backups/poseidon_backup_*.db 2>/dev/null | head -1); \
	if [ -z "$$LATEST" ]; then \
		echo "$(RED)✗ No backup found$(NC)"; \
	else \
		cp $$LATEST poseidon.db; \
		echo "$(GREEN)✓ Database restored from $$LATEST$(NC)"; \
	fi

##@ Docker

docker-build: ## Build Docker image
	@echo "$(BLUE)Building Docker image...$(NC)"
	$(DOCKER_COMPOSE) build
	@echo "$(GREEN)✓ Docker image built$(NC)"

docker-up: ## Start Docker containers
	@echo "$(BLUE)Starting Docker containers...$(NC)"
	$(DOCKER_COMPOSE) up -d
	@echo "$(GREEN)✓ Containers started$(NC)"
	@echo "$(YELLOW)Access at: http://localhost:80$(NC)"

docker-down: ## Stop Docker containers
	@echo "$(BLUE)Stopping Docker containers...$(NC)"
	$(DOCKER_COMPOSE) down
	@echo "$(GREEN)✓ Containers stopped$(NC)"

docker-restart: ## Restart Docker containers
	@echo "$(BLUE)Restarting Docker containers...$(NC)"
	$(DOCKER_COMPOSE) restart
	@echo "$(GREEN)✓ Containers restarted$(NC)"

docker-logs: ## View Docker container logs
	@echo "$(BLUE)Viewing Docker logs...$(NC)"
	$(DOCKER_COMPOSE) logs -f

docker-ps: ## List running Docker containers
	@echo "$(BLUE)Running containers:$(NC)"
	$(DOCKER_COMPOSE) ps

docker-clean: ## Remove Docker containers and volumes
	@echo "$(BLUE)Cleaning Docker containers and volumes...$(NC)"
	$(DOCKER_COMPOSE) down -v
	@echo "$(GREEN)✓ Docker cleaned$(NC)"

docker-shell: ## Open shell in Docker container
	@echo "$(BLUE)Opening shell in container...$(NC)"
	$(DOCKER_COMPOSE) exec webserver /bin/bash

docker-rebuild: docker-clean docker-build docker-up ## Rebuild and restart Docker containers
	@echo "$(GREEN)✓ Docker rebuilt and started$(NC)"

##@ Frontend

frontend-install: ## Install frontend dependencies
	@echo "$(BLUE)Installing frontend dependencies...$(NC)"
	cd frontend && npm install
	@echo "$(GREEN)✓ Frontend dependencies installed$(NC)"

frontend-start: ## Start frontend development server
	@echo "$(BLUE)Starting frontend dev server...$(NC)"
	cd frontend && npm start

frontend-build: ## Build frontend for production
	@echo "$(BLUE)Building frontend...$(NC)"
	cd frontend && npm run build
	@echo "$(GREEN)✓ Frontend built$(NC)"

frontend-test: ## Run frontend tests
	@echo "$(BLUE)Running frontend tests...$(NC)"
	cd frontend && npm test

frontend-clean: ## Clean frontend build artifacts
	@echo "$(BLUE)Cleaning frontend...$(NC)"
	rm -rf frontend/node_modules frontend/build
	@echo "$(GREEN)✓ Frontend cleaned$(NC)"

##@ AWS / Cloud Deployment

terraform-init: ## Initialize Terraform
	@echo "$(BLUE)Initializing Terraform...$(NC)"
	terraform init
	@echo "$(GREEN)✓ Terraform initialized$(NC)"

terraform-plan: ## Show Terraform deployment plan
	@echo "$(BLUE)Running Terraform plan...$(NC)"
	terraform plan

terraform-validate: ## Validate Terraform configuration
	@echo "$(BLUE)Validating Terraform configuration...$(NC)"
	terraform validate
	@echo "$(GREEN)✓ Terraform configuration valid$(NC)"

terraform-apply: ## Deploy infrastructure with Terraform
	@echo "$(BLUE)Deploying infrastructure...$(NC)"
	terraform apply
	@echo "$(GREEN)✓ Infrastructure deployed$(NC)"

terraform-destroy: ## Destroy infrastructure
	@echo "$(RED)⚠ This will destroy all infrastructure!$(NC)"
	terraform destroy

lambda-deploy: ## Deploy Lambda functions
	@echo "$(BLUE)Deploying Lambda functions...$(NC)"
	zip -r lambda.zip lambda_function.py
	zip -r guardduty.zip guardduty_handler.py
	@echo "$(GREEN)✓ Lambda packages created$(NC)"
	@echo "$(YELLOW)Run 'aws lambda create-function' to deploy$(NC)"

aws-status: ## Check AWS resources status
	@echo "$(BLUE)Checking AWS resources...$(NC)"
	@aws ec2 describe-instances --filters "Name=tag:Name,Values=Poseidon-Trident-Instance" || echo "No EC2 instances found"
	@aws s3 ls | grep poseidon-trident || echo "No S3 buckets found"
	@aws lambda list-functions | grep poseidon || echo "No Lambda functions found"

##@ Documentation

docs: ## Generate documentation
	@echo "$(BLUE)Generating documentation...$(NC)"
	mkdocs build
	@echo "$(GREEN)✓ Documentation generated$(NC)"

docs-serve: ## Serve documentation locally
	@echo "$(BLUE)Starting documentation server...$(NC)"
	@echo "$(YELLOW)Visit: http://localhost:8000$(NC)"
	mkdocs serve

docs-deploy: ## Deploy documentation to GitHub Pages
	@echo "$(BLUE)Deploying documentation...$(NC)"
	mkdocs gh-deploy --force
	@echo "$(GREEN)✓ Documentation deployed$(NC)"

##@ Maintenance & Cleanup

clean: ## Clean build artifacts and cache
	@echo "$(BLUE)Cleaning build artifacts...$(NC)"
	find . -type d -name "__pycache__" -exec rm -rf {} + 2>/dev/null || true
	find . -type f -name "*.pyc" -delete 2>/dev/null || true
	find . -type f -name "*.pyo" -delete 2>/dev/null || true
	find . -type d -name "*.egg-info" -exec rm -rf {} + 2>/dev/null || true
	find . -type d -name ".pytest_cache" -exec rm -rf {} + 2>/dev/null || true
	find . -type d -name ".mypy_cache" -exec rm -rf {} + 2>/dev/null || true
	rm -rf $(BUILD_DIR) $(DIST_DIR) htmlcov .coverage
	@echo "$(GREEN)✓ Cleaned$(NC)"

clean-all: clean frontend-clean docker-clean ## Clean everything (build, frontend, docker)
	@echo "$(GREEN)✓ Everything cleaned$(NC)"

clean-logs: ## Clean log files
	@echo "$(BLUE)Cleaning logs...$(NC)"
	rm -f logs/*.log security.log user_activity.log
	@echo "$(GREEN)✓ Logs cleaned$(NC)"

clean-backups: ## Clean old backups (keeps last 7 days)
	@echo "$(BLUE)Cleaning old backups...$(NC)"
	find backups -type f -name "*.db" -mtime +7 -delete 2>/dev/null || true
	find backups -type f -name "*.tar.gz" -mtime +7 -delete 2>/dev/null || true
	@echo "$(GREEN)✓ Old backups cleaned$(NC)"

reset: clean-all db-reset ## Reset entire project (WARNING: deletes data)
	@echo "$(GREEN)✓ Project reset complete$(NC)"

##@ Utilities

logs: ## View application logs
	@echo "$(BLUE)Viewing logs...$(NC)"
	tail -f logs/poseidon.log security.log user_activity.log 2>/dev/null || echo "No logs found"

logs-security: ## View security logs
	@tail -f security.log

logs-activity: ## View user activity logs
	@tail -f user_activity.log

version: ## Show version information
	@echo "$(BLUE)Poseidon's Trident$(NC)"
	@echo "Python version: $$($(PYTHON) --version)"
	@echo "Pip version: $$($(PYTHON) -m pip --version)"
	@echo "Docker version: $$(docker --version 2>/dev/null || echo 'Not installed')"
	@echo "Docker Compose version: $$($(DOCKER_COMPOSE) --version 2>/dev/null || echo 'Not installed')"
	@echo "Node version: $$(node --version 2>/dev/null || echo 'Not installed')"
	@echo "npm version: $$(npm --version 2>/dev/null || echo 'Not installed')"

deps: ## Show installed dependencies
	@echo "$(BLUE)Installed Python packages:$(NC)"
	$(PYTHON) -m pip list

check-deps: ## Check for outdated dependencies
	@echo "$(BLUE)Checking for outdated dependencies...$(NC)"
	$(PYTHON) -m pip list --outdated

update-deps: ## Update dependencies (use with caution)
	@echo "$(BLUE)Updating dependencies...$(NC)"
	$(PYTHON) -m pip install --upgrade -r requirements.txt
	@echo "$(GREEN)✓ Dependencies updated$(NC)"

##@ CI/CD

ci: check test ## Run CI pipeline (checks + tests)
	@echo "$(GREEN)✓ CI pipeline passed$(NC)"

pre-commit: format lint test-fast ## Run pre-commit checks
	@echo "$(GREEN)✓ Pre-commit checks passed$(NC)"

validate: check test-cov security-scan ## Validate codebase (full validation)
	@echo "$(GREEN)✓ Validation complete$(NC)"

##@ Quick Commands

dev: install-dev run ## Setup dev environment and run app
	@echo "$(GREEN)✓ Development mode$(NC)"

quick-start: docker-up ## Quick start with Docker
	@echo "$(GREEN)✓ Quick start complete$(NC)"

quick-test: format-check test-fast ## Quick test (format check + fast tests)
	@echo "$(GREEN)✓ Quick test complete$(NC)"

##@ Information

info: ## Display project information
	@echo "$(BLUE)╔════════════════════════════════════════════╗$(NC)"
	@echo "$(BLUE)║      Poseidon's Trident 🔱                 ║$(NC)"
	@echo "$(BLUE)║      Cybersecurity Framework               ║$(NC)"
	@echo "$(BLUE)╚════════════════════════════════════════════╝$(NC)"
	@echo ""
	@echo "$(GREEN)Project Directory:$(NC) $(shell pwd)"
	@echo "$(GREEN)Python:$(NC) $$($(PYTHON) --version 2>&1)"
	@echo "$(GREEN)Virtual Env:$(NC) $(VENV)"
	@echo ""
	@echo "$(YELLOW)Quick Commands:$(NC)"
	@echo "  make install      - Install dependencies"
	@echo "  make run          - Run GUI application"
	@echo "  make test         - Run tests"
	@echo "  make docker-up    - Start with Docker"
	@echo "  make help         - Show all commands"
	@echo ""

status: ## Show project status
	@echo "$(BLUE)Project Status:$(NC)"
	@echo ""
	@echo "$(YELLOW)Files:$(NC)"
	@echo "  Python files: $$(find . -name '*.py' ! -path './$(VENV)/*' ! -path './node_modules/*' | wc -l)"
	@echo "  Test files: $$(find $(TEST_DIR) -name '*.py' 2>/dev/null | wc -l)"
	@echo "  Total lines: $$(find . -name '*.py' ! -path './$(VENV)/*' ! -path './node_modules/*' -exec wc -l {} + 2>/dev/null | tail -1 | awk '{print $$1}')"
	@echo ""
	@echo "$(YELLOW)Docker:$(NC)"
	@$(DOCKER_COMPOSE) ps 2>/dev/null || echo "  No containers running"
	@echo ""
	@echo "$(YELLOW)Git:$(NC)"
	@echo "  Branch: $$(git branch --show-current 2>/dev/null || echo 'Not a git repo')"
	@echo "  Last commit: $$(git log -1 --oneline 2>/dev/null || echo 'No commits')"
