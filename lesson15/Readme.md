# robotdreams-15
Lesson #15


### Setup
- clone the project by run ```git clone git@github.com:Valentinishe/robotdreams-15.git```;
- go to root folder in the project;
- create `MySQL` image by run ```docker build . -t mysql-image```;

### Run
- run `database` container by run ```docker run -d --name database -p 3306:3306 mysql-image```;

### Migration
- log in to the server using the MySQL Workbench client and credentials:
  - IP: `127.0.0.1`
  - Port: `3306`
  - Username: `developer`
  - Password: `3AMTf?DcXxpczeaUPx2_?tTethw4aFmF`
- run migration script 

### Destroy
- run ```docker rm databese -f```;