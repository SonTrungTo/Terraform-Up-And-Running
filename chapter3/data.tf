data "terraform_remote_state" "db" {
  backend = "s3"

  config = {
    bucket = "terraform-tutorial-state-son-to"
    key    = "global/s3/terraform.tfstate"
    region = "eu-west-1"
   }
}

data "template_file" "user_data" {
  template = "${file("user-data.sh")}"

  vars = {
    server_port = "${var.server_port}"
    db_address  = "${data.terraform_remote_state.db.outputs.rds_address}"
    db_port     = "${data.terraform_remote_state.db.outputs.rds_port}"
  }
}