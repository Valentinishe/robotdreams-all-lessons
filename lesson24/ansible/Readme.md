### Setup
- Install Ansible on the `master machine` or locally, referring to the documentation https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html
- create and configure instances (manually or using terraform, see lesson #21) and save in the `inventory.ini` file for each instance the necessary information about it (username, IP Address, ssh-key)

### Run
- run `ansible-playbook -i inventory.ini playbook.yml --ask-vault-pass`, if you want install all playbook (with secrets);

### Login to Kibana
- IP: `127.0.0.1`
- Port: `5601`
- Username: `kibana`
- Password: `kibana123`

### Creation Secret
- run `ansible-vault encrypt_string`
- create and confirm password for this secret
- pass secret 
- then run playbook with flag `--ask-vault-pass`
