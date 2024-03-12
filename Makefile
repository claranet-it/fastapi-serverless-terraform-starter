.PHONY: help start-local test coverage lint lint-fix format test coverage terraform-create terraform-destroy terraform-format pre-commit-install pre-commit

default: help

help: # Show help for each of the Makefile recipes.
	@grep -E '^[a-zA-Z0-9 -]+:.*#'  Makefile | sort | while read -r l; do printf "\033[1;32m$$(echo $$l | cut -f 1 -d':')\033[00m:$$(echo $$l | cut -f 2- -d'#')\n"; done

start-local: # Start local server
	uvicorn fastapi_serverless_terraform_starter.main:app --reload

lint: # Run linter
	poetry run ruff check .

lint-fix: # Run linter with fix
	poetry run ruff check --fix .

format: # Run formatter
	poetry run ruff format .

terraform-create: # Create infrastructure
	cd infra && terraform init && terraform plan && terraform apply -auto-approve

terraform-destroy: # Destroy infrastructure
	cd infra && terraform destroy -auto-approve

terraform-format: # Format terraform files
	cd infra && terraform fmt

test: # Run tests
ifdef filter
	poetry run pytest $(filter) -vv
else
	poetry run pytest -vv
endif

coverage: test # Run tests with coverage
	poetry run pytest --cov-report term-missing --cov=fastapi_serverless_starter

pre-commit-install: # Install pre-commit hooks
	pre-commit install

pre-commit: # Run pre-commit hooks
	pre-commit