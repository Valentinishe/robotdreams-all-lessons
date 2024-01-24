# robotdreams-22
Lesson #22

### Description
This is folder/project need for deploy state storage which allow to control updating projects based on Terraform.

This projects include:
- S3
- DynamoDB

### Setup
- install terraform by guide on your [master machine](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)
- clone the project by run ```git clone git@github.com:Valentinishe/robotdreams-22.git```;
- go to `state-bucket-storage` folder in the project;
- setup your AWS credentials to ~/.aws/credentials file
- update envs in `terraform.tfvars`

### Run
- run `terraform init` for initialization
- run `terraform plan` for checking what will be change
- run `terraform apply` for create/update your state infrastracture

### Destroy
- run ```terraform apply -destroy``` for deleting project;