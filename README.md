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

Get Poseidon's Trident running in under 5 minutes using Docker Compose.

Clone the repository:
```bash
git clone https://github.com/Cyber-Samurai-Group/Poseidon-s-Trident.git
cd Poseidon-s-Trident
```

Start with Docker Compose:
```bash
docker-compose up -d
```

Access the application at http://localhost:80 with default credentials: `admin` / `password`

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

Install Docker and Docker Compose:
```bash
sudo apt-get update
sudo apt-get install docker.io docker-compose -y
```

Add your user to docker group to avoid using sudo:
```bash
sudo usermod -aG docker $USER
newgrp docker
```

Verify installation:
```bash
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
cat > .env << EOF
SECRET_KEY=your-secret-key-here
DATABASE_URL=sqlite:///poseidon.db
LOG_LEVEL=INFO
AWS_REGION=us-west-2
EOF
```

#### Step 4: Build and Start Services

Build the Docker images:
```bash
docker-compose build
```

Start all services in detached mode:
```bash
docker-compose up -d
```

View logs (optional):
```bash
docker-compose logs -f
```

#### Step 5: Verify Installation

Check running containers:
```bash
docker-compose ps
```

Expected output: `webserver "python main.py" Up 10 seconds 0.0.0.0:80->80/tcp`

Test the web interface:
```bash
curl http://localhost:80/health
```

Expected response: `{"status": "healthy"}`

#### Step 6: Access the Application

Open your browser and navigate to:
- **Web UI:** http://localhost:80
- **Default Credentials:**
  - Username: `admin`
  - Password: `password`

#### Docker Compose Management

Stop all services:
```bash
docker-compose down
```

Stop and remove volumes (clean slate):
```bash
docker-compose down -v
```

Restart services:
```bash
docker-compose restart
```

View logs:
```bash
docker-compose logs -f webserver
```

Update to latest code:
```bash
git pull
docker-compose up -d --build
```

---

### Local Python Setup

**⏱️ Setup Time: 10-15 minutes**

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

Upgrade pip:
```bash
pip install --upgrade pip
```

Install required packages:
```bash
pip install -r requirements.txt
```

Verify installation:
```bash
pip list
```

#### Step 4: Initialize Database

Create necessary directories:
```bash
mkdir -p logs data backups
```

Initialize database (if using SQLite):
```bash
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

#### Option 1: Main Frontend

```bash
cd frontend
npm install
npm start
```

Opens at http://localhost:3000

Build for production:
```bash
npm run build
```

#### Option 2: Modern Frontend (TypeScript Components)

```bash
cd my-react-frontend
npm install
npm start
```

Opens at http://localhost:3000

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
SECRET_KEY=your-secret-key-change-this-in-production
DEBUG=False
LOG_LEVEL=INFO

DATABASE_URL=sqlite:///poseidon.db

AWS_ACCESS_KEY_ID=your-access-key
AWS_SECRET_ACCESS_KEY=your-secret-key
AWS_DEFAULT_REGION=us-west-2

SMTP_HOST=smtp.gmail.com
SMTP_PORT=587
SMTP_USER=your-email@gmail.com
SMTP_PASSWORD=your-app-password

SESSION_TIMEOUT=300
PASSWORD_MIN_LENGTH=8
ENABLE_2FA=True
```

For MySQL: `DATABASE_URL=mysql://username:password@localhost:3306/poseidon`
For PostgreSQL: `DATABASE_URL=postgresql://username:password@localhost:5432/poseidon`

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

Threat detection on target:
```bash
python PoseidonsTrident_Cybersecurity.py --mode threat_detection --target 192.168.1.1
```

Vulnerability assessment:
```bash
python vulnerability_assessment.py
```

Start intrusion detection:
```bash
python ids.py --config ids_config.yaml
```

Run encryption test:
```bash
python encryption.py
```

### Web API

Start the Flask server:
```bash
python app.py
```

**API Endpoints:**

Login:
```bash
curl -X POST http://localhost:5000/api/login \
  -H "Content-Type: application/json" \
  -d '{"username":"admin","password":"password"}'
```

Register new user:
```bash
curl -X POST http://localhost:5000/api/register \
  -H "Content-Type: application/json" \
  -d '{"username":"newuser","password":"securepass123"}'
```

### Running Tests

Run all tests:
```bash
pytest
```

Run with coverage report:
```bash
pytest --cov=. --cov-report=html
```

Run specific test file:
```bash
pytest tests/test_encryption.py
```

Run with verbose output:
```bash
pytest -v
```

### Code Quality Checks

Format code with Black:
```bash
make format
```
or
```bash
black .
```

