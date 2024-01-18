# robotdreams-16
Lesson #16


### Setup
- clone the project by run ```git clone git@github.com:Valentinishe/robotdreams-16.git```;
- go to root folder in the project;
- create `MongoDB` image by run ```docker build . -t mongo-image```;

### Run
- run `database` container by run ```docker run -d --name database -p 27017:27017 mongo-image```;

### Migration
- will be executed automatically, see `init-mongo.sh` file  

### Log in
- for log in to the server, please use MongoDB Compass client:
  - credentials:
    - IP: `localhost`
    - Port: `27017`
    - Username: `root`
    - Password: `root`
    - Database: `gymDatabase` 
  # or 
  - Mongo URI: `mongodb://root:root@localhost:27017/gymDatabase?authSource=gymDatabase`
- 

### Destroy
- run ```docker rm databese -f```;