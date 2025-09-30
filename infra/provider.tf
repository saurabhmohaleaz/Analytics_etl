terraform {
  required_providers {
    azurerm={
        source = "hashicorp/azurerm"
        version = "~>3.0"
    }
    random={
        source = "hashicorp/random"
        version = "~>3.0"
    }
  }
  backend "azurerm" {
    storage_account_name = "backendadls2512"
    resource_group_name = "backend-rg"
    container_name = "tfstate"
    key = "tf.state"
  }
}
provider azurerm{
    features {
    
    }

}