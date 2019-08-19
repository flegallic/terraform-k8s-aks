# terraform-k8s-aks
Create a Kubernetes cluster using Terraform and AKS.

## Run container with Docker
~$ docker images mcr.microsoft.com/azure-cli:latest \
~$ docker run -it mcr.microsoft.com/azure-cli

## Create K8S cluster
install terraform -> https://learn.hashicorp.com/terraform/getting-started/install.html

## Manage K8S cluster
- Run commands \
bash-4.4# curl -LO https://storage.googleapis.com/kubernetes-release/release/`curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt`/bin/linux/amd64/kubectl \
bash-4.4# chmod +x ./kubectl \
bash-4.4# mv ./kubectl /usr/local/bin/kubectl \
bash-4.4# kubectl version \
bash-4.4# az login
bash-4.4# az aks list
bash-4.4# az aks show --resource-group k8saks-ResourceGroup --name k8saks \
bash-4.4# az aks get-credentials --resource-group k8saks-ResourceGroup --name k8saks --output yaml \
bash-4.4# export KUBECONFIG=/root/.kube/config \
bash-4.4# kubectl get nodes

## Help
Install kubectl           = *https://kubernetes.io/docs/tasks/tools/install-kubectl/#install-kubectl-on-linux \
Create K8S cluster on AKS = https://docs.microsoft.com/fr-fr/azure/terraform/terraform-create-k8s-cluster-with-tf-and-aks \
AKS command line          = https://docs.microsoft.com/en-us/cli/azure/aks?view=azure-cli-latest#az-aks-scale
