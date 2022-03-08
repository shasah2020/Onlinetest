variable "appserver" {
    description = "name of the server"
    default = "appserver1"
}

variable "webserver" {
  description = "name of the server"
  default = "webserver1"
}

variable "resource_grp_name" {
    description = "the resource group of the project"
    default = "project_rg1"
}

variable "location" {
    decription = "location of resource group"
    default = "West Europe"
}

variable "vnet_app" {
    description = "name of the vnet"
    default = "vnetapp"
}

variable "vnet_web" {
    description = "name of the vnet"
    default = "vnetweb"
}

variable "address_space" {
    description = "the IP range for vnet"
    default = "[10.0.0.0/16]"
}

variable "address_prefix" {
    description = "address range of subnet"
    default = "[10.0.1.0/24]"
}

variable "address_prefix2" {
  description = "address range of subnet"
  default = "[10.0.2.0/24]"
}

variable "environment" {
  default = "dev"
}

variable "adminuser" {
  description = "admin user for server - pass at runtime"
}

variable "adminpass" {
  description = "admin password for server - pass at runtime"
}

variable "pub_ip" {
  description = "public ip for the webserver"
  default = "webserverip"
}