# robotdreams-11
Lesson #11


### Prepare Local Machine
- clone the project by run ```git clone git@github.com:Valentinishe/robotdreams-11.git```;
- go to root folder in the project;

### Prepare Server Image
- go to /server folder
- create `nodejs` image by run ```docker build . -t nodejs```;
- need tag image by run ```docker tag {containerID from nodejs image }  . -t {name of repository from DockerHub}```;
- push image to DockerHub by run ```docker push {name of repository from DockerHub}:1.0```;

### Prepare DB Image
- go to /db folder
- create `mongodb` image by run ```docker build . -t mongodb```;
- need tag image by run ```docker tag {containerID from mongodb image }  . -t {name of repository from DockerHub}```;
- push image to DockerHub by run ```docker push {name of repository from DockerHub}:1.0```;

### Prepare EC2
- setup VPC (with 3 subdomains, 1 RouteTable and 1 IGW)
- setup SG for VPC ( open all need ports)
- launch 3 instances (Master, Worker1, Worker2):
  - used VPC and SG from previous steps
  - chooise t2.micro and image Amazon Linux 2023 AMI 2023.2.2
chooise your SSH key (optional)
  - also switch "Auto-assign public IP" to enable

- install docker for all instance, need run for every:
  - sudo su
  - yum install docker
  - service docker start
  - sudo chkconfig docker on

- initialize swarm mode
In Master instance, please run `docker swarm init` and copy result (must be like `docker swarm join --token {TOKEN} {IP}:2377`), then past and run  in every WorkerX.
For checking result need run (in Master) `docker node ls` where will display all connected instances.

- deploy the stack:
  - create stack.yml file in Master with contants from repository (docker-compoese.yml file)
  - run: ```docker stack deploy -c stack.yml {name of future stack/cluster}```

- that's all!


### Stopping Stack
- run ```docker stack rm {name of stack}```; (in Master)
 
### Destroy Swarm
- run ```docker swarm leave -force```; (in every instance)