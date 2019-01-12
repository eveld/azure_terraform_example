# Create a vault to store our secret.
resource "azurerm_key_vault" "vault" {
  name = "${var.name}kv"
  resource_group_name = "${azurerm_resource_group.main.name}"
  location = "${azurerm_resource_group.main.location}"
  tenant_id = "${data.azurerm_client_config.current.tenant_id}"
  enabled_for_disk_encryption = true

  sku {
    name = "standard"
  }
}

# Create a secret with the passed in value.
resource "azurerm_key_vault_secret" "secret" {
  name = "my-secret"
  value = "${var.secret}"
  vault_uri = "${azurerm_key_vault.vault.vault_uri}"
}

# Allow the function application to get the secret.
resource "azurerm_key_vault_access_policy" "allow_app" {
  vault_name          = "${azurerm_key_vault.vault.name}"
  resource_group_name = "${azurerm_resource_group.main.name}"

  tenant_id = "${data.azurerm_client_config.current.tenant_id}"
  object_id = "${azurerm_function_app.application.identity.principal_id}"

  key_permissions = [
    "get",
  ]

  secret_permissions = [
    "get",
  ]
}
