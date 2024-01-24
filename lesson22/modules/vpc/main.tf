provider "aws" {
  region = var.region
}

resource "aws_vpc" "tf_vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags = {
    Name = "${var.vpc_name}"
    Env  = var.env
  }
}

resource "aws_subnet" "tf_public_subnet" {
  for_each                = { for idx, cidr in var.public_subnets : idx => cidr }
  vpc_id                  = aws_vpc.tf_vpc.id
  cidr_block              = each.value
  availability_zone       = var.availability_zones[each.key]
  map_public_ip_on_launch = true
  tags = {
    Name = "${var.vpc_name}_public_${each.key}"
    Env  = var.env
  }
}

resource "aws_subnet" "tf_private_subnet" {
  for_each                = { for idx, cidr in var.private_subnets : idx => cidr }
  vpc_id                  = aws_vpc.tf_vpc.id
  cidr_block              = each.value
  availability_zone       = var.availability_zones[each.key]
  map_public_ip_on_launch = true
  tags = {
    Name = "${var.vpc_name}_private_${each.key}"
    Env  = var.env
  }
}

resource "aws_internet_gateway" "tf_igw" {
  vpc_id = aws_vpc.tf_vpc.id
  tags = {
    Name = "${var.vpc_name}_igw"
    Env  = var.env
  }
}

resource "aws_eip" "tf_nat" {
  domain = "vpc"
}

resource "aws_nat_gateway" "tf_nat_gw" {
  subnet_id     = values(aws_subnet.tf_public_subnet)[0].id
  allocation_id = aws_eip.tf_nat.id

  tags = {
    Name : "${var.vpc_name}-nat-gw"
    Env : var.env
  }
}

resource "aws_route_table" "tf_public_rt" {
  vpc_id = aws_vpc.tf_vpc.id
  route {
    cidr_block = var.route_cidr
    gateway_id = aws_internet_gateway.tf_igw.id
  }
  tags = {
    Name = "${var.vpc_name}_public_rt"
    Env  = var.env
  }
}

resource "aws_route_table_association" "tf_public_rt_assoc" {
  for_each       = aws_subnet.tf_public_subnet
  subnet_id      = each.value.id
  route_table_id = aws_route_table.tf_public_rt.id
}

resource "aws_route_table" "tf_private_rt" {
  vpc_id = aws_vpc.tf_vpc.id
  route {
    cidr_block     = var.route_cidr
    nat_gateway_id = aws_nat_gateway.tf_nat_gw.id
  }
  tags = {
    Name = "${var.vpc_name}_private_rt"
    Env  = var.env
  }
}

resource "aws_route_table_association" "tf_private_rt_assoc" {
  for_each       = aws_subnet.tf_private_subnet
  subnet_id      = each.value.id
  route_table_id = aws_route_table.tf_private_rt.id
}