variable "role" {
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

variable "db_secret"{
    type = string
    sensitive = true
}

