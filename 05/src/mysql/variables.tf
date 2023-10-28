### MySQL cluster vars
variable "name" {
  type        = string
}

variable "network_id" {
  type        = string
}

variable "mysql_cluster" {
  default = {
    environment         = "PRESTABLE"
    version             = "8.0"
    security_group_ids  = null
    deletion_protection = false
  }
  type = object({
    environment         = string
    version             = string
    security_group_ids  = list(string)
    deletion_protection = bool
  })
}

variable "resource_cluster" {
  default = {
    preset_id    = "s2.micro"
    disk_type_id = "network-ssd"
    disk_size    = 10
  }
  type = object({
    preset_id    = string
    disk_type_id = string
    disk_size    = number
  })
}

variable "subnet_zones" {
  type = list(string)
}

variable "subnet_ids" {
  type = list(string)
}

variable "HA" {
  type        = bool
  description = "change to true for cluster with 3 hosts, or false for cluster wit 1 host"
}
