resource "aws_redshift_cluster" "my_cluster" {
  cluster_identifier = var.cluster_name
  database_name      = var.database_name
  master_username    = local.db_credentials.username
  master_password    = local.db_credentials.password
  node_type          = var.node_type
  cluster_type       = var.cluster_type
  number_of_nodes = var.number_of_nodes
  skip_final_snapshot = "true"
  apply_immediately = "true"
  publicly_accessible = "false"
}



resource "aws_redshift_scheduled_action" "pause_cluster" {
  name     = "start-cluster"
  schedule = "cron(50 17 * * ? *)"
  iam_role = var.role

  target_action {
    resume_cluster {
      cluster_identifier = aws_redshift_cluster.my_cluster.cluster_identifier
    }
  }
}

data "aws_secretsmanager_secret_version" "db_secret" {
  secret_id = "db-secret"
}

locals {
  db_credentials = jsondecode(data.aws_secretsmanager_secret_version.db_secret.secret_string)
}

