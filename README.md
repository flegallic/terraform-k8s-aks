# terraform-k8s-aks
Create a Kubernetes cluster using Terraform and AKS.

### Run container Azure cli
docker images mcr.microsoft.com/azure-cli:latest
docker run -it mcr.microsoft.com/azure-cli

### On container Azure cli
Install kubectl*

bash-4.4# az aks list
bash-4.4# az aks show --resource-group k8saks-ResourceGroup --name k8saks
bash-4.4# az aks get-credentials --resource-group k8saks-ResourceGroup --name k8saks --output yaml
bash-4.4# export KUBECONFIG=/root/.kube/config
bash-4.4# kubectl get nodes

### Help
Install kubectl           = *https://kubernetes.io/docs/tasks/tools/install-kubectl/#install-kubectl-on-linux \
Create K8S cluster on AKS = https://docs.microsoft.com/fr-fr/azure/terraform/terraform-create-k8s-cluster-with-tf-and-aks \
AKS command line          = https://docs.microsoft.com/en-us/cli/azure/aks?view=azure-cli-latest#az-aks-scale
