output "vms_external_ip" {
  value = tomap({
    "${local.company}-${local.stage}-${local.app}-web" = ([yandex_compute_instance.platform.network_interface[0].nat_ip_address]),
    "${local.company}-${local.stage}-${local.app}-db" = ([yandex_compute_instance.database.network_interface[0].nat_ip_address])
  })
  description = "vms external ip"
}
