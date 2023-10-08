

data "yandex_compute_image" "ubuntu" {
  family = var.vms_resources.web.image
}

resource "yandex_compute_instance" "for-web" {
  count       = var.vms_resources.web.count
  name        = "${local.web}-${count.index + 1}"
  platform_id = var.vms_resources.web.platform
  resources {
    cores         = var.vms_resources.web.core_count
    memory        = var.vms_resources.web.memory
    core_fraction = var.vms_resources.web.core_fraction
  }
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
    }
  }
  scheduling_policy {
    preemptible = var.vms_resources.web.preemptible
  }
  network_interface {
    security_group_ids = [yandex_vpc_security_group.example.id]
    subnet_id          = yandex_vpc_subnet.develop.id
    nat                = var.vms_resources.web.nat
  }

  metadata = {
    serial-port-enable = var.vms_ssh.serial-port-enable
    ssh-keys           = "${var.vms_ssh.user}:${file(var.vms_ssh.pub_key)}"
  }

}