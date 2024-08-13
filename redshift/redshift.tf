resource "aws_redshift_cluster" "my_cluster" {
  cluster_identifier = "test-redshift-cluster"
  database_name      = "dev"
  master_username    = "awsuser"
  master_password    = "Mustbe8characters"
  node_type          = "dc2.large"
  cluster_type       = "single-node"
  skip_final_snapshot = "true"
  apply_immediately = "true"
  publicly_accessible = "false"
}



resource "aws_redshift_scheduled_action" "pause_cluster" {
  name     = "start-cluster"
  schedule = "cron(50 21 * * ? *)"
  iam_role = var.role

  target_action {
    pause_cluster {
      cluster_identifier = aws_redshift_cluster.my_cluster.cluster_identifier
    }
  }
}