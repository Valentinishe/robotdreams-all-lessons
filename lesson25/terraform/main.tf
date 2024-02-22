provider "aws" {
  region = var.region
}

resource "aws_vpc" "VPC" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags = {
    Name = "VPC_ELK"
    ENV  = var.env
  }
}

resource "aws_subnet" "PUBLIC_VPC" {
  vpc_id                  = aws_vpc.VPC.id
  cidr_block              = var.public_subnet_cidr
  availability_zone       = var.availability_zone
  map_public_ip_on_launch = true
  tags = {
    Name = "PUBLIC_SUBNET_ELK"
    ENV  = var.env
  }
}

resource "aws_subnet" "PRIVATE_VPC" {
  vpc_id                  = aws_vpc.VPC.id
  cidr_block              = var.private_subnet_cidr
  map_public_ip_on_launch = true
  tags = {
    Name = "PRIVATE_SUBNET_ELK"
    ENV  = var.env
  }
}

resource "aws_internet_gateway" "IGW" {
  vpc_id = aws_vpc.VPC.id
  tags = {
    Name = "IGW_ELK"
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
    Name = "PUBLIC_RT_ELK"
    ENV  = var.env
  }
}

resource "aws_route_table_association" "PUBLIC_SUBNET_ASSOCIATION_ELK" {
  subnet_id      = aws_subnet.PUBLIC_VPC.id
  route_table_id = aws_route_table.PUBLIC_RT.id
}

resource "aws_security_group" "VPC_SG" {
  name        = "VPC_SG_ELK"
  description = "VPC_SG_ELK"
  vpc_id      = aws_vpc.VPC.id

  ingress = [
    for port in [22, 80, 443, 8080, 9200, 5601, 5044, 3000] : {
      description      = "TLS from VPC"
      from_port        = port
      to_port          = port
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      security_groups  = []
      self             = false
    }
  ]

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "ELK_INSTANCE" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  key_name               = var.key_pair_name
  subnet_id              = aws_subnet.PUBLIC_VPC.id
  vpc_security_group_ids = [aws_security_group.VPC_SG.id]
  tags = {
    Name = "INSTANCE_ELK"
    ENV  = var.env
    Role = "ELK"
  }
}

resource "aws_eip" "VPC_ELK_EIP" {
  instance = aws_instance.ELK_INSTANCE.id
}