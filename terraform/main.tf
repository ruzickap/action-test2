terraform {
  required_providers {
    github = {
      source  = "integrations/github"
      version = ">= 4.23.0"
    }
    tls = {
      source  = "hashicorp/tls"
      version = "3.3.0"
    }
  }
}

resource "tls_private_key" "main" {
  algorithm   = "ECDSA"
  ecdsa_curve = "P256"
}

resource "github_repository_deploy_key" "main" {
  title      = "test123"
  repository = "action-test2"
  key        = tls_private_key.main.public_key_openssh
  read_only  = true
}
