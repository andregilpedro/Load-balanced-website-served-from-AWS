provider "aws" {
  # Default provider
  region = "eu-west-1"
  default_tags {
    tags = {
      ManagedBy = "terraform",
      Region    = "eu-west-1",
      Owner     = "Andre Pedro"
    }
  }
}

terraform {
  required_version = "~> 1.7.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}
