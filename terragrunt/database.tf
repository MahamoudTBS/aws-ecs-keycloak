#
# RDS Postgress cluster
#
module "keycloak_database" {
  source = "github.com/cds-snc/terraform-modules//rds?ref=v9.1.0"
  name   = "keycloak-${var.env}"

  database_name  = "keycloak"
  engine         = "aurora-mysql"
  engine_version = "8.0.32.mysql_aurora.3.05.2"
  username       = var.keycloak_database_username
  password       = var.keycloak_database_password

  backup_retention_period      = 7
  preferred_backup_window      = "02:00-04:00"
  performance_insights_enabled = true

  vpc_id             = module.keycloak_vpc.vpc_id
  subnet_ids         = module.keycloak_vpc.private_subnet_ids
  security_group_ids = [aws_security_group.keycloak_database.id]

  serverlessv2_scaling_configuration {
    max_capacity = var.keycloak_database_max_acu
    min_capacity = var.keycloak_database_min_acu
  }

  billing_tag_value = var.billing_code
}

resource "aws_ssm_parameter" "keycloak_database_host" {
  name  = "keycloak_database_host"
  type  = "SecureString"
  value = module.keycloak_database.proxy_endpoint
  tags  = local.common_tags
}

resource "aws_ssm_parameter" "keycloak_database_username" {
  name  = "keycloak_database_username"
  type  = "SecureString"
  value = var.keycloak_database_username
  tags  = local.common_tags
}

resource "aws_ssm_parameter" "keycloak_database_password" {
  name  = "keycloak_database_password"
  type  = "SecureString"
  value = var.keycloak_database_password
  tags  = local.common_tags
}
