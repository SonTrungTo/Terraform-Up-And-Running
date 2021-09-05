## Configuring AWS + Terraform
- Unzip Terraform and add it PATH
- Configuring AWS IAM user at `~/.aws/credentials`

## Terraform
- Written in HCL (HashiCorps Configuration Language)
- Start with `main.tf`
- Note `implicit dependency` between resources (references), use `terraform graph`
- Cidr Range Calculator: `ipaddressguide.com/cidr`
- Graph dependency graphics for DOT: `GraphvizOnline`

## Deploying to a cluster of servers
- Using Auto Scaling Group (ASG) by AWS
- First is to make configurations `aws_launch_configuration`
- `lifecycle` config is needed for ASG.
    - `create_before_destroy(bool)`: create a replacement before destroying the original resource.(must be on dependent resources as well)
- `aws_elb` resources need `listeners` to route requests
and listen on ports.
- To accept incoming requests, all resources need security groups.
- Terraform searches for variables 
    - with `TF_VAR_NAME`
    - Input -var=...
    - File -var-file=...
- ELB service has the capability to check health for all instances
and stops routing to that instance should it become unhealthy.

## Cleanup
- `terraform destroy` to clean the infras.