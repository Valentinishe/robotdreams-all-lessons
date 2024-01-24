provider "aws" {
  region = var.region
}

resource "aws_s3_bucket" "sb" {
  bucket = var.bucket_state_name
}

resource "aws_s3_bucket_versioning" "sb_versioning" {
  bucket = aws_s3_bucket.sb.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "sb_encryption" {
  bucket = aws_s3_bucket.sb.id
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_dynamodb_table" "sb_lock" {
  name           = var.dynamodb_state_table
  read_capacity  = 1
  write_capacity = 1
  billing_mode   = "PROVISIONED"
  hash_key       = "LockID"
  attribute {
    name = "LockID"
    type = "S"
  }
  tags = {
    Name = "TF lock table"
    ENV  = var.env
  }
}