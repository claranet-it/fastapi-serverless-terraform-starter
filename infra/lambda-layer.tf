resource "null_resource" "lambda_layer" {
  triggers = {
    requirements = filesha1("${path.module}/../poetry.lock")
  }
  provisioner "local-exec" {
    command = "cd ${path.module}/.. && ./create_layer.sh"
  }
}

resource "aws_s3_bucket" "lambda_layer_fastapi" {
  bucket_prefix = "layer"

  tags = local.common_tags
}

resource "aws_s3_object" "lambda_layer_zip" {
  bucket     = aws_s3_bucket.lambda_layer_fastapi.id
  key        = "layer.zip"
  source     = "${path.module}/../dist/layer/layer.zip"
  depends_on = [null_resource.lambda_layer]

  tags = local.common_tags
}

resource "aws_lambda_layer_version" "lambda_layer_fastapi" {
  s3_bucket           = aws_s3_bucket.lambda_layer_fastapi.id
  s3_key              = aws_s3_object.lambda_layer_zip.key
  layer_name          = local.layers.fastapi.name
  compatible_runtimes = local.layers.fastapi.compatible_runtimes
  description         = local.layers.fastapi.description
  skip_destroy        = true
  depends_on          = [aws_s3_object.lambda_layer_zip]
}