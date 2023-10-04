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
  description = "VPC network & subnet name"
}


###ssh vars

variable "vms_ssh_root_key" {
  type        = string
  default     = "~/.ssh/id_ed25519.pub"
  description = "ssh-keygen -t ed25519"
}

### vm_web vars
variable "vm_web_name" {
  type        = string
  default     = "netology-develop-platform-web"
  description = "name for Virtual Machine"
}

variable "vm_web_image" {
  type        = string
  default     = "ubuntu-2004-lts"
  description = "image name"
}

variable "vm_web_platform" {
  type        = string
  default     = "standard-v1"
  description = "https://cloud.yandex.ru/docs/compute/concepts/vm-platforms#gpu-platforms"
}

variable "vm_web_core_count" {
  type        = number
  default     = "2"
  description = "https://cloud.yandex.ru/docs/compute/concepts/performance-levels"
}

variable "vm_web_memory" {
  type        = number
  default     = "1"
  description = "https://cloud.yandex.ru/docs/compute/concepts/performance-levels"
}

variable "vm_web_core_fraction" {
  type        = number
  default     = "5"
  description = "https://cloud.yandex.ru/docs/compute/concepts/performance-levels"
}

variable "vm_web_preemptible" {
  type        = bool
  default     = "true" #or false
  description = "https://cloud.yandex.ru/docs/compute/concepts/preemptible-vm"
}

variable "vm_web_nat" {
  type        = bool
  default     = "true" #or false
  description = "(Optional) Provide a public address, for instance, to access the internet over NAT."
}

variable "vm_web_serial_port" {
  type        = number
  default     = "1" #or 0
  description = "Flag that enables access to the serial console. Default value 0 (disabled)."
}
