env                 = "DEV"
region              = "us-east-1"
vpc_cidr            = "10.0.0.0/16"
public_subnet_cidr  = "10.0.1.0/24"
private_subnet_cidr = "10.0.2.0/24"
route_cidr          = "0.0.0.0/0"
ami_id              = "ami-0c7217cdde317cfec"
instance_type       = "t2.medium"
key_pair_name       = "vpc-key"
availability_zone   = "us-east-1a"