variable "instance_name" {
  description = "Instance name"
  type        = string
}

variable "instance_role" {
  description = "Instance role"
  type        = string
}

variable "instance_type" {
  description = "Instance type"
  type        = string
}

variable "key_pair_name" {
  description = "Key pair"
  type        = string
}

variable "subnet_id" {
  type = string
}

variable "sg_id" {
  type = string
}

variable "ami" {
  description = "AMI ID"
  type        = string
}

variable "env" {
  description = "Environment"
  type        = string
}
