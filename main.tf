provider "azurerm" {
  version = "=1.20.0"
}

# We need the client config to get the tenant_id.
data "azurerm_client_config" "current" {}

# Create a resource group.
resource "azurerm_resource_group" "main" {
  name     = "${var.name}"
  location = "${var.location}"
}