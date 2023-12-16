# robotdreams-14
Lesson #14


## Steps for prepared Manager:
- create one EC2 instances with Ubuntu 22.04 + t2.nano type + Custom VPC + 20GB Storage
- update instance `apt update`
- install unzip `apt install unzip`
- download AWS CLI `curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"`
- unzip archive `unzip awscliv2.zip`
- install aws cli `./aws/install`
- aws configure `aws configure` and PUT your credentials of user
- download kubectl `curl --silent --location -o /usr/local/bin/kubectl   https://s3.us-west-2.amazonaws.com/amazon-eks/1.22.6/2022-03-09/bin/linux/amd64/kubectl`
- enable execution kubectl `chmod +x /usr/local/bin/kubectl`
- download eksctl `curl --silent --location "https://github.com/weaveworks/eksctl/releases/latest/download/eksctl_$(uname -s)_amd64.tar.gz" | tar xz -C /tmp`
- move eksctl `mv /tmp/eksctl /usr/local/bin/`
- curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3
- change permission to file `chmod 700 get_helm.sh`
- install helm ` ./get_helm.sh`
- install prometheus `helm repo add prometheus-community https://prometheus-community.github.io/helm-charts`
- create namespace `kubectl create namespace prometheus`
- added prometheus to namespace `helm install stable prometheus-community/kube-prometheus-stack -n prometheus`
- change CLusterIP to LoadBalancer (Prometheus) `kubectl edit svc stable-kube-prometheus-sta-prometheus -n prometheus`
- change CLusterIP to LoadBalancer (Grafana) `kubectl edit svc stable-grafana -n prometheus`
- get password from Grafana`kubectl get secrets -n prometheus`
- `scp -i vpc-key.pem deployment.yml ubuntu@ec2-3-84-61-117.compute-1.amazonaws.com:/home/ubuntu`
- deploy `kubectl apply -f deployment.yml`