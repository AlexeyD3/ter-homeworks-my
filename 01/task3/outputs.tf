output "vm_web_external_ip" {
  value = [yandex_compute_instance.platform.network_interface[0].nat_ip_address]
  description = "vm web external ip"
}
output "vm_db_external_ip" {
  value = [yandex_compute_instance.database.network_interface[0].nat_ip_address]
  description = "vm database external ip"
}