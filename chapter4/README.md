## Modules in Terraform
Modules allow the programmer to use codes in different environment without the need
to duplicate the codes themselves.

`variables.tf` -----------------> `main.tf`(root module) -----------------> `outputs.tf`

                                  ↙         ↘

                            `m1`                    `m2` (m === sub-module)
                               
                    ⤢        🡙                  ⤢        🡙

                `out.tf`   `var.tf`            `out.tf`   `var.tf`

