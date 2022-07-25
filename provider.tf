terraform {
  required_providers {
    arvan = {
      source = "arvancloud/arvan"
      version = "0.6.3"
    }
  }
}

provider "arvan" {
  api_key = "ARVAN-API-KEY"
}
