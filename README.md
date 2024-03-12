# FastAPI Serverless Starter

## Pre-requisites

- Python 3.12.2
- Poetry 1.8.2
- Terraform

## Tools and Frameworks

- [x] FastApi
- [x] Uvicorn
- [x] pytest
- [x] pre-commit
- [x] ruff

## Install dependencies

```
poetry install
```

## Terraform state (S3)
- Create S3 Bucket: fastapi-tf-starter-tfstate
- Create DynamoDB Table: fastapi-tf-starter-tf-lockid (PK: LockID)

## Install pre-commit hooks

```
pre-commit install
```

## Terraform commands

Create infrastructure
```
make terraform-create
```

Destroy infrastructure
```
make terraform-destroy
```

Format terraform files
```
make terraform-format
```

## Commands

Start local server
```
make start-local
```

Lint
```
make lint
```

Lint and fix
```
make lint-fix
```

Format
```
make format
```

Launch tests
```
make test
```

Launch test with coverage
```
make coverage
```

Run pre-commit hooks
```
make pre-commit
```