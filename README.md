# terraform-k8s-aks
Create a Kubernetes cluster using Terraform and AKS.

## Prerequisites
- Azure subscription
- Azure service principal
- Azure storage
- B2s is a minimum AKS instance to create a kubernetes cluster on Azure
- Docker
- Terraform

## Create a K8S cluster
#### clone repository
git clone git@github.com:haxware/terraform-k8s-aks.git
#### add your Azure account subscription
terraform-k8s-aks/secret.tf
#### SSH Key
check your private key (id_rsa and id_rsa.pub)
#### run script on your local machine
. createK8sCluster.sh

## Manage your K8S cluster
#### Run an azure-cli container on local machine
docker images mcr.microsoft.com/azure-cli:latest \
docker run -it mcr.microsoft.com/azure-cli
#### On the container
bash-5.0# curl -LO https://storage.googleapis.com/kubernetes-release/release/`curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt`/bin/linux/amd64/kubectl \
bash-5.0# chmod +x ./kubectl \
bash-5.0# mv ./kubectl /usr/local/bin/kubectl \
bash-5.0# kubectl version \
bash-5.0# \
bash-5.0# az login  \
bash-5.0# az storage container create -n tfstate --account-name "YourAzureStorageAccountName" --account-key "YourAzureStorageAccountKey" \
bash-5.0# az aks list  \
bash-5.0# az aks show --resource-group k8saks-ResourceGroup --name k8saks \
bash-5.0# az aks get-credentials --resource-group k8saks-ResourceGroup --name k8saks --output yaml \
bash-5.0# export KUBECONFIG=/root/.kube/config \
bash-5.0# kubectl config get-clusters \
bash-5.0# kubectl config get-contexts \
bash-5.0# kubectl get nodes

## Connect with SSH to Azure Kubernetes Service
#### Check internal IP addresses of all the nodes in the cluster
bash-5.0# kubectl get nodes -o wide
#### Run a Debian container to create an SSH connection to an AKS node
bash-5.0# kubectl run --generator=run-pod/v1 -it --rm aks-ssh --image=debian
#### On the container
apt-get update && apt-get install openssh-client vim -y  \
vim .ssh/id_rsa (copy your private SSH key)  \
kubectl cp ~/.ssh/id_rsa $(kubectl get pod -l run=aks-ssh -o jsonpath='{.items[0].metadata.name}'):/id_rsa  \
chmod 0600 id_rsa  \
ssh -i id_rsa azureuser@IP_NODE
#### Connect on your Node
ubuntu@aks-agentpool-24072430-0:~$

## nginx deployment
#### On the container
bash-5.0# kubectl apply -f https://k8s.io/examples/application/deployment.yaml \
bash-5.0# kubectl get deployment \
bash-5.0# kubectl get pods -l app=nginx \
bash-5.0# kubectl expose deployment {{your-nginx-pods}} --port=80 --type=LoadBalancer \
bash-5.0# kubectl get service
#### Azure environment
All services -> Public IP addresses -> kubernetes-{{id}} -> Overview -> {{your-IP Address}}
#### Connect to nginx
http://{{your-IP Address}}

## Remove a K8S cluster
#### run script on local machine
. removeK8sCluster.sh

## Help
Install terraform         = https://learn.hashicorp.com/terraform/getting-started/install.html \
Install docker            = https://docs.docker.com/install/ \
Install kubectl           = https://kubernetes.io/docs/tasks/tools/install-kubectl/#install-kubectl-on-linux \
Create K8S cluster on AKS = https://docs.microsoft.com/fr-fr/azure/terraform/terraform-create-k8s-cluster-with-tf-and-aks \
SSH to AKS                = https://docs.microsoft.com/fr-fr/azure/aks/ssh \
AKS command line          = https://docs.microsoft.com/en-us/cli/azure/aks?view=azure-cli-latest#az-aks-scale
