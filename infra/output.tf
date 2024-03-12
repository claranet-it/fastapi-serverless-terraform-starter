output "lambda_main_base_url" {
  value = aws_api_gateway_deployment.main_dev.invoke_url
}
