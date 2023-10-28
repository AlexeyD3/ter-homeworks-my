variable "vpc_name" {
  type        = string
  default     = "develop"
  description = "VPC network&subnet name"
}

variable "subnets" {
  type = list(object({
    zone           = string
    v4_cidr_blocks = string
  }))
  description = "https://cloud.yandex.ru/docs/overview/concepts/geo-scope"
}