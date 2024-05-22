terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=2.48.0"
    }
  }
}
provider "azurerm" {
  features {}
  subscription_id            = "c61ea177-3092-49b2-b416-2742300b59fd"
  client_id                  = "d2eb23fb-162a-4198-87c8-16e573d59205"
  client_secret              = "1575bd5f-c65a-47c3-8ff6-1d7c90c94e90"
  tenant_id                  = "d7d3f2c0-a6ee-4480-8526-ea05647335b3
  skip_provider_registration = true
}

resource "azurerm_resource_group" "rg" {
  name     = "learnk8sResourceGroup"
  location = "eastus"
}

resource "azurerm_kubernetes_cluster" "cluster" {
  name                = "learnk8scluster"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  dns_prefix          = "learnk8scluster"

  default_node_pool {
    name       = "default"
    node_count = "2"
    vm_size    = "standard_d2_v2"
  }

  identity {
    type = "SystemAssigned"
  }
}
