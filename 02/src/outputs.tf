output "vms_external_ip" {
  value = {
    (local.web) = yandex_compute_instance.platform.network_interface[0].nat_ip_address,
    (local.db)  = yandex_compute_instance.database.network_interface[0].nat_ip_address
  }
  description = "vms external ip"
}
