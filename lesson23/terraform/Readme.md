### Setup
- install terraform by guide on your [master machine](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)
- setup your AWS credentials to ~/.aws/credentials file

### Run
- run `terraform init` for initialization
- run `terraform plan` for checking what will be change
- run `terraform apply` for create/update your state infrastracture

### Destroy
- run ```terraform apply -destroy```;