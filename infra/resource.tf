
resource "azurerm_resource_group" "rg" {
  name = "analytics_rg"
  location = "centralindia"
}

resource "azurerm_storage_account" "adls" {
  name = "analyticsadls2512"
  resource_group_name = azurerm_resource_group.rg.name
  account_replication_type = "GRS"
  account_tier = "Standard"
  location = azurerm_resource_group.rg.location
  is_hns_enabled = true
}
resource "azurerm_storage_container" "container" {
  for_each = toset(["bronze","sliver","gold"])
  name = each.value
  storage_account_name = azurerm_storage_account.adls.name
}
resource "azurerm_data_factory" "adf" {
  name = "analyticsadf"
  resource_group_name = azurerm_resource_group.rg.name
  location = azurerm_resource_group.rg.location
}
resource "azurerm_databricks_workspace" "dbws" {
  name = "analyticsdbws"
  resource_group_name = azurerm_resource_group.rg.name
  location = azurerm_resource_group.rg.location
  sku = "standard"
}