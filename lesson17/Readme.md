# robotdreams-17
Lesson #17

### Setup
- install docker and docker-compose on machine
- clone the project by run ```git clone git@github.com:Valentinishe/robotdreams-17.git```;
- go to root folder in the project;

### Run
- run script by `./build.sh`;

### Log in (MysqlWorkbench)
- Master DB:
  - IP: `localhost`
  - Port: `3306`
  - Username: `mydb_user`
  - Password: `mydb_pwd`
  - Database: `mydb` 
- Slave DB:
  - IP: `localhost`
  - Port: `3306`
  - Username: `mydb_slave_user`
  - Password: `mydb_slave_pwd`
  - Database: `mydb` 

### Migration
- for migration please log in to Master DB throught client (like MysqlWorkbench) and run script.sql

### Destroy
- run ```docker-compose down```;