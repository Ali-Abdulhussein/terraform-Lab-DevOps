#Terraform block
terraform {
  required_providers {
    #variable used in provider
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0.2"
    }
  }
  backend "azurerm" {
    resource_group_name  = "tf_rg_blobstorage"
    storage_account_name = "tfstoragestatefile"
    container_name       = "tfstatefilecontainer"
    key                  = "terraform.tfstate"

  }
  required_version = ">=0.12"
}

#Get this variable from terraform block required_providers
#Can use own file provider.tf
provider "azurerm" {
  features {}
}
#should by just the last part of Pipeline Variable TF_VAR_(imagebuild):
variable "imagebuild" {
  type        = string
  description = "Latest Image Build TF_VAR_(imagebuild)"
}
#Resource block and can also move to its own file
resource "azurerm_resource_group" "rg" {
  name     = "tr_devops_rg"
  location = "westus2"
}

resource "azurerm_container_group" "cg" {
  name                = "app-api-container"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  ip_address_type = "Public"
  dns_name_label  = "trLabDevopsAppApi"
  os_type         = "Linux"

  container {
    name   = "app-api"
    image  = "aliabdulhussein/app-api:${var.imagebuild}"
    cpu    = "1"
    memory = "1"

    ports {
      port     = 80
      protocol = "TCP"
    }

  }
}
