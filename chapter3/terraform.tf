terraform {
  backend "s3" {
    bucket = "terraform-tutorial-state-son-to"
    key = "global/s3/terraform.tfstate"
    region = "eu-west-1"
    encrypt = true
  }
}
