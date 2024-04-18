terraform {
  required_providers {
    tfe = {
      version = "~> 0.53.0"
    }
  }
  cloud {
    organization = "ben-miles-org"

    workspaces {
      name = "utils-copy-Variable-set"
    }
  }
}
provider "tfe" {
  token    = var.token
  organization = var.orgname
}