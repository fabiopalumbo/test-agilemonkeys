resource "azurerm_cdn_profile" "example" {
  name                = "example-cdn"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  sku                 = "Standard_Verizon"
}

resource "azurerm_cdn_endpoint" "example" {
  name                = "example"
  profile_name        = azurerm_cdn_profile.example.name
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name

  origin {
    name      = "example"
    host_name = "www.contoso.com"
  }
}

resource "azurerm_storage_account" "example" {
  name                     = "examplestoracc"
  resource_group_name      = azurerm_resource_group.example.name
  location                 = azurerm_resource_group.example.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_storage_container" "example" {
  name                  = "content"
  storage_account_name  = azurerm_storage_account.example.name
  container_access_type = "private"
}

resource "azurerm_storage_blob" "example" {
  name                   = "my-awesome-content.zip"
  storage_account_name   = azurerm_storage_account.example.name
  storage_container_name = azurerm_storage_container.example.name
  type                   = "Block"
  source                 = "some-local-file.zip"
}
