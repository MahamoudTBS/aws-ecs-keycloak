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
