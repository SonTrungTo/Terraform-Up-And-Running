provider "aws" {
    region = "us-east-1"
}

resource "aws_instance" "example" {
  ami           = "ami-087c17d1fe0178315"
  instance_type = "t2.micro"
  vpc_security_group_ids = [ "${aws_security_group.instance.id}" ]

  user_data = <<-EOF
  #!/bin/bash
  echo "Hello world" > index.html
  nohup python -m SimpleHTTPServer 8080 &
  EOF

  tags = {
    Name = "terraform-example"
  }
}

## AWS needs to be allowed for incoming/outgoing traffic
## from EC2
resource "aws_security_group" "instance" {
  name = "terraform-example-instance"

  ingress = [ {
    cidr_blocks = [ "0.0.0.0/0" ]
    description = "Opening incoming/outgoing traffic to EC2"
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
  } ]
}

## We must use the security group on the VPC security group ids
## of the AWS Instance