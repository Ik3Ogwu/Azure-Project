# Configure the Azure provider
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.0.0"
    }
  }
}

provider "azurerm" {
  features {}
}

# Create a resource group
resource "azurerm_resource_group" "rg" {
  name     = "Azure-project-rg"
  location = "eastus"
}

# Create a storage account
resource "azurerm_storage_account" "storage" {
  name                     = "azureprojectstorage"
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

# Create a storage container
resource "azurerm_storage_container" "container" {
  name                  = "results"
  storage_account_name  = azurerm_storage_account.storage.name
  container_access_type = "private"
}

# Create a storage queue
resource "azurerm_storage_queue" "queue" {
  name                 = "f1-results-queue"
  storage_account_name = azurerm_storage_account.storage.name
}

# Create an AKS cluster
resource "azurerm_kubernetes_cluster" "aks" {
  name                = "f1-results-aks"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  dns_prefix          = "f1resultsaks"

  default_node_pool {
    name       = "default"
    node_count = 1
    vm_size    = "Standard_D2_v2"
  }

  identity {
    type = "SystemAssigned"
  }
}

# Output the AKS cluster name
output "kubernetes_cluster_name" {
  value = azurerm_kubernetes_cluster.aks.name
}

# Output the resource group name
output "resource_group_name" {
  value = azurerm_resource_group.rg.name
}
