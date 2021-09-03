## The rise of DevOps
- The goal of DevOps is to make software delivery vastly more efficient.
## What is infrastructure as code (IAC)?
- 4 cases of IAC:
    - Ad-hoc scripts. (Bash, Ruby, Python, etc...)
    - Configuration management tools. (Chef, Puppet, Ansible, and SaltStack)
    - Server templating tools. (Docker => containers, (Packet, Vagrant) => VM as code)
    => immutable infrastructure.
    - Server provisioning tools.(Terraform, AWS CloudFormation, OpenStack Heat)
## Benefits of Infras as code
- More powerful, faster and efficient. Also enable to practice various
best engineering practices.
    - Self-service.
    - Speed and error-safe.
    - Documentation.
    - Version control.
    - Validation.
    - Reuse.
    - Happiness.
## How Terraform works
- Terraform: high-level code as infrastructure by HashiCorp.
- Has underlying API with many cloud providers: AWS, Google GCP, Digital Ocean...
- Make changes on config files, then `terraform apply`.
## How Terraform compares to other infras as code tools
- Configuration vs Management tools.
- Mutable vs Immutable Infrastructure.
- Procedural vs Declarative.
    - `terraform plan` to compare the difference between upcoming
    and current infra.
    - Ansible is procedural vs Terraform is declarative.
- Master (Chef, Puppet, SaltStack) vs Masterless(Terraform, Ansible, CloudFormation)
- Agent vs Agentless
    - Chef, Puppet, SaltStack is needs to have their agents installed => increasing problems.
    - Terraform, CloudFormation are not.
- Large vs Small Community (Terraform slowly catching up)
- Mature vs Cutting Edge (Terraform youngest, 2014)