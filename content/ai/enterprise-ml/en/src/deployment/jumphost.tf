# Copyright (c) 2021 Microsoft
# 
# This software is released under the MIT License.
# https://opensource.org/licenses/MIT

# Jump host for testing VNET and Private Link

resource "azurerm_network_interface" "jumphost_nic" {
  name                = "jumphost-nic"
  location            = azurerm_resource_group.aml_rg.location
  resource_group_name = azurerm_resource_group.aml_rg.name

  ip_configuration {
    name                          = "configuration"
    private_ip_address_allocation = "Dynamic"
    subnet_id                     = azurerm_subnet.aml_subnet.id
    # public_ip_address_id          = azurerm_public_ip.jumphost_public_ip.id
  }
}

resource "azurerm_network_security_group" "jumphost_nsg" {
  name                = "jumphost-nsg"
  location            = azurerm_resource_group.aml_rg.location
  resource_group_name = azurerm_resource_group.aml_rg.name

  security_rule {
    name                       = "RDP"
    priority                   = 1010
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = 3389
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

resource "azurerm_network_interface_security_group_association" "jumphost_nsg_association" {
  network_interface_id      = azurerm_network_interface.jumphost_nic.id
  network_security_group_id = azurerm_network_security_group.jumphost_nsg.id
}

resource "azurerm_virtual_machine" "jumphost" {
  name                  = "jumphost"
  location              = azurerm_resource_group.aml_rg.location
  resource_group_name   = azurerm_resource_group.aml_rg.name
  network_interface_ids = [azurerm_network_interface.jumphost_nic.id]
  vm_size               = "Standard_DS3_v2"

  delete_os_disk_on_termination    = true
  delete_data_disks_on_termination = true

  storage_image_reference {
    publisher = "microsoft-dsvm"
    offer     = "dsvm-win-2019"
    sku       = "server-2019"
    version   = "latest"
  }

  os_profile {
    computer_name  = "jumphost"
    admin_username = var.jumphost_username
    admin_password = var.jumphost_password
  }

  os_profile_windows_config {
    provision_vm_agent        = true
    enable_automatic_upgrades = true
  }

  identity {
    type = "SystemAssigned"
  }

  storage_os_disk {
    name              = "jumphost-osdisk"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "StandardSSD_LRS"
  }
}

resource "azurerm_dev_test_global_vm_shutdown_schedule" "jumphost_schedule" {
  virtual_machine_id = azurerm_virtual_machine.jumphost.id
  location           = azurerm_resource_group.aml_rg.location
  enabled            = true

  daily_recurrence_time = "2000"
  timezone              = "W. Europe Standard Time"

  notification_settings {
    enabled = false
  }
}
