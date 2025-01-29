
################################################################################
# CHILD MODULE
################################################################################


terraform {
  required_version = ">=1.1.0" # version

  backend "s3" {
    bucket         = "3-tier-architecture-implementation"
    key            = "path/env"
    region         = "us-east-1"
    dynamodb_table = "terraform-lock"
    encrypt        = true
  }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

################################################################################
# PROVIDERS BLOCK
################################################################################

provider "aws" {
  region = "us-east-1"

  default_tags {
    tags = {
      ChangeCode = "100283836HDHDF"
      #   component  = var.component
    }
  }
}

################################################################################
# DATA SOURCE BLOCK
################################################################################

data "aws_availability_zones" "available" {
  state = "available"
}

module "vpc" {
  source = "../.."

  component_name      = "testing-module"
  vpc_cidr            = "10.0.0.0/16"
  availability_zone   = ["us-east-1a", "us-east-1b"]
  public_subnetcidr   = ["10.0.0.0/24", "10.0.2.0/24", "10.0.4.0/24"]
  private_subnetcidr  = ["10.0.1.0/24", "10.0.3.0/24", "10.0.5.0/24"]
  database_subnetcidr = ["10.0.51.0/24", "10.0.53.0/24", "10.0.55.0/24"]
}