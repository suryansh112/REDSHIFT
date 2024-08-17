module "redshift"{
    source = "./redshift"
    role = var.role
}

module "lambda" {
    source = "./lambda"
    bucket = var.bucket
    github_workspace = var.github_workspace
    redshift_lambda_access = var.redshift_lambda_access
}
