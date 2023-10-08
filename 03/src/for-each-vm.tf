resource "yandex_compute_instance" "node" {
  depends_on  = [yandex_compute_instance.for-web]
  for_each    = var.vms_node_resources
  name        = "${local.node}-${each.key}"
  platform_id = var.vms_node_resources[each.key].platform
  resources {
    cores         = var.vms_node_resources[each.key].core_count
    memory        = var.vms_node_resources[each.key].memory
    core_fraction = var.vms_node_resources[each.key].core_fraction
  }
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
    }
  }
  scheduling_policy {
    preemptible = var.vms_node_resources[each.key].preemptible
  }
  network_interface {
    security_group_ids = [yandex_vpc_security_group.example.id]
    subnet_id          = yandex_vpc_subnet.develop.id
    nat                = var.vms_node_resources[each.key].nat
  }

  metadata = {
    serial-port-enable = var.vms_ssh.serial-port-enable
    ssh-keys           = "${var.vms_ssh.user}:${file(var.vms_ssh.pub_key)}"
  }

}