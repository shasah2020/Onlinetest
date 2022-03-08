#create an nsg
resource "azurerm_network_security_group" "webserver" {
  name                = "secgroup"
  resource_group_name = azurerm_resource_group.project_rg1.name
  location            = azurerm_resource_group.project_rg1.location
}

#create an nsg rule to allow http traffic to webserver
resource "azurerm_network_security_rule" "allowhttp" {
  name                        = "allowhttp"
  priority                    = 100
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "80"
  destination_port_range      = "*"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name = azurerm_resource_group.project_rg1.name
  network_security_group_name = azurerm_network_security_group.webserver.name
}

#attach nsg to webserver subnet
resource "azurerm_subnet_network_security_group_association" "web" {
  subnet_id                 = azurerm_subnet.external.id
  network_security_group_id = azurerm_network_security_group.webserver.id
}


resource "azurerm_network_security_group" "appserver" {
  name                = "secgroup"
  resource_group_name = azurerm_resource_group.project_rg1.name
  location            = azurerm_resource_group.project_rg1.location
}

#create an nsg rule to deny http traffic to appserver
resource "azurerm_network_security_rule" "denyhttp" {
  name                        = "denyhttp"
  priority                    = 100
  direction                   = "Inbound"
  access                      = "Deny"
  protocol                    = "Tcp"
  source_port_range           = "80"
  destination_port_range      = "*"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name = azurerm_resource_group.project_rg1.name
  network_security_group_name = azurerm_network_security_group.appserver.name
}

#create an nsg rule to deny http traffic to appserver
resource "azurerm_network_security_rule" "allowVnet_inbound" {
  name                        = "allowVnet_inbound"
  priority                    = 100
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "5432"
  source_address_prefix       = var.web_address_prefix
  destination_address_prefix  = var.app_address_prefix
  resource_group_name = azurerm_resource_group.project_rg1.name
  network_security_group_name = azurerm_network_security_group.appserver.name
}
#attach nsg to appserver subnet
resource "azurerm_subnet_network_security_group_association" "app" {
  subnet_id                 = azurerm_subnet.internal.id
  network_security_group_id = azurerm_network_security_group.appserver.id
}