### vm_web vars

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

### vm_db vars

variable "vm_db_image" {
  type        = string
  default     = "ubuntu-2004-lts"
  description = "image name"
}

variable "vm_db_platform" {
  type        = string
  default     = "standard-v1"
  description = "https://cloud.yandex.ru/docs/compute/concepts/vm-platforms#gpu-platforms"
}

variable "vm_db_core_count" {
  type        = number
  default     = "2"
  description = "https://cloud.yandex.ru/docs/compute/concepts/performance-levels"
}

variable "vm_db_memory" {
  type        = number
  default     = "2"
  description = "https://cloud.yandex.ru/docs/compute/concepts/performance-levels"
}

variable "vm_db_core_fraction" {
  type        = number
  default     = "20"
  description = "https://cloud.yandex.ru/docs/compute/concepts/performance-levels"
}

variable "vm_db_preemptible" {
  type        = bool
  default     = "true" #or false
  description = "https://cloud.yandex.ru/docs/compute/concepts/preemptible-vm"
}

variable "vm_db_nat" {
  type        = bool
  default     = "true" #or false
  description = "(Optional) Provide a public address, for instance, to access the internet over NAT."
}

variable "vm_db_serial_port" {
  type        = number
  default     = "1" #or 0
  description = "Flag that enables access to the serial console. Default value 0 (disabled)."
}
