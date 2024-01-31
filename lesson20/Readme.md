# robotdreams-21
Lesson #21


### Setup
- install terraform by guide on your [master machine](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)
- Install Ansible on the `master machine` or locally, referring to the documentation https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html
- clone the project by run ```git clone git@github.com:Valentinishe/robotdreams-20.git```;
- go to root folder in the project;
- setup your AWS credentials to ~/.aws/credentials file

### Deploy Infrastructure
- cd `terraform` folder
- run `terraform init` for initialization
- run `terraform plan` for checking what will be change
- run `terraform apply` for create/update your state infrastracture

### Install Jenkins and other dependencies by Ansible
- cd `ansible` folder from root
- configure instances (update the `inventory.ini` file: username, IP Address, ssh-key)
- run `ansible-playbook -i inventory.ini playbook.yml`, for install jenkins and all dependencies;

### Setup Jenkins manually
- go to website instanceIP:8080 (instanceIP took from inventory.ini file)
- pass password from console to jenkins (ex. `Your initialAdminPassword is "a15b311a21bf408a87a1558f63523edc"`)
- choise "Install suggested plugins"
- create user
- create pipeline (connect https://github.com/Valentinishe/18-app.git repository with Jenkinsfile)
- run pipeline

### Destroy
- run ```terraform apply -destroy```;