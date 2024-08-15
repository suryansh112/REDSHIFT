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


variable "github_workspace" {
    type =string
    sensitive = false
}
