provider "azurerm" {
   subscription_id = "${var.subscription_id}"
   client_id = "${var.client_id}"
   client_secret = "${var.client_secret}"
   tenant_id = "${var.tenant_id}"
}

resource "azurerm_resource_group" "k8s" {
    name     = "${var.resource_group_name}"
    location = "${var.location}"
}

resource "random_string" "fqdn" {
 length  = 6
 special = false
 upper   = false
 number  = false
}

resource "azurerm_public_ip" "public_ip" {
 name                         = "${var.env}-public-ip"
 location                     = "${var.location}"
 resource_group_name          = "${azurerm_resource_group.resource_group.name}"
 allocation_method = "Static"
 domain_name_label            = "${random_string.fqdn.result}"
}

resource "azurerm_log_analytics_workspace" "test" {
    name                = "${var.log_analytics_workspace_name}"
    location            = "${var.log_analytics_workspace_location}"
    resource_group_name = "${azurerm_resource_group.k8s.name}"
    sku                 = "${var.log_analytics_workspace_sku}"
}

resource "azurerm_log_analytics_solution" "test" {
    solution_name         = "ContainerInsights"
    location              = "${azurerm_log_analytics_workspace.test.location}"
    resource_group_name   = "${azurerm_resource_group.k8s.name}"
    workspace_resource_id = "${azurerm_log_analytics_workspace.test.id}"
    workspace_name        = "${azurerm_log_analytics_workspace.test.name}"

    plan {
        publisher = "Microsoft"
        product   = "OMSGallery/ContainerInsights"
    }
}

resource "azurerm_kubernetes_cluster" "k8s" {
    name                = "${var.cluster_name}"
    location            = "${azurerm_resource_group.k8s.location}"
    resource_group_name = "${azurerm_resource_group.k8s.name}"
    dns_prefix          = "${var.dns_prefix}"

    linux_profile {
        admin_username = "${var.admin_username}"

        ssh_key {
            key_data = "${file("${var.ssh_public_key}")}"
        }
    }

    agent_pool_profile {
        name            = "agentpool"
        count           = "${var.agent_count}"
        vm_size         = "${var.vm_size}"
        os_type         = "${var.os_type}"
        os_disk_size_gb = "${var.os_disk_size_gb}"
    }

    service_principal {
        client_id     = "${var.client_id}"
        client_secret = "${var.client_secret}"
    }

    addon_profile {
        oms_agent {
        enabled                    = true
        log_analytics_workspace_id = "${azurerm_log_analytics_workspace.test.id}"
        }
    }

    tags {
        Environment = "Development"
    }
}
