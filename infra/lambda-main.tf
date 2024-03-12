resource "aws_iam_role" "lambda_main_exec" {
  name = "${local.functions.main.name}-exec-role"

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY

  tags = local.common_tags
}

resource "aws_iam_role_policy_attachment" "lambda_main_policy" {
  role       = aws_iam_role.lambda_main_exec.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

resource "aws_lambda_function" "main" {
  function_name = local.functions.main.name

  s3_bucket = aws_s3_bucket.lambda_main_bucket.bucket
  s3_key    = aws_s3_object.lambda_main.key

  runtime = local.aws_params.lambda_runtime
  handler = local.functions.main.handler

  layers = [aws_lambda_layer_version.lambda_layer_fastapi.arn]

  source_code_hash = data.archive_file.lambda_main.output_base64sha256

  role = aws_iam_role.lambda_main_exec.arn

  tags = local.common_tags
}

resource "aws_cloudwatch_log_group" "lambda_main" {
  name              = "/aws/lambda/${aws_lambda_function.main.function_name}"
  retention_in_days = local.aws_params.cloudwatch_log_group_retention_in_days

  tags = local.common_tags
}

resource "null_resource" "create_lambda_main_tmp_dir" {
  provisioner "local-exec" {
    command = <<EOT
      mkdir -p ${path.module}/../dist/lambda_main_src
      cp -a ${path.module}/../fastapi_serverless_terraform_starter/ ${path.module}/../dist/lambda_main_src/fastapi_serverless_terraform_starter/
    EOT
  }
}

data "archive_file" "lambda_main" {
  type = "zip"

  source_dir  = "${path.module}/../dist/lambda_main_src"
  output_path = "${path.module}/../dist/fastapi_serverless_terraform_starter.zip"

  excludes = ["__pycache__"]

  depends_on = [null_resource.create_lambda_main_tmp_dir]
}

resource "aws_s3_object" "lambda_main" {
  bucket = aws_s3_bucket.lambda_main_bucket.id

  key    = "fastapi_serverless_terraform_starter.zip"
  source = data.archive_file.lambda_main.output_path

  tags = local.common_tags
}
