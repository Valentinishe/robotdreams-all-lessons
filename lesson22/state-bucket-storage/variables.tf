variable "env" {
  description = "Environment"
  type        = string
}

variable "region" {
  description = "AWS region"
  type        = string
}

variable "bucket_state_name" {
  description = "Name of bucket for store Terraform state"
  type        = string
}

variable "dynamodb_state_table" {
  description = "Name of table for lock update Terraform state"
  type        = string
}