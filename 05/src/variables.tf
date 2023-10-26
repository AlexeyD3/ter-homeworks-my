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

variable "zone" {
  type        = string
  default     = "ru-central1-a"
  description = "https://cloud.yandex.ru/docs/overview/concepts/geo-scope"
}

variable "vpc_name" {
  type        = string
  default     = "develop"
  description = "VPC network&subnet name"
}

### ssh vars

variable "vms_ssh" {

  default = {
    user               = "ubuntu"
    serial-port-enable = 0
    pub_key            = "~/.ssh/id_ed25519.pub"
  }
  type = object({
    user               = string
    serial-port-enable = number
    pub_key            = string
  })
}

### VMs vars
variable "nginx_vm" {
  default = {
    env_name        = "develop"
    instance_name   = "web"
    instance_count  = 2
    image_family    = "ubuntu-2004-lts"
    public_ip       = true
  }
  type = object({
    env_name        = string
    instance_name   = string
    instance_count  = number
    image_family    = string
    public_ip       = bool
  })
}
