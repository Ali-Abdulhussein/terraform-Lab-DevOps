#Terraform block
terraform {
  required_providers {
    #variable used in provider
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0.2"
    }
  }
  required_version = ">=0.12"
}

#Get this variable from terraform block required_providers
#Can use own file provider.tf
provider "azurerm" {
  features {}
}


#Resource block and can also move to its own file
resource "azurerm_resource_group" "rg" {
  name     = "tr_devops_rg"
  location = "westus2"
}

resource "azurerm_container_group" "cg" {
  name                = "app-api"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  
  ip_address_type     = "Public"
  dns_name_label      = "trLabDevopsAppApi"
  os_type             = "Linux"

  container {
    name   = "app-api"
    image  = "aliabdulhussein/app-api"
    cpu    = "1"
    memory = "1"

    ports {
      port     = 80
      protocol = "TCP"
    }

  }
}
