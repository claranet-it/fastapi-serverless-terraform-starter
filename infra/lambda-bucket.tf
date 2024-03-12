resource "aws_s3_bucket" "lambda_main_bucket" {
  bucket_prefix = "main"
  force_destroy = true

  tags = local.common_tags
}

resource "aws_s3_bucket_public_access_block" "lambda_main_bucket" {
  bucket = aws_s3_bucket.lambda_main_bucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}
