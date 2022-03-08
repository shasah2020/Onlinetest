#network interface for the appserver
resource "azurerm_network_interface" "nic" {
  name                = "nic1"
  location            = azurerm_resource_group.project_rg1.location
  resource_group_name = azurerm_resource_group.project_rg1.name
  
  ip_configuration {
    name                          = "ipconfig1"
    subnet_id                     = azurerm_subnet.internal.id
    private_ip_address_allocation = "Dynamic"
  }
}

#appserver for hosting database
resource "azurerm_virtual_machine" "appserver1" {
  name                  = var.appserver
  resource_group_name   = azurerm_resource_group.project_rg1.name
  location              = azurerm_resource_group.project_rg1.location
  network_interface_ids = [azurerm_network_interface.nic.id]
  vm_size               = "Standard_E64s_v3"
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
