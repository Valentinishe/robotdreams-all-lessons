output "vpc_id" {
  value = aws_vpc.tf_vpc.id
}

output "public_subnet_ids" {
  value = [for subnet in aws_subnet.tf_public_subnet : subnet.id]
}


output "private_subnet_ids" {
  value = [for subnet in aws_subnet.tf_private_subnet : subnet.id]
}

output "nat_gw_id" {
  value = aws_nat_gateway.tf_nat_gw.id
}

output "igw_id" {
  value = aws_internet_gateway.tf_igw.id
}