Lint with Flake8:
```bash
make lint
```
or
```bash
flake8 .
```

Security scan with Semgrep:
```bash
semgrep --config .semgrep.yaml --error --quiet
```

---

## AWS/Cloud Deployment

### Prerequisites

1. AWS Account with appropriate permissions
2. AWS CLI configured (run `aws configure`)
3. Terraform installed (version 1.0+)

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

Resources to be created: EC2 instance (t2.micro), S3 buckets (data + logs), RDS MySQL database, Security groups, IAM roles, CloudWatch alarms, SNS topics

#### 4. Deploy Infrastructure

```bash
terraform apply
```

Type 'yes' when prompted.

#### 5. Deploy Lambda Functions

Package and deploy Lambda function:
```bash
zip -r lambda.zip lambda_function.py
aws lambda create-function \
  --function-name poseidon-trident-security \
  --runtime python3.9 \
  --role arn:aws:iam::YOUR_ACCOUNT_ID:role/lambda-execution-role \
  --handler lambda_function.lambda_handler \
  --zip-file fileb://lambda.zip
```

Deploy GuardDuty handler:
```bash
zip -r guardduty.zip guardduty_handler.py
aws lambda create-function \
  --function-name poseidon-guardduty-handler \
  --runtime python3.9 \
  --role arn:aws:iam::YOUR_ACCOUNT_ID:role/lambda-execution-role \
  --handler guardduty_handler.lambda_handler \
  --zip-file fileb://guardduty.zip
```

#### 6. Verify Deployment

Check EC2 instance:
```bash
aws ec2 describe-instances --filters "Name=tag:Name,Values=Poseidon-Trident-Instance"
```

Check S3 buckets:
```bash
aws s3 ls | grep poseidon-trident
```

Check Lambda functions:
```bash
aws lambda list-functions | grep poseidon
```

#### 7. Clean Up Resources

```bash
terraform destroy
```

Type 'yes' when prompted.

---

## Troubleshooting

### Common Issues and Solutions

#### 1. Docker Issues

**Problem:** `docker-compose: command not found`

On Linux, install docker-compose:
```bash
sudo apt-get install docker-compose
```

On Mac/Windows, ensure Docker Desktop is running. Check with:
```bash
docker --version && docker-compose --version
```

**Problem:** `Permission denied while trying to connect to Docker daemon`

Add user to docker group (Linux):
```bash
sudo usermod -aG docker $USER
newgrp docker
```

Restart Docker service:
```bash
sudo systemctl restart docker
```

**Problem:** Port 80 already in use

Find process using port 80:

Windows:
```bash
netstat -ano | findstr :80
```

Mac/Linux:
```bash
lsof -i :80
```

Kill the process or change port in `docker-compose.yml` from `"80:80"` to `"8080:80"`

---

#### 2. Python/Installation Issues

**Problem:** `ModuleNotFoundError: No module named 'X'`

Ensure virtual environment is activated and reinstall dependencies:

Mac/Linux:
```bash
source venv/bin/activate
pip install -r requirements.txt
```

Windows:
```bash
venv\Scripts\activate
pip install -r requirements.txt
```

**Problem:** `python: command not found`

Try `python3` instead:
```bash
python3 --version
```

On Windows, ensure Python is in PATH: Add `C:\Python39\` and `C:\Python39\Scripts\` to your system PATH.

**Problem:** Virtual environment activation fails

Windows PowerShell execution policy error:
```bash
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
venv\Scripts\Activate.ps1
```

Alternative - use Command Prompt:
```bash
venv\Scripts\activate.bat
```

---

#### 3. Database Issues

**Problem:** Database connection errors

For SQLite, ensure directory exists:
```bash
mkdir -p data/
```

Check `DATABASE_URL` in `.env` is set correctly.

For MySQL/PostgreSQL, verify service is running:
```bash
sudo systemctl status mysql
sudo systemctl status postgresql
```

**Problem:** SQLAlchemy migration errors

Reset database (WARNING: deletes all data):
```bash
rm poseidon.db
python -c "from database import Database; Database('sqlite:///poseidon.db')"
```

---

#### 4. Frontend Issues

**Problem:** `npm install` fails

Clear cache and reinstall:
```bash
npm cache clean --force
rm -rf node_modules package-lock.json
npm install
```

If still failing:
```bash
npm install --legacy-peer-deps
```

**Problem:** Frontend can't connect to backend

Verify backend is running:
```bash
curl http://localhost:5000/health
```

Check CORS settings in `app.py`:
```python
from flask_cors import CORS
CORS(app)
```

Update API URL in `frontend/src/config.js`:
```javascript
export const API_BASE_URL = 'http://localhost:5000';
```

**Problem:** `npm start` port 3000 already in use

Windows:
```bash
netstat -ano | findstr :3000
taskkill /PID <PID> /F
```

Mac/Linux:
```bash
lsof -ti:3000 | xargs kill -9
```

Or use different port:
```bash
PORT=3001 npm start
```

---

#### 5. AWS/Cloud Deployment Issues

**Problem:** Terraform `Error: InvalidClientTokenId`

Verify AWS credentials:
```bash
aws sts get-caller-identity
```

Reconfigure AWS CLI:
```bash
aws configure
```

Check credentials file:
```bash
cat ~/.aws/credentials
```

**Problem:** Lambda function deployment fails

Ensure IAM role has proper permissions: `AWSLambdaBasicExecutionRole` and custom policies for S3, GuardDuty.

Check function logs:
```bash
aws logs tail /aws/lambda/poseidon-trident-security --follow
```

**Problem:** EC2 instance not accessible

Check security group rules:
```bash
aws ec2 describe-security-groups --group-ids <sg-id>
```

Ensure port 22 (SSH) is open:
```bash
aws ec2 authorize-security-group-ingress \
  --group-id <sg-id> \
  --protocol tcp \
  --port 22 \
  --cidr 0.0.0.0/0
