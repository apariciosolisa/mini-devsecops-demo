provider "azurerm" {
  features = {}
}

resource "azurerm_resource_group" "rg" {
  name     = "rg-devsecops"
  location = "East US"
}

resource "azurerm_app_service_plan" "asp" {
  name                = "asp-devsecops"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  sku {
    tier = "Basic"
    size = "B1"
  }
}

resource "azurerm_app_service" "app" {
  name                = "app-devsecops-${random_id.rand.hex}"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  app_service_plan_id = azurerm_app_service_plan.asp.id

  site_config {
    linux_fx_version = "DOCKER|<TU_USUARIO>.azurecr.io/devsecops-app:latest"
  }

  app_settings = {
    WEBSITES_PORT = "5000"
  }

  identity {
    type = "SystemAssigned"
  }
}

resource "random_id" "rand" {
  byte_length = 4
}