#resource group for the project
resorce "azurerm_resource_group" "project_rg1" {
    name     = var.resource_grp_name
    location = var.location
}

#vnet for the app 
resource "azurerm_virtual_network" "vnetapp" {
    name                = var.vnet_app
    address_space       = var.address_space
    location            = azurerm_resource_group.project_rg1.location
    resource_group_name = azurerm_resource_group.project_rg1.name
}

#subnet for the appserver
resource "azurerm_subnet" "internal" {
    name                 = "internal"
    resource_group_name  = azurerm_resource_group.project_rg1.name
    virtual_network_name = azurerm_virtual_network.vnet1.name
    address_prefixes     = var.app_address_prefix
}

#vnet for the webserver
resource "azurerm_virtual_network" "vnetweb" {
    name                = var.vnet_web
    address_space       = var.address_space
    location            = azurerm_resource_group.project_rg1.location
    resource_group_name = azurerm_resource_group.project_rg1.name
}

#subnet for external
resource "azurerm_subnet" "external" {
    name                 = "external"
    resource_group_name  = azurerm_resource_group.project_rg1.name
    virtual_network_name = azurerm_virtual_network.vnet2.name
    address_prefixes     = var.web_address_prefix
}
