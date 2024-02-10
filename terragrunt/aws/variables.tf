variable "keycloak_database_min_acu" {
  description = "The minimum serverless capacity for the database."
  type        = number
}

variable "keycloak_database_max_acu" {
  description = "The maximum serverless capacity for the database."
  type        = number
}

variable "keycloak_database_username" {
  description = "The username to use for the database."
  type        = string
  sensitive   = true
}

variable "keycloak_database_password" {
  description = "The password to use for the database."
  type        = string
  sensitive   = true
}