```

Check instance state:
```bash
aws ec2 describe-instances --instance-ids <instance-id>
```

---

#### 6. UI/GUI Issues

**Problem:** UI doesn't launch or shows blank screen

Check if trident.png exists:
```bash
ls -la trident.png
```

Install tkinter if missing:

Ubuntu/Debian:
```bash
sudo apt-get install python3-tk
```

macOS:
```bash
brew install python-tk
```

Run with debug output:
```bash
python UI.py --debug
```

**Problem:** Login fails with correct credentials

Default credentials: `admin/password` (SHA-256 hashed)

Reset admin password:
```bash
python -c "import hashlib; print(hashlib.sha256('password'.encode()).hexdigest())"
```

Check logs:
```bash
tail -f user_activity.log
```

---

#### 7. Firewall/Network Issues

**Problem:** Firewall rules not applying

Note: `firewall.py` may be empty and require implementation.

Check firewall rules:
```bash
cat firewall_rules.json
```

Verify firewall service status (Linux):
```bash
sudo ufw status
sudo iptables -L
```

---

#### 8. Logging Issues

**Problem:** Logs not being created

Create logs directory:
```bash
mkdir -p logs/
chmod 755 logs/
```

Verify logging config exists:
```bash
ls -la logging_config.yaml
```

Check log files:
```bash
tail -f logs/poseidon.log
tail -f security.log
```

---

#### 9. Testing Issues

**Problem:** Tests fail with import errors

Install test dependencies:
```bash
pip install pytest pytest-cov
```

Run from project root:
```bash
cd /path/to/Poseidon-s-Trident
pytest
```

Set PYTHONPATH if needed:
```bash
export PYTHONPATH="${PYTHONPATH}:$(pwd)"
pytest
```

**Problem:** Specific test failures

Run individual test with verbose output:
```bash
pytest tests/test_encryption.py -v
```

Show print statements:
```bash
pytest -s
```

Stop on first failure:
```bash
pytest -x
```

---

### Getting Help

Check existing issues: [GitHub Issues](https://github.com/Cyber-Samurai-Group/Poseidon-s-Trident/issues)

When creating a new issue, include: OS version, Python version, full error message, steps to reproduce.

Check logs:
```bash
cat logs/poseidon.log
cat security.log
docker-compose logs
```

Enable debug mode:
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

Install dependencies:
```bash
pip install -r requirements.txt
pip install -r requirements-dev.txt
```

Install pre-commit hooks:
```bash
pip install pre-commit
pre-commit install
```

Run full test suite:
```bash
pytest --cov=. --cov-report=html
```

Generate documentation:
```bash
mkdocs serve
```

Visit http://localhost:8000

---

## License

**Poseidon's Trident** is licensed under the MIT License. See the [LICENSE](LICENSE) file for more information.

```
MIT License

Copyright (c) 2024 Cyber-Samurai-Group

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

Built by the Cyber-Samurai-Group security community.

Special thanks to all contributors who have helped make Poseidon's Trident a robust cybersecurity framework.

---

**⚡ Quick Links:**
- [Quick Start](#quick-start-5-minutes)
- [Docker Setup](#docker-compose-setup-recommended)
- [Troubleshooting](#troubleshooting)
- [Contributing](#contributing)
