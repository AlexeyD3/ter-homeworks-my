###cloud vars
variable "yc_token" {
  type        = string
  sensitive   = true
  description = "OAuth-token; https://cloud.yandex.ru/docs/iam/concepts/authorization/oauth-token"
}

variable "yc_cloud_id" {
  type        = string
  sensitive   = true
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/cloud/get-id"
}

variable "yc_folder_id" {
  type        = string
  sensitive   = true
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/folder/get-id"
}

variable "default_zone" {
  type        = string
  default     = "ru-central1-a"
  description = "https://cloud.yandex.ru/docs/overview/concepts/geo-scope"
}

variable "default_cidr" {
  type        = list(string)
  default     = ["10.0.1.0/24"]
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
}

variable "vpc_name" {
  type        = string
  default     = "develop"
  description = "VPC network&subnet name"
}

###ssh vars

variable "vms_ssh" {

  default = {
    user               = "ubuntu"
    serial-port-enable = 1
    pub_key            = "~/.ssh/id_ed25519.pub"
  }
  type = object({
    user               = string
    serial-port-enable = number
    pub_key            = string
  })
}


### vms resources
variable name {
  default = {
    company = "netology"
    stage   = "develop"
    app     = "platform"
  }
  type    = map(string)
}


variable "vms_resources" {
  default     = {
    web = {
      count = 2
      image         = "ubuntu-2004-lts"
      core_count    = 2
      memory        = 1
      core_fraction = 5
      preemptible   = true
      platform      = "standard-v1"
      nat           = true
    }
    storage = {
      count         = 1
      image         = "ubuntu-2004-lts"
      core_count    = 2
      memory        = 1
      core_fraction = 5
      preemptible   = true
      platform      = "standard-v1"
      nat           = false
    }
  }
  type        = map(object({
    count         = number
    image         = string
    core_count    = number
    memory        = number
    core_fraction = number
    preemptible   = bool
    platform      = string
    nat           = bool
    }))
  description = "https://cloud.yandex.ru/docs/compute/concepts/performance-levels"
}



###VMs vars


variable "vms_node_resources" {
  default = {
    main = {
      image         = "ubuntu-2004-lts"
      core_count    = 2              #(Required) CPU cores for the instance. (min value 2)
      memory        = 2                  #(Required) Memory size in GB.
      core_fraction = 20          #(Optional) If provided, specifies baseline performance for a core as a percent.
      preemptible   = true          #(Optional) Specifies if the instance is preemptible. Defaults to false.
      platform      = "standard-v1"    #(Optional) The type of virtual machine to create. The default is 'standard-v1'.
      nat           = true #(Optional) Provide a public address, for instance, to access the internet over NAT.
    }
    replica  = {
      image         = "ubuntu-2004-lts"
      core_count    = 2              #(Required) CPU cores for the instance. (min value 2)
      memory        = 1                  #(Required) Memory size in GB.
      core_fraction = 20          #(Optional) If provided, specifies baseline performance for a core as a percent.
      preemptible   = true          #(Optional) Specifies if the instance is preemptible. Defaults to false.
      platform      = "standard-v1"    #(Optional) The type of virtual machine to create. The default is 'standard-v1'.
      nat           = true #(Optional) Provide a public address, for instance, to access the internet over NAT.
    }
  }
  type        = map(object({
    image         = string
    core_count    = number
    memory        = number
    core_fraction = number
    preemptible   = bool
    platform      = string
    nat           = bool
    }))
  description = "https://cloud.yandex.ru/docs/compute/concepts/performance-levels"
}

###Disk vars

variable "vm_disk" {
  default     = {
    count       = 3
    name        = "forstorage"
    type        = "network-hdd"
    size        = 1
    auto_delete = true
    #    block_size = <block_size>
  }
  type  = object({
    count       = number
    name        = string
    type        = string
    size        = number
    auto_delete = bool
  })
  description = "https://cloud.yandex.com/en/docs/compute/operations/disk-create/empty"
}