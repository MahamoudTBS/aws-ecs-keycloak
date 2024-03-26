#
# RDS Postgress cluster
#
module "keycloak_database" {
  source = "github.com/cds-snc/terraform-modules//rds?ref=v9.1.0"
  name   = "keycloak-${var.env}"

  database_name  = "keycloak"
  engine         = "aurora-mysql"
  engine_version = "8.0.mysql_aurora.3.05.2"
  instances      = 2
  instance_class = "db.serverless"
  username       = var.keycloak_database_username
  password       = var.keycloak_database_password

  serverless_min_capacity = var.keycloak_database_min_acu
  serverless_max_capacity = var.keycloak_database_max_acu

  backup_retention_period      = 7
  preferred_backup_window      = "02:00-04:00"
  performance_insights_enabled = false

  vpc_id             = module.keycloak_vpc.vpc_id
  subnet_ids         = module.keycloak_vpc.private_subnet_ids
  security_group_ids = [aws_security_group.keycloak_db.id]

  billing_tag_value        = var.billing_code
  prevent_cluster_deletion = false
}

resource "aws_ssm_parameter" "keycloak_database_url" {
  name  = "keycloak_database_url"
  type  = "SecureString"
  value = "jdbc:mysql://${module.keycloak_database.proxy_endpoint}:3306/keycloak"
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
