## Configuring AWS + Terraform
- Unzip Terraform and add it PATH
- Configuring AWS IAM user at `~/.aws/credentials`

## Terraform
- Written in HCL (HashiCorps Configuration Language)
- Start with `main.tf`
- Note `implicit dependency` between resources (references), use `terraform graph`
- Cidr Range Calculator: `ipaddressguide.com/cidr`
- Graph dependency graphics for DOT: `GraphvizOnline`