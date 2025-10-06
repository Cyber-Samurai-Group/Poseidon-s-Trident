# Poseidon's Trident 🔱

**Poseidon's Trident** is a comprehensive cybersecurity framework built around three core principles - threat detection, protection, and response. Harness the power of the sea god's trident to secure your network and cloud infrastructure.

[![CI](https://github.com/Cyber-Samurai-Group/Poseidon-s-Trident/workflows/CI/badge.svg)](https://github.com/Cyber-Samurai-Group/Poseidon-s-Trident/actions)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

---

## Table of Contents

- [Overview](#overview)
- [Features](#features)
- [Quick Start (5 Minutes)](#quick-start-5-minutes)
- [Prerequisites](#prerequisites)
- [Installation Methods](#installation-methods)
  - [Docker Compose Setup (Recommended)](#docker-compose-setup-recommended)
  - [Local Python Setup](#local-python-setup)
  - [Frontend Setup](#frontend-setup)
- [Configuration](#configuration)
- [Usage](#usage)
- [AWS/Cloud Deployment](#awscloud-deployment)
- [Troubleshooting](#troubleshooting)
- [Contributing](#contributing)
- [License](#license)

---

## Overview

Poseidon's Trident provides a unified cybersecurity platform with:

🔍 **Threat Detection** - Identify security threats using ML-based analysis, intrusion detection, and vulnerability scanning
🛡️ **Protection** - Secure systems with encryption, firewalls, DLP, and authentication
🚨 **Response** - Handle incidents with automated responses, logging, and alerts

**Technology Stack:**
- **Backend:** Python 3.8+, Flask, scikit-learn, boto3
- **Frontend:** React 17, TypeScript, Tailwind CSS
- **Database:** SQLAlchemy (SQLite/MySQL/PostgreSQL)
- **Cloud:** AWS (Lambda, GuardDuty, EC2, S3, RDS)
- **Infrastructure:** Docker, Terraform, Jenkins

---

## Features

### Core Security Capabilities

- **Threat Intelligence** - Real-time threat indicator management
- **Intrusion Detection System (IDS)** - Rule-based network monitoring
- **Vulnerability Assessment** - Automated scanning with Nmap integration
- **Advanced Threat Detection** - ML-based anomaly detection using Random Forest
- **End-to-End Encryption** - Fernet-based data protection
- **Firewall Management** - Dynamic rule configuration
- **Data Loss Prevention (DLP)** - Sensitive data protection
- **Incident Response** - Multi-level severity handling (low/medium/high/critical)
- **API Security** - OAuth2 + JWT authentication

### User Interfaces

- **Desktop GUI** (Tkinter) - Full-featured security dashboard with dark mode
- **Web Interface** (React) - Modern responsive UI
- **REST API** - Programmatic access via Flask

### Enterprise Features

- **Role-Based Access Control (RBAC)** - Admin and user roles
- **Two-Factor Authentication (2FA)** - Enhanced login security
- **Real-Time Logging** - Security event tracking and audit trails
- **Email Notifications** - Automated security alerts
- **Session Management** - Automatic timeout after inactivity
- **CloudWatch Integration** - AWS monitoring and alerting

---

## Quick Start (5 Minutes)

Get Poseidon's Trident running in under 5 minutes using Docker Compose:

```bash
# 1. Clone the repository
git clone https://github.com/Cyber-Samurai-Group/Poseidon-s-Trident.git
cd Poseidon-s-Trident

# 2. Start with Docker Compose
docker-compose up -d

# 3. Access the application
# Web UI: http://localhost:80
# Default credentials: admin / password
```

That's it! The application is now running. Continue reading for detailed setup options.

---

## Prerequisites

Before installation, ensure you have the following installed:

### Required

| Tool | Minimum Version | Check Command |
|------|----------------|---------------|
| **Python** | 3.8+ | `python --version` |
| **pip** | 20.0+ | `pip --version` |
| **Git** | 2.20+ | `git --version` |

### Optional (Based on Setup Method)

| Tool | Purpose | Minimum Version | Check Command |
|------|---------|----------------|---------------|
| **Docker** | Containerized deployment | 20.10+ | `docker --version` |
| **Docker Compose** | Multi-container orchestration | 1.29+ | `docker-compose --version` |
| **Node.js** | Frontend development | 14.0+ | `node --version` |
| **npm** | Frontend package management | 6.14+ | `npm --version` |
| **Terraform** | Infrastructure as Code | 1.0+ | `terraform --version` |
| **AWS CLI** | Cloud deployment | 2.0+ | `aws --version` |

### System Requirements

- **OS:** Windows 10+, macOS 10.14+, or Linux (Ubuntu 18.04+)
- **RAM:** 4GB minimum, 8GB recommended
- **Disk Space:** 2GB free space

---

## Installation Methods

### Docker Compose Setup (Recommended)

**⏱️ Setup Time: 5-10 minutes**

Docker Compose is the fastest way to get started. It handles all dependencies automatically.

#### Step 1: Install Docker and Docker Compose

**On Windows:**
1. Download [Docker Desktop for Windows](https://www.docker.com/products/docker-desktop)
2. Run the installer and restart your computer
3. Verify installation: `docker --version && docker-compose --version`

**On macOS:**
1. Download [Docker Desktop for Mac](https://www.docker.com/products/docker-desktop)
2. Drag Docker to Applications folder
3. Launch Docker from Applications
4. Verify: `docker --version && docker-compose --version`

**On Linux (Ubuntu/Debian):**
```bash
# Install Docker
sudo apt-get update
sudo apt-get install docker.io docker-compose -y

# Add your user to docker group (avoid sudo)
sudo usermod -aG docker $USER
newgrp docker

# Verify installation
docker --version && docker-compose --version
```

#### Step 2: Clone the Repository

```bash
git clone https://github.com/Cyber-Samurai-Group/Poseidon-s-Trident.git
cd Poseidon-s-Trident
```

#### Step 3: Configure Environment (Optional)

Create a `.env` file for custom configuration:

```bash
# Create .env file
cat > .env << EOF
SECRET_KEY=your-secret-key-here
DATABASE_URL=sqlite:///poseidon.db
LOG_LEVEL=INFO
AWS_REGION=us-west-2
EOF
```

#### Step 4: Build and Start Services

```bash
# Build the Docker images
docker-compose build

# Start all services in detached mode
docker-compose up -d

# View logs (optional)
docker-compose logs -f
```

#### Step 5: Verify Installation

```bash
# Check running containers
docker-compose ps

# Expected output:
# NAME                COMMAND             STATUS              PORTS
# webserver           "python main.py"    Up 10 seconds       0.0.0.0:80->80/tcp

# Test the web interface
curl http://localhost:80/health
# Expected: {"status": "healthy"}
```

#### Step 6: Access the Application

Open your browser and navigate to:
- **Web UI:** http://localhost:80
- **Default Credentials:**
  - Username: `admin`
  - Password: `password`

#### Docker Compose Management

```bash
# Stop all services
docker-compose down

# Stop and remove volumes (clean slate)
docker-compose down -v

# Restart services
docker-compose restart

# View logs
docker-compose logs -f webserver

# Update to latest code
git pull
docker-compose up -d --build
```

---

### Local Python Setup

**⏱️ Setup Time: 10-15 minutes**

For development or if you prefer running without Docker:

#### Step 1: Clone Repository

```bash
git clone https://github.com/Cyber-Samurai-Group/Poseidon-s-Trident.git
cd Poseidon-s-Trident
```

#### Step 2: Create Virtual Environment

**On Windows:**
```bash
python -m venv venv
venv\Scripts\activate
```

**On macOS/Linux:**
```bash
python3 -m venv venv
source venv/bin/activate
```

You should see `(venv)` in your terminal prompt.

#### Step 3: Install Dependencies

```bash
# Upgrade pip
pip install --upgrade pip

# Install required packages
pip install -r requirements.txt

# Verify installation
pip list
```

#### Step 4: Initialize Database

```bash
# Create necessary directories
mkdir -p logs data backups

# Initialize database (if using SQLite)
python -c "from database import Database; db = Database('sqlite:///poseidon.db')"
```

#### Step 5: Run the Application

**Option A: Desktop GUI (Recommended for first-time users)**
```bash
python UI.py
```
This launches the Tkinter-based security dashboard.

**Option B: Main ML-based threat detection**
```bash
python PoseidonsTrident_Cybersecurity.py
```

**Option C: Flask Web Server**
```bash
python app.py
# Access at http://localhost:5000
```

**Option D: Using the startup script**
```bash
# On Unix/Linux/macOS
chmod +x start.sh
./start.sh

# On Windows (use Git Bash or WSL)
bash start.sh
```

---

### Frontend Setup

**⏱️ Setup Time: 5-10 minutes**

Set up the React-based web interface for development:

#### Option 1: Main Frontend

```bash
cd frontend

# Install dependencies
npm install

# Start development server
npm start
# Opens at http://localhost:3000

# Build for production
npm run build
```

#### Option 2: Modern Frontend (TypeScript Components)

```bash
cd my-react-frontend

# Install dependencies
npm install

# Start development server
npm start
# Opens at http://localhost:3000
```

#### Connecting Frontend to Backend

The frontend expects the Flask backend to run on `http://localhost:5000`. Update `frontend/src/config.js` if needed:

```javascript
export const API_BASE_URL = process.env.REACT_APP_API_URL || 'http://localhost:5000';
```

---

## Configuration

### Environment Variables

Create a `.env` file in the project root:

```bash
# Application Settings
SECRET_KEY=your-secret-key-change-this-in-production
DEBUG=False
LOG_LEVEL=INFO

# Database Configuration
DATABASE_URL=sqlite:///poseidon.db
# Or use MySQL: mysql://username:password@localhost:3306/poseidon
# Or PostgreSQL: postgresql://username:password@localhost:5432/poseidon

# AWS Configuration (optional)
AWS_ACCESS_KEY_ID=your-access-key
AWS_SECRET_ACCESS_KEY=your-secret-key
AWS_DEFAULT_REGION=us-west-2

# Email Settings (for notifications)
SMTP_HOST=smtp.gmail.com
SMTP_PORT=587
SMTP_USER=your-email@gmail.com
SMTP_PASSWORD=your-app-password

# Security Settings
SESSION_TIMEOUT=300
PASSWORD_MIN_LENGTH=8
ENABLE_2FA=True
```

### Configuration Files

**`logging_config.yaml`** - Logging configuration
```yaml
version: 1
formatters:
  standard:
    format: "%(asctime)s [%(levelname)s] %(name)s: %(message)s"
handlers:
  console:
    class: logging.StreamHandler
    level: INFO
  file:
    class: logging.handlers.RotatingFileHandler
    filename: logs/poseidon.log
    maxBytes: 1048576
    backupCount: 3
```

**`config.json`** - Application configuration (created by config_manager.py)
```json
{
  "security_level": "high",
  "firewall_enabled": true,
  "encryption": "AES256",
  "threat_intelligence_feeds": [
    "https://example.com/threat-feed"
  ]
}
```

---

## Usage

### Desktop GUI Application

1. **Launch the application:**
   ```bash
   python UI.py
   ```

2. **Login with default credentials:**
   - Username: `admin`
   - Password: `password`

3. **Available Features:**
   - **Firewall Management** - Add/remove firewall rules
   - **Intrusion Detection** - Monitor for suspicious activity
   - **Real-Time Logs** - View security events
   - **User Management** - Create accounts, assign roles
   - **Password Management** - Change passwords, 2FA setup
   - **Activity Dashboard** - View user activity logs

### Command-Line Interface

Run specific security operations:

```bash
# Threat detection on target
python PoseidonsTrident_Cybersecurity.py --mode threat_detection --target 192.168.1.1

# Vulnerability assessment
python vulnerability_assessment.py

# Start intrusion detection
python ids.py --config ids_config.yaml

# Run encryption test
python encryption.py
```

### Web API

Start the Flask server:
```bash
python app.py
```

**API Endpoints:**

```bash
# Login
curl -X POST http://localhost:5000/api/login \
  -H "Content-Type: application/json" \
  -d '{"username":"admin","password":"password"}'

# Register new user
curl -X POST http://localhost:5000/api/register \
  -H "Content-Type: application/json" \
  -d '{"username":"newuser","password":"securepass123"}'
```

### Running Tests

```bash
# Run all tests
pytest

# Run with coverage report
pytest --cov=. --cov-report=html

# Run specific test file
pytest tests/test_encryption.py

# Run with verbose output
pytest -v
```

### Code Quality Checks

```bash
# Format code with Black
make format
# or
black .

# Lint with Flake8
make lint
# or
flake8 .

# Security scan with Semgrep
semgrep --config .semgrep.yaml --error --quiet
```

---

## AWS/Cloud Deployment

### Prerequisites

1. **AWS Account** with appropriate permissions
2. **AWS CLI configured:**
   ```bash
   aws configure
   # Enter: Access Key ID, Secret Access Key, Region, Output format
   ```
3. **Terraform installed** (version 1.0+)

### Step-by-Step Deployment

#### 1. Configure Terraform Variables

Create `terraform.tfvars`:
```hcl
region = "us-west-2"
instance_type = "t2.micro"
aws_access_key = "YOUR_ACCESS_KEY"
aws_secret_key = "YOUR_SECRET_KEY"
```

#### 2. Initialize Terraform

```bash
terraform init
```

#### 3. Review Deployment Plan

```bash
terraform plan
```

This shows what resources will be created:
- EC2 instance (t2.micro)
- S3 buckets (data + logs)
- RDS MySQL database
- Security groups
- IAM roles
- CloudWatch alarms
- SNS topics

#### 4. Deploy Infrastructure

```bash
terraform apply
# Type 'yes' when prompted
```

#### 5. Deploy Lambda Functions

```bash
# Package Lambda function
zip -r lambda.zip lambda_function.py

# Deploy to AWS
aws lambda create-function \
  --function-name poseidon-trident-security \
  --runtime python3.9 \
  --role arn:aws:iam::YOUR_ACCOUNT_ID:role/lambda-execution-role \
  --handler lambda_function.lambda_handler \
  --zip-file fileb://lambda.zip

# Deploy GuardDuty handler
zip -r guardduty.zip guardduty_handler.py
aws lambda create-function \
  --function-name poseidon-guardduty-handler \
  --runtime python3.9 \
  --role arn:aws:iam::YOUR_ACCOUNT_ID:role/lambda-execution-role \
  --handler guardduty_handler.lambda_handler \
  --zip-file fileb://guardduty.zip
```

#### 6. Verify Deployment

```bash
# Check EC2 instance
aws ec2 describe-instances --filters "Name=tag:Name,Values=Poseidon-Trident-Instance"

# Check S3 buckets
aws s3 ls | grep poseidon-trident

# Check Lambda functions
aws lambda list-functions | grep poseidon
```

#### 7. Clean Up Resources (when done)

```bash
terraform destroy
# Type 'yes' when prompted
```

---

## Troubleshooting

### Common Issues and Solutions

#### 1. Docker Issues

**Problem:** `docker-compose: command not found`

**Solutions:**
```bash
# On Linux, install docker-compose
sudo apt-get install docker-compose

# On Mac/Windows, ensure Docker Desktop is running
# Check: docker --version && docker-compose --version
```

**Problem:** `Permission denied while trying to connect to Docker daemon`

**Solutions:**
```bash
# Add user to docker group (Linux)
sudo usermod -aG docker $USER
newgrp docker

# Restart Docker service
sudo systemctl restart docker
```

**Problem:** Port 80 already in use

**Solutions:**
```bash
# Find process using port 80
# Windows:
netstat -ano | findstr :80

# Mac/Linux:
lsof -i :80

# Kill the process or change port in docker-compose.yml:
# ports:
#   - "8080:80"
```

---

#### 2. Python/Installation Issues

**Problem:** `ModuleNotFoundError: No module named 'X'`

**Solutions:**
```bash
# Ensure virtual environment is activated
source venv/bin/activate  # Mac/Linux
venv\Scripts\activate     # Windows

# Reinstall dependencies
pip install -r requirements.txt

# If specific module missing:
pip install <module-name>
```

**Problem:** `python: command not found`

**Solutions:**
```bash
# Try python3 instead
python3 --version

# On Windows, ensure Python is in PATH
# Add to PATH: C:\Python39\;C:\Python39\Scripts\

# Verify:
python --version
```

**Problem:** Virtual environment activation fails

**Solutions:**
```bash
# Windows PowerShell - execution policy error
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser

# Then activate:
venv\Scripts\Activate.ps1

# Alternative: Use Command Prompt instead
venv\Scripts\activate.bat
```

---

#### 3. Database Issues

**Problem:** Database connection errors

**Solutions:**
```bash
# For SQLite, ensure directory exists
mkdir -p data/

# Check DATABASE_URL in .env
DATABASE_URL=sqlite:///data/poseidon.db

# For MySQL/PostgreSQL, verify service is running
# MySQL:
sudo systemctl status mysql

# PostgreSQL:
sudo systemctl status postgresql
```

**Problem:** SQLAlchemy migration errors

**Solutions:**
```bash
# Reset database (WARNING: deletes all data)
rm poseidon.db

# Recreate tables
python -c "from database import Database; Database('sqlite:///poseidon.db')"
```

---

#### 4. Frontend Issues

**Problem:** `npm install` fails

**Solutions:**
```bash
# Clear npm cache
npm cache clean --force

# Delete node_modules and package-lock.json
rm -rf node_modules package-lock.json

# Reinstall
npm install

# If still fails, try:
npm install --legacy-peer-deps
```

**Problem:** Frontend can't connect to backend

**Solutions:**
```bash
# 1. Verify backend is running
curl http://localhost:5000/health

# 2. Check CORS settings in app.py
# Add:
from flask_cors import CORS
CORS(app)

# 3. Update API URL in frontend
# frontend/src/config.js:
export const API_BASE_URL = 'http://localhost:5000';
```

**Problem:** `npm start` port 3000 already in use

**Solutions:**
```bash
# Find and kill process on port 3000
# Windows:
netstat -ano | findstr :3000
taskkill /PID <PID> /F

# Mac/Linux:
lsof -ti:3000 | xargs kill -9

# Or use different port:
PORT=3001 npm start
```

---

#### 5. AWS/Cloud Deployment Issues

**Problem:** Terraform `Error: InvalidClientTokenId`

**Solutions:**
```bash
# Verify AWS credentials
aws sts get-caller-identity

# Reconfigure AWS CLI
aws configure

# Check credentials file
cat ~/.aws/credentials
```

**Problem:** Lambda function deployment fails

**Solutions:**
```bash
# Ensure IAM role has proper permissions
# Required policies:
# - AWSLambdaBasicExecutionRole
# - Custom policy for S3, GuardDuty, etc.

# Check function logs
aws logs tail /aws/lambda/poseidon-trident-security --follow
```

**Problem:** EC2 instance not accessible

**Solutions:**
```bash
# 1. Check security group rules
aws ec2 describe-security-groups --group-ids <sg-id>

# 2. Ensure port 22 (SSH) is open
# Add rule if needed:
aws ec2 authorize-security-group-ingress \
  --group-id <sg-id> \
  --protocol tcp \
  --port 22 \
  --cidr 0.0.0.0/0

# 3. Check instance state
aws ec2 describe-instances --instance-ids <instance-id>
```

---

#### 6. UI/GUI Issues

**Problem:** UI doesn't launch or shows blank screen

**Solutions:**
```bash
# 1. Check if trident.png exists
ls -la trident.png

# 2. Install tkinter (if missing)
# Ubuntu/Debian:
sudo apt-get install python3-tk

# macOS (with Homebrew):
brew install python-tk

# 3. Run with debug output
python UI.py --debug
```

**Problem:** Login fails with correct credentials

**Solutions:**
```bash
# 1. Check password hashing
# Default: admin/password
# Password is SHA-256 hashed

# 2. Reset admin password
python -c "
import hashlib
print(hashlib.sha256('password'.encode()).hexdigest())
"

# 3. Check user_activity.log for errors
tail -f user_activity.log
```

---

#### 7. Firewall/Network Issues

**Problem:** Firewall rules not applying

**Solutions:**
```bash
# 1. Check firewall.py implementation
# Note: firewall.py is currently empty in the project
# You may need to implement firewall logic

# 2. Check firewall_rules.json
cat firewall_rules.json

# 3. Verify firewall service status (on Linux)
sudo ufw status
sudo iptables -L
```

---

#### 8. Logging Issues

**Problem:** Logs not being created

**Solutions:**
```bash
# 1. Create logs directory
mkdir -p logs/

# 2. Check permissions
chmod 755 logs/

# 3. Verify logging_config.yaml exists
ls -la logging_config.yaml

# 4. Check log file manually
tail -f logs/poseidon.log
tail -f security.log
```

---

#### 9. Testing Issues

**Problem:** Tests fail with import errors

**Solutions:**
```bash
# 1. Install test dependencies
pip install pytest pytest-cov

# 2. Run from project root
cd /path/to/Poseidon-s-Trident
pytest

# 3. Set PYTHONPATH
export PYTHONPATH="${PYTHONPATH}:$(pwd)"
pytest
```

**Problem:** Specific test failures

**Solutions:**
```bash
# Run individual test with verbose output
pytest tests/test_encryption.py -v

# Show print statements
pytest -s

# Stop on first failure
pytest -x
```

---

### Getting Help

If you're still experiencing issues:

1. **Check existing issues:** [GitHub Issues](https://github.com/Cyber-Samurai-Group/Poseidon-s-Trident/issues)
2. **Create a new issue** with:
   - Operating system and version
   - Python version (`python --version`)
   - Full error message
   - Steps to reproduce
3. **Check logs:**
   ```bash
   # Application logs
   cat logs/poseidon.log
   cat security.log

   # Docker logs
   docker-compose logs
   ```

4. **Enable debug mode:**
   ```bash
   export DEBUG=True
   python app.py
   ```

---

## Contributing

We welcome contributions from the community! Please see [CONTRIBUTING.md](CONTRIBUTING.md) for detailed guidelines.

### Quick Contribution Guide

1. **Fork the repository**
2. **Create a feature branch:**
   ```bash
   git checkout -b feature/your-feature-name
   ```
3. **Make your changes and commit:**
   ```bash
   git add .
   git commit -m "Add: your feature description"
   ```
4. **Run tests and linting:**
   ```bash
   pytest
   black .
   flake8 .
   ```
5. **Push to your fork:**
   ```bash
   git push origin feature/your-feature-name
   ```
6. **Create a Pull Request**

### Development Setup

```bash
# Install development dependencies
pip install -r requirements.txt
pip install -r requirements-dev.txt  # if exists

# Install pre-commit hooks (recommended)
pip install pre-commit
pre-commit install

# Run full test suite
pytest --cov=. --cov-report=html

# Generate documentation
mkdocs serve
# Visit http://localhost:8000
```

---

## License

**Poseidon's Trident** is licensed under the MIT License. See the [LICENSE](LICENSE) file for more information.

```
MIT License

Copyright (c) 2024 White-Hats

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.
```

---

## Additional Resources

- **Documentation:** [Read the Docs](https://poseidons-trident.readthedocs.io)
- **GitHub Repository:** [Poseidon-s-Trident](https://github.com/Cyber-Samurai-Group/Poseidon-s-Trident)
- **Issue Tracker:** [GitHub Issues](https://github.com/Cyber-Samurai-Group/Poseidon-s-Trident/issues)
- **Security Guidelines:** [SECURITY.md](SECURITY.md)
- **Contributing Guide:** [CONTRIBUTING.md](CONTRIBUTING.md)

---

## Acknowledgments

Built with ❤️ by the White-Hats security community.

Special thanks to all contributors who have helped make Poseidon's Trident a robust cybersecurity framework.

---

**⚡ Quick Links:**
- [Quick Start](#quick-start-5-minutes)
- [Docker Setup](#docker-compose-setup-recommended)
- [Troubleshooting](#troubleshooting)
- [Contributing](#contributing)
