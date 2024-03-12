locals {
  service_name = "fastapi_tf_starter"
  owner        = "Claranet"

  aws_params = {
    region                                 = "eu-west-1"
    lambda_runtime                         = "python3.12"
    cloudwatch_log_group_retention_in_days = 14
  }

  layers = {
    fastapi = {
      name                = "fastapi-layer"
      description         = "FastAPI layer"
      compatible_runtimes = ["python3.12"]
    }
  }

  functions = {
    main = {
      name    = "fastapi_tf_starter_main"
      handler = "fastapi_serverless_terraform_starter.functions.main_function.handler"
    }
  }

  common_tags = {
    Service = local.service_name
    Owner   = local.owner
    Destroy = "false"
  }
}