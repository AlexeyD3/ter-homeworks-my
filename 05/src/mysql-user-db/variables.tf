###Mysql db
variable "cluster_id" {
  type = string
}

variable "db_name" {
  type = string
}

### Mysql user
variable "user_name" {
  type = string
}

variable "user_password" {
  type = string
  default = "netology1"
  sensitive   = true
}

variable "user_roles" {
  type = list(string)
  default = ["ALL"]
}