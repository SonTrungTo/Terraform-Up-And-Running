terraform {
  required_providers {
    aws = {
        source  = "hashicorp/aws"
        version = ">=3.5"
    }
  }
}

## One could easily divide module for staging vs prod

module "example_db" {
  source            = "./modules/example-db"
  aws_region        = var.aws_region
  aws_profile       = var.aws_profile
  aws_profile_path  = var.aws_credentials_path
}

module "server" {
  source            = "./modules/server"
  aws_region        = var.aws_region
  aws_profile       = var.aws_profile
  aws_profile_path  = var.aws_credentials_path
}
