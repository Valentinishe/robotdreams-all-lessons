provider "aws" {
  region = var.region
}

resource "aws_vpc" "VPC" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags = {
    Name = "VPC_TERRAFORM"
    ENV  = var.env
  }
}

resource "aws_subnet" "PUBLIC_VPC" {
  vpc_id                  = aws_vpc.VPC.id
  cidr_block              = var.public_subnet_cidr
  availability_zone       = var.availability_zone
  map_public_ip_on_launch = true
  tags = {
    Name = "PUBLIC_SUBNET_TERRAFORM"
    ENV  = var.env
  }
}

resource "aws_subnet" "PRIVATE_VPC" {
  vpc_id                  = aws_vpc.VPC.id
  cidr_block              = var.private_subnet_cidr
  map_public_ip_on_launch = true
  tags = {
    Name = "PRIVATE_SUBNET_TERRAFORM"
    ENV  = var.env
  }
}

resource "aws_internet_gateway" "IGW" {
  vpc_id = aws_vpc.VPC.id
  tags = {
    Name = "IGW_TERRAFORM_TERRAFORM"
    ENV  = var.env
  }
}

resource "aws_route_table" "PUBLIC_RT" {
  vpc_id = aws_vpc.VPC.id
  route {
    cidr_block = var.route_cidr
    gateway_id = aws_internet_gateway.IGW.id
  }
  tags = {
    Name = "PUBLIC_RT_TERRAFORM_TERRAFORM"
    ENV  = var.env
  }
}

resource "aws_route_table_association" "PUBLIC_SUBNET_ASSOCIATION_TERRAFORM" {
  subnet_id      = aws_subnet.PUBLIC_VPC.id
  route_table_id = aws_route_table.PUBLIC_RT.id
}

resource "aws_security_group" "VPC_SG" {
  name        = "VPC_SG_TERRAFORM"
  description = "VPC_SG_TERRAFORM"
  vpc_id      = aws_vpc.VPC.id
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group_rule" "VPC_SG_RULE" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "TCP"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.VPC_SG.id
}

resource "aws_security_group_rule" "VPC_SG_RULE2" {
  type              = "ingress"
  from_port         = 3306
  to_port           = 3306
  protocol          = "TCP"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.VPC_SG.id
}

resource "aws_instance" "JENKINS_INSTANCE" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  key_name               = var.key_pair_name
  subnet_id              = aws_subnet.PUBLIC_VPC.id
  vpc_security_group_ids = [aws_security_group.VPC_SG.id]
  tags = {
    Name = "JENKINS_INSTANCE_TERRAFORM"
    ENV  = var.env
    Role = "Jenkins"
  }
}

resource "aws_instance" "LAB_INSTANCE" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  key_name               = var.key_pair_name
  subnet_id              = aws_subnet.PUBLIC_VPC.id
  vpc_security_group_ids = [aws_security_group.VPC_SG.id]
  tags = {
    Name = "LAB_INSTANCE_TERRAFORM"
    ENV  = var.env
    Role = "Lab"
  }
}

resource "aws_eip" "VPC_JENKINS_EIP" {
  instance = aws_instance.JENKINS_INSTANCE.id
}

resource "aws_eip" "VPC_LAB_EIP" {
  instance = aws_instance.LAB_INSTANCE.id
}