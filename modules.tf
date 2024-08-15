module "redshift"{
    source = "./redshift"
    role = var.role
}

module "lambda" {
    source = "./lambda"
}
