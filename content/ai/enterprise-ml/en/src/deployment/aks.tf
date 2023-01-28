# Copyright (c) 2021 Microsoft
# 
# This software is released under the MIT License.
# https://opensource.org/licenses/MIT

# Azure Kubernetes Service (not deployed per default)

resource "azurerm_kubernetes_cluster" "aml_aks" {
  count               = var.deploy_aks ? 1 : 0
  name                = "${var.prefix}-aks-${random_string.postfix.result}"
  location            = azurerm_resource_group.aml_rg.location
  resource_group_name = azurerm_resource_group.aml_rg.name
  dns_prefix          = "aks"

  default_node_pool {
    name       = "default"
    node_count = 3
    vm_size    = "Standard_DS2_v2"
	  vnet_subnet_id = azurerm_subnet.aks_subnet[count.index].id
  }
  
  identity {
    type = "SystemAssigned"
  }
  
  network_profile {
    network_plugin     = "azure"
    dns_service_ip     = "10.0.3.10"
    service_cidr       = "10.0.3.0/24"
	  docker_bridge_cidr = "172.17.0.1/16"
  }  
  
  provisioner "local-exec" {
    command = "az ml computetarget attach aks -n ${azurerm_kubernetes_cluster.aml_aks[count.index].name} -i ${azurerm_kubernetes_cluster.aml_aks[count.index].id} -g ${var.resource_group} -w ${azurerm_machine_learning_workspace.aml_ws.name}"
  }
  
  depends_on = [azurerm_machine_learning_workspace.aml_ws]
}
