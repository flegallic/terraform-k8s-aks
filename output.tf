###OUTPUT for env k8s-aks
output "k8s-aks client_key" {
    value = "${module.k8s-aks.client_key}"
}

output "k8s-aks client_certificate" {
    value = "${module.k8s-aks.client_certificate}"
}

output "k8s-aks cluster_ca_certificate" {
    value = "${module.k8s-aks.cluster_ca_certificate}"
}

output "k8s-aks cluster_username" {
    value = "${module.k8s-aks.cluster_username}"
}

output "k8s-aks cluster_password" {
    value = "${module.k8s-aks.cluster_password}"
}

output "k8s-aks kube_config" {
    value = "${module.k8s-aks.kube_config}"
}

output "host" {
    value = "${module.k8s-aks.host}"
}
