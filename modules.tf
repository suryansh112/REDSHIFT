module "redshift"{
    source = "./redshift"
    role = var.role
     cluster_name = var.cluster_name
     number_of_nodes =  var.number_of_nodes
     cluster_type = var.cluster_type
     node_type = var.node_type
     database_name = var.database_name
     db_secret = var.db_secret
}

module "lambda" {
    source = "./lambda"
    bucket = var.bucket
    github_workspace = var.github_workspace
    redshift_lambda_access = var.redshift_lambda_access
    env_function_name = var.env_function_name
    cluster_name =  var.cluster_name
    bucket_name = var.bucket_name
}
