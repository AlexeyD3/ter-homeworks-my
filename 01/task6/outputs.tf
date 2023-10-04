#output "vm_web_external_ip" {
#  value = [yandex_compute_instance.platform.network_interface[0].nat_ip_address]
#  description = "vm web external ip"
#}
#
#output "vm_db_external_ip" {
#  value = [yandex_compute_instance.database.network_interface[0].nat_ip_address]
#  description = "vm database external ip"
#}

#output "vm_web_external_ip" {
#  value = tomap(
#    var.vm_web_name, "=", [yandex_compute_instance.platform.network_interface[0].nat_ip_address]
#  )
#  description = "vm web external ip"
#}
#
#output "vm_db_external_ip" {
#  value = tomap(
#    var.vm_db_name, "=", [yandex_compute_instance.database.network_interface[0].nat_ip_address]
#  )
#  description = "vm database external ip"
#}

output "vms_external_ip" {
  value = tomap({
    "${local.company}-${local.stage}-${local.app}-web" = ([yandex_compute_instance.platform.network_interface[0].nat_ip_address]),
    "${local.company}-${local.stage}-${local.app}-db" = ([yandex_compute_instance.database.network_interface[0].nat_ip_address])
  })
  description = "vms external ip"
}

#output "vm_web_external_ip" {
#  value = var.external_ip[var.vm_web_name]
#}
#
#output "vm_db_external_ip" {
#  value = var.external_ip[var.vm_db_name]
#}