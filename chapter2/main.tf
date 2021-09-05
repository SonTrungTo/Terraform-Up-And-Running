provider "aws" {
    region = "us-east-1"
}

data "aws_availability_zones" "all" {}
data "aws_iam_user" "current" {
  user_name = "terraform-tutorial"
}

resource "aws_elb" "example" {
  name = "terraform-asg-example"
  availability_zones = "${data.aws_availability_zones.all.names}"
  security_groups = [ "${aws_security_group.elb.id}" ]

  listener {
    lb_port           = 80
    lb_protocol       = "http"
    instance_port     = "${var.server_port}"
    instance_protocol = "http"
  }

  health_check {
    healthy_threshold   = 5
    unhealthy_threshold = 5
    timeout             = 3
    interval            = 30
    target              = "HTTP:${var.server_port}/"
  }
}

resource "aws_security_group" "elb" {
  name = "terraform-example-elb"

  ingress {
    from_port = 80
    to_port   = 80
    protocol  = "tcp"
    cidr_blocks = [ "0.0.0.0/0" ]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [ "0.0.0.0/0" ]
  }
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

  load_balancers = [ "${aws_elb.example.name}" ]
  health_check_type = "ELB"

  min_size = 5
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

output "elb_dns_name" {
  value = "${aws_elb.example.dns_name}"
}

output "current_user" {
  value = "${data.aws_iam_user.current}"
}