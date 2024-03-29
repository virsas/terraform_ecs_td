# terraform_ecs_td

Terraform module to ECS task definition

##  Dependencies

ECR - <https://github.com/virsas/terraform_ecr>

## Files

- None

## Terraform example

``` terraform
##############
# Variable
##############
variable "ecs_td_example_api" {
  default = {
    # definition name
    name                  = "example_api"
    # allocated CPU units
    cpu                   = 200
    # allocated Memory units
    memory                = 200
    # Service exposed port
    serviceContainerPort  = 3000
    # Host mapped port of the exposed container port
    serviceHostPort       = 3000
  }
}

##############
# Locales
##############
locals {
  ecs_td_example_api_variables = <<EOT
    {"name": "FOO", "value": "BAR"},
    {"name": "FOO2", "value": "BAR2"},
  EOT
}

##############
# Module
##############
module "ecs_td_example_api" {
  source = "git::https://github.com/virsas/terraform_ecs_td.git?ref=v1.0.0"
  task   = var.ecs_td_example_api
  variables = local.ecs_td_example_api_variables
  region = "eu-west-1"
  ecr    = module.ecr_example_api.url
}
```

## Outputs

- arn