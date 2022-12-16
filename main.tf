terraform {
  required_version = ">= 0.12"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 2.19.0"
    }
  }
}

provider "aws" {
  region = var.region
}

terraform {
  backend "s3" {
  }
}
