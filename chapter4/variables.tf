variable "aws_region" {
  description = "Region of AWS"
  default     = "eu-west-1"
}

variable "aws_availability_1" {
  description = "AWS Availability 1"
  default     = "eu-west-1a"
}

variable "aws_availability_2" {
  description = "AWS Availability 2"
  default     = "eu-west-1b"
}

variable "aws_profile" {
  description = "AWS Profile Name for credentials"
  default     = "terraform-tutorial"
}

variable "aws_credentials_path" {
  description = "Path for AWS credentials file"
  default     = "~/.aws/credentials"
}
