# robotdreams-19
Lesson #19


### Setup
- Install Ansible on the `master machine` or locally, referring to the documentation https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html
- create and configure instances (manually or using terraform, see lesson #21) and save in the `inventory.ini` file for each instance the necessary information about it (username, IP Address, ssh-key)
- clone the project by run ```git clone git@github.com:Valentinishe/robotdreams-19.git```;
- go to root folder in the project;

### Run
- run `ansible-playbook -i inventory.ini playbook_full.yml --ask-vault-pass`, if you want install all playbook (with secrets);
- run `ansible-playbook -i inventory.ini playbook_web.yml`, if you want install only nginx;
- run `ansible-playbook -i inventory.ini playbook_db.yml --ask-vault-pass`, if you want install only mysqlDB (with secret);

### Login to MysqlDB (log in to the server using the MySQL Workbench client and credentials):
- IP: `127.0.0.1`
- Port: `3306`
- Username: `developer`
- Password: `3AMTf?DcXxpczeaUPx2_?tTethw4aFmF`

### Creation Secret
- run `ansible-vault encrypt_string`
- create and confirm password for this secret
- pass secret 
- then run playbook with flag `--ask-vault-pass`
