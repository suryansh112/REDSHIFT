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