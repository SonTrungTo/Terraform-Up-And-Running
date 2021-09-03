resource "aws_instance" "example" {
  ami           = "ami-40d28157"
  instance_type = "t2.micro"
}

resource "dnssimple_record" "example" {
  domain = "example.com"
  name   = "test"
  value  = "${aws_instance.example.public_ip}"
  type   = "A"
}