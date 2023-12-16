# robotdreams-12
Lesson #12


## Steps for prepared Master:
- create one EC2 instances with Ubuntu 22.04 + t3.medium type + Custom VPC + 20GB Storage
- change name of intstance for terminal: `sudo hostnamectl set-hostname "k8smaster" && exec bash`
- go to /etc/hosts and add Public IPs your instances: 
{Public IP of master node} k8smaster 
{Public IP of worker node} k8sworker
- disabled swap by run `sudo swapoff -a`
- prepared place and install modules
  - run installer `sudo tee /etc/modules-load.d/containerd.conf <<EOF`
  - pass `overlay` module
  - pass `br_netfilter` module
  - pass `EOF`
- checking instaled modules by run `cat /etc/modules-load.d/containerd.conf`
- enabled overlay by run `sudo modprobe overlay`
- enabled br_netfilter by run `sudo modprobe br_netfilter`
- setup core of kubernetes:
  - run setup by `sudo tee /etc/sysctl.d/kubernetes.conf <<EOF`
  - pass `net.bridge.bridge-nf-call-ip6tables = 1`
  - pass `net.bridge.bridge-nf-call-iptables = 1`
  - pass `net.ipv4.ip_forward = 1`
  - pass `EOF`
- install additionals packages by run `sudo apt update && sudo apt install -y curl gnupg2 software-properties-common apt-transport-https ca-certificates`
- add repositories 
 - `sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmour -o /etc/apt/trusted.gpg.d/docker.gpg`
 - `sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"`
 - update system by `sudo apt update`
 - setup containerd:
  - install `sudo apt install -y containerd.io`
  - set config `containerd config default | sudo tee /etc/containerd/config.toml >/dev/null 2>&1`
  - checking SystemdCgroup by run `cat /etc/containerd/config.toml | grep Systemd`
  - set value on "true" for SystemdCgroup `sudo sed -i 's/SystemdCgroup \= false/SystemdCgroup \= true/g' /etc/containerd/config.toml`
  - restart service containerd `sudo systemctl restart containerd.service`
  - enable service containerd `sudo systemctl enable containerd.service`
- setup k8s
 - `curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo gpg --dearmour -o /etc/apt/trusted.gpg.d/kubernetes-xenial.gpg`
 - `sudo apt-add-repository "deb http://apt.kubernetes.io/ kubernetes-xenial main"`
 - `sudo apt update`
 - `sudo apt install -y kubelet kubeadm kubectl`
 - blocked packeges by `sudo apt-mark hold kubelet kubeadm kubectl`
- `sudo sysctl --system`


## Steps for prepared Workers:
- create X EC2 instances with Ubuntu 22.04 + t3.medium type + Custom VPC + 20GB Storage
- change name of intstance for terminal: `sudo hostnamectl set-hostname "k8sworker" && exec bash`
- go to /etc/hosts and add Public IPs your instances:
`
{Public IP of master node} k8smaster 
{Public IP of worker node} k8sworker
`
- disabled swap by run `sudo swapoff -a`
- prepared place and install modules
  - run installer `sudo tee /etc/modules-load.d/containerd.conf <<EOF`
  - pass `overlay` module
  - pass `br_netfilter` module
  - pass `EOF`
- checking instaled modules by run `cat /etc/modules-load.d/containerd.conf`
- enabled overlay by run `sudo modprobe overlay`
- enabled br_netfilter by run `sudo modprobe br_netfilter`
- setup core of kubernetes:
  - run setup by `sudo tee /etc/sysctl.d/kubernetes.conf <<EOF`
  - pass `net.bridge.bridge-nf-call-ip6tables = 1`
  - pass `net.bridge.bridge-nf-call-iptables = 1`
  - pass `net.ipv4.ip_forward = 1`
  - pass `EOF`
- install additionals packages by run `sudo apt update && sudo apt install -y curl gnupg2 software-properties-common apt-transport-https ca-certificates`
- add repositories 
 - `sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmour -o /etc/apt/trusted.gpg.d/docker.gpg`
 - `sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"`
 - update system by `sudo apt update`
 - setup containerd:
  - install `sudo apt install -y containerd.io`
  - set config `containerd config default | sudo tee /etc/containerd/config.toml >/dev/null 2>&1`
  - checking SystemdCgroup by run `cat /etc/containerd/config.toml | grep Systemd`
  - set value on "true" for SystemdCgroup `sudo sed -i 's/SystemdCgroup \= false/SystemdCgroup \= true/g' /etc/containerd/config.toml`
  - restart service containerd `sudo systemctl restart containerd.service`
  - enable service containerd `sudo systemctl enable containerd.service`
- setup k8s
 - `curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo gpg --dearmour -o /etc/apt/trusted.gpg.d/kubernetes-xenial.gpg`
 - `sudo apt-add-repository "deb http://apt.kubernetes.io/ kubernetes-xenial main"`
 - `sudo apt update`
 - `sudo apt install -y kubelet kubeadm kubectl`
 - blocked packeges by `sudo apt-mark hold kubelet kubeadm kubectl`
- `sudo sysctl --system`


## Steps for running cluster:
- `sudo kubeadm init --control-plane-endpoint=k8smaster` (Master)
- `mkdir -p $HOME/.kube` (Master)
- `sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config` (Master)
- `sudo chown $(id -u):$(id -g) $HOME/.kube/config` (Master)
- get info about k8s cluster `kubectl cluster-info` (Master)
- get nodes `kubectl get nodes` (Master)
- copy from Master and run in Workers `kubeadm join k8smaster:6443 --token m3fmys.4zczhojw6tor7ke7 --discovery-token-ca-cert-hash sha256:${token}` (Workers)
- get nodes `kubectl get nodes` for checking joon Worker  (Master)
- add plugin `kubectl apply -f https://raw.githubusercontent.com/projectcalico/calico/v3.25.0/manifests/calico.yaml` (Master)
- get namespaces `kubectl get namespaces` (Master)
- create nginx `kubectl create deployment nginx-app --image=nginx --replicas=2` (Master)
- checking working nginx `kubectl get deployment`
- get info about nginx pods `kubectl describe pods {name of pod}`
- expose port for nginx `kubectl expose deployment nxinx-app --type=NodePort --port=80`
- get Info abot port nginx `kubectl get svc nginx-app`
- create secret for mysql `kubectl create secret generic mysql-secret --from-literal=mysql-user=admin --from-literal=mysql-password=passport123`
- run mysql `kubectl run mysql-deployment --image=mysql:latest --env MYSQL_ROOT_PASSWORD=$(kubectl get secret mysql-secret -o=jsonpath='{.data.mysql-password}' | base64 --decode) --env MYSQL_DATABASE=mydb --env=MYSQL_USER=$(kubectl get secret mysql-secret -o=jsonpath='{.data.mysql-user}' | base64 --decode) --env=MYSQL_PASSWORD=$(kubectl get secret mysql-secret -o=jsonpath='{.data.mysql-password}' | base64 --decode)`
`kubectl run --it --rm --image=mysql:latest mysql-client -- /bin/bash`
