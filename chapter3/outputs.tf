output "s3_bucket_arn" {
  value = "${aws_s3_bucket.terraform_state.arn}"
}

output "rds_address" {
  value = "${aws_db_instance.example.address}"
}

output "rds_port" {
  value = "${aws_db_instance.example.port}"
}


output "instance_public_ip" {
  value = "${aws_instance.example.public_ip}"
}