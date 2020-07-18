resource "azurerm_storage_account" "to_monitor" {
  name                     = "Alert_Storage"
  resource_group_name      = azurerm_resource_group.main.name
  location                 = azurerm_resource_group.main.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_monitor_action_group" "main" {
  name                = "${var.alert_name}-actiongroup"
  resource_group_name = azurerm_resource_group.main.name
  short_name          = "${var.alert_name}act"

  webhook_receiver {
    name        = "slack"
    service_uri = "https://hooks.slack.com/services/{azerty}/XXXXXXXXXXXXXXx/{hook-key}"
  }
}

resource "azurerm_monitor_metric_alert" "example" {
  name                = "${var.alert_name}-metricalert"
  resource_group_name = azurerm_resource_group.main.name
  scopes              = [azurerm_storage_account.to_monitor.id]
  description         = "Action will be triggered when Transactions count is greater than 50."

  criteria {
    metric_namespace = "Microsoft.Storage/storageAccounts"
    metric_name      = "Transactions"
    aggregation      = "Total"
    operator         = "GreaterThan"
    threshold        = 50

    dimension {
      name     = "ApiName"
      operator = "Include"
      values   = ["*"]
    }
  }

  action {
    action_group_id = azurerm_monitor_action_group.main.id
  }
}
