provider "aws" {
    region = "us-east-1"
}

data "aws_availability_zones" "all" {}
data "aws_iam_user" "current" {
  user_name = "terraform-tutorial"
}

resource "aws_launch_configuration" "example" {
  image_id      = "ami-087c17d1fe0178315"
  instance_type = "t2.micro"
  security_groups = [ "${aws_security_group.instance.id}" ]

  user_data = <<-EOF
  #!/bin/bash
  echo "Hello world" > index.html
  nohup python -m SimpleHTTPServer "${var.server_port}" &
  EOF

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "example" {
  launch_configuration = "${aws_launch_configuration.example.id}"
  availability_zones   = "${data.aws_availability_zones.all.names}"

  min_size = 2
  max_size = 10

  tag {
    key = "Name"
    value = "terraform-asg-example"
    propagate_at_launch = true
  }
}

resource "aws_instance" "example" {
  ami           = "ami-087c17d1fe0178315"
  instance_type = "t2.micro"
  vpc_security_group_ids = [ "${aws_security_group.instance.id}" ]

  user_data = <<-EOF
  #!/bin/bash
  echo "Hello world" > index.html
  nohup python -m SimpleHTTPServer "${var.server_port}" &
  EOF

  tags = {
    Name = "terraform-example"
  }
}

## AWS needs to be allowed for incoming/outgoing traffic
## from EC2
resource "aws_security_group" "instance" {
  name = "terraform-example-instance"

  ingress {
    from_port   = "${var.server_port}"
    to_port     = "${var.server_port}"
    protocol    = "tcp"
    cidr_blocks = [ "0.0.0.0/0" ]
  }

  lifecycle {
    create_before_destroy = true
  }
}

## We must use the security group on the VPC security group ids
## of the AWS Instance

variable "server_port" {
  description = "The port the server will use for HTTP requests"
  default     = 8080
}

output "public_ip" {
  value = "${aws_instance.example.public_ip}"
}

output "current_user" {
  value = "${data.aws_iam_user.current}"
}