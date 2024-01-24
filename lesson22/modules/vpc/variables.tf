variable "env" {
  description = "Environment"
  type        = string
}

variable "region" {
  description = "AWS region"
  type        = string
}

variable "vpc_name" {
  description = "Name of VPC"
  type        = string
}

variable "vpc_cidr" {
  description = "VPC CIDR"
  type        = string
  default     = "10.0.0.0/16"
}

variable "availability_zones" {
  description = "List of availability zones"
  type        = list(string)
}

variable "public_subnets" {
  description = "List of public subnets CIDR"
  type        = list(string)
}

variable "private_subnets" {
  description = "List of private subnets CIDR"
  type        = list(string)
}

variable "route_cidr" {
  description = "Route table CIDR"
  type        = string
}