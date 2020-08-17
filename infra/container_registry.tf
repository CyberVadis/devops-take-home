provider "azurerm" {
   features {}
}

resource "azurerm_resource_group" "rg" {
  name     = "resourceGroupAntoni"
  location = "West Europe"
}

resource "azurerm_container_registry" "acr" {
  name                     = "cybtakehomeant"
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  sku                      = "Basic"
  admin_enabled            = true  
}

resource "null_resource" "docker_build"{
  triggers = {
    id =uuid()
  }

  provisioner "local-exec" {
    command = <<BASH
  cd ../

  docker login ${azurerm_container_registry.acr.login_server} -p ${azurerm_container_registry.acr.admin_password} -u ${azurerm_container_registry.acr.admin_username}
  docker build ./backend/app  -t ${azurerm_container_registry.acr.login_server}/cybbackendapp:latest
  docker build ./backend/db   -t ${azurerm_container_registry.acr.login_server}/cybbackenddb:latest
  docker build ./frontend  -t ${azurerm_container_registry.acr.login_server}/cybfrontend:latest

  docker push ${azurerm_container_registry.acr.login_server}/cybbackendapp:latest
  docker push ${azurerm_container_registry.acr.login_server}/cybbackenddb:latest
  docker push ${azurerm_container_registry.acr.login_server}/cybfrontend:latest


  kubectl get secret regcred
  if [ $? -eq 0 ]
  then
    echo "Secret already defined"
  else
    kubectl create secret docker-registry regcred --docker-server=${azurerm_container_registry.acr.login_server} --docker-username=${azurerm_container_registry.acr.admin_username} --docker-password=${azurerm_container_registry.acr.admin_password}
  fi


BASH
  }
}



resource "azurerm_kubernetes_cluster" "takehome" {
  name                = "takehome-aks1"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  dns_prefix          = "takehome"

  default_node_pool {
    name       = "default"
    node_count = 1
    vm_size    = "Standard_D2_v2"
  }

  identity {
    type = "SystemAssigned"
  }

  tags = {
    Environment = "Testing"
  }
}

output "client_certificate" {
  value = azurerm_kubernetes_cluster.takehome.kube_config.0.client_certificate
}

output "kube_config" {
  value = azurerm_kubernetes_cluster.takehome.kube_config_raw
}
