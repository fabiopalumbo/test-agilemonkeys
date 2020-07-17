
resource "azurerm_storage_account" "appstorage" {
  name                      = "appstorage${var.environment}"
  resource_group_name       = var.environment
  location                  = var.location
  account_tier              = "Standard"
  account_replication_type  = "RAGRS"
  account_kind              = "BlobStorage"
}

resource "azurerm_storage_container" "blob" {
  name                  = "blob"
  resource_group_name   = var.environment
  storage_account_name  = azurerm_storage_account.appstorage.name
  container_access_type = "blob"
}

resource "azurerm_cdn_profile" "app_cdn_profile" {
  name                = "app-cdn-profile-${var.environment}"
  location            = var.location}"
  resource_group_name = var.environment
  sku                 = "Standard_Akamai"
}

resource "azurerm_cdn_endpoint" "app" {
  name                = "app${var.environment}"
  profile_name        = azurerm_cdn_profile.app_cdn_profile.name
  location            = var.location
  resource_group_name = var.environment

  origin {
    name      = "consents-documents"
    host_name = "${azurerm_storage_account.appstorage.name}.blob.core.windows.net"
  }
}
