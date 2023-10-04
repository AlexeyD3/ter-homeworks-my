output "vms_external_ip" {
  value = tomap({
    (var.vm_web_name) = ([yandex_compute_instance.platform.network_interface[0].nat_ip_address]),
    (var.vm_db_name) = ([yandex_compute_instance.database.network_interface[0].nat_ip_address])
  })
  description = "vms external ip"
}
