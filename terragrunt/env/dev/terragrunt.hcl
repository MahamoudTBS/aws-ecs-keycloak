#
# Module Terragrunt config.  This example is setup with a single root in module
# `./terragrunt/aws` but could be split into multiple submodules by adding subfolders, 
# each with their own terragrunt.hcl:
#
# terragrunt/
# ├── aws/
# │   ├── database/
# │   │   ├── inputs.tf
# │   │   └── rds.tf
# │   ├── ecs/
# │   │   ├── inputs.tf
# │   │   └── ecs.tf
# │   └── network/
# │       ├── inputs.tf
# │       └── vpc.tf
# └── env/
#     ├── dev/
#     │   ├── database/
#     │   │   └── terragrunt.hcl
#     │   ├── ecs/
#     │   │   └── terragrunt.hcl
#     │   ├── network/
#     │   │   └── terragrunt.hcl
#     │   └── env_vars.hcl
#     ├── prod/
#     │   ├── database/
#     │   │   └── terragrunt.hcl
#     │   ├── ecs/
#     │   │   └── terragrunt.hcl
#     │   ├── network/
#     │   │   └── terragrunt.hcl
#     │   └── env_vars.hcl      
#     └── terragrunt.hcl
#
terraform {
  source = "../..//aws"
}

inputs = {
  keycloak_database_min_acu = 2
  keycloak_database_max_acu = 4
}

include {
  path = find_in_parent_folders()
}
