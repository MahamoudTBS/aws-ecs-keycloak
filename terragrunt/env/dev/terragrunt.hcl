#
# Module's Terragrunt config.  This example is setup with a single root module but
# could easily be split into multiple sub-modules by adding subfolders, each with
# their own terragrunt.hcl file.
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
