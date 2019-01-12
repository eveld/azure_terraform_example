# The storage account for the function application.
resource "azurerm_storage_account" "store" {
  name                     = "${var.name}store"
  resource_group_name      = "${azurerm_resource_group.main.name}"
  location                 = "${azurerm_resource_group.main.location}"
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

# The service plan for the function application.
resource "azurerm_app_service_plan" "plan" {
  name                = "${var.name}plan"
  resource_group_name = "${azurerm_resource_group.main.name}"
  location            = "${azurerm_resource_group.main.location}"

  sku {
    tier = "Standard"
    size = "S1"
  }
}

# The function application.
resource "azurerm_function_app" "application" {
  name                      = "${var.name}fa"
  resource_group_name       = "${azurerm_resource_group.main.name}"
  location                  = "${azurerm_resource_group.main.location}"
  app_service_plan_id       = "${azurerm_app_service_plan.plan.id}"
  storage_connection_string = "${azurerm_storage_account.store.primary_connection_string}"
}