terraform {
  required_providers {
    aws = {
        source  = "hashicorp/aws"
        version = ">=3.5"
    }
  }
}

module "main_module" {
  source = "./modules/"
}