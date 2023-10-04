### vms resources
variable "vms_resources" {
  type        = map(any)
  default     = {
    web = {
      image = "ubuntu-2004-lts"
      core_count = 2              #(Required) CPU cores for the instance. (min value 2)
      memory = 1                  #(Required) Memory size in GB.
      core_fraction = 5           #(Optional) If provided, specifies baseline performance for a core as a percent.
      preemptible = true          #(Optional) Specifies if the instance is preemptible. Defaults to false.
      platform = "standard-v1"    #(Optional) The type of virtual machine to create. The default is 'standard-v1'.
      nat = true                  #(Optional) Provide a public address, for instance, to access the internet over NAT.
    }
    db = {
      image = "ubuntu-2004-lts"
      core_count = 2              #(Required) CPU cores for the instance. (min value 2)
      memory = 2                  #(Required) Memory size in GB.
      core_fraction = 20          #(Optional) If provided, specifies baseline performance for a core as a percent.
      preemptible = true          #(Optional) Specifies if the instance is preemptible. Defaults to false.
      platform = "standard-v1"    #(Optional) The type of virtual machine to create. The default is 'standard-v1'.
      nat = true                  #(Optional) Provide a public address, for instance, to access the internet over NAT.
    }

  }
  description = "https://cloud.yandex.ru/docs/compute/concepts/performance-levels"
}

### vm_web vars

#variable "vm_web_image" {
#  type        = string
#  default     = "ubuntu-2004-lts"
#  description = "image name"
#}

#variable "vm_web_platform" {
#  type        = string
#  default     = "standard-v1"
#  description = "https://cloud.yandex.ru/docs/compute/concepts/vm-platforms#gpu-platforms"
#}

#variable "vm_web_core_count" {
#  type        = number
#  default     = "2"
#  description = "https://cloud.yandex.ru/docs/compute/concepts/performance-levels"
#}
#
#variable "vm_web_memory" {
#  type        = number
#  default     = "1"
#  description = "https://cloud.yandex.ru/docs/compute/concepts/performance-levels"
#}
#
#variable "vm_web_core_fraction" {
#  type        = number
#  default     = "5"
#  description = "https://cloud.yandex.ru/docs/compute/concepts/performance-levels"
#}

#variable "vm_web_preemptible" {
#  type        = bool
#  default     = "true" #or false
#  description = "https://cloud.yandex.ru/docs/compute/concepts/preemptible-vm"
#}

#variable "vm_web_nat" {
#  type        = bool
#  default     = "true" #or false
#  description = "(Optional) Provide a public address, for instance, to access the internet over NAT."
#}

#variable "vm_web_serial_port" {
#  type        = number
#  default     = "1" #or 0
#  description = "Flag that enables access to the serial console. Default value 0 (disabled)."
#}

### vm_db vars

#variable "vm_db_image" {
#  type        = string
#  default     = "ubuntu-2004-lts"
#  description = "image name"
#}
#
#variable "vm_db_platform" {
#  type        = string
#  default     = "standard-v1"
#  description = "https://cloud.yandex.ru/docs/compute/concepts/vm-platforms#gpu-platforms"
#}

#variable "vm_db_core_count" {
#  type        = number
#  default     = "2"
#  description = "https://cloud.yandex.ru/docs/compute/concepts/performance-levels"
#}
#
#variable "vm_db_memory" {
#  type        = number
#  default     = "2"
#  description = "https://cloud.yandex.ru/docs/compute/concepts/performance-levels"
#}
#
#variable "vm_db_core_fraction" {
#  type        = number
#  default     = "20"
#  description = "https://cloud.yandex.ru/docs/compute/concepts/performance-levels"
#}
#
#variable "vm_db_preemptible" {
#  type        = bool
#  default     = "true" #or false
#  description = "https://cloud.yandex.ru/docs/compute/concepts/preemptible-vm"
#}
#
#variable "vm_db_nat" {
#  type        = bool
#  default     = "true" #or false
#  description = "(Optional) Provide a public address, for instance, to access the internet over NAT."
#}
#
#variable "vm_db_serial_port" {
#  type        = number
#  default     = "1" #or 0
#  description = "Flag that enables access to the serial console. Default value 0 (disabled)."
#}
