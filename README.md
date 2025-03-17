# Python Template Repository

<div markdown="1">

[![Build](https://github.com/amerkurev/python-template-repo/actions/workflows/ci.yml/badge.svg?branch=master)](https://github.com/amerkurev/python-template-repo/actions/workflows/ci.yml)
[![Coverage Status](https://coveralls.io/repos/github/amerkurev/python-template-repo/badge.svg?branch=master)](https://coveralls.io/github/amerkurev/python-template-repo?branch=master)
[![License](https://img.shields.io/badge/license-mit-blue.svg)](https://github.com/amerkurev/python-template-repo/blob/master/LICENSE)
</div>

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
