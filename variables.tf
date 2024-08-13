variable "region" {
  default = "us-east-1"

}

variable "role" {
    type = string
    sensitive = true
}