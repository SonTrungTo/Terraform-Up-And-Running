provider "aws" {
  region = "eu-west-1"
}

resource "aws_instance" "example" {
  ami           = "ami-0d1bf5b68307103c2"
  instance_type = "t2.micro"
  vpc_security_group_ids = [ "${aws_security_group.instance.id}" ]
  user_data     = "${data.template_file.user_data.rendered}"

  tags = {
    "key" = "Name"
    "value" = "terraform-example"
  }
}

resource "aws_security_group" "instance" {
  name = "terraform-example-instance"

  ingress {
    from_port = "${var.server_port}"
    to_port   = "${var.server_port}"
    protocol  = "tcp"
    cidr_blocks = [ "0.0.0.0/0" ]
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_db_instance" "example" {
  engine            = "mysql"
  allocated_storage = 10
  instance_class    = "db.t2.micro"
  name              = "example_database"
  username          = "stt92"
  password          = "${var.db_password}"
  skip_final_snapshot = true
}

resource "aws_s3_bucket" "terraform_state" {
  bucket = "terraform-tutorial-state-son-to"
  force_destroy = true

  versioning {
    enabled = true
  }

  lifecycle {
    # prevent_destroy = true
  }
}