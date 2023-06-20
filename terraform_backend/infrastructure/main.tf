resource "azurerm_resource_group" "tfstate" {
  name     = "tfstate"
  location = "West Europe"
}

resource "azurerm_storage_account" "tfstate" {
  name                     = substr("tfstate${sha256(upper(var.owner))}", 0, 24)
  resource_group_name      = azurerm_resource_group.tfstate.name
  location                 = azurerm_resource_group.tfstate.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags = {
    owner = var.owner
  }
}

resource "azurerm_storage_container" "tfstate" {
  name                  = "tfstate"
  storage_account_name  = azurerm_storage_account.tfstate.name
  container_access_type = "private"
}