terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.39.0"
    }
    archive = {
      source  = "hashicorp/archive"
      version = "~> 2.4.2"
    }
  }

  required_version = "~> 1.0"

  backend "s3" {
    bucket         = "fastapi-tf-starter-tfstate"
    key            = "state/terraform.tfstate"
    region         = "eu-west-1"
    encrypt        = true
    dynamodb_table = "fastapi-tf-starter-tf-lockid"
  }
}

provider "aws" {
  region = local.aws_params.region
}
