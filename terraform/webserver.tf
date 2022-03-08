
#assign public ip to the webserver
resource "azurerm_public_ip" "pub_ip" {
  name                = var.pub_ip
  resource_group_name = azurerm_resource_group.project_rg1.name
  location            = azurerm_resource_group.project_rg1.location
  allocation_method   = "Static"

  tags = {
    environment = var.env
  }
}

resource "azurerm_virtual_machine" "webserver1" {
  name                  = var.webserver
  resource_group_name   = azurerm_resource_group.project_rg1.name
  location              = azurerm_resource_group.project_rg1.location
  network_interface_ids = [azurerm_network_interface.nic.id]
  vm_size               = "Standard_DS1_v2"
  os_profile_linux_config {
    disable_password_authentication = false
  }
  storage_os_disk {
    name              = "myosdisk1"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }
  os_profile {
    computer_name  = "hostname"
    admin_username = var.adminuser
    admin_password = var.adminpass
  }
  
  tags = {
    environment = var.env
  }
}