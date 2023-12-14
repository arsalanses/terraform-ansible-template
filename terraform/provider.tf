terraform {
  required_providers {
    arvan = {
      source  = "arvancloud/arvan"
      version = "0.6.4"
    }
  }
}

provider "arvan" {
  api_key = var.ApiKey
}
