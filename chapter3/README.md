# Terraform State
## What is terraform state?
- The Statefile is a private API and should not be tampered with.
- Rarer uses: `terraform import` or `terraform state`.
## Shared storage for state files
- Problem: Out-of-date state file => accidentally rollback/duplicate deployments
- Solution: `terraform remote config` (Remote State Storage)
    - Create S3 Bucket resource.
    - Resource (`aws_s3_bucket`: bucket, versioning, lifecycle(`prevent_destroy`))
    - Create `terraform.tf` to make backend.
## Locking state files ([solved](https://www.terraform.io/docs/language/state/locking.html))
- Locking is needed because statefiles maybe uploaded simultaneously
by multiple developers.
- 3 Solutions for locking state files,
    - Terraform Pro/Enterprise
    - Build Servers(Jenkins, Circle CI)
    - Terragrunt, with DynamoDB as its backend
## Isolating state files
- Better to separate files.
- Better to use modules in chapter 4 to avoid duplications.
## Read-only state
- Use `data "terraform_remote_state" "db_instance" { backend="s3" config{ ... } }`
- Use `data "template_file" "user_data" { template="${file("user-data.sh")}" vars {...} }` => `.rendered` attribute
