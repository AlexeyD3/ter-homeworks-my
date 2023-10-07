output "compute_instance_list" {
  value = concat(
    [for instance in yandex_compute_instance.for-web : {
      name = instance.name
      id   = instance.id
      fqdn = instance.fqdn
    }],
    [for instance in yandex_compute_instance.node : {
      name = instance.name
      id   = instance.id
      fqdn = instance.fqdn
    }],
    [{
      name = yandex_compute_instance.storage.name
      id   = yandex_compute_instance.storage.id
      fqdn = yandex_compute_instance.storage.fqdn
    }])
}
