### vms resources
variable name {
  type    = map(string)
  default = {
    company = "netology"
    stage   = "develop"
    app     = "platform"
  }
}

variable "vms_resources" {
  type        = map(any)
  default     = {
    web = {
      image         = "ubuntu-2004-lts"
      core_count    = 2
      memory        = 1
      core_fraction = 5
      preemptible   = true
      platform      = "standard-v1"
      nat           = true
    }
    db = {
      image         = "ubuntu-2004-lts"
      core_count    = 2
      memory        = 2
      core_fraction = 20
      preemptible   = true
      platform      = "standard-v1"
      nat           = true
    }
  }
  description = "https://cloud.yandex.ru/docs/compute/concepts/performance-levels"
}
