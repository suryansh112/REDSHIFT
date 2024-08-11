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