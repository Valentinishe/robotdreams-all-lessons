terraform {
  backend "s3" {
    bucket         = "tf-state-bucket-storage"
    key            = "terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "tf-state-table-lock"
    encrypt        = true
  }
}

data "aws_ami" "ubuntu" {

  owners      = ["amazon"]
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }
}

provider "aws" {
  region = var.region
}

module "tf_vpc" {
  source = "./modules/vpc"

  region             = var.region
  env                = var.env
  vpc_name           = "tf-vpc"
  route_cidr         = "0.0.0.0/0"
  vpc_cidr           = "10.0.0.0/16"
  availability_zones = ["us-east-1a", "us-east-1b"]
  public_subnets     = ["10.0.110.0/24", "10.0.111.0/24"]
  private_subnets    = ["10.0.120.0/24", "10.0.121.0/24"]
}

module "tf_sg" {
  source = "./modules/security_group"

  env     = var.env
  sg_name = "tf-sg"
  vpc_id  = module.tf_vpc.vpc_id
}

module "jenkins" {
  source = "./modules/ec2-instance"

  env           = var.env
  ami = data.aws_ami.ubuntu.id
  instance_name = "Jenkins-EC2"
  instance_role = "Jenkins"
  instance_type = "t2.micro"
  key_pair_name = var.key_pair_name
  subnet_id     = module.tf_vpc.public_subnet_ids[0]
  sg_id         = module.tf_sg.sg_id

}

module "monitoring" {
  source = "./modules/ec2-instance"

  env           = var.env
  ami = data.aws_ami.ubuntu.id
  instance_name = "Monitoring-EC2"
  instance_role = "Monitoring"
  instance_type = "t2.micro"
  key_pair_name = var.key_pair_name
  subnet_id     = module.tf_vpc.public_subnet_ids[0]
  sg_id         = module.tf_sg.sg_id

}