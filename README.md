# Python Template Repository

This repository is a template for Python projects. It includes a basic project structure.

## Available Commands

This project includes several convenient `make` commands to help with development:

- `make info` - Display current revision information (git tag and SHA)
- `make pip-sync` - Generate requirements.txt from requirements.in and sync your Python environment
- `make build` - Build Docker image for the project
- `make lint` - Run code linting with ruff
- `make fmt` - Format code with ruff (runs lint first)
- `make test` - Run unit tests in Docker container
- `make cov` - Generate HTML test coverage reports
- `make dev` - Start development container with mounted source code, environment variables and exposed port 8000
