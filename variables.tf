variable "region" {
  type = string
  sensitive = true

}

variable "role" {
    type = string
    sensitive = true
}

variable "bucket" {
  type = string
  sensitive = true
}
variable "github_workspace"{
    type =  string
    sensitive = false
}

variable "redshift_lambda_access"{
    type = string
    sensitive = true
}


variable "database_name"{
    type = string
    sensitive = false
}

variable "node_type"{
    type = string
    sensitive = false
}
variable "cluster_type"{
    type = string
    sensitive = false
}

variable "number_of_nodes" {

    type = string
    sensitive = false
}
variable "cluster_name"{
    type = string
    sensitive = false
}
variable "env_function_name"{
    type = string
    sensitive = false
}

variable "bucket_name" {

    type = string
    sensitive = false
}

variable "db_secret" {

    type = string
    sensitive = true
}
